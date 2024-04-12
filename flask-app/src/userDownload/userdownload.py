from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


downloads  = Blueprint('User_Downloads', __name__)


 # Deletes a playlist given the pID
@downloads.route('/userdownloads/<userID>/<playlistID>', methods=['DELETE'])
def delete_playlist(userID, playlistID):
    playlist = downloads.query.get_or_404(PlaylistID = playlistID, UserID = userID)
    db.session.delete(playlist)
    db.session.commit()
    return jsonify({'message': 'Playlist deleted successfully from User'}), 200
