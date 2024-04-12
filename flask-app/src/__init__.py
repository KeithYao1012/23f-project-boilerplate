# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'spotigram'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the 3200 boilerplate app</h1>"

    # Import the various Blueprint Objects
    from src.users.users import users
    from src.artists.artists  import artists
    from src.community.community import community
    from src.curator.curators import curators
    from src.producers.producers import producers
    from src.playlist.playlists import playlists
    from src.userDownload.userdownload import downloads

    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.register_blueprint(users,   url_prefix='/u')
    app.register_blueprint(artists,    url_prefix='/a')
    app.register_blueprint(community,   url_prefix='/cm/')
    app.register_blueprint(curators,    url_prefix='/c')
    app.register_blueprint(producers,    url_prefix='/p')
    app.register_blueprint(playlists,    url_prefix='/pl')
    app.register_blueprint(downloads,    url_prefix='/d')

    # Don't forget to return the app object
    return app