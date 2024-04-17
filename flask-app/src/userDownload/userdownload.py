from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


downloads  = Blueprint('User_Downloads', __name__)


 # Deletes a playlist given the pID
@downloads.route('/userdownloads/<userID>/<playlistID>', methods=['DELETE'])
def delete_playlist(userID, playlistID):
    query = 'DELETE FROM User_Downloads WHERE UserID = ' + str(userID) + ' && PlaylistID = ' + str(playlistID)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return jsonify({'message': 'Playlist deleted successfully from User'}), 200
