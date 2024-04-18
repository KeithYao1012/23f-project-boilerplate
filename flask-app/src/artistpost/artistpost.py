from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


artistpost  = Blueprint('artistpost', __name__)

# Get all the artist posts
@artistpost.route('/artistpost', methods=['GET'])
def get_artistsposts():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Artist_Post NATURAL JOIN Artists')

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

# Adds a new artistpost
@artistpost.route('/artistpost', methods=['POST'])
def add_new_artistpost():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    artist_name = the_data['Artist_Name']
    content = the_data['Post_Content']

    # Constructing the query
    query = 'insert into Artist_Post (ArtistID, Content) values ('
    query += '(select ArtistID FROM Artists WHERE Artist_name = "' + artist_name + '"), "'
    query += content + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Get all artist posts by a certain artist
@artistpost.route('/artistpost/<artist_name>', methods=['GET'])
def get_artistpost_by_artist(artist_name):

    query = 'SELECT Artist_Name, Creation_Date, Content, PostID \
          FROM Artist_Post NATURAL JOIN Artists WHERE Artist_Name = ' + str(artist_name) 
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Get all artist posts by a certain postID
@artistpost.route('/artistpost/<postID>', methods=['GET'])
def get_artistpost_by_id(postID):

    query = 'SELECT Artist_Name, Creation_Date, Content \
          FROM Artist_Post NATURAL JOIN Artists WHERE PostID = ' + str(postID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor() 
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Get all interactions on a a certain postID
@artistpost.route('/artistpost/interactions/<postID>', methods=['GET'])
def get_artistpostinteractions_by_id(postID):

    query = 'SELECT * FROM Artist_Post NATURAL JOIN \
        Artists NATURAL JOIN UserArtist_Interactions \
            NATURAL JOIN Users WHERE PostID = ' + str(postID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Adds a comment to a specific artist post
@artistpost.route('/artistpost/interact/<username>/<postid>', methods=['POST'])
def add_artistpostinteraction(username, postid):

    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    comment = the_data['Comment']

    # Constructing the query
    query = 'insert into UserArtist_Interactions(UserID, PostID, Comments, Interactions) values ('
    query += '(SELECT UserID FROM Users WHERE Username = ' + str(username) + '), '
    query += str(postid) + ', "'
    query += comment + '", '
    query += '0)'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# Updates a current artistpost
@artistpost.route('/artistpost', methods=['PUT'])
def update_artistpost():
    data = request.get_json()
    PostID = str(data['postID'])
    content = str(data['content'])
    # Constructing the query
    query = 'UPDATE Artist_Post SET Content = \'' + content + '\' WHERE PostID =' + str(PostID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return jsonify({'message': 'Post #%s updated successfully!'%(PostID)}), 200


# Delete the post with the given <PostID>
@artistpost.route('/artistpost/d/<postID>', methods=['DELETE'])
def delete_artistpost(postID):
    query = 'DELETE FROM Artist_Post WHERE PostID = ' + str(postID)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return jsonify({'message': 'Arist Post deleted successfully'}), 200
