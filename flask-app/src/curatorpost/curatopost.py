from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


curatorpost  = Blueprint('curatopost', __name__)

# Get all the artists
@curatorpost.route('/curatorpost', methods=['GET'])
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

# Adds a new curatorpost
@curatorpost.route('/curatorpost', methods=['POST'])
def add_new_curatorpost():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    artist_name = the_data['Artist_Name']
    content = the_data['Post_Content']


    # Constructing the query
    query = 'insert into Artist_Post (ArtistID, Content) values ('
    query += '(select ArtistID FROM Artists WHERE Artist_name = ' + str(artist_name) + '), "'
    # query += post_id + '", "'
    # query += creation_date + '", "'
    query += content + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Get all artist posts by a certain artist
@curatorpost.route('/curatorpost/<artist_name>', methods=['GET'])
def get_curatorpost_by_artist(artist_name):

    query = 'SELECT Artist_Name, Creation_Date, Content \
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
@curatorpost.route('/curatorpost/<postID>', methods=['GET'])
def get_curatorpost_by_artist(postID):

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


# Updates a current curatorpost
@curatorpost.route('/curatorpost/<postID>', methods=['PUT'])
def update_curatorpost(PostID):
    ap = curatorpost.query.get_or_404(PostID)
    data = request.get_json()
    ap.content = data['content']
    db.session.commit()
    return jsonify({'message': 'Post #%s updated successfully!'%(PostID)}), 200


# Delete the post with the given <PostID>
@curatorpost.route('/curatorpost/<postID>', methods=['DELETE'])
def delete_curatorpost(PostID):
    cp = curatorpost.query.get_or_404(PostID)
    db.session.delete(cp)
    db.session.commit()
    return jsonify({'message': 'Post #%s deleted successfully'%(PostID)}), 200