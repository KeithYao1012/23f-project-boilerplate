from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


usersongs = Blueprint('User_Song', __name__)

# Gets a specific song that a specfic user has downloaded
@usersongs.route('/song/usersong/<username>/<songID>', methods=['GET'])
def get_spec_downloaded_songs(username, songID):
    
    query = 'SELECT * FROM Users NATURAL JOIN User_Song \
        NATURAL JOIN Songs NATURAL JOIN Genre \
            NATURAL JOIN Artists WHERE Username = ' + str(username) \
            + '&& SongID = ' + str(songID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Gets all songs by a that a specfic user has downloaded
@usersongs.route('/usersong/<username>', methods=['GET'])
def get_downloaded_songs(username):
    
    query = 'SELECT * FROM Users NATURAL JOIN User_Song \
        NATURAL JOIN Songs NATURAL JOIN Genre \
            NATURAL JOIN Artists WHERE Username = ' + str(username)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Adds a song to the users songs
@usersongs.route('/usersong/<username>', methods=['POST'])
def add_downloaded_song(username):

    # collecting data from the request object 
    data = request.json
    current_app.logger.info(data)

    # Constructing the query
    query = 'insert into User_Song values ('
    query += '(SELECT UserID FROM Users WHERE Username = ' + str(username) + '), '
    query += str(data) + ', '
    query += '1)'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# # Delete the song with the given <songID>
# @usersongs.route('/usersong/<userid>/<songID>', methods=['DELETE'])
# def delete_spec_song(userid, songID):
#     song = usersongs.query.get_or_404(userid, songID)
#     db.session.delete(song)
#     db.session.commit()
#     return jsonify({'message': 'Song deleted successfully'}), 200

# Gets a specific song that a specfic user has downloaded
@usersongs.route('/usersong/<userid>/<songID>', methods=['DELETE'])
def delete_spec_downloaded_songs(userid, songID):
    
    query = 'DELETE FROM User_Song WHERE UserID = ' + str(userid) \
            + '&& SongID = ' + str(songID)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Deleted!'

