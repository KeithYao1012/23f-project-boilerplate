from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


playlistsong  = Blueprint('Playlist_Songs', __name__)

# Adds a song to a playlist
@playlistsong.route('/playlistsong', methods=['POST'])
def add_new_song_to_playlist():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)
    pID = str(the_data["PlaylistID"])
    songID = str(the_data["SongID"])

    # Constructing the query
    query = 'insert into Playlist_Songs (PlaylistID, SongID) values ('
    query += pID + ', '
    query += songID + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Get a songs from specific playlist
@playlistsong.route('/playlistsong/<pID>', methods=['GET'])
def get_playlistsong(pID):


   query = 'SELECT * FROM Playlist_Songs ps NATURAL JOIN \
       Playlist p JOIN Songs s ON ps.SongID = s.SongID \
           JOIN Genre g on p.GenreID = g.GenreID  \
               JOIN Artists a ON s.ArtistID = a.ArtistID WHERE PlaylistID = ' + str(pID)
   current_app.logger.info(query)


   cursor = db.get_db().cursor()
   cursor.execute(query)
   column_headers = [x[0] for x in cursor.description]
   json_data = []
   the_data = cursor.fetchall()
   for row in the_data:
       json_data.append(dict(zip(column_headers, row)))
   return jsonify(json_data)





# Deletes a song from a playlist
@playlistsong.route('/playlistsong', methods=['DELETE'])
def delete_song_playlist():
    the_data = request.json
    pID = str(the_data["PlaylistID"])
    songID = str(the_data["SongID"])

    query = 'DELETE FROM Playlist_Songs WHERE PlaylistID = ' + pID + ' AND SongID = ' + songID
    # executing and committing the insert statement 
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return jsonify({'message': 'Song deleted successfully'}), 200