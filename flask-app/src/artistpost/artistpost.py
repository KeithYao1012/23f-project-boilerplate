from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


artistpost  = Blueprint('artistpost', __name__)

# Get all the artists
@artistpost.route('/artistpost', methods=['GET'])
def get_artistsposts():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Artist_Post')

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

# Adds a new artist
@artistpost.route('/artistpost', methods=['POST'])
def add_new_artistpost():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    artist_id = the_data['ArtistID']
    post_id = the_data['PostID']
    creation_date = the_data['Creation_Date']
    content = the_data['Post_Content']


    # Constructing the query
    query = 'insert into artist_post (ArtistID, PostID, Creation_Date, Post_Content) values ("'
    query += artist_id + '", "'
    query += post_id + '", "'
    query += creation_date + '", "'
    query += content + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


