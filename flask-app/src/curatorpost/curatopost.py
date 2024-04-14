from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


curatorpost  = Blueprint('curatorpost', __name__)

# Get all the curatorposts
@curatorpost.route('/curatorpost', methods=['GET'])
def get_curatorposts():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Curator_Post')

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
    curator_id = the_data['CuratorID']
    content = the_data['Post_Content']


    # Constructing the query
    query = 'insert into Curator_Post (CuratorID, Post_Content) values ('
    query += curator_id + '", "'
    query += content + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Get all CuratorPosts by a certain curator
@curatorpost.route('/curatorpost/<curator_name>', methods=['GET'])
def get_curatorpost_by_curator(curator_name):

    query = 'SELECT c.Name, cp.PostID, cp.Post_Content, cp.Creation_Date \
            FROM Curator_Post cp JOIN Curator c ON c.CuratorID = cp.CuratorID \
            WHERE c.Name = ' + str(curator_name)

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Get curator posts by a certain postID
@curatorpost.route('/curatorpost/<postID>', methods=['GET'])
def get_curatorpost_by_id(postID):

    query = 'SELECT c.Name, cp.PostID, cp.Post_Content, cp.Creation_Date \
            FROM Curator_Post cp JOIN Curator c ON c.CuratorID = cp.CuratorID \
            WHERE cp.PostID = ' + str(postID)
    
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
    ap.Post_Content = data['content']
    db.session.commit()
    return jsonify({'message': 'Post #%s updated successfully!'%(PostID)}), 200


# Delete the post with the given <PostID>
@curatorpost.route('/curatorpost/<postID>', methods=['DELETE'])
def delete_curatorpost(PostID):
    cp = curatorpost.query.get_or_404(PostID)
    db.session.delete(cp)
    db.session.commit()
    return jsonify({'message': 'Post #%s deleted successfully'%(PostID)}), 200