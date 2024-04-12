from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


artists  = Blueprint('products', __name__)

# Get all the artists
@artists.route('/artists', methods=['GET'])
def get_artists():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT ArtistID, Artist_Name FROM Artists')

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
@artists.route('/artists/<ArtistID>', methods=['GET'])
def get_artist(ArtistID):

    query = 'SELECT Artist_Name, ArtistID FROM Artists WHERE ArtistID = ' + str(ArtistID)
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
@artists.route('/artists/<userID>', methods=['GET'])
def get_artistsSupported(userID):

    query = 'SELECT a.ArtistID, a.Artist_Name FROM Users u \
        JOIN User_Following uf ON u.UserID = uc.UserID \
        JOIN Artists a ON uf.ArtistID = a.ArtistID \
        WHERE u.UserID = ' + str(userID)
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
    id = the_data['ArtistID']
    name = the_data['Artist_Name']


    # Constructing the query
    query = 'insert into artists (ArtistID, Artist_Name) values ("'
    query += id + '", "'
    query += name + '", "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# Updates a current artist
@artists.route('/artists/<ArtistID>', methods=['PUT'])
def update_artist(ArtistID):
    artist = artists.query.get_or_404(ArtistID)
    data = request.get_json()
    artist.name = data['Artist_Name']
    db.session.commit()
    return jsonify({'message': 'Artist updated successfully!'}), 200

# Delete the producer with the given <ProducerID>
@artists.route('/artists/<artistID>', methods=['DELETE'])
def delete_artist(ArtistID):
    artist = artists.query.get_or_404(ArtistID)
    db.session.delete(artist)
    db.session.commit()
    return jsonify({'message': 'Artist deleted successfully'}), 200

