from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


producers  = Blueprint('products', __name__)

# Get all the producers
@producers.route('/producers', methods=['GET'])
def get_producers():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT Name, ProducerID FROM Producer')

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

# Get a specific producer
@producers.route('/producers/<producerID>', methods=['GET'])
def get_producer(producerID):

    query = 'SELECT Name, ProducerID FROM Producer WHERE ProducerID = ' + str(producerID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Adds a new producer
@producers.route('/producers', methods=['POST'])
def add_new_producer():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['ProducerID']
    name = the_data['Name']


    # Constructing the query
    query = 'insert into producers (ProducerID, Name) values ("'
    query += id + '", "'
    query += name + '", "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Updates a current producer
@producers.route('/producers/<producerID>', methods=['PUT'])
def update_producer(producerID):
    prod = producers.query.get_or_404(producerID)
    data = request.get_json()
    prod.name = data['name']
    db.session.commit()
    return jsonify({'message': 'Producer updated successfully!'}), 200

# Delete the producer with the given <ProducerID>
@producers.route('/producers/<producerrID>', methods=['DELETE'])
def delete_producer(userID):
    prod = producers.query.get_or_404(userID)
    db.session.delete(prod)
    db.session.commit()
    return jsonify({'message': 'User deleted successfully'}), 200