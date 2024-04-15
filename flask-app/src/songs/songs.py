from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


songs  = Blueprint('Songs', __name__)

# Get all the songs
@songs.route('/song', methods=['GET'])
def get_songs():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Songs NATURAL JOIN Artists \
                   NATURAL JOIN Genre')

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

# Get a specific song
@songs.route('/song/<songID>', methods=['GET'])
def get_song(songID):

    query = 'SELECT ArtistID, GenreID, TItle, Length, Plays, CreatedAt FROM Songs WHERE SongID = ' + str(songID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Adds a new song
@songs.route('/song', methods=['POST'])
def add_new_song():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    artistID = the_data['ArtistID']
    genreID = the_data['GenreID']
    title = the_data['Title']
    length = the_data['Length']
    plays = the_data['Plays']
    createdAt = the_data['CreatedAt']

    # Constructing the query
    query = 'insert into songs values ("'
    query += artistID + '", "'
    query += genreID + '", "'
    query += title + '", "'
    query += length + '", "'
    query += plays + '", "'
    query += createdAt + '"; "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Updates a current song
@songs.route('/song/<songID>', methods=['PUT'])
def update_song(songID):
    song = songs.query.get_or_404(songID)
    data = request.get_json()
    song.artistID = data['ArtistID']
    song.genreID = data['GenreID']
    song.title = data['Title']
    song.length = data['Length']
    song.plays = data['Plays']
    song.createdAt = data['CreatedAt']
    db.session.commit()
    return jsonify({'message': 'Song updated successfully!'}), 200

# Delete the song with the given <songID>
@songs.route('/song/<songID>', methods=['DELETE'])
def delete_song(songID):
    song = songs.query.get_or_404(songID)
    db.session.delete(song)
    db.session.commit()
    return jsonify({'message': 'Song deleted successfully'}), 200


# Gets all songs with a certain genre
@songs.route('/song/genresong/<genreID>', methods=['GET'])
def get_song_by_id(genreID):

    query = 'SELECT ArtistID, GenreID, Title, Length, Plays, CreatedAt FROM Songs WHERE GenreID = ' + str(genreID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Gets all songs by a certain artist
@songs.route('/song/artistsong/<artist_name>', methods=['GET'])
def get_song_by_artist(artist_name):

    query = 'SELECT s.Title, s.Plays, s.Length, s.CreatedAt \
            FROM Songs s JOIN Artist_Songs as ON s.SongID = as.SongID \
            JOIN Artist a ON a.ArtistID = as.ArtistID \
            WHERE a.Artist_Name = ' + str(artist_name)
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
@songs.route('/song/usersong/<username>', methods=['GET'])
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

# Gets all songs by a that a specfic user has downloaded
@songs.route('/song/usersong/<username>', methods=['POST'])
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



