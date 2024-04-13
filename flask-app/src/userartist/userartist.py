from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


follows  = Blueprint('User_Following', __name__)



# Adds a user who supports an artist
@follows.route('/users/<userID>/<artistID>', methods=['POST'])
def user_support_artist(userID, artistID):
 # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    user_id = the_data['UserID']
    artist_id = the_data['ArtistID']


    # Constructing the query
    query = 'insert into User_Following(UserID, ArtistID) values ("'
    query += user_id + '", "'
    query += artist_id + '") "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Deletes a connection from a user who supporsts an artist
@follows.route('/users/<userID>/<artistID>', methods=['DELETE'])
def delete_support_artist(userID, artistID):
    userart = follows.query.get_or_404(UserId = userID, ArtistId = artistID)
    db.session.delete(userart)
    db.session.commit()
    
    return 'Success!'