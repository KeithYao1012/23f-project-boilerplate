from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


curators  = Blueprint('Curator', __name__)

# Get all the curators
@curators.route('/curator', methods=['GET'])
def get_curators():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT CuratorID, Name FROM Curatos')

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

# Get a specific curator
@curators.route('/curator/<CuratorID>', methods=['GET'])
def get_curator(CuratorID):

    query = 'SELECT CuratorID, Name FROM Curator WHERE CuratorID = ' + str(CuratorID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Adds a new curator
@curators.route('/curator', methods=['POST'])
def add_new_curator():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['CuratorID']
    name = the_data['Name']

    # Constructing the query
    query = 'insert into curator (CuratorID, Name) values ("'
    query += id + '", "'
    query += name + '", "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Updates a current curator
@curators.route('/curator/<curatorID>', methods=['PUT'])
def update_curator(CuratorID):
    curator = curators.query.get_or_404(CuratorID)
    data = request.get_json()
    curator.name = data['Name']
    db.session.commit()
    return jsonify({'message': 'Curator updated successfully!'}), 200

# Delete the curator with the given <curatorID>
@curators.route('/curator/<curatorID>', methods=['DELETE'])
def curator(curatorID):
    curator = curators.query.get_or_404(curatorID)
    db.session.delete(curator)
    db.session.commit()
    return jsonify({'message': 'Curator deleted successfully'}), 200

