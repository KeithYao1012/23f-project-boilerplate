from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


downloads  = Blueprint('User_Downloads', __name__)


# Gets all playlists that a specfic user has downloaded
@downloads.route('/downloads/<username>', methods=['GET'])
def get_downloaded_songs(username):
  
   query = 'SELECT * FROM User_Downloads NATURAL JOIN \
       Playlist NATURAL JOIN Genre NATURAL JOIN \
           Users WHERE Username =  ' + str(username)
   current_app.logger.info(query)


   cursor = db.get_db().cursor()
   cursor.execute(query)
   column_headers = [x[0] for x in cursor.description]
   json_data = []
   the_data = cursor.fetchall()
   for row in the_data:
       json_data.append(dict(zip(column_headers, row)))
   return jsonify(json_data)


# Adds a playlist to the users playlists
@downloads.route('/downloads/<username>', methods=['POST'])
def add_downloaded_playlist(username):


   # collecting data from the request object
   data = request.json
   current_app.logger.info(data)


   # Constructing the query
   query = 'insert into User_Downloads values ('
   query += '(SELECT UserID FROM Users WHERE Username = ' + str(username) + '), '
   query += str(data) + ') '
   current_app.logger.info(query)


   # executing and committing the insert statement
   cursor = db.get_db().cursor()
   cursor.execute(query)
   db.get_db().commit()
  
   return 'Success!'


 # Deletes a playlist given the pID
@downloads.route('/userdownloads', methods=['DELETE'])
def delete_playlist():
    data = request.json
    userID = data['userID']
    playlistID = data['pID']
    query = 'DELETE FROM User_Downloads WHERE UserID = ' + str(userID) + ' && PlaylistID = ' + str(playlistID)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return jsonify({'message': 'Playlist deleted successfully from User'}), 200