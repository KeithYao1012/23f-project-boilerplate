from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


curatorplaylist  = Blueprint('Curator_Playlist', __name__)


# Adds a  playlist to a curators portfolio
@curatorplaylist.route('/curatorplaylist/<pID>/<curatorID>', methods=['POST'])
def add_new_playlist_to_curator(pID, curatorID):
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # Constructing the query
    query = 'insert into Curator_Playlist (PlaylistID, CuratorID) values ("'
    query += pID + '", "'
    query += curatorID + '") "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'




# Deletes a playlist from a Curator's Portfolio
@curatorplaylist.route('/curatorplaylist/<pID>/<curatorID>', methods=['DELETE'])
def delete_curator_playlist(pID, curatorID):
    query = 'DELETE FROM Curator_Playlist WHERE PlayistID = ' + str(pID) + ' && CuratorID = ' + str(curatorID)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return jsonify({'message': 'Playlist deleted successfully'}), 200