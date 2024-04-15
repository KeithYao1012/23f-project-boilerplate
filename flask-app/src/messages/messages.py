from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


messages = Blueprint('Messages', __name__)

# Get all the messages
@messages.route('/messages', methods=['GET'])
def get_messages():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Message')

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

# Get messages from specific user
@messages.route('/messages/from/<username>', methods=['GET'])
def get_usermsgsent(username):

    query = 'SELECT * FROM (Message m JOIN Users uF ON \
        m.FromUserID = uF.UserID) JOIN Users uT ON \
             m.ToUserID = uT.UserID WHERE uF.Username = ' + str(username)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Get messages sent to a specific user
@messages.route('/messages/to/<username>', methods=['GET'])
def get_usermsgrec(username):

    query = 'SELECT uF.Username, Content FROM Message m JOIN Users uF ON \
        m.FromUserID = uF.UserID JOIN Users uT ON \
             m.ToUserID = uT.UserID WHERE uT.Username = ' + str(username)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Sends a message to a specifc user 
@messages.route('/messages/<username>', methods=['POST'])
def send_Message(username):

    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    content = the_data['Content']
    toUsername = the_data['Username']
    

    # Constructing the query
    query = 'INSERT INTO Message(ToUserID, FromUserID, Content) VALUES ('
    query += '(SELECT UserID FROM Users WHERE Username = "' + toUsername + '"), '
    query += '(SELECT UserID FROM Users WHERE Username = ' + str(username) + '), "'
    query += content + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'