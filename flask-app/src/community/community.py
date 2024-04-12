from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


community  = Blueprint('Community', __name__)

# Get all the communities
@community.route('/community', methods=['GET'])
def get_communities():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT c.Com_Name, g.GenreName, c.Com_Desc FROM Community c \
                   JOIN Genre g ON g.GenreID = c.GenreID')

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

# Get a specific community
@community.route('/comunity/<Community>', methods=['GET'])
def get_community(Com_Name):

    query = 'SELECT Com_Name, GenreName, Com_Desc FROM Community c \
            JOIN GENRE g on c.genreID = g.genreID \
            WHERE Com_Name = ' + str(Com_Name)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Gets all communities that a specific genre is associated with
@community.route('/community/<genreName>', methods=['GET'])
def get_genreCommunities(GenreName):

    query = 'SELECT c.Com_Name, g.GenreName, Com_Desc FROM Community \
        JOIN Genre gON g.GenreID = c.genreID \
        WHERE g.GenreName = ' + str(GenreName)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Adds a new community
@community.route('/community', methods=['POST'])
def add_new_community():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['CommunityID']
    name = the_data['Com_Name']
    genreName = the_data['GenreName']
    com_desc = the_data['Com_Desc']


    # Constructing the query
    query = 'insert into community (CommunityID, Com_Name, GenreID, Com_Desc) values ("'
    query += id + '", "'
    query += name + '", "'
    query += '(SELECT GenreID FROM Genre WHERE GenreName = ' + str(genreName) + '", "'
    query += com_desc + '", "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# Updates a current community
@community.route('/community/<CommunityID>', methods=['PUT'])
def update_community(CommunityID):
    community = community.query.get_or_404(CommunityID)
    data = request.get_json()
    community.name = data['Com_Name']
    db.session.commit()
    return jsonify({'message': 'Community updated successfully!'}), 200

# Delete the community with the given <CommunityID>
@community.route('/community/<CommunityID>', methods=['DELETE'])
def delete_community(CommunityID):
    community = community.query.get_or_404(CommunityID)
    db.session.delete(community)
    db.session.commit()
    return jsonify({'message': 'Community deleted successfully'}), 200