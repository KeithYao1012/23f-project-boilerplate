from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


users = Blueprint('Users', __name__)

# Get all the users
@users.route('/users', methods=['GET'])
def get_users():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT Username FROM Users')

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

# Get a specific user
@users.route('/users/<username>', methods=['GET'])
def get_user(username):

    query = 'SELECT Username FROM Users WHERE Username = ' + str(username)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Adds a new user
@users.route('/users', methods=['POST'])
def add_new_user():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['Username']


    # Constructing the query
    query = 'insert into Users (Username) values ("'
    query += name + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Updates a current user
@users.route('/users/<username>', methods=['PUT'])
def update_user(username):
    user = users.query.get_or_404(username)
    data = request.get_json()
    user.username = data['username']
    db.session.commit()
    return jsonify({'message': 'User updated successfully!'}), 200

# Delete the user with user_id
@users.route('/users/<username>', methods=['DELETE'])
def delete_user(username):
    query = 'DELETE FROM Users WHERE Username = ' + str(username)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return jsonify({'message': 'User deleted successfully'}), 200

# Gets all users in a certain community
@users.route('/users/<com_name>', methods=['GET'])
def get_users_from_community(com_name):

    query = 'SELECT u.Username FROM Users u \
        JOIN User_Community uc ON u.UserID = uc.UserID \
        JOIN Community c ON uc.CommunityID = c.CommunityID \
        WHERE c.Com_Name = ' + str(com_name)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Get all users other than specific user
@users.route('/users/otherusers/<username>', methods=['GET'])
def get_otherusers(username):

    query = 'SELECT * FROM Users WHERE NOT Username = ' + str(username)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


