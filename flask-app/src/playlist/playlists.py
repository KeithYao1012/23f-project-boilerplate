from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


playlists  = Blueprint('Playlist', __name__)

# Get all the playlists
@playlists.route('/playlist', methods=['GET'])
def get_playlists():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT PlaylistID, PlaylistName FROM Playlists')

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

# Get a specific playlist 
@playlists.route('/playlist/<pID>', methods=['GET'])
def get_playlist(pID):

    query = 'SELECT PlaylistID, PlaylistName FROM Playlists WHERE PlaylistID = ' + str(pID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Gets all playlists that a specific artist has
@playlists.route('/playlist/<artistID>', methods=['GET'])
def get_artist_playlists(artistID):
    query = 'SELECT p.PlaylistID, p.PlaylistName FROM Playlist p \
        JOIN Playlist_Songs ps ON ps.PlaylistID = p.PlaylistID \
        JOIN Songs s ON s.songID = ps.songID \
        JOIN Artist_Songs as ON as.songID = s.songID \
        JOIN Arist a on a.artistID = as.artistID \
        WHERE a.artistID = ' + str(artistID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Adds a new playlist
@playlists.route('/playlist', methods=['POST'])
def add_new_playlist():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['PlaylistID']
    name = the_data['PlaylistName']


    # Constructing the query
    query = 'insert into playlists (PlaylistID, PlaylistName) values ("'
    query += id + '", "'
    query += name + '", "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Updates a current playlist
@playlists.route('/playlist/<pID>', methods=['PUT'])
def update_playlist(pID):
    playlist = playlists.query.get_or_404(pID)
    data = request.get_json()
    playlist.name = data['PlaylistName']
    db.session.commit()
    return jsonify({'message': 'Playlist updated successfully!'}), 200

# Deletes a playlist given the pID
@playlists.route('/playlist/<pID>', methods=['DELETE'])
def delete_playlist(pID):
    playlist = playlists.query.get_or_404(pID)
    db.session.delete(playlist)
    db.session.commit()
    return jsonify({'message': 'Playlist deleted successfully'}), 200

# Retreives all playlists of a certain user downloaded
@playlists.route('/playlist/<userID>', methods=['GET'])
def get_downloaded_playlist(userID):
    query = 'SELECT p.PlaylistID, p.PlaylistName FROM Playlist p \
        JOIN User_downloads ud ON ud.PlaylistID = p.PlaylistID \
        JOIN Users u ON u.UserID = ud.UserID \
        WHERE u.UserID = ' + str(userID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Retreives all playlists a curator made
@playlists.route('/playlist/<curatorID>', methods=['GET'])
def get_curator_playlist(curatorID):
    query = 'SELECT p.PlaylistID, p.PlaylistName FROM Playlist p \
        JOIN Curator_Playlist cp ON cp.PlaylistID = p.PlaylistID \
        JOIN Curator c ON c.CuratorID = cp.CuratorID \
        WHERE c.CuratorID = ' + str(curatorID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Retreives all playlists a curator made
@playlists.route('/playlist/<genreID>', methods=['GET'])
def get_paylist_by_genre(genreID):
    query = 'SELECT p.PlaylistID, p.PlaylistName, p. FROM Playlist p \
        JOIN genre g ON g.GenreID = p.GenreID \
        WHERE g.GenreID = ' + str(genreID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Adds a new playlist to user downloads
@playlists.route('/playlist/<userID>', methods=['POST'])
def add_new_playlist(userID):
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    playlistID = the_data['PlaylistID']

    # Constructing the query
    query = 'insert into User_Downloads (UserID, PlaylistID) values ("'
    query += userID + '", "'
    query += playlistID + '", "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

 # Deletes a playlist given the pID
@playlists.route('/playlist/<userID>/<playlistID>', methods=['DELETE'])
def delete_playlist(userID, playlistID):
    playlist = playlists.query.get_or_404(playlistID)
    db.session.delete(playlist)
    db.session.commit()
    return jsonify({'message': 'Playlist deleted successfully'}), 200
