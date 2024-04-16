from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db
from datetime import datetime


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
@songs.route('/song/genresong/<genreName>', methods=['GET'])
def get_song_by_id(genreName):

    query = '''SELECT a.Artist_Name, s.GenreID, g.GenreName, s.Title, s.Length, s.Plays, s.CreatedAt, s.SongID
        FROM Songs s
        INNER JOIN Genre g ON g.GenreID = s.GenreID
        JOIN Artists a ON s.ArtistID = a.ArtistID
        WHERE s.GenreID = (
            SELECT GenreID FROM Genre
            WHERE GenreName = '%s'
        )
        ''' % (genreName)
    format_string = "%Y-%m-%d"
    
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        row[6].strftime(format_string)
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)


# Gets all songs by a certain artist
@songs.route('/song/artistsong/<artist_name>', methods=['GET'])
def get_song_by_artist(artist_name):

    query =  """
    SELECT a.Artist_Name, s.Title, s.Plays, s.Length, s.CreatedAt
    FROM Songs s
    JOIN Artist_Songs art_songs ON s.SongID = art_songs.SongID
    JOIN Artists a ON a.ArtistID = art_songs.ArtistID
    WHERE a.Artist_Name = \'"""+ str(artist_name) + '\';'
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
@songs.route('/song/artistsong/metrics/<artist_name>', methods=['GET'])
def get_song_metrics_by_artist(artist_name):

    query =  '''SELECT a.Artist_Name, s.Title, s.Plays, s.Length, s.CreatedAt
    FROM Songs s
    JOIN Artist_Songs art_songs ON s.SongID = art_songs.SongID
    JOIN Artists a ON a.ArtistID = art_songs.ArtistID
    WHERE a.Artist_Name = \'''' + str(artist_name) + '''\'
    ORDER BY s.CreatedAt'''
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    format_string = "%Y-%m-%d"
    the_data = cursor.fetchall()
    for row in the_data:
        song = {
            'x': str(row[1]) + "\n Created At: " + str(row[4].strftime(format_string)),  # Title as 'X'
            'y': row[2],  # Plays as 'Y'
        }
        json_data.append(song)
    return jsonify(json_data)







