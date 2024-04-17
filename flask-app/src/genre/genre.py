from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


genre  = Blueprint('genre', __name__)

# Get all the genres
@genre.route('/genre', methods=['GET'])
def get_genres():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Genre')

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

# Get a specific genre
@genre.route('/genre/<GenreID>', methods=['GET'])
def get_genre(GenreID):

    query = 'SELECT * From Genre WHERE GenreID = ' + str(GenreID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Adds a new genre
@genre.route('/genre', methods=['POST'])
def add_new_genre():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['GenreName']

    # Constructing the query
    query = 'insert into Genre (GenreName) values("'
    query += name + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@genre.route('/genre/<GenreID>', methods=['DELETE'])
def delete_genre(Genre_ID):
    query = 'DELETE FROM Genre WHERE GenreID = ' + str(Genre_ID)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return jsonify({'message': 'Genre deleted successfully'}), 200
