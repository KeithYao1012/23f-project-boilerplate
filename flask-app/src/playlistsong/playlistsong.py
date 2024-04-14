from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


playlistsong  = Blueprint('Playlist_Songs', __name__)



# Adds a song to a playlist
@playlistsong.route('/playlistsong/<pID>/<songID>', methods=['POST'])
def add_new_song_to_playlist(pID, songID):
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # Constructing the query
    query = 'insert into Playlist_Songs (PlaylistID, SongID) values ("'
    query += pID + '", "'
    query += songID + '") "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'




# Deletes a song from a playlist
@playlistsong.route('/playlistsong/<pID>/<songID>', methods=['DELETE'])
def delete_song_playlist(pID, songID):
    playlistsong = playlistsong.query.get_or_404(PlaylistID = pID, SongID = songID)
    db.session.delete(playlistsong)
    db.session.commit()
    return jsonify({'message': 'Song deleted successfully'}), 200




