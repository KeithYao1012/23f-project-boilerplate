from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


artists  = Blueprint('artists', __name__)

# Get all the artists
@artists.route('/artists', methods=['GET'])
def get_artists():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of artist
    cursor.execute('SELECT * FROM Artists')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get a specific artist
@artists.route('/artists/<Artist_Name>', methods=['GET'])
def get_artist(Artist_Name):

    query = 'SELECT * FROM Artists WHERE Artist_Name = ' + str(Artist_Name)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Gets all artists that a specific user follows
@artists.route('/artists/<Username>', methods=['GET'])
def get_artistsSupported(Username):

    query = 'SELECT a.Artist_Name FROM Users u \
        JOIN User_Following uf ON u.UserID = uf.UserID \
        JOIN Artists a ON uf.ArtistID = a.ArtistID \
        WHERE u.Username = ' + str(Username)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Adds a new artist
@artists.route('/artist', methods=['POST'])
def add_new_artist():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['Artist_Name']

    # Constructing the query
    query = 'insert into Artists (Artist_Name) values("'
    query += name + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Updates a current artist
@artists.route('/artists/<ArtistID>', methods=['PUT'])
def update_artist(ArtistID):
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['Name']
    # Constructing the query
    query = 'UPDATE Artists SET Artist_Name = \'' + name + '\' WHERE ArtistID =' + ArtistID
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)

    db.session.commit()
    return jsonify({'message': 'Artist updated successfully!'}), 200

# Delete the producer with the given <ProducerID>
@artists.route('/artists/<artistID>', methods=['DELETE'])
def delete_artist(ArtistID):
    query = 'DELETE FROM Artists WHERE ArtistID = ' + str(ArtistID)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return jsonify({'message': 'Artist deleted successfully'}), 200