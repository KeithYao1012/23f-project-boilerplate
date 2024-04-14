DROP SCHEMA IF EXISTS spotigram;
CREATE SCHEMA IF NOT EXISTS spotigram;
USE spotigram;
CREATE TABLE IF NOT EXISTS Users(
    UserID integer AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS Curator(
    CuratorID integer AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS Curator_Post(
    PostID integer AUTO_INCREMENT PRIMARY KEY,
    Creation_Date date DEFAULT (CURRENT_DATE),
    CuratorID integer NOT NULL,
    Post_Content VARCHAR(300) NOT NULL,
    FOREIGN KEY (CuratorID) REFERENCES Curator(CuratorID) ON UPDATE RESTRICT ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS Artists(
    ArtistID INTEGER AUTO_INCREMENT PRIMARY KEY,
    Artist_Name VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS Artist_Post(
    PostID INTEGER AUTO_INCREMENT PRIMARY KEY,
    ArtistID INTEGER NOT NULL,
    Creation_Date datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Content VARCHAR(300) NOT NULL,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Genre(
    GenreID INTEGER AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS Playlist(
    PlaylistID INTEGER AUTO_INCREMENT PRIMARY KEY,
    PlaylistName VARCHAR(100) NOT NULL,
    GenreID INTEGER NOT NULL,
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Songs(
    SongID INTEGER AUTO_INCREMENT PRIMARY KEY,
    ArtistID INTEGER NOT NULL,
    GenreID INTEGER NOT NULL,
    Title VARCHAR(50) NOT NULL,
    Length REAL NOT NULL,
    Plays INTEGER NOT NULL,
    CreatedAt datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Producer(
    ProducerID INTEGER AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS Message(
    MessageID INTEGER AUTO_INCREMENT PRIMARY KEY,
    ToUserID INTEGER NOT NULL,
    FromUserID INTEGER NOT NULL,
    Content VARCHAR(300) NOT NULL,
    FOREIGN KEY (ToUserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (FromUserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Community(
    CommunityID INTEGER AUTO_INCREMENT PRIMARY KEY,
    Com_Name VARCHAR(50) NOT NULL,
    GenreID INTEGER NOT NULL,
    Com_Desc VARCHAR(300) NOT NULL,
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Friends(
    UserID1 INTEGER,
    UserID2 INTEGER,
    PRIMARY KEY(UserID1, UserID2),
    FOREIGN KEY (UserID1) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (UserID2) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS User_Community(
    UserID INTEGER,
    CommunityID INTEGER,
    PRIMARY KEY(UserID, CommunityID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (CommunityID) REFERENCES Community(CommunityID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Prod_Artist(
    ArtistID INTEGER,
    ProducerID INTEGER,
    PRIMARY KEY(ArtistID, ProducerID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (ProducerID) REFERENCES Producer(ProducerID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Producer_Credit(
    SongID INTEGER,
    ProducerID INTEGER,
    PRIMARY KEY(SongID, ProducerID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (ProducerID) REFERENCES Producer(ProducerID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Artist_Songs(
    ArtistID INTEGER,
    SongID INTEGER,
    Royalties REAL,
    PRIMARY KEY(ArtistID, SongID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS User_Song(
    UserID INTEGER,
    SongID INTEGER,
    User_Plays INTEGER,
    PRIMARY KEY(UserID, SongID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Curator_Playlist(
    CuratorID INTEGER,
    PlaylistID INTEGER,
    PRIMARY KEY(CuratorID, PlaylistID),
    FOREIGN KEY (CuratorID) REFERENCES Curator(CuratorID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS User_Downloads(
    UserID INTEGER,
    PlaylistID INTEGER,
    PRIMARY KEY(UserID, PlaylistID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Playlist_Songs(
    PlaylistID INTEGER,
    SongID INTEGER,
    PRIMARY KEY(PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS User_Following(
    UserID INTEGER,
    ArtistID INTEGER,
    PRIMARY KEY(UserID, ArtistID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS UserCurator_Interact(
    UserID INTEGER,
    PostID INTEGER,
    Comments VARCHAR(300),
    Interactions BOOLEAN,
    PRIMARY KEY(UserID, PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (PostID) REFERENCES Curator_Post(PostID) ON UPDATE RESTRICT ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS UserArtist_Interactions(
    UserID INTEGER,
    PostID INTEGER NOT NULL,
    Comments VARCHAR(150),
    Interactions BOOLEAN,
    PRIMARY KEY(UserID, PostID),
    CONSTRAINT fk01 FOREIGN KEY (UserID) REFERENCES Users(UserID) ON UPDATE RESTRICT ON DELETE CASCADE,
    CONSTRAINT fk02 FOREIGN KEY (PostID) REFERENCES Artist_Post(PostID) ON UPDATE RESTRICT ON DELETE CASCADE
);
SE spotigram;
-- Data for table Users
INSERT INTO Users
VALUES(1, 'Gustav22');
INSERT INTO Users
VALUES(2, 'GeraldIsBack1');
INSERT INTO Users
VALUES(3, 'angiezz');
INSERT INTO Users
VALUES(4, 'kpirrie3');
INSERT INTO Users
VALUES(5, 'rbims4');
INSERT INTO Users
VALUES(6, 'jsmees5');
INSERT INTO Users
VALUES(7, 'byeell6');
INSERT INTO Users
VALUES(8, 'bphilps7');
INSERT INTO Users
VALUES(9, 'ateeney8');
INSERT INTO Users
VALUES(10, 'pmiko9');
INSERT INTO Users
VALUES(11, 'chamala');
INSERT INTO Users
VALUES(12, 'mbreedyb');
INSERT INTO Users
VALUES(13, 'sbixleyc');
INSERT INTO Users
VALUES(14, 'csteeplesd');
INSERT INTO Users
VALUES(15, 'srickardse');
INSERT INTO Users
VALUES(16, 'fdilkef');
INSERT INTO Users
VALUES(17, 'dlamasg');
INSERT INTO Users
VALUES(18, 'mlantaphh');
INSERT INTO Users
VALUES(19, 'hgromleyi');
INSERT INTO Users
VALUES(20, 'mgarbuttj');
INSERT INTO Users
VALUES(21, 'vellcockk');
INSERT INTO Users
VALUES(22, 'gaskelll');
INSERT INTO Users
VALUES(23, 'yjoneym');
INSERT INTO Users
VALUES(24, 'bmcgeouchn');
INSERT INTO Users
VALUES(25, 'lpendleburyo');
INSERT INTO Users
VALUES(26, 'pguyotp');
INSERT INTO Users
VALUES(27, 'ctapsfieldq');
INSERT INTO Users
VALUES(28, 'bcalleyr');
INSERT INTO Users
VALUES(29, 'cfineys');
INSERT INTO Users
VALUES(30, 'lmarrisont');
INSERT INTO Users
VALUES(31, 'bgiacoppoliu');
INSERT INTO Users
VALUES(32, 'dtitchenerv');
INSERT INTO Users
VALUES(33, 'cklimentyonokw');
INSERT INTO Users
VALUES(34, 'rstookesx');
INSERT INTO Users
VALUES(35, 'esawley');
INSERT INTO Users
VALUES(36, 'swaitlandz');
INSERT INTO Users
VALUES(37, 'bhabbeshaw10');
INSERT INTO Users
VALUES(38, 'eleckenby11');
INSERT INTO Users
VALUES(39, 'smaitland12');
INSERT INTO Users
VALUES(40, 'ayouster13');
INSERT INTO Users
VALUES(41, 'scausley14');
INSERT INTO Users
VALUES(42, 'drickford15');
INSERT INTO Users
VALUES(43, 'cwitherdon16');
INSERT INTO Users
VALUES(44, 'wmaier17');
INSERT INTO Users
VALUES(45, 'gbaudrey18');
INSERT INTO Users
VALUES(46, 'jgreson19');
INSERT INTO Users
VALUES(47, 'sdyers1a');
INSERT INTO Users
VALUES(48, 'uchipman1b');
INSERT INTO Users
VALUES(49, 'dseide1c');
INSERT INTO Users
VALUES(50, 'dsiely1d');
INSERT INTO Users
VALUES(51, 'droscamps1e');
INSERT INTO Users
VALUES(52, 'wmatura1f');
INSERT INTO Users
VALUES(53, 'owilloughley1g');
INSERT INTO Users
VALUES(54, 'kboor1h');
INSERT INTO Users
VALUES(55, 'enunnerley1i');
INSERT INTO Users
VALUES(56, 'acurwood1j');
INSERT INTO Users
VALUES(57, 'epostance1k');
INSERT INTO Users
VALUES(58, 'cyouthead1l');
INSERT INTO Users
VALUES(59, 'wwintle1m');
INSERT INTO Users
VALUES(60, 'alogan1n');
-- Data for table Curators
INSERT INTO Curator
VALUES(1, 'PierreIsGreat');
INSERT INTO Curator
VALUES(2, 'FrancisPop');
INSERT INTO Curator
VALUES(3, 'Tabina');
INSERT INTO Curator
VALUES(4, 'Imelda');
INSERT INTO Curator
VALUES(5, 'Janna');
INSERT INTO Curator
VALUES(6, 'Adara');
INSERT INTO Curator
VALUES(7, 'Zitella');
INSERT INTO Curator
VALUES(8, 'Neall');
INSERT INTO Curator
VALUES(9, 'Ernesto');
INSERT INTO Curator
VALUES(10, 'Beatrix');
INSERT INTO Curator
VALUES(11, 'Emmott');
INSERT INTO Curator
VALUES(12, 'Hyacinthie');
INSERT INTO Curator
VALUES(13, 'Arabelle');
INSERT INTO Curator
VALUES(14, 'Stephanus');
INSERT INTO Curator
VALUES(15, 'Mylo');
INSERT INTO Curator
VALUES(16, 'Tiphany');
INSERT INTO Curator
VALUES(17, 'Francisco');
INSERT INTO Curator
VALUES(18, 'Brendan');
INSERT INTO Curator
VALUES(19, 'Sascha');
INSERT INTO Curator
VALUES(20, 'Alyda');
INSERT INTO Curator
VALUES(21, 'Phoebe');
INSERT INTO Curator
VALUES(22, 'Doralin');
INSERT INTO Curator
VALUES(23, 'Gerrilee');
INSERT INTO Curator
VALUES(24, 'Loydie');
INSERT INTO Curator
VALUES(25, 'Mikey');
INSERT INTO Curator
VALUES(26, 'Esmaria');
INSERT INTO Curator
VALUES(27, 'Dalenna');
INSERT INTO Curator
VALUES(28, 'Cole');
INSERT INTO Curator
VALUES(29, 'Cletus');
INSERT INTO Curator
VALUES(30, 'Demetris');
INSERT INTO Curator
VALUES(31, 'Alexandrina');
INSERT INTO Curator
VALUES(32, 'Port');
INSERT INTO Curator
VALUES(33, 'Nell');
INSERT INTO Curator
VALUES(34, 'Gregoor');
INSERT INTO Curator
VALUES(35, 'Gaile');
INSERT INTO Curator
VALUES(36, 'Nyssa');
INSERT INTO Curator
VALUES(37, 'Rasia');
INSERT INTO Curator
VALUES(38, 'Catharina');
INSERT INTO Curator
VALUES(39, 'Babita');
INSERT INTO Curator
VALUES(40, 'Pierson');
INSERT INTO Curator
VALUES(41, 'Heath');
INSERT INTO Curator
VALUES(42, 'Langston');
INSERT INTO Curator
VALUES(43, 'Virgilio');
INSERT INTO Curator
VALUES(44, 'Aretha');
INSERT INTO Curator
VALUES(45, 'Rodrick');
INSERT INTO Curator
VALUES(46, 'Tressa');
INSERT INTO Curator
VALUES(47, 'Geoffrey');
INSERT INTO Curator
VALUES(48, 'Tana');
INSERT INTO Curator
VALUES(49, 'Hazel');
INSERT INTO Curator
VALUES(50, 'Yuri');
INSERT INTO Curator
VALUES(51, 'Glori');
INSERT INTO Curator
VALUES(52, 'Allan');
INSERT INTO Curator
VALUES(53, 'Lona');
INSERT INTO Curator
VALUES(54, 'Townsend');
INSERT INTO Curator
VALUES(55, 'Morgen');
INSERT INTO Curator
VALUES(56, 'Koenraad');
INSERT INTO Curator
VALUES(57, 'Gilburt');
INSERT INTO Curator
VALUES(58, 'Wadsworth');
INSERT INTO Curator
VALUES(59, 'Margalit');
INSERT INTO Curator
VALUES(60, 'Westbrooke');
-- Data for table Artists
INSERT INTO Artists
VALUES(1, 'Annie Fields');
INSERT INTO Artists
VALUES(2, 'Noah Jones');
INSERT INTO Artists
VALUES(3, 'Pandora');
INSERT INTO Artists
VALUES(4, 'Clemence');
INSERT INTO Artists
VALUES(5, 'Kerby');
INSERT INTO Artists
VALUES(6, 'Osborne');
INSERT INTO Artists
VALUES(7, 'Daphene');
INSERT INTO Artists
VALUES(8, 'Min');
INSERT INTO Artists
VALUES(9, 'Ava');
INSERT INTO Artists
VALUES(10, 'Leeann');
INSERT INTO Artists
VALUES(11, 'Ami');
INSERT INTO Artists
VALUES(12, 'Jedidiah');
INSERT INTO Artists
VALUES(13, 'Remington');
INSERT INTO Artists
VALUES(14, 'Morris');
INSERT INTO Artists
VALUES(15, 'Joelynn');
INSERT INTO Artists
VALUES(16, 'Aguie');
INSERT INTO Artists
VALUES(17, 'Prentiss');
INSERT INTO Artists
VALUES(18, 'Jacquelynn');
INSERT INTO Artists
VALUES(19, 'Fancy');
INSERT INTO Artists
VALUES(20, 'Beverlee');
INSERT INTO Artists
VALUES(21, 'Keir');
INSERT INTO Artists
VALUES(22, 'Bebe');
INSERT INTO Artists
VALUES(23, 'Maurita');
INSERT INTO Artists
VALUES(24, 'Joline');
INSERT INTO Artists
VALUES(25, 'Rea');
INSERT INTO Artists
VALUES(26, 'Magda');
INSERT INTO Artists
VALUES(27, 'Carlin');
INSERT INTO Artists
VALUES(28, 'Abby');
INSERT INTO Artists
VALUES(29, 'Alejandra');
INSERT INTO Artists
VALUES(30, 'Isa');
INSERT INTO Artists
VALUES(31, 'Sandro');
INSERT INTO Artists
VALUES(32, 'Bourke');
INSERT INTO Artists
VALUES(33, 'Griffith');
INSERT INTO Artists
VALUES(34, 'Arch');
INSERT INTO Artists
VALUES(35, 'Travis');
INSERT INTO Artists
VALUES(36, 'Morgan');
INSERT INTO Artists
VALUES(37, 'Harry');
INSERT INTO Artists
VALUES(38, 'Marchelle');
INSERT INTO Artists
VALUES(39, 'Errick');
INSERT INTO Artists
VALUES(40, 'Hussein');
INSERT INTO Artists
VALUES(41, 'Karissa');
INSERT INTO Artists
VALUES(42, 'Nollie');
INSERT INTO Artists
VALUES(43, 'Link');
INSERT INTO Artists
VALUES(44, 'Ashton');
INSERT INTO Artists
VALUES(45, 'Sanson');
INSERT INTO Artists
VALUES(46, 'Joleen');
INSERT INTO Artists
VALUES(47, 'Arlette');
INSERT INTO Artists
VALUES(48, 'Philomena');
INSERT INTO Artists
VALUES(49, 'Wenonah');
INSERT INTO Artists
VALUES(50, 'Tommy');
INSERT INTO Artists
VALUES(51, 'Katharyn');
INSERT INTO Artists
VALUES(52, 'Odessa');
INSERT INTO Artists
VALUES(53, 'Lynne');
INSERT INTO Artists
VALUES(54, 'Christabel');
INSERT INTO Artists
VALUES(55, 'Margret');
INSERT INTO Artists
VALUES(56, 'Bessie');
INSERT INTO Artists
VALUES(57, 'Kerianne');
INSERT INTO Artists
VALUES(58, 'Robinet');
INSERT INTO Artists
VALUES(59, 'Ahmed');
INSERT INTO Artists
VALUES(60, 'Ninon');
-- Data for table Genre
INSERT INTO Genre
VALUES(1, 'Pop');
INSERT INTO Genre
VALUES(2, 'Rock');
INSERT INTO Genre
VALUES(3, 'R&B');
INSERT INTO Genre
VALUES(4, 'Jazz');
INSERT INTO Genre
VALUES(5, 'Blues');
INSERT INTO Genre
VALUES(6, 'Country');
INSERT INTO Genre
VALUES(7, 'Folk');
INSERT INTO Genre
VALUES(8, 'Funk');
INSERT INTO Genre
VALUES(9, 'Musical Theatre');
INSERT INTO Genre
VALUES(10, 'Hip Hop');
INSERT INTO Genre
VALUES(11, 'Ska');
INSERT INTO Genre
VALUES(12, 'Techno');
INSERT INTO Genre
VALUES(13, 'K-Pop');
INSERT INTO Genre
VALUES(14, 'Indie');
INSERT INTO Genre
VALUES(15, 'Indie Rock');
INSERT INTO Genre
VALUES(16, 'Reggae');
INSERT INTO Genre
VALUES(17, 'Opera');
INSERT INTO Genre
VALUES(18, 'Classical');
INSERT INTO Genre
VALUES(19, 'Instrumental');
INSERT INTO Genre
VALUES(20, 'Punk Rock');
INSERT INTO Genre
VALUES(21, 'Indie Rock');
INSERT INTO Genre
VALUES(22, 'Lo-Fi');
INSERT INTO Genre
VALUES(23, 'New Wave');
INSERT INTO Genre
VALUES(24, 'Acoustic Blues');
INSERT INTO Genre
VALUES(25, 'Orchestral');
INSERT INTO Genre
VALUES(26, 'Parody');
INSERT INTO Genre
VALUES(27, 'Vaudeville');
INSERT INTO Genre
VALUES(28, 'Zydeco');
INSERT INTO Genre
VALUES(29, 'Film Score');
INSERT INTO Genre
VALUES(30, 'Britpunk');
INSERT INTO Genre
VALUES(31, 'Alt Rock');
INSERT INTO Genre
VALUES(32, 'Country Blues');
INSERT INTO Genre
VALUES(33, 'Jazz Blues');
INSERT INTO Genre
VALUES(34, 'Folk Blues');
INSERT INTO Genre
VALUES(35, 'Soul Blues');
INSERT INTO Genre
VALUES(36, 'Lullabies');
INSERT INTO Genre
VALUES(37, 'Modern Classical');
INSERT INTO Genre
VALUES(38, 'Ballet');
INSERT INTO Genre
VALUES(39, 'Modern Blues');
INSERT INTO Genre
VALUES(40, 'Goth Rock');
INSERT INTO Producer
VALUES(1, 'Claire Lemon');
INSERT INTO Producer
VALUES(2, 'Amelie Smith');
INSERT INTO Producer
VALUES(3, 'Efren');
INSERT INTO Producer
VALUES(4, 'Vilhelmina');
INSERT INTO Producer
VALUES(5, 'Aristotle');
INSERT INTO Producer
VALUES(6, 'Alexander');
INSERT INTO Producer
VALUES(7, 'Dmitri');
INSERT INTO Producer
VALUES(8, 'Melisandra');
INSERT INTO Producer
VALUES(9, 'Peyter');
INSERT INTO Producer
VALUES(10, 'Tedmund');
INSERT INTO Producer
VALUES(11, 'Minerva');
INSERT INTO Producer
VALUES(12, 'Dominique');
INSERT INTO Producer
VALUES(13, 'Audry');
INSERT INTO Producer
VALUES(14, 'Marsiella');
INSERT INTO Producer
VALUES(15, 'Julie');
INSERT INTO Producer
VALUES(16, 'Ryon');
INSERT INTO Producer
VALUES(17, 'Hilarius');
INSERT INTO Producer
VALUES(18, 'Enrico');
INSERT INTO Producer
VALUES(19, 'Esmeralda');
INSERT INTO Producer
VALUES(20, 'Cosette');
INSERT INTO Producer
VALUES(21, 'Monty');
INSERT INTO Producer
VALUES(22, 'Oona');
INSERT INTO Producer
VALUES(23, 'Ansel');
INSERT INTO Producer
VALUES(24, 'Blythe');
INSERT INTO Producer
VALUES(25, 'Bernetta');
INSERT INTO Producer
VALUES(26, 'Godfry');
INSERT INTO Producer
VALUES(27, 'Carolin');
INSERT INTO Producer
VALUES(28, 'Jacob');
INSERT INTO Producer
VALUES(29, 'Antoine');
INSERT INTO Producer
VALUES(30, 'Zulema');
INSERT INTO Producer
VALUES(31, 'Arabele');
INSERT INTO Producer
VALUES(32, 'Nicolea');
INSERT INTO Producer
VALUES(33, 'Fred');
INSERT INTO Producer
VALUES(34, 'Terrell');
INSERT INTO Producer
VALUES(35, 'Clarabelle');
INSERT INTO Producer
VALUES(36, 'Nell');
INSERT INTO Producer
VALUES(37, 'Matt');
INSERT INTO Producer
VALUES(38, 'Karlotta');
INSERT INTO Producer
VALUES(39, 'Sibel');
INSERT INTO Producer
VALUES(40, 'Carmine');
INSERT INTO Producer
VALUES(41, 'Dexter');
INSERT INTO Producer
VALUES(42, 'Weber');
INSERT INTO Producer
VALUES(43, 'Alaster');
INSERT INTO Producer
VALUES(44, 'Dael');
INSERT INTO Producer
VALUES(45, 'Mair');
INSERT INTO Producer
VALUES(46, 'Beatrisa');
INSERT INTO Producer
VALUES(47, 'Kassi');
INSERT INTO Producer
VALUES(48, 'Hodge');
INSERT INTO Producer
VALUES(49, 'Cinderella');
INSERT INTO Producer
VALUES(50, 'Amandie');
INSERT INTO Producer
VALUES(51, 'Stephana');
INSERT INTO Producer
VALUES(52, 'Danit');
INSERT INTO Producer
VALUES(53, 'Berty');
INSERT INTO Producer
VALUES(54, 'Madge');
INSERT INTO Producer
VALUES(55, 'Estrella');
INSERT INTO Producer
VALUES(56, 'Glenna');
INSERT INTO Producer
VALUES(57, 'Hadrian');
INSERT INTO Producer
VALUES(58, 'Vinson');
INSERT INTO Producer
VALUES(59, 'Glyn');
INSERT INTO Producer
VALUES(60, 'Kippie');
-- Data for table Artist_Post
SQL STATEMENT
INSERT INTO Artist_Post
Values(
        1,
        16,
        '2023-11-13 04:05:00',
        'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.'
    );
INSERT INTO Artist_Post
Values(
        2,
        36,
        '2024-03-17 20:12:00',
        'Pellentesque viverra pede ac diam.'
    );
INSERT INTO Artist_Post
Values(
        3,
        46,
        '2023-10-13 13:48:00',
        'Praesent id massa id nisl venenatis lacinia.'
    );
INSERT INTO Artist_Post
Values(
        4,
        37,
        '2023-04-28 13:49:00',
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.'
    );
INSERT INTO Artist_Post
Values(
        5,
        13,
        '2024-02-26 14:51:00',
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.'
    );
INSERT INTO Artist_Post
Values(
        6,
        46,
        '2024-01-11 11:32:00',
        'Mauris sit amet eros.'
    );
INSERT INTO Artist_Post
Values(
        7,
        27,
        '2024-03-21 17:52:00',
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    );
INSERT INTO Artist_Post
Values(8, 6, '2023-05-24 14:50:00', 'In quis justo.');
INSERT INTO Artist_Post
Values(
        9,
        38,
        '2024-02-22 17:44:00',
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.'
    );
INSERT INTO Artist_Post
Values(
        10,
        42,
        '2024-01-22 06:32:00',
        'Vestibulum rutrum rutrum neque.'
    );
INSERT INTO Artist_Post
Values(
        11,
        24,
        '2023-04-23 12:22:00',
        'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.'
    );
INSERT INTO Artist_Post
Values(
        12,
        10,
        '2023-09-01 03:58:00',
        'Suspendisse potenti.'
    );
INSERT INTO Artist_Post
Values(
        13,
        2,
        '2023-05-29 17:49:00',
        'Mauris lacinia sapien quis libero.'
    );
INSERT INTO Artist_Post
Values(
        14,
        52,
        '2023-08-21 06:47:00',
        'Ut at dolor quis odio consequat varius.'
    );
INSERT INTO Artist_Post
Values(
        15,
        3,
        '2023-08-29 23:54:00',
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'
    );
INSERT INTO Artist_Post
Values(
        16,
        34,
        '2024-01-30 21:59:00',
        'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.'
    );
INSERT INTO Artist_Post
Values(
        17,
        37,
        '2023-12-01 07:13:00',
        'Cras in purus eu magna vulputate luctus.'
    );
INSERT INTO Artist_Post
Values(
        18,
        39,
        '2024-04-01 23:19:00',
        'Pellentesque at nulla.'
    );
INSERT INTO Artist_Post
Values(19, 58, '2023-07-18 05:28:00', 'Nunc purus.');
INSERT INTO Artist_Post
Values(20, 7, '2023-12-10 13:35:00', 'Aenean lectus.');
INSERT INTO Artist_Post
Values(
        21,
        33,
        '2023-08-03 15:40:00',
        'Pellentesque viverra pede ac diam.'
    );
INSERT INTO Artist_Post
Values(
        22,
        25,
        '2024-02-25 17:38:00',
        'Suspendisse ornare consequat lectus.'
    );
INSERT INTO Artist_Post
Values(23, 56, '2024-01-04 23:39:00', 'Integer ac leo.');
INSERT INTO Artist_Post
Values(
        24,
        52,
        '2023-12-29 04:51:00',
        'Aenean fermentum.'
    );
INSERT INTO Artist_Post
Values(
        25,
        56,
        '2023-10-10 18:49:00',
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.'
    );
INSERT INTO Artist_Post
Values(
        26,
        16,
        '2024-01-19 15:37:00',
        'In hac habitasse platea dictumst.'
    );
INSERT INTO Artist_Post
Values(27, 41, '2023-09-05 09:57:00', 'Integer ac leo.');
INSERT INTO Artist_Post
Values(
        28,
        4,
        '2023-06-18 09:11:00',
        'Etiam faucibus cursus urna.'
    );
INSERT INTO Artist_Post
Values(
        29,
        20,
        '2024-01-30 18:45:00',
        'Phasellus in felis.'
    );
INSERT INTO Artist_Post
Values(
        30,
        27,
        '2023-09-09 16:02:00',
        'Duis at velit eu est congue elementum.'
    );
INSERT INTO Artist_Post
Values(
        31,
        29,
        '2023-12-25 18:52:00',
        'Sed vel enim sit amet nunc viverra dapibus.'
    );
INSERT INTO Artist_Post
Values(
        32,
        2,
        '2024-02-11 14:16:00',
        'Donec posuere metus vitae ipsum.'
    );
INSERT INTO Artist_Post
Values(33, 52, '2024-03-12 10:06:00', 'In congue.');
INSERT INTO Artist_Post
Values(
        34,
        51,
        '2023-05-13 11:39:00',
        'Nulla suscipit ligula in lacus.'
    );
INSERT INTO Artist_Post
Values(35, 58, '2023-05-14 10:04:00', 'Nunc purus.');
INSERT INTO Artist_Post
Values(
        36,
        5,
        '2023-08-29 22:48:00',
        'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.'
    );
INSERT INTO Artist_Post
Values(
        37,
        1,
        '2023-05-02 06:27:00',
        'Curabitur in libero ut massa volutpat convallis.'
    );
INSERT INTO Artist_Post
Values(38, 44, '2023-11-09 22:28:00', 'In quis justo.');
INSERT INTO Artist_Post
Values(
        39,
        33,
        '2023-05-16 04:41:00',
        'Proin interdum mauris non ligula pellentesque ultrices.'
    );
INSERT INTO Artist_Post
Values(40, 31, '2024-02-19 14:50:00', 'Vivamus tortor.');
INSERT INTO Artist_Post
Values(41, 33, '2023-08-14 10:09:00', 'Donec ut dolor.');
INSERT INTO Artist_Post
Values(
        42,
        43,
        '2023-07-03 10:53:00',
        'Pellentesque eget nunc.'
    );
INSERT INTO Artist_Post
Values(43, 45, '2024-03-05 21:46:00', 'Ut tellus.');
INSERT INTO Artist_Post
Values(
        44,
        47,
        '2023-05-23 19:00:00',
        'Suspendisse accumsan tortor quis turpis.'
    );
INSERT INTO Artist_Post
Values(
        45,
        50,
        '2023-12-30 02:21:00',
        'Duis consequat dui nec nisi volutpat eleifend.'
    );
INSERT INTO Artist_Post
Values(
        46,
        51,
        '2023-12-27 17:10:00',
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.'
    );
INSERT INTO Artist_Post
Values(
        47,
        35,
        '2024-01-26 15:07:00',
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    );
INSERT INTO Artist_Post
Values(
        48,
        19,
        '2024-01-15 00:48:00',
        'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.'
    );
INSERT INTO Artist_Post
Values(49, 22, '2023-10-12 05:28:00', 'Nulla facilisi.');
INSERT INTO Artist_Post
Values(
        50,
        43,
        '2023-09-19 07:15:00',
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'
    );
INSERT INTO Artist_Post
Values(
        51,
        34,
        '2023-08-23 20:39:00',
        'Mauris ullamcorper purus sit amet nulla.'
    );
INSERT INTO Artist_Post
Values(
        52,
        2,
        '2023-04-26 02:36:00',
        'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.'
    );
INSERT INTO Artist_Post
Values(
        53,
        3,
        '2024-01-04 01:39:00',
        'Proin at turpis a pede posuere nonummy.'
    );
INSERT INTO Artist_Post
Values(
        54,
        34,
        '2024-04-06 16:19:00',
        'Nam tristique tortor eu pede.'
    );
INSERT INTO Artist_Post
Values(
        55,
        16,
        '2023-06-05 12:15:00',
        'Nunc rhoncus dui vel sem.'
    );
INSERT INTO Artist_Post
Values(
        56,
        41,
        '2023-05-26 03:37:00',
        'Duis aliquam convallis nunc.'
    );
INSERT INTO Artist_Post
Values(57, 43, '2023-08-08 17:05:00', 'Integer a nibh.');
INSERT INTO Artist_Post
Values(
        58,
        3,
        '2023-09-13 08:53:00',
        'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.'
    );
INSERT INTO Artist_Post
Values(59, 2, '2023-12-15 22:42:00', 'Ut tellus.');
INSERT INTO Artist_Post
Values(
        60,
        9,
        '2023-10-08 22:37:00',
        'Sed accumsan felis.'
    );
INSERT INTO Artist_Post
Values(
        61,
        1,
        '2023-05-31 11:58:00',
        'Aliquam sit amet diam in magna bibendum imperdiet.'
    );
INSERT INTO Artist_Post
Values(
        62,
        26,
        '2023-08-17 13:11:00',
        'Pellentesque at nulla.'
    );
INSERT INTO Artist_Post
Values(
        63,
        12,
        '2024-03-06 07:51:00',
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.'
    );
INSERT INTO Artist_Post
Values(
        64,
        16,
        '2023-09-01 08:32:00',
        'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.'
    );
INSERT INTO Artist_Post
Values(65, 10, '2023-06-18 06:34:00', 'In congue.');
INSERT INTO Artist_Post
Values(
        66,
        17,
        '2023-08-26 17:38:00',
        'In blandit ultrices enim.'
    );
INSERT INTO Artist_Post
Values(67, 22, '2023-05-08 23:58:00', 'Nunc nisl.');
INSERT INTO Artist_Post
Values(
        68,
        55,
        '2023-09-21 17:37:00',
        'In blandit ultrices enim.'
    );
INSERT INTO Artist_Post
Values(
        69,
        11,
        '2023-12-08 13:24:00',
        'In hac habitasse platea dictumst.'
    );
INSERT INTO Artist_Post
Values(
        70,
        1,
        '2023-11-08 09:19:00',
        'Nullam sit amet turpis elementum ligula vehicula consequat.'
    );
INSERT INTO Artist_Post
Values(
        71,
        35,
        '2023-12-05 07:06:00',
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.'
    );
INSERT INTO Artist_Post
Values(
        72,
        13,
        '2024-03-19 00:57:00',
        'Pellentesque ultrices mattis odio.'
    );
INSERT INTO Artist_Post
Values(73, 39, '2023-12-04 09:54:00', 'Proin risus.');
INSERT INTO Artist_Post
Values(74, 59, '2023-11-13 21:42:00', 'Vivamus tortor.');
INSERT INTO Artist_Post
Values(
        75,
        2,
        '2023-10-23 15:38:00',
        'Vestibulum ac est lacinia nisi venenatis tristique.'
    );
INSERT INTO Artist_Post
Values(76, 4, '2024-02-29 09:27:00', 'Nam dui.');
INSERT INTO Artist_Post
Values(
        77,
        37,
        '2023-12-22 17:58:00',
        'Nulla mollis molestie lorem.'
    );
INSERT INTO Artist_Post
Values(78, 9, '2023-08-17 00:39:00', 'Etiam vel augue.');
INSERT INTO Artist_Post
Values(
        79,
        23,
        '2023-11-19 18:37:00',
        'Morbi porttitor lorem id ligula.'
    );
INSERT INTO Artist_Post
Values(
        80,
        26,
        '2024-03-16 03:30:00',
        'Donec posuere metus vitae ipsum.'
    );
-- Data for table Community
INSERT INTO Community
VALUES (
        1,
        'open architecture',
        29,
        'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.'
    );
INSERT INTO Community
VALUES (
        2,
        'alliance',
        6,
        'Nulla mollis molestie lorem.'
    );
INSERT INTO Community
VALUES (
        3,
        'customer loyalty',
        40,
        'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.'
    );
INSERT INTO Community
VALUES (
        4,
        'intangible',
        16,
        'Nullam molestie nibh in lectus.'
    );
INSERT INTO Community
VALUES (
        5,
        'internet solution',
        36,
        'In sagittis dui vel nisl.'
    );
INSERT INTO Community
VALUES (
        6,
        'global',
        2,
        'Morbi vel lectus in quam fringilla rhoncus.'
    );
INSERT INTO Community
VALUES (
        7,
        'structure',
        32,
        'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.'
    );
INSERT INTO Community
VALUES (
        8,
        'extranet',
        38,
        'Morbi quis tortor id nulla ultrices aliquet.'
    );
INSERT INTO Community
VALUES (
        9,
        'analyzer',
        11,
        'Phasellus id sapien in sapien iaculis congue.'
    );
INSERT INTO Community
VALUES (
        10,
        'open architecture',
        29,
        'Nunc rhoncus dui vel sem.'
    );
INSERT INTO Community
VALUES (11, 'analyzer', 11, 'Aenean sit amet justo.');
INSERT INTO Community
VALUES (
        12,
        'alliance',
        6,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    );
INSERT INTO Community
VALUES (
        13,
        'Organic',
        12,
        'Cras pellentesque volutpat dui.'
    );
INSERT INTO Community
VALUES (
        14,
        'Vision-oriented',
        37,
        'Morbi quis tortor id nulla ultrices aliquet.'
    );
INSERT INTO Community
VALUES (
        15,
        'grid-enabled',
        22,
        'In hac habitasse platea dictumst.'
    );
INSERT INTO Community
VALUES (
        16,
        'systemic',
        5,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.'
    );
INSERT INTO Community
VALUES (17, 'Persistent', 31, 'Vivamus tortor.');
INSERT INTO Community
VALUES (18, 'Progressive', 14, 'Nulla justo.');
INSERT INTO Community
VALUES (19, 'Universal', 18, 'Sed ante.');
INSERT INTO Community
VALUES (20, 'intangible', 27, 'Aliquam non mauris.');
INSERT INTO Community
VALUES (
        21,
        'intangible',
        27,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.'
    );
INSERT INTO Community
VALUES (
        22,
        'Vision-oriented',
        37,
        'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.'
    );
INSERT INTO Community
VALUES (
        23,
        'global',
        2,
        'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.'
    );
INSERT INTO Community
VALUES (24, 'alliance', 6, 'Nulla justo.');
INSERT INTO Community
VALUES (
        25,
        'solution',
        13,
        'Ut at dolor quis odio consequat varius.'
    );
INSERT INTO Community
VALUES (
        26,
        'Persistent',
        31,
        'Aliquam sit amet diam in magna bibendum imperdiet.'
    );
INSERT INTO Community
VALUES (
        27,
        'methodical',
        7,
        'Curabitur gravida nisi at nibh.'
    );
INSERT INTO Community
VALUES (28, 'alliance', 6, 'Nulla tellus.');
INSERT INTO Community
VALUES (
        29,
        'real-time',
        25,
        'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.'
    );
INSERT INTO Community
VALUES (30, 'dynamic', 24, 'Proin risus.');
INSERT INTO Community
VALUES (
        31,
        'grid-enabled',
        22,
        'Vestibulum sed magna at nunc commodo placerat.'
    );
INSERT INTO Community
VALUES (
        32,
        'zero tolerance',
        15,
        'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.'
    );
INSERT INTO Community
VALUES (
        33,
        'Public-key',
        23,
        'Maecenas tincidunt lacus at velit.'
    );
INSERT INTO Community
VALUES (
        34,
        'orchestration',
        21,
        'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.'
    );
INSERT INTO Community
VALUES (
        35,
        'Innovative',
        4,
        'Fusce posuere felis sed lacus.'
    );
INSERT INTO Community
VALUES (
        36,
        'solution',
        13,
        'Cras non velit nec nisi vulputate nonummy.'
    );
INSERT INTO Community
VALUES (37, 'alliance', 6, 'Nulla facilisi.');
INSERT INTO Community
VALUES (
        38,
        'tangible',
        19,
        'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.'
    );
INSERT INTO Community
VALUES (
        39,
        'analyzer',
        11,
        'Morbi vel lectus in quam fringilla rhoncus.'
    );
INSERT INTO Community
VALUES (
        40,
        'dynamic',
        24,
        'Morbi vel lectus in quam fringilla rhoncus.'
    );
INSERT INTO Community
VALUES (
        41,
        'Future-proofed',
        35,
        'Proin at turpis a pede posuere nonummy.'
    );
INSERT INTO Community
VALUES (
        42,
        'middleware',
        28,
        'Etiam pretium iaculis justo.'
    );
INSERT INTO Community
VALUES (
        43,
        'Re-contextualized',
        3,
        'Mauris lacinia sapien quis libero.'
    );
INSERT INTO Community
VALUES (44, 'Organic', 12, 'Proin eu mi.');
INSERT INTO Community
VALUES (45, 'real-time', 25, 'Praesent blandit.');
INSERT INTO Community
VALUES (
        46,
        'methodical',
        7,
        'Duis at velit eu est congue elementum.'
    );
INSERT INTO Community
VALUES (
        47,
        'Versatile',
        1,
        'Vivamus in felis eu sapien cursus vestibulum.'
    );
INSERT INTO Community
VALUES (48, 'Progressive', 14, 'Donec dapibus.');
INSERT INTO Community
VALUES (
        49,
        'global',
        2,
        'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.'
    );
INSERT INTO Community
VALUES (50, 'systemic', 5, 'Morbi a ipsum.');
INSERT INTO Community
VALUES (
        51,
        'Right-sized',
        20,
        'Maecenas pulvinar lobortis est.'
    );
INSERT INTO Community
VALUES (
        52,
        'open architecture',
        29,
        'Nullam molestie nibh in lectus.'
    );
INSERT INTO Community
VALUES (53, 'Business-focused', 9, 'Nunc purus.');
INSERT INTO Community
VALUES (54, 'extranet', 38, 'Mauris sit amet eros.');
INSERT INTO Community
VALUES (
        55,
        'intangible',
        16,
        'Sed vel enim sit amet nunc viverra dapibus.'
    );
INSERT INTO Community
VALUES (
        56,
        'disintermediate',
        17,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'
    );
INSERT INTO Community
VALUES (
        57,
        'complexity',
        33,
        'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.'
    );
INSERT INTO Community
VALUES (
        58,
        'open architecture',
        8,
        'Maecenas ut massa quis augue luctus tincidunt.'
    );
INSERT INTO Community
VALUES (
        59,
        'upward-trending',
        30,
        'In blandit ultrices enim.'
    );
INSERT INTO Community
VALUES (
        60,
        'Vision-oriented',
        37,
        'Aenean auctor gravida sem.'
    );
-- Data for table Songs
INSERT INTO Songs
VALUES(
        1,
        37,
        8,
        'Reverse-engineered',
        120,
        45807,
        '2023-08-22'
    );
INSERT INTO Songs
VALUES(2, 9, 39, 'mission-critical', 96, 8643, '2023-12-18');
INSERT INTO Songs
VALUES(3, 23, 18, 'Sharable', 86, 98523, '2023-08-16');
INSERT INTO Songs
VALUES(4, 15, 15, 'moderator', 70, 32946, '2024-01-18');
INSERT INTO Songs
VALUES(5, 43, 12, 'leading edge', 23, 38332, '2023-05-23');
INSERT INTO Songs
VALUES(6, 24, 1, 'Optional', 33, 16456, '2023-09-05');
INSERT INTO Songs
VALUES(7, 38, 39, 'Persistent', 87, 23443, '2023-12-02');
INSERT INTO Songs
VALUES(8, 25, 18, 'Intuitive', 122, 86216, '2023-12-07');
INSERT INTO Songs
VALUES(9, 60, 27, 'homogeneous', 11, 79413, '2023-09-02');
INSERT INTO Songs
VALUES(10, 49, 1, 'Front-line', 31, 46112, '2023-04-24');
INSERT INTO Songs
VALUES(11, 22, 20, 'Implemented', 105, 44418, '2023-09-26');
INSERT INTO Songs
VALUES(12, 48, 38, 'executive', 117, 87751, '2023-09-10');
INSERT INTO Songs
VALUES(13, 34, 39, 'non-volatile', 99, 78738, '2024-03-11');
INSERT INTO Songs
VALUES(14, 19, 10, 'full-range', 34, 45238, '2023-06-05');
INSERT INTO Songs
VALUES(15, 46, 32, 'hybrid', 84, 22724, '2023-12-15');
INSERT INTO Songs
VALUES(16, 39, 8, 'Function-based', 120, 82401, '2024-02-29');
INSERT INTO Songs
VALUES(17, 14, 27, 'Focused', 110, 95495, '2023-12-10');
INSERT INTO Songs
VALUES(18, 41, 4, 'Polarised', 12, 87, '2023-08-19');
INSERT INTO Songs
VALUES(19, 35, 12, 'Monitored', 83, 25931, '2023-07-25');
INSERT INTO Songs
VALUES(20, 25, 26, 'scalable', 13, 25566, '2024-01-29');
INSERT INTO Songs
VALUES(21, 27, 19, 'incremental', 105, 89208, '2023-09-27');
INSERT INTO Songs
VALUES(
        22,
        40,
        21,
        'artificial intelligence',
        55,
        72146,
        '2023-07-17'
    );
INSERT INTO Songs
VALUES(23, 4, 37, 'optimizing', 125, 13899, '2023-08-17');
INSERT INTO Songs
VALUES(24, 48, 40, 'open system', 81, 58780, '2023-09-30');
INSERT INTO Songs
VALUES(25, 20, 25, 'demand-driven', 44, 65080, '2024-01-22');
INSERT INTO Songs
VALUES(26, 3, 5, 'installation', 19, 53398, '2023-06-21');
INSERT INTO Songs
VALUES(27, 21, 28, 'discrete', 12, 5136, '2024-02-07');
INSERT INTO Songs
VALUES(28, 19, 40, 'Self-enabling', 39, 15297, '2023-08-19');
INSERT INTO Songs
VALUES(29, 42, 6, 'Streamlined', 32, 52787, '2023-11-09');
INSERT INTO Songs
VALUES(30, 45, 8, 'Organic', 87, 82953, '2023-08-15');
INSERT INTO Songs
VALUES(31, 47, 35, 'Multi-lateral', 58, 59463, '2024-03-11');
INSERT INTO Songs
VALUES(32, 19, 37, 'capability', 12, 25683, '2024-03-29');
INSERT INTO Songs
VALUES(33, 45, 20, 'human-resource', 20, 59032, '2024-01-05');
INSERT INTO Songs
VALUES(34, 6, 33, 'didactic', 96, 24321, '2023-10-02');
INSERT INTO Songs
VALUES(35, 57, 30, 'array', 91, 59937, '2024-01-31');
INSERT INTO Songs
VALUES(36, 35, 31, 'cohesive', 113, 84844, '2023-10-06');
INSERT INTO Songs
VALUES(37, 43, 22, 'complexity', 46, 92491, '2023-06-27');
INSERT INTO Songs
VALUES(
        38,
        42,
        7,
        'mission-critical',
        43,
        71846,
        '2023-08-04'
    );
INSERT INTO Songs
VALUES(39, 2, 28, 'Extended', 114, 57639, '2024-03-12');
INSERT INTO Songs
VALUES(40, 44, 9, 'Function-based', 20, 10506, '2023-06-16');
INSERT INTO Songs
VALUES(41, 41, 14, 'installation', 12, 58538, '2023-12-31');
INSERT INTO Songs
VALUES(42, 8, 25, 'alliance', 107, 68847, '2023-10-22');
INSERT INTO Songs
VALUES(43, 10, 12, 'real-time', 33, 19178, '2023-05-20');
INSERT INTO Songs
VALUES(44, 42, 16, 'product', 94, 74749, '2023-11-05');
INSERT INTO Songs
VALUES(45, 31, 39, 'systemic', 57, 3421, '2024-03-05');
INSERT INTO Songs
VALUES(
        46,
        54,
        26,
        'open architecture',
        64,
        27940,
        '2024-03-30'
    );
INSERT INTO Songs
VALUES(
        47,
        51,
        19,
        'instruction set',
        102,
        41582,
        '2023-04-22'
    );
INSERT INTO Songs
VALUES(48, 52, 4, '24/7', 15, 48198, '2023-12-19');
INSERT INTO Songs
VALUES(49, 13, 13, 'Monitored', 92, 55754, '2023-06-06');
INSERT INTO Songs
VALUES(50, 56, 35, 'Face to face', 20, 26505, '2024-03-01');
INSERT INTO Songs
VALUES(51, 5, 24, 'Down-sized', 72, 9458, '2023-09-01');
INSERT INTO Songs
VALUES(52, 60, 25, 'Integrated', 41, 92093, '2023-05-25');
INSERT INTO Songs
VALUES(53, 58, 18, 'data-warehouse', 121, 8037, '2023-11-29');
INSERT INTO Songs
VALUES(54, 24, 3, 'Pre-emptive', 103, 10443, '2023-10-22');
INSERT INTO Songs
VALUES(55, 19, 20, 'explicit', 38, 59869, '2024-01-27');
INSERT INTO Songs
VALUES(56, 60, 26, 'heuristic', 121, 17998, '2024-01-25');
INSERT INTO Songs
VALUES(57, 44, 17, '24/7', 102, 97386, '2023-05-16');
INSERT INTO Songs
VALUES(58, 43, 11, 'real-time', 61, 23956, '2023-12-13');
INSERT INTO Songs
VALUES(59, 34, 22, 'Programmable', 33, 24814, '2023-12-29');
INSERT INTO Songs
VALUES(60, 18, 32, 'Profound', 65, 55927, '2024-01-03');
INSERT INTO Songs
VALUES(61, 51, 5, 'capacity', 9, 43856, '2023-04-12');
INSERT INTO Songs
VALUES(62, 1, 35, 'Grass-roots', 52, 96523, '2024-03-01');
INSERT INTO Songs
VALUES(63, 57, 39, 'protocol', 113, 77155, '2023-06-01');
INSERT INTO Songs
VALUES(64, 3, 26, 'Quality-focused', 66, 66897, '2024-01-01');
INSERT INTO Songs
VALUES(65, 34, 10, '24/7', 114, 27969, '2023-08-12');
INSERT INTO Songs
VALUES(66, 29, 8, 'Assimilated', 122, 25964, '2023-11-04');
INSERT INTO Songs
VALUES(67, 19, 11, 'value-added', 118, 62161, '2023-08-19');
INSERT INTO Songs
VALUES(68, 33, 23, 'focus group', 87, 13146, '2024-01-18');
INSERT INTO Songs
VALUES(69, 20, 6, 'Open-source', 127, 66390, '2023-05-29');
INSERT INTO Songs
VALUES(70, 6, 10, 'Team-oriented', 50, 42187, '2023-12-05');
INSERT INTO Songs
VALUES(71, 12, 26, 'motivating', 123, 73137, '2024-01-27');
INSERT INTO Songs
VALUES(72, 25, 22, 'heuristic', 97, 1232, '2023-04-26');
INSERT INTO Songs
VALUES(73, 60, 6, 'client-driven', 55, 46366, '2023-08-03');
INSERT INTO Songs
VALUES(74, 34, 4, 'zero defect', 109, 88974, '2023-12-01');
INSERT INTO Songs
VALUES(75, 5, 19, 'Seamless', 70, 45711, '2023-11-09');
INSERT INTO Songs
VALUES(76, 35, 7, 'moratorium', 13, 8038, '2023-09-14');
INSERT INTO Songs
VALUES(77, 39, 15, 'database', 13, 77132, '2023-04-15');
INSERT INTO Songs
VALUES(78, 45, 13, 'matrix', 37, 62628, '2024-01-15');
INSERT INTO Songs
VALUES(79, 13, 12, 'mobile', 26, 76033, '2023-07-29');
INSERT INTO Songs
VALUES(80, 55, 39, 'Automated', 68, 29470, '2023-06-15');
INSERT INTO Songs
VALUES(
        81,
        11,
        27,
        'Vision-oriented',
        15,
        20586,
        '2023-10-31'
    );
INSERT INTO Songs
VALUES(82, 44, 17, 'Multi-lateral', 65, 41880, '2023-11-23');
INSERT INTO Songs
VALUES(83, 54, 13, 'full-range', 99, 56181, '2023-07-09');
INSERT INTO Songs
VALUES(84, 51, 38, 'Team-oriented', 127, 12489, '2024-01-17');
INSERT INTO Songs
VALUES(85, 40, 27, 'Innovative', 33, 46604, '2024-02-03');
INSERT INTO Songs
VALUES(86, 46, 3, 'Polarised', 47, 54853, '2023-06-06');
INSERT INTO Songs
VALUES(87, 30, 20, 'Networked', 126, 87869, '2023-10-12');
INSERT INTO Songs
VALUES(88, 35, 6, 'strategy', 20, 23013, '2023-04-28');
INSERT INTO Songs
VALUES(89, 7, 16, 'Adaptive', 25, 26787, '2023-07-29');
INSERT INTO Songs
VALUES(90, 22, 39, 'directional', 20, 12814, '2024-01-18');
INSERT INTO Songs
VALUES(91, 21, 31, 'concept', 10, 98231, '2023-04-21');
INSERT INTO Songs
VALUES(92, 22, 12, 'productivity', 100, 63570, '2023-09-27');
INSERT INTO Songs
VALUES(93, 60, 15, 'Streamlined', 30, 91936, '2023-11-11');
INSERT INTO Songs
VALUES(94, 30, 34, 'regional', 117, 11310, '2023-12-21');
INSERT INTO Songs
VALUES(
        95,
        39,
        11,
        'Fully-configurable',
        111,
        14641,
        '2024-01-25'
    );
INSERT INTO Songs
VALUES(96, 12, 21, 'implementation', 42, 36059, '2023-12-23');
INSERT INTO Songs
VALUES(97, 14, 34, '4th generation', 48, 63399, '2023-10-28');
INSERT INTO Songs
VALUES(98, 35, 25, 'projection', 23, 71253, '2023-04-16');
INSERT INTO Songs
VALUES(99, 58, 29, 'ability', 120, 58967, '2024-02-21');
INSERT INTO Songs
VALUES(100, 60, 16, 'Balanced', 81, 87888, '2024-03-16');
INSERT INTO Songs
VALUES(101, 12, 15, 'empowering', 122, 14315, '2023-05-02');
INSERT INTO Songs
VALUES(102, 51, 24, 'Organized', 59, 27528, '2023-09-12');
INSERT INTO Songs
VALUES(
        103,
        25,
        13,
        'internet solution',
        40,
        86634,
        '2023-04-14'
    );
INSERT INTO Songs
VALUES(
        104,
        28,
        34,
        'budgetary management',
        40,
        82391,
        '2023-08-06'
    );
INSERT INTO Songs
VALUES(
        105,
        56,
        12,
        'bi-directional',
        108,
        66215,
        '2024-03-04'
    );
INSERT INTO Songs
VALUES(106, 57, 20, 'parallelism', 10, 17795, '2023-09-27');
INSERT INTO Songs
VALUES(107, 2, 40, 'zero defect', 108, 73469, '2023-09-12');
INSERT INTO Songs
VALUES(108, 7, 1, 'benchmark', 39, 65061, '2024-03-07');
INSERT INTO Songs
VALUES(109, 50, 40, 'Persevering', 127, 16917, '2023-07-08');
INSERT INTO Songs
VALUES(110, 4, 9, 'Persevering', 54, 10176, '2023-08-16');
INSERT INTO Songs
VALUES(111, 58, 21, 'asymmetric', 67, 75608, '2023-09-27');
INSERT INTO Songs
VALUES(112, 43, 25, 'Diverse', 22, 92991, '2023-07-16');
INSERT INTO Songs
VALUES(113, 55, 18, 'Seamless', 36, 46527, '2023-11-15');
INSERT INTO Songs
VALUES(114, 37, 19, 'solution', 13, 75861, '2024-01-21');
INSERT INTO Songs
VALUES(115, 36, 8, 'solution', 29, 90525, '2023-09-16');
INSERT INTO Songs
VALUES(116, 33, 31, 'methodology', 48, 52374, '2023-11-11');
INSERT INTO Songs
VALUES(117, 38, 21, 'support', 80, 65554, '2024-03-09');
INSERT INTO Songs
VALUES(118, 8, 7, 'Persistent', 110, 51723, '2023-09-25');
INSERT INTO Songs
VALUES(119, 13, 17, 'Front-line', 120, 98247, '2023-08-31');
INSERT INTO Songs
VALUES(120, 2, 19, 'maximized', 10, 68461, '2023-04-17');
INSERT INTO Songs
VALUES(121, 37, 36, 'national', 33, 23718, '2023-10-07');
INSERT INTO Songs
VALUES(122, 56, 15, 'hybrid', 72, 30970, '2023-04-21');
INSERT INTO Songs
VALUES(123, 23, 17, 'leverage', 72, 60021, '2024-04-09');
INSERT INTO Songs
VALUES(124, 58, 27, 'encompassing', 27, 86905, '2023-09-01');
INSERT INTO Songs
VALUES(125, 11, 33, 'Networked', 85, 34693, '2024-02-22');
INSERT INTO Songs
VALUES(
        126,
        43,
        30,
        'bandwidth-monitored',
        126,
        27533,
        '2024-03-14'
    );
INSERT INTO Songs
VALUES(127, 47, 21, 'task-force', 111, 31334, '2024-01-31');
INSERT INTO Songs
VALUES(128, 30, 6, 'support', 24, 8381, '2024-04-04');
INSERT INTO Songs
VALUES(129, 14, 8, 'time-frame', 128, 34360, '2023-08-15');
INSERT INTO Songs
VALUES(130, 51, 25, 'multi-state', 64, 21180, '2023-10-28');
INSERT INTO Songs
VALUES(131, 9, 39, 'secured line', 99, 10702, '2023-06-10');
INSERT INTO Songs
VALUES(132, 6, 36, 'Automated', 127, 40953, '2023-12-01');
INSERT INTO Songs
VALUES(133, 43, 1, 'toolset', 97, 67445, '2023-11-20');
INSERT INTO Songs
VALUES(134, 7, 11, 'demand-driven', 77, 45135, '2023-05-20');
INSERT INTO Songs
VALUES(135, 30, 25, 'neutral', 44, 35348, '2024-01-06');
INSERT INTO Songs
VALUES(136, 40, 24, 'radical', 33, 51576, '2023-07-11');
INSERT INTO Songs
VALUES(137, 37, 40, 'foreground', 43, 43697, '2023-10-15');
INSERT INTO Songs
VALUES(
        138,
        38,
        29,
        'Triple-buffered',
        49,
        35498,
        '2023-10-20'
    );
INSERT INTO Songs
VALUES(139, 2, 40, 'Mandatory', 51, 73709, '2023-11-10');
INSERT INTO Songs
VALUES(140, 3, 2, 'heuristic', 90, 61621, '2023-12-20');
INSERT INTO Songs
VALUES(141, 37, 31, 'User-centric', 89, 12237, '2023-09-25');
INSERT INTO Songs
VALUES(142, 51, 8, 'system engine', 118, 3154, '2023-06-19');
INSERT INTO Songs
VALUES(143, 47, 33, 'homogeneous', 32, 73552, '2024-02-08');
INSERT INTO Songs
VALUES(
        144,
        29,
        22,
        'Reverse-engineered',
        116,
        19620,
        '2023-06-24'
    );
INSERT INTO Songs
VALUES(145, 33, 23, 'structure', 10, 40900, '2023-09-06');
INSERT INTO Songs
VALUES(146, 48, 9, 'moderator', 101, 34882, '2024-03-06');
INSERT INTO Songs
VALUES(
        147,
        26,
        25,
        'Profit-focused',
        47,
        59837,
        '2024-01-14'
    );
INSERT INTO Songs
VALUES(148, 24, 13, 'regional', 31, 3561, '2023-12-08');
INSERT INTO Songs
VALUES(149, 57, 36, 'background', 79, 46130, '2023-10-03');
INSERT INTO Songs
VALUES(150, 54, 38, 'Ameliorated', 41, 72936, '2023-07-05');
INSERT INTO Songs
VALUES(151, 2, 3, 'foreground', 36, 64145, '2023-06-05');
INSERT INTO Songs
VALUES(
        152,
        42,
        15,
        '3rd generation',
        84,
        13315,
        '2023-09-28'
    );
INSERT INTO Songs
VALUES(153, 35, 39, 'Secured', 14, 49487, '2024-03-31');
INSERT INTO Songs
VALUES(154, 7, 40, 'interactive', 49, 15787, '2023-08-08');
INSERT INTO Songs
VALUES(155, 1, 24, 'system engine', 103, 59980, '2023-11-13');
INSERT INTO Songs
VALUES(156, 24, 2, 'Face to face', 84, 38269, '2023-12-27');
INSERT INTO Songs
VALUES(157, 17, 2, 'extranet', 32, 65114, '2023-09-17');
INSERT INTO Songs
VALUES(158, 51, 7, 'frame', 97, 74714, '2023-05-14');
INSERT INTO Songs
VALUES(
        159,
        19,
        19,
        'info-mediaries',
        109,
        76589,
        '2023-07-12'
    );
INSERT INTO Songs
VALUES(160, 37, 20, 'multi-state', 72, 88803, '2023-08-29');
INSERT INTO Songs
VALUES(161, 50, 8, 'Operative', 118, 88445, '2023-08-28');
INSERT INTO Songs
VALUES(
        162,
        40,
        10,
        'Open-architected',
        62,
        63084,
        '2023-11-06'
    );
INSERT INTO Songs
VALUES(163, 60, 14, 'Networked', 57, 64450, '2023-12-02');
INSERT INTO Songs
VALUES(164, 7, 5, 'Distributed', 83, 14920, '2023-11-22');
INSERT INTO Songs
VALUES(165, 49, 18, 'Multi-layered', 28, 85857, '2023-08-07');
INSERT INTO Songs
VALUES(166, 18, 24, 'collaboration', 62, 40310, '2023-12-15');
INSERT INTO Songs
VALUES(
        167,
        51,
        12,
        'Fully-configurable',
        44,
        36557,
        '2024-02-22'
    );
INSERT INTO Songs
VALUES(168, 43, 13, 'Customizable', 71, 17916, '2023-08-24');
INSERT INTO Songs
VALUES(169, 21, 9, 'client-server', 128, 95574, '2023-10-24');
INSERT INTO Songs
VALUES(
        170,
        34,
        11,
        'bandwidth-monitored',
        52,
        60965,
        '2023-05-19'
    );
INSERT INTO Songs
VALUES(171, 51, 3, 'structure', 27, 48105, '2023-08-20');
INSERT INTO Songs
VALUES(172, 22, 7, 'Secured', 28, 78192, '2023-09-12');
INSERT INTO Songs
VALUES(173, 58, 40, 'Managed', 32, 33841, '2024-03-10');
INSERT INTO Songs
VALUES(174, 4, 38, 'Stand-alone', 34, 25151, '2024-04-04');
INSERT INTO Songs
VALUES(175, 21, 8, 'Reduced', 128, 6286, '2023-07-01');
INSERT INTO Songs
VALUES(
        176,
        54,
        18,
        'Graphic Interface',
        106,
        25983,
        '2023-08-30'
    );
INSERT INTO Songs
VALUES(177, 46, 27, 'Optional', 100, 99149, '2023-09-15');
INSERT INTO Songs
VALUES(178, 31, 30, 'Pre-emptive', 87, 36069, '2024-01-09');
INSERT INTO Songs
VALUES(179, 27, 40, 'high-level', 28, 95927, '2023-07-11');
INSERT INTO Songs
VALUES(180, 15, 26, 'Stand-alone', 58, 73596, '2023-04-27');
INSERT INTO Songs
VALUES(181, 25, 27, 'installation', 98, 45835, '2024-02-21');
INSERT INTO Songs
VALUES(182, 2, 33, 'real-time', 30, 20199, '2023-10-20');
INSERT INTO Songs
VALUES(183, 18, 32, 'Decentralized', 35, 45782, '2023-12-16');
INSERT INTO Songs
VALUES(
        184,
        20,
        28,
        'local area network',
        48,
        85437,
        '2023-08-06'
    );
INSERT INTO Songs
VALUES(185, 29, 5, 'zero tolerance', 24, 86494, '2023-12-26');
INSERT INTO Songs
VALUES(186, 55, 14, 'framework', 90, 28684, '2023-04-24');
INSERT INTO Songs
VALUES(187, 52, 23, 'exuding', 81, 62789, '2024-04-07');
INSERT INTO Songs
VALUES(188, 40, 29, 'zero defect', 117, 43320, '2023-06-15');
INSERT INTO Songs
VALUES(189, 60, 39, 'Versatile', 36, 84136, '2024-01-11');
INSERT INTO Songs
VALUES(
        190,
        31,
        28,
        'well-modulated',
        19,
        45036,
        '2023-04-20'
    );
INSERT INTO Songs
VALUES(191, 27, 19, 'approach', 14, 79744, '2023-05-21');
INSERT INTO Songs
VALUES(192, 42, 6, 'methodology', 98, 75138, '2024-03-01');
INSERT INTO Songs
VALUES(193, 48, 40, 'Centralized', 114, 89524, '2023-09-30');
INSERT INTO Songs
VALUES(194, 57, 32, 'Public-key', 109, 50134, '2023-06-29');
INSERT INTO Songs
VALUES(195, 44, 3, 'circuit', 103, 7736, '2024-01-23');
INSERT INTO Songs
VALUES(196, 37, 9, 'Object-based', 32, 65306, '2024-01-05');
INSERT INTO Songs
VALUES(197, 56, 15, 'Cross-group', 16, 47080, '2023-12-24');
INSERT INTO Songs
VALUES(
        198,
        20,
        25,
        '4th generation',
        18,
        65796,
        '2023-12-11'
    );
INSERT INTO Songs
VALUES(199, 51, 11, 'Visionary', 32, 31001, '2023-12-13');
INSERT INTO Songs
VALUES(
        200,
        50,
        20,
        'implementation',
        34,
        96047,
        '2023-05-12'
    );
-- Data for table Friends
INSERT INTO Friends
VALUES(28, 50);
INSERT INTO Friends
VALUES(7, 1);
INSERT INTO Friends
VALUES(21, 42);
INSERT INTO Friends
VALUES(17, 5);
INSERT INTO Friends
VALUES(29, 6);
INSERT INTO Friends
VALUES(56, 26);
INSERT INTO Friends
VALUES(59, 54);
INSERT INTO Friends
VALUES(58, 52);
INSERT INTO Friends
VALUES(9, 16);
INSERT INTO Friends
VALUES(21, 23);
INSERT INTO Friends
VALUES(41, 20);
INSERT INTO Friends
VALUES(53, 59);
INSERT INTO Friends
VALUES(4, 28);
INSERT INTO Friends
VALUES(53, 25);
INSERT INTO Friends
VALUES(27, 59);
INSERT INTO Friends
VALUES(22, 7);
INSERT INTO Friends
VALUES(31, 39);
INSERT INTO Friends
VALUES(39, 46);
INSERT INTO Friends
VALUES(24, 49);
INSERT INTO Friends
VALUES(13, 31);
INSERT INTO Friends
VALUES(9, 44);
INSERT INTO Friends
VALUES(11, 54);
INSERT INTO Friends
VALUES(42, 45);
INSERT INTO Friends
VALUES(49, 20);
INSERT INTO Friends
VALUES(40, 32);
INSERT INTO Friends
VALUES(28, 51);
INSERT INTO Friends
VALUES(13, 47);
INSERT INTO Friends
VALUES(26, 5);
INSERT INTO Friends
VALUES(19, 49);
INSERT INTO Friends
VALUES(46, 4);
INSERT INTO Friends
VALUES(38, 21);
INSERT INTO Friends
VALUES(7, 37);
INSERT INTO Friends
VALUES(41, 28);
INSERT INTO Friends
VALUES(56, 47);
INSERT INTO Friends
VALUES(58, 57);
INSERT INTO Friends
VALUES(60, 19);
INSERT INTO Friends
VALUES(52, 58);
INSERT INTO Friends
VALUES(38, 23);
INSERT INTO Friends
VALUES(40, 20);
INSERT INTO Friends
VALUES(18, 44);
INSERT INTO Friends
VALUES(23, 16);
INSERT INTO Friends
VALUES(10, 33);
INSERT INTO Friends
VALUES(36, 53);
INSERT INTO Friends
VALUES(16, 30);
INSERT INTO Friends
VALUES(58, 47);
INSERT INTO Friends
VALUES(15, 7);
INSERT INTO Friends
VALUES(55, 44);
INSERT INTO Friends
VALUES(5, 4);
INSERT INTO Friends
VALUES(1, 56);
INSERT INTO Friends
VALUES(15, 15);
INSERT INTO Friends
VALUES(47, 19);
INSERT INTO Friends
VALUES(16, 38);
INSERT INTO Friends
VALUES(34, 45);
INSERT INTO Friends
VALUES(11, 48);
INSERT INTO Friends
VALUES(13, 48);
INSERT INTO Friends
VALUES(31, 54);
INSERT INTO Friends
VALUES(32, 14);
INSERT INTO Friends
VALUES(19, 38);
INSERT INTO Friends
VALUES(46, 26);
INSERT INTO Friends
VALUES(55, 13);
INSERT INTO Friends
VALUES(41, 15);
INSERT INTO Friends
VALUES(54, 33);
INSERT INTO Friends
VALUES(47, 28);
INSERT INTO Friends
VALUES(56, 57);
INSERT INTO Friends
VALUES(18, 49);
INSERT INTO Friends
VALUES(28, 56);
INSERT INTO Friends
VALUES(48, 18);
INSERT INTO Friends
VALUES(45, 53);
INSERT INTO Friends
VALUES(44, 19);
INSERT INTO Friends
VALUES(7, 22);
INSERT INTO Friends
VALUES(11, 16);
INSERT INTO Friends
VALUES(46, 49);
INSERT INTO Friends
VALUES(39, 10);
INSERT INTO Friends
VALUES(18, 36);
INSERT INTO Friends
VALUES(57, 55);
INSERT INTO Friends
VALUES(37, 46);
INSERT INTO Friends
VALUES(2, 58);
INSERT INTO Friends
VALUES(31, 59);
INSERT INTO Friends
VALUES(52, 54);
INSERT INTO Friends
VALUES(10, 4);
INSERT INTO Friends
VALUES(11, 40);
INSERT INTO Friends
VALUES(56, 17);
INSERT INTO Friends
VALUES(50, 25);
INSERT INTO Friends
VALUES(43, 28);
INSERT INTO Friends
VALUES(17, 37);
INSERT INTO Friends
VALUES(26, 23);
INSERT INTO Friends
VALUES(10, 43);
INSERT INTO Friends
VALUES(45, 58);
INSERT INTO Friends
VALUES(16, 24);
INSERT INTO Friends
VALUES(13, 19);
INSERT INTO Friends
VALUES(7, 11);
INSERT INTO Friends
VALUES(26, 47);
INSERT INTO Friends
VALUES(38, 42);
INSERT INTO Friends
VALUES(56, 35);
INSERT INTO Friends
VALUES(59, 59);
INSERT INTO Friends
VALUES(39, 20);
INSERT INTO Friends
VALUES(45, 55);
INSERT INTO Friends
VALUES(39, 35);
INSERT INTO Friends
VALUES(38, 60);
INSERT INTO Friends
VALUES(34, 19);
INSERT INTO Friends
VALUES(54, 38);
INSERT INTO Friends
VALUES(55, 58);
INSERT INTO Friends
VALUES(18, 32);
INSERT INTO Friends
VALUES(10, 49);
INSERT INTO Friends
VALUES(37, 50);
INSERT INTO Friends
VALUES(16, 42);
INSERT INTO Friends
VALUES(49, 58);
INSERT INTO Friends
VALUES(55, 5);
INSERT INTO Friends
VALUES(2, 45);
INSERT INTO Friends
VALUES(59, 44);
INSERT INTO Friends
VALUES(40, 56);
INSERT INTO Friends
VALUES(38, 4);
INSERT INTO Friends
VALUES(17, 31);
INSERT INTO Friends
VALUES(56, 9);
INSERT INTO Friends
VALUES(46, 53);
INSERT INTO Friends
VALUES(28, 60);
INSERT INTO Friends
VALUES(33, 7);
INSERT INTO Friends
VALUES(2, 27);
INSERT INTO Friends
VALUES(17, 46);
INSERT INTO Friends
VALUES(36, 44);
INSERT INTO Friends
VALUES(3, 52);
INSERT INTO Friends
VALUES(54, 45);
INSERT INTO Friends
VALUES(7, 18);
INSERT INTO Friends
VALUES(26, 57);
INSERT INTO Friends
VALUES(9, 43);
INSERT INTO Friends
VALUES(29, 3);
INSERT INTO Friends
VALUES(46, 22);
INSERT INTO Friends
VALUES(23, 46);
INSERT INTO Friends
VALUES(8, 53);
INSERT INTO Friends
VALUES(41, 57);
INSERT INTO Friends
VALUES(12, 11);
INSERT INTO Friends
VALUES(33, 21);
INSERT INTO Friends
VALUES(55, 19);
INSERT INTO Friends
VALUES(59, 8);
INSERT INTO Friends
VALUES(15, 42);
INSERT INTO Friends
VALUES(56, 45);
INSERT INTO Friends
VALUES(28, 31);
INSERT INTO Friends
VALUES(14, 32);
INSERT INTO Friends
VALUES(33, 41);
INSERT INTO Friends
VALUES(12, 54);
INSERT INTO Friends
VALUES(6, 2);
INSERT INTO Friends
VALUES(40, 42);
INSERT INTO Friends
VALUES(57, 38);
INSERT INTO Friends
VALUES(24, 8);
INSERT INTO Friends
VALUES(56, 60);
INSERT INTO Friends
VALUES(43, 8);
INSERT INTO Friends
VALUES(31, 27);
INSERT INTO Friends
VALUES(55, 1);
INSERT INTO Friends
VALUES(47, 40);
INSERT INTO Friends
VALUES(51, 46);
INSERT INTO Friends
VALUES(57, 51);
INSERT INTO Friends
VALUES(30, 14);
INSERT INTO Friends
VALUES(13, 49);
INSERT INTO Friends
VALUES(17, 34);
INSERT INTO Friends
VALUES(25, 9);
INSERT INTO Friends
VALUES(7, 39);
INSERT INTO Friends
VALUES(44, 32);
INSERT INTO Friends
VALUES(43, 51);
INSERT INTO Friends
VALUES(58, 2);
INSERT INTO Friends
VALUES(55, 20);
INSERT INTO Friends
VALUES(33, 11);
INSERT INTO Friends
VALUES(4, 59);
INSERT INTO Friends
VALUES(17, 54);
INSERT INTO Friends
VALUES(20, 52);
INSERT INTO Friends
VALUES(49, 32);
INSERT INTO Friends
VALUES(33, 17);
INSERT INTO Friends
VALUES(52, 19);
INSERT INTO Friends
VALUES(55, 21);
INSERT INTO Friends
VALUES(18, 43);
INSERT INTO Friends
VALUES(26, 51);
INSERT INTO Friends
VALUES(43, 27);
INSERT INTO Friends
VALUES(50, 48);
INSERT INTO Friends
VALUES(52, 42);
INSERT INTO Friends
VALUES(45, 9);
INSERT INTO Friends
VALUES(52, 43);
INSERT INTO Friends
VALUES(27, 29);
INSERT INTO Friends
VALUES(32, 30);
INSERT INTO Friends
VALUES(54, 16);
INSERT INTO Friends
VALUES(4, 41);
INSERT INTO Friends
VALUES(17, 3);
INSERT INTO Friends
VALUES(8, 43);
INSERT INTO Friends
VALUES(20, 56);
INSERT INTO Friends
VALUES(5, 28);
INSERT INTO Friends
VALUES(49, 60);
INSERT INTO Friends
VALUES(53, 42);
INSERT INTO Friends
VALUES(41, 52);
INSERT INTO Friends
VALUES(27, 54);
INSERT INTO Friends
VALUES(43, 12);
INSERT INTO Friends
VALUES(23, 32);
INSERT INTO Friends
VALUES(52, 9);
INSERT INTO Friends
VALUES(26, 37);
INSERT INTO Friends
VALUES(42, 13);
INSERT INTO Friends
VALUES(55, 39);
INSERT INTO Friends
VALUES(7, 28);
INSERT INTO Friends
VALUES(25, 49);
INSERT INTO Friends
VALUES(57, 17);
INSERT INTO Friends
VALUES(17, 35);
INSERT INTO Friends
VALUES(35, 6);
INSERT INTO Friends
VALUES(10, 18);
INSERT INTO Friends
VALUES(13, 43);
-- Data for table messages
INSERT INTO Message
Values(
        1,
        47,
        50,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.'
    );
INSERT INTO Message
Values(2, 59, 13, 'Vestibulum rutrum rutrum neque.');
INSERT INTO Message
Values(
        3,
        37,
        16,
        'Morbi vel lectus in quam fringilla rhoncus.'
    );
INSERT INTO Message
Values(4, 52, 42, 'Nulla nisl.');
INSERT INTO Message
Values(5, 50, 5, 'Quisque porta volutpat erat.');
INSERT INTO Message
Values(
        6,
        6,
        35,
        'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.'
    );
INSERT INTO Message
Values(
        7,
        38,
        7,
        'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.'
    );
INSERT INTO Message
Values(
        8,
        32,
        15,
        'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.'
    );
INSERT INTO Message
Values(
        9,
        2,
        51,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.'
    );
INSERT INTO Message
Values(
        10,
        35,
        48,
        'Nullam sit amet turpis elementum ligula vehicula consequat.'
    );
INSERT INTO Message
Values(
        11,
        38,
        49,
        'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.'
    );
INSERT INTO Message
Values(
        12,
        19,
        16,
        'Donec ut mauris eget massa tempor convallis.'
    );
INSERT INTO Message
Values(
        13,
        20,
        48,
        'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.'
    );
INSERT INTO Message
Values(14, 23, 54, 'Etiam faucibus cursus urna.');
INSERT INTO Message
Values(15, 23, 37, 'Nulla facilisi.');
INSERT INTO Message
Values(
        16,
        25,
        12,
        'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.'
    );
INSERT INTO Message
Values(17, 24, 57, 'In hac habitasse platea dictumst.');
INSERT INTO Message
Values(18, 35, 43, 'Quisque porta volutpat erat.');
INSERT INTO Message
Values(
        19,
        22,
        12,
        'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.'
    );
INSERT INTO Message
Values(20, 53, 55, 'Sed accumsan felis.');
INSERT INTO Message
Values(
        21,
        44,
        47,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'
    );
INSERT INTO Message
Values(
        22,
        16,
        40,
        'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.'
    );
INSERT INTO Message
Values(
        23,
        43,
        23,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.'
    );
INSERT INTO Message
Values(24, 25, 27, 'Vivamus tortor.');
INSERT INTO Message
Values(25, 21, 19, 'Proin eu mi.');
INSERT INTO Message
Values(
        26,
        2,
        11,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.'
    );
INSERT INTO Message
Values(27, 20, 6, 'Mauris lacinia sapien quis libero.');
INSERT INTO Message
Values(28, 41, 30, 'Pellentesque at nulla.');
INSERT INTO Message
Values(
        29,
        53,
        60,
        'Mauris ullamcorper purus sit amet nulla.'
    );
INSERT INTO Message
Values(
        30,
        19,
        10,
        'Morbi quis tortor id nulla ultrices aliquet.'
    );
INSERT INTO Message
Values(31, 4, 7, 'Aliquam non mauris.');
INSERT INTO Message
Values(32, 41, 11, 'Donec semper sapien a libero.');
INSERT INTO Message
Values(
        33,
        14,
        60,
        'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.'
    );
INSERT INTO Message
Values(
        34,
        45,
        17,
        'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.'
    );
INSERT INTO Message
Values(35, 21, 46, 'Nulla tempus.');
INSERT INTO Message
Values(36, 35, 57, 'Aenean lectus.');
INSERT INTO Message
Values(37, 47, 36, 'Maecenas rhoncus aliquam lacus.');
INSERT INTO Message
Values(
        38,
        6,
        35,
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.'
    );
INSERT INTO Message
Values(
        39,
        17,
        12,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.'
    );
INSERT INTO Message
Values(40, 3, 30, 'Praesent blandit lacinia erat.');
INSERT INTO Message
Values(41, 39, 43, 'Aenean sit amet justo.');
INSERT INTO Message
Values(
        42,
        54,
        37,
        'Suspendisse accumsan tortor quis turpis.'
    );
INSERT INTO Message
Values(43, 4, 22, 'Donec vitae nisi.');
INSERT INTO Message
Values(44, 48, 55, 'Nullam varius.');
INSERT INTO Message
Values(
        45,
        7,
        34,
        'Vestibulum sed magna at nunc commodo placerat.'
    );
INSERT INTO Message
Values(
        46,
        10,
        27,
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.'
    );
INSERT INTO Message
Values(47, 44, 58, 'Cras pellentesque volutpat dui.');
INSERT INTO Message
Values(
        48,
        18,
        1,
        'Duis consequat dui nec nisi volutpat eleifend.'
    );
INSERT INTO Message
Values(49, 32, 23, 'Quisque ut erat.');
INSERT INTO Message
Values(
        50,
        55,
        6,
        'In est risus, auctor sed, tristique in, tempus sit amet, sem.'
    );
INSERT INTO Message
Values(51, 25, 18, 'Aenean lectus.');
INSERT INTO Message
Values(
        52,
        46,
        9,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.'
    );
INSERT INTO Message
Values(53, 31, 50, 'Nulla mollis molestie lorem.');
INSERT INTO Message
Values(54, 11, 2, 'Nunc nisl.');
INSERT INTO Message
Values(
        55,
        22,
        8,
        'Morbi vel lectus in quam fringilla rhoncus.'
    );
INSERT INTO Message
Values(
        56,
        19,
        40,
        'Aliquam sit amet diam in magna bibendum imperdiet.'
    );
INSERT INTO Message
Values(57, 33, 15, 'Nulla suscipit ligula in lacus.');
INSERT INTO Message
Values(58, 43, 5, 'Integer tincidunt ante vel ipsum.');
INSERT INTO Message
Values(
        59,
        60,
        51,
        'Morbi quis tortor id nulla ultrices aliquet.'
    );
INSERT INTO Message
Values(60, 30, 42, 'Duis aliquam convallis nunc.');
-- Data for table Playlists
INSERT INTO Playlist
Values(
        1,
        'Vestibulum sed magna at nunc commodo placerat.',
        6
    );
INSERT INTO Playlist
Values(
        2,
        'Vestibulum ante ipsum primis in faucibus orci luctus et u',
        3
    );
INSERT INTO Playlist
Values(3, 'Cras pellentesque volutpat dui.', 19);
INSERT INTO Playlist
Values(
        4,
        'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',
        26
    );
INSERT INTO Playlist
Values(5, 'Ut tellus.', 25);
INSERT INTO Playlist
Values(6, 'Curabitur gravida nisi at nibh.', 31);
INSERT INTO Playlist
Values(7, 'Integer ac leo.', 30);
INSERT INTO Playlist
Values(8, 'Nulla justo.', 2);
INSERT INTO Playlist
Values(
        9,
        'Curabitur in libero ut massa volutpat convallis.',
        33
    );
INSERT INTO Playlist
Values(10, 'Suspendisse ornare consequat lectus.', 16);
INSERT INTO Playlist
Values(11, 'Nunc purus.', 34);
INSERT INTO Playlist
Values(12, 'Duis aliquam convallis nunc.', 18);
INSERT INTO Playlist
Values(
        13,
        'In tempor, turpis nec euismod scelerisque',
        17
    );
INSERT INTO Playlist
Values(
        14,
        'Morbi vel lectus in quam fringilla rhoncus.',
        12
    );
INSERT INTO Playlist
Values(
        15,
        'Suspendisse accumsan tortor quis turpis.',
        16
    );
INSERT INTO Playlist
Values(16, 'Duis bibendum.', 18);
INSERT INTO Playlist
Values(17, 'Duis bibendum.', 7);
INSERT INTO Playlist
Values(18, 'Vivamus vestibulum sagittis sapien.', 40);
INSERT INTO Playlist
Values(19, 'Donec posuere metus vitae ipsum.', 7);
INSERT INTO Playlist
Values(
        20,
        'Quisque id justo sit amet sapien dignissim vestibulum.',
        8
    );
INSERT INTO Playlist
Values(21, 'Etiam justo.', 16);
INSERT INTO Playlist
Values(22, 'Morbi porttitor lorem id ligula.', 19);
INSERT INTO Playlist
Values(23, 'Nulla mollis molestie lorem.', 40);
INSERT INTO Playlist
Values(24, 'Duis bibendum.', 38);
INSERT INTO Playlist
Values(25, 'Vestibulum ante ipsum primis in f', 6);
INSERT INTO Playlist
Values(26, 'Nulla justo.', 2);
INSERT INTO Playlist
Values(27, 'Maecenas tincidunt lacus at velit.', 3);
INSERT INTO Playlist
Values(28, 'Morbi porttitor lorem id ligula.', 38);
INSERT INTO Playlist
Values(29, 'Nam dui.', 16);
INSERT INTO Playlist
Values(30, 'Donec dapibus.', 31);
INSERT INTO Playlist
Values(
        31,
        'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.',
        4
    );
INSERT INTO Playlist
Values(32, 'Praesent lectus.', 32);
INSERT INTO Playlist
Values(33, 'Proin at turpis a pede posuere nonummy.', 3);
INSERT INTO Playlist
Values(34, 'Morbi porttitor lorem id ligula.', 35);
INSERT INTO Playlist
Values(
        35,
        'Donec quis orci eget orci vehicula condimentum.',
        8
    );
INSERT INTO Playlist
Values(36, 'Duis mattis egestas metus.', 25);
INSERT INTO Playlist
Values(
        37,
        'Proin interdum mauris non ligula pellentesque ultrices.',
        9
    );
INSERT INTO Playlist
Values(38, 'Integer ac neque.', 27);
INSERT INTO Playlist
Values(39, 'Pellentesque at nulla.', 6);
INSERT INTO Playlist
Values(40, 'Nulla ac enim.', 2);
INSERT INTO Playlist
Values(41, 'Pellentesque viverra pede ac diam.', 10);
INSERT INTO Playlist
Values(42, 'Aenean lectus.', 34);
INSERT INTO Playlist
Values(43, 'Mauris sit amet eros.', 36);
INSERT INTO Playlist
Values(44, 'In congue.', 14);
INSERT INTO Playlist
Values(45, 'Nulla nisl.', 20);
INSERT INTO Playlist
Values(
        46,
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',
        19
    );
INSERT INTO Playlist
Values(47, 'Curabitur convallis.', 22);
INSERT INTO Playlist
Values(48, 'Integer tincidunt ante vel ipsum.', 17);
INSERT INTO Playlist
Values(49, 'Nam ultrices, libero non', 21);
INSERT INTO Playlist
Values(50, 'Nunc purus.', 30);
INSERT INTO Playlist
Values(51, 'Donec posuere metus vitae ipsum.', 39);
INSERT INTO Playlist
Values(52, 'In tempor, turpis nec euismod sceleris', 1);
INSERT INTO Playlist
Values(53, 'Cum sociis natoque penatibus et magn', 16);
INSERT INTO Playlist
Values(54, 'Nam dui.', 33);
INSERT INTO Playlist
Values(55, 'Vivamus vestibulum sagittis sapien.', 28);
INSERT INTO Playlist
Values(
        56,
        'Nullam sit amet turpis elementum ligula vehicula consequat.',
        37
    );
INSERT INTO Playlist
Values(57, 'Cum sociis natoque penatibus.', 31);
INSERT INTO Playlist
Values(58, 'Cras pellentesque volutpat dui.', 15);
INSERT INTO Playlist
Values(59, 'Suspendisse potenti.', 40);
INSERT INTO Playlist
Values(60, 'In eleifend quam a odio.', 4);
-- Data for table prod_artist
INSERT INTO Prod_Artist
Values(25, 36);
INSERT INTO Prod_Artist
Values(14, 26);
INSERT INTO Prod_Artist
Values(55, 13);
INSERT INTO Prod_Artist
Values(16, 22);
INSERT INTO Prod_Artist
Values(52, 46);
INSERT INTO Prod_Artist
Values(46, 54);
INSERT INTO Prod_Artist
Values(44, 23);
INSERT INTO Prod_Artist
Values(40, 44);
INSERT INTO Prod_Artist
Values(20, 25);
INSERT INTO Prod_Artist
Values(53, 33);
INSERT INTO Prod_Artist
Values(48, 32);
INSERT INTO Prod_Artist
Values(60, 7);
INSERT INTO Prod_Artist
Values(22, 4);
INSERT INTO Prod_Artist
Values(36, 16);
INSERT INTO Prod_Artist
Values(11, 24);
INSERT INTO Prod_Artist
Values(6, 59);
INSERT INTO Prod_Artist
Values(40, 25);
INSERT INTO Prod_Artist
Values(57, 46);
INSERT INTO Prod_Artist
Values(7, 51);
INSERT INTO Prod_Artist
Values(32, 3);
INSERT INTO Prod_Artist
Values(57, 59);
INSERT INTO Prod_Artist
Values(39, 22);
INSERT INTO Prod_Artist
Values(55, 48);
INSERT INTO Prod_Artist
Values(29, 41);
INSERT INTO Prod_Artist
Values(14, 12);
INSERT INTO Prod_Artist
Values(53, 36);
INSERT INTO Prod_Artist
Values(54, 44);
INSERT INTO Prod_Artist
Values(11, 30);
INSERT INTO Prod_Artist
Values(56, 52);
INSERT INTO Prod_Artist
Values(51, 17);
INSERT INTO Prod_Artist
Values(4, 43);
INSERT INTO Prod_Artist
Values(53, 60);
INSERT INTO Prod_Artist
Values(6, 48);
INSERT INTO Prod_Artist
Values(58, 47);
INSERT INTO Prod_Artist
Values(34, 36);
INSERT INTO Prod_Artist
Values(59, 30);
INSERT INTO Prod_Artist
Values(11, 16);
INSERT INTO Prod_Artist
Values(29, 13);
INSERT INTO Prod_Artist
Values(45, 44);
INSERT INTO Prod_Artist
Values(50, 42);
INSERT INTO Prod_Artist
Values(58, 25);
INSERT INTO Prod_Artist
Values(3, 15);
INSERT INTO Prod_Artist
Values(51, 21);
INSERT INTO Prod_Artist
Values(49, 60);
INSERT INTO Prod_Artist
Values(57, 35);
INSERT INTO Prod_Artist
Values(29, 10);
INSERT INTO Prod_Artist
Values(19, 46);
INSERT INTO Prod_Artist
Values(37, 19);
INSERT INTO Prod_Artist
Values(28, 45);
INSERT INTO Prod_Artist
Values(20, 13);
INSERT INTO Prod_Artist
Values(31, 12);
INSERT INTO Prod_Artist
Values(42, 42);
INSERT INTO Prod_Artist
Values(6, 38);
INSERT INTO Prod_Artist
Values(43, 58);
INSERT INTO Prod_Artist
Values(7, 25);
INSERT INTO Prod_Artist
Values(9, 45);
INSERT INTO Prod_Artist
Values(33, 42);
INSERT INTO Prod_Artist
Values(44, 5);
INSERT INTO Prod_Artist
Values(8, 33);
INSERT INTO Prod_Artist
Values(4, 53);
INSERT INTO Prod_Artist
Values(46, 58);
INSERT INTO Prod_Artist
Values(6, 19);
INSERT INTO Prod_Artist
Values(55, 53);
INSERT INTO Prod_Artist
Values(35, 34);
INSERT INTO Prod_Artist
Values(18, 21);
INSERT INTO Prod_Artist
Values(45, 33);
INSERT INTO Prod_Artist
Values(33, 36);
INSERT INTO Prod_Artist
Values(54, 10);
INSERT INTO Prod_Artist
Values(38, 59);
INSERT INTO Prod_Artist
Values(4, 5);
INSERT INTO Prod_Artist
Values(49, 31);
INSERT INTO Prod_Artist
Values(8, 57);
INSERT INTO Prod_Artist
Values(58, 7);
INSERT INTO Prod_Artist
Values(23, 12);
INSERT INTO Prod_Artist
Values(5, 25);
INSERT INTO Prod_Artist
Values(56, 39);
INSERT INTO Prod_Artist
Values(3, 23);
INSERT INTO Prod_Artist
Values(4, 3);
INSERT INTO Prod_Artist
Values(13, 40);
INSERT INTO Prod_Artist
Values(27, 17);
INSERT INTO Prod_Artist
Values(35, 5);
INSERT INTO Prod_Artist
Values(11, 23);
INSERT INTO Prod_Artist
Values(5, 26);
INSERT INTO Prod_Artist
Values(29, 20);
INSERT INTO Prod_Artist
Values(22, 48);
INSERT INTO Prod_Artist
Values(32, 39);
INSERT INTO Prod_Artist
Values(58, 35);
INSERT INTO Prod_Artist
Values(19, 21);
INSERT INTO Prod_Artist
Values(4, 42);
INSERT INTO Prod_Artist
Values(38, 54);
INSERT INTO Prod_Artist
Values(13, 2);
INSERT INTO Prod_Artist
Values(5, 34);
INSERT INTO Prod_Artist
Values(12, 12);
INSERT INTO Prod_Artist
Values(58, 29);
INSERT INTO Prod_Artist
Values(25, 40);
INSERT INTO Prod_Artist
Values(31, 17);
INSERT INTO Prod_Artist
Values(1, 41);
INSERT INTO Prod_Artist
Values(26, 48);
INSERT INTO Prod_Artist
Values(7, 30);
INSERT INTO Prod_Artist
Values(37, 31);
INSERT INTO Prod_Artist
Values(25, 34);
INSERT INTO Prod_Artist
Values(58, 19);
INSERT INTO Prod_Artist
Values(2, 1);
INSERT INTO Prod_Artist
Values(58, 15);
INSERT INTO Prod_Artist
Values(45, 41);
INSERT INTO Prod_Artist
Values(42, 40);
INSERT INTO Prod_Artist
Values(14, 45);
INSERT INTO Prod_Artist
Values(29, 27);
INSERT INTO Prod_Artist
Values(48, 33);
INSERT INTO Prod_Artist
Values(7, 3);
INSERT INTO Prod_Artist
Values(19, 36);
INSERT INTO Prod_Artist
Values(49, 19);
INSERT INTO Prod_Artist
Values(39, 29);
INSERT INTO Prod_Artist
Values(30, 41);
INSERT INTO Prod_Artist
Values(34, 55);
INSERT INTO Prod_Artist
Values(30, 59);
INSERT INTO Prod_Artist
Values(5, 14);
INSERT INTO Prod_Artist
Values(23, 52);
INSERT INTO Prod_Artist
Values(3, 37);
INSERT INTO Prod_Artist
Values(43, 31);
INSERT INTO Prod_Artist
Values(59, 44);
INSERT INTO Prod_Artist
Values(38, 47);
INSERT INTO Prod_Artist
Values(43, 4);
INSERT INTO Prod_Artist
Values(29, 6);
INSERT INTO Prod_Artist
Values(15, 32);
INSERT INTO Prod_Artist
Values(14, 60);
INSERT INTO Prod_Artist
Values(56, 40);
INSERT INTO Prod_Artist
Values(54, 58);
INSERT INTO Prod_Artist
Values(47, 18);
INSERT INTO Prod_Artist
Values(50, 59);
INSERT INTO Prod_Artist
Values(36, 41);
INSERT INTO Prod_Artist
Values(30, 8);
INSERT INTO Prod_Artist
Values(37, 30);
INSERT INTO Prod_Artist
Values(53, 48);
INSERT INTO Prod_Artist
Values(35, 44);
INSERT INTO Prod_Artist
Values(26, 40);
INSERT INTO Prod_Artist
Values(38, 52);
INSERT INTO Prod_Artist
Values(20, 50);
INSERT INTO Prod_Artist
Values(60, 25);
INSERT INTO Prod_Artist
Values(56, 9);
INSERT INTO Prod_Artist
Values(49, 41);
INSERT INTO Prod_Artist
Values(41, 22);
INSERT INTO Prod_Artist
Values(6, 10);
INSERT INTO Prod_Artist
Values(20, 33);
INSERT INTO Prod_Artist
Values(58, 8);
INSERT INTO Prod_Artist
Values(36, 5);
INSERT INTO Prod_Artist
Values(59, 57);
INSERT INTO Prod_Artist
Values(20, 47);
INSERT INTO Prod_Artist
Values(21, 45);
INSERT INTO Prod_Artist
Values(44, 30);
INSERT INTO Prod_Artist
Values(33, 25);
INSERT INTO Prod_Artist
Values(44, 1);
INSERT INTO Prod_Artist
Values(40, 4);
INSERT INTO Prod_Artist
Values(11, 43);
INSERT INTO Prod_Artist
Values(15, 17);
INSERT INTO Prod_Artist
Values(23, 20);
INSERT INTO Prod_Artist
Values(26, 9);
INSERT INTO Prod_Artist
Values(2, 60);
INSERT INTO Prod_Artist
Values(23, 50);
INSERT INTO Prod_Artist
Values(31, 34);
INSERT INTO Prod_Artist
Values(40, 19);
INSERT INTO Prod_Artist
Values(51, 23);
INSERT INTO Prod_Artist
Values(21, 18);
INSERT INTO Prod_Artist
Values(55, 17);
INSERT INTO Prod_Artist
Values(60, 34);
INSERT INTO Prod_Artist
Values(20, 9);
INSERT INTO Prod_Artist
Values(7, 6);
INSERT INTO Prod_Artist
Values(56, 22);
INSERT INTO Prod_Artist
Values(19, 49);
INSERT INTO Prod_Artist
Values(60, 17);
INSERT INTO Prod_Artist
Values(28, 51);
INSERT INTO Prod_Artist
Values(37, 13);
INSERT INTO Prod_Artist
Values(6, 21);
INSERT INTO Prod_Artist
Values(18, 14);
INSERT INTO Prod_Artist
Values(19, 50);
INSERT INTO Prod_Artist
Values(16, 4);
INSERT INTO Prod_Artist
Values(12, 14);
INSERT INTO Prod_Artist
Values(27, 44);
INSERT INTO Prod_Artist
Values(40, 26);
INSERT INTO Prod_Artist
Values(18, 47);
INSERT INTO Prod_Artist
Values(35, 49);
INSERT INTO Prod_Artist
Values(26, 53);
INSERT INTO Prod_Artist
Values(14, 30);
INSERT INTO Prod_Artist
Values(21, 27);
INSERT INTO Prod_Artist
Values(59, 35);
INSERT INTO Prod_Artist
Values(8, 13);
INSERT INTO Prod_Artist
Values(7, 34);
INSERT INTO Prod_Artist
Values(33, 57);
INSERT INTO Prod_Artist
Values(60, 49);
INSERT INTO Prod_Artist
Values(22, 14);
INSERT INTO Prod_Artist
Values(34, 37);
INSERT INTO Prod_Artist
Values(29, 11);
INSERT INTO Prod_Artist
Values(54, 23);
INSERT INTO Prod_Artist
Values(43, 59);
INSERT INTO Prod_Artist
Values(57, 41);
INSERT INTO Prod_Artist
Values(44, 3);
INSERT INTO Prod_Artist
Values(28, 15);
INSERT INTO Prod_Artist
Values(24, 7);
INSERT INTO Prod_Artist
Values(25, 51);
INSERT INTO Prod_Artist
Values(5, 22);
-- Data for table Producer Credit
INSERT INTO Producer_Credit
Values(9, 34);
INSERT INTO Producer_Credit
Values(83, 23);
INSERT INTO Producer_Credit
Values(18, 4);
INSERT INTO Producer_Credit
Values(196, 38);
INSERT INTO Producer_Credit
Values(174, 18);
INSERT INTO Producer_Credit
Values(97, 40);
INSERT INTO Producer_Credit
Values(64, 23);
INSERT INTO Producer_Credit
Values(138, 16);
INSERT INTO Producer_Credit
Values(51, 35);
INSERT INTO Producer_Credit
Values(158, 19);
INSERT INTO Producer_Credit
Values(29, 54);
INSERT INTO Producer_Credit
Values(23, 51);
INSERT INTO Producer_Credit
Values(116, 19);
INSERT INTO Producer_Credit
Values(182, 45);
INSERT INTO Producer_Credit
Values(105, 28);
INSERT INTO Producer_Credit
Values(86, 44);
INSERT INTO Producer_Credit
Values(93, 15);
INSERT INTO Producer_Credit
Values(176, 46);
INSERT INTO Producer_Credit
Values(65, 18);
INSERT INTO Producer_Credit
Values(187, 35);
INSERT INTO Producer_Credit
Values(60, 46);
INSERT INTO Producer_Credit
Values(26, 19);
INSERT INTO Producer_Credit
Values(43, 57);
INSERT INTO Producer_Credit
Values(188, 23);
INSERT INTO Producer_Credit
Values(152, 14);
INSERT INTO Producer_Credit
Values(168, 45);
INSERT INTO Producer_Credit
Values(151, 10);
INSERT INTO Producer_Credit
Values(37, 21);
INSERT INTO Producer_Credit
Values(127, 13);
INSERT INTO Producer_Credit
Values(155, 8);
INSERT INTO Producer_Credit
Values(49, 23);
INSERT INTO Producer_Credit
Values(130, 50);
INSERT INTO Producer_Credit
Values(101, 30);
INSERT INTO Producer_Credit
Values(30, 41);
INSERT INTO Producer_Credit
Values(46, 58);
INSERT INTO Producer_Credit
Values(103, 55);
INSERT INTO Producer_Credit
Values(82, 2);
INSERT INTO Producer_Credit
Values(192, 51);
INSERT INTO Producer_Credit
Values(100, 49);
INSERT INTO Producer_Credit
Values(33, 28);
INSERT INTO Producer_Credit
Values(148, 60);
INSERT INTO Producer_Credit
Values(194, 29);
INSERT INTO Producer_Credit
Values(129, 19);
INSERT INTO Producer_Credit
Values(170, 42);
INSERT INTO Producer_Credit
Values(1, 36);
INSERT INTO Producer_Credit
Values(140, 25);
INSERT INTO Producer_Credit
Values(6, 59);
INSERT INTO Producer_Credit
Values(37, 33);
INSERT INTO Producer_Credit
Values(121, 53);
INSERT INTO Producer_Credit
Values(176, 39);
INSERT INTO Producer_Credit
Values(108, 51);
INSERT INTO Producer_Credit
Values(25, 28);
INSERT INTO Producer_Credit
Values(86, 7);
INSERT INTO Producer_Credit
Values(181, 43);
INSERT INTO Producer_Credit
Values(76, 51);
INSERT INTO Producer_Credit
Values(79, 44);
INSERT INTO Producer_Credit
Values(29, 18);
INSERT INTO Producer_Credit
Values(5, 31);
INSERT INTO Producer_Credit
Values(195, 8);
INSERT INTO Producer_Credit
Values(67, 6);
INSERT INTO Producer_Credit
Values(26, 57);
INSERT INTO Producer_Credit
Values(56, 26);
INSERT INTO Producer_Credit
Values(63, 9);
INSERT INTO Producer_Credit
Values(157, 17);
INSERT INTO Producer_Credit
Values(177, 23);
INSERT INTO Producer_Credit
Values(16, 27);
INSERT INTO Producer_Credit
Values(129, 35);
INSERT INTO Producer_Credit
Values(123, 5);
INSERT INTO Producer_Credit
Values(94, 38);
INSERT INTO Producer_Credit
Values(29, 27);
INSERT INTO Producer_Credit
Values(167, 54);
INSERT INTO Producer_Credit
Values(103, 34);
INSERT INTO Producer_Credit
Values(133, 40);
INSERT INTO Producer_Credit
Values(153, 46);
INSERT INTO Producer_Credit
Values(123, 16);
INSERT INTO Producer_Credit
Values(65, 28);
INSERT INTO Producer_Credit
Values(99, 26);
INSERT INTO Producer_Credit
Values(128, 15);
INSERT INTO Producer_Credit
Values(162, 31);
INSERT INTO Producer_Credit
Values(128, 3);
INSERT INTO Producer_Credit
Values(22, 6);
INSERT INTO Producer_Credit
Values(138, 40);
INSERT INTO Producer_Credit
Values(7, 20);
INSERT INTO Producer_Credit
Values(103, 13);
INSERT INTO Producer_Credit
Values(36, 58);
INSERT INTO Producer_Credit
Values(37, 18);
INSERT INTO Producer_Credit
Values(26, 16);
INSERT INTO Producer_Credit
Values(190, 41);
INSERT INTO Producer_Credit
Values(27, 36);
INSERT INTO Producer_Credit
Values(158, 60);
INSERT INTO Producer_Credit
Values(92, 34);
INSERT INTO Producer_Credit
Values(175, 51);
INSERT INTO Producer_Credit
Values(27, 59);
INSERT INTO Producer_Credit
Values(146, 8);
INSERT INTO Producer_Credit
Values(195, 6);
INSERT INTO Producer_Credit
Values(190, 48);
INSERT INTO Producer_Credit
Values(102, 16);
INSERT INTO Producer_Credit
Values(11, 54);
INSERT INTO Producer_Credit
Values(99, 2);
INSERT INTO Producer_Credit
Values(53, 12);
INSERT INTO Producer_Credit
Values(18, 31);
INSERT INTO Producer_Credit
Values(36, 18);
INSERT INTO Producer_Credit
Values(44, 41);
INSERT INTO Producer_Credit
Values(118, 29);
INSERT INTO Producer_Credit
Values(25, 15);
INSERT INTO Producer_Credit
Values(53, 32);
INSERT INTO Producer_Credit
Values(75, 30);
INSERT INTO Producer_Credit
Values(17, 25);
INSERT INTO Producer_Credit
Values(170, 22);
INSERT INTO Producer_Credit
Values(152, 52);
INSERT INTO Producer_Credit
Values(139, 45);
INSERT INTO Producer_Credit
Values(61, 9);
INSERT INTO Producer_Credit
Values(92, 35);
INSERT INTO Producer_Credit
Values(54, 8);
INSERT INTO Producer_Credit
Values(10, 3);
INSERT INTO Producer_Credit
Values(22, 29);
INSERT INTO Producer_Credit
Values(52, 7);
INSERT INTO Producer_Credit
Values(173, 47);
INSERT INTO Producer_Credit
Values(33, 24);
INSERT INTO Producer_Credit
Values(170, 35);
INSERT INTO Producer_Credit
Values(117, 18);
INSERT INTO Producer_Credit
Values(191, 7);
INSERT INTO Producer_Credit
Values(190, 8);
INSERT INTO Producer_Credit
Values(152, 32);
INSERT INTO Producer_Credit
Values(98, 5);
INSERT INTO Producer_Credit
Values(48, 16);
INSERT INTO Producer_Credit
Values(111, 16);
INSERT INTO Producer_Credit
Values(58, 21);
INSERT INTO Producer_Credit
Values(28, 4);
INSERT INTO Producer_Credit
Values(142, 30);
INSERT INTO Producer_Credit
Values(182, 35);
INSERT INTO Producer_Credit
Values(168, 19);
INSERT INTO Producer_Credit
Values(56, 43);
INSERT INTO Producer_Credit
Values(141, 8);
INSERT INTO Producer_Credit
Values(184, 40);
INSERT INTO Producer_Credit
Values(69, 14);
INSERT INTO Producer_Credit
Values(198, 55);
INSERT INTO Producer_Credit
Values(146, 35);
INSERT INTO Producer_Credit
Values(162, 48);
INSERT INTO Producer_Credit
Values(75, 20);
INSERT INTO Producer_Credit
Values(99, 59);
INSERT INTO Producer_Credit
Values(50, 24);
INSERT INTO Producer_Credit
Values(11, 23);
INSERT INTO Producer_Credit
Values(89, 2);
INSERT INTO Producer_Credit
Values(44, 9);
INSERT INTO Producer_Credit
Values(134, 40);
INSERT INTO Producer_Credit
Values(118, 37);
INSERT INTO Producer_Credit
Values(14, 16);
INSERT INTO Producer_Credit
Values(97, 26);
INSERT INTO Producer_Credit
Values(100, 22);
INSERT INTO Producer_Credit
Values(184, 14);
INSERT INTO Producer_Credit
Values(144, 28);
INSERT INTO Producer_Credit
Values(86, 32);
INSERT INTO Producer_Credit
Values(17, 57);
INSERT INTO Producer_Credit
Values(183, 19);
INSERT INTO Producer_Credit
Values(162, 55);
INSERT INTO Producer_Credit
Values(98, 52);
INSERT INTO Producer_Credit
Values(8, 25);
INSERT INTO Producer_Credit
Values(138, 8);
INSERT INTO Producer_Credit
Values(193, 21);
INSERT INTO Producer_Credit
Values(28, 6);
INSERT INTO Producer_Credit
Values(68, 47);
INSERT INTO Producer_Credit
Values(199, 55);
INSERT INTO Producer_Credit
Values(168, 37);
INSERT INTO Producer_Credit
Values(133, 47);
INSERT INTO Producer_Credit
Values(82, 23);
INSERT INTO Producer_Credit
Values(25, 51);
INSERT INTO Producer_Credit
Values(149, 41);
INSERT INTO Producer_Credit
Values(24, 55);
INSERT INTO Producer_Credit
Values(10, 37);
INSERT INTO Producer_Credit
Values(82, 27);
INSERT INTO Producer_Credit
Values(85, 51);
INSERT INTO Producer_Credit
Values(149, 17);
INSERT INTO Producer_Credit
Values(14, 44);
INSERT INTO Producer_Credit
Values(27, 33);
INSERT INTO Producer_Credit
Values(159, 43);
INSERT INTO Producer_Credit
Values(76, 17);
INSERT INTO Producer_Credit
Values(46, 16);
INSERT INTO Producer_Credit
Values(165, 11);
INSERT INTO Producer_Credit
Values(104, 53);
INSERT INTO Producer_Credit
Values(100, 29);
INSERT INTO Producer_Credit
Values(16, 30);
INSERT INTO Producer_Credit
Values(73, 16);
INSERT INTO Producer_Credit
Values(98, 15);
INSERT INTO Producer_Credit
Values(122, 3);
INSERT INTO Producer_Credit
Values(92, 10);
INSERT INTO Producer_Credit
Values(9, 36);
INSERT INTO Producer_Credit
Values(113, 19);
INSERT INTO Producer_Credit
Values(26, 47);
INSERT INTO Producer_Credit
Values(190, 56);
INSERT INTO Producer_Credit
Values(133, 2);
INSERT INTO Producer_Credit
Values(121, 43);
INSERT INTO Producer_Credit
Values(151, 5);
INSERT INTO Producer_Credit
Values(7, 40);
INSERT INTO Producer_Credit
Values(140, 52);
INSERT INTO Producer_Credit
Values(116, 12);
INSERT INTO Producer_Credit
Values(2, 29);
INSERT INTO Producer_Credit
Values(148, 16);
INSERT INTO Producer_Credit
Values(27, 30);
INSERT INTO Producer_Credit
Values(129, 9);
-- Data for table Artist Songs
INSERT INTO Artist_Songs
VALUES(43, 20, 767);
INSERT INTO Artist_Songs
VALUES(12, 165, 9525);
INSERT INTO Artist_Songs
VALUES(26, 31, 1963);
INSERT INTO Artist_Songs
VALUES(11, 136, 1490);
INSERT INTO Artist_Songs
VALUES(50, 26, 7045);
INSERT INTO Artist_Songs
VALUES(45, 55, 8991);
INSERT INTO Artist_Songs
VALUES(26, 97, 5518);
INSERT INTO Artist_Songs
VALUES(2, 191, 7685);
INSERT INTO Artist_Songs
VALUES(9, 99, 8213);
INSERT INTO Artist_Songs
VALUES(16, 91, 3446);
INSERT INTO Artist_Songs
VALUES(49, 200, 1098);
INSERT INTO Artist_Songs
VALUES(38, 10, 2538);
INSERT INTO Artist_Songs
VALUES(55, 44, 1566);
INSERT INTO Artist_Songs
VALUES(25, 146, 2226);
INSERT INTO Artist_Songs
VALUES(57, 128, 4015);
INSERT INTO Artist_Songs
VALUES(3, 169, 9103);
INSERT INTO Artist_Songs
VALUES(22, 12, 9904);
INSERT INTO Artist_Songs
VALUES(54, 21, 2416);
INSERT INTO Artist_Songs
VALUES(30, 101, 7887);
INSERT INTO Artist_Songs
VALUES(38, 197, 856);
INSERT INTO Artist_Songs
VALUES(27, 145, 7877);
INSERT INTO Artist_Songs
VALUES(31, 74, 8765);
INSERT INTO Artist_Songs
VALUES(18, 122, 2821);
INSERT INTO Artist_Songs
VALUES(40, 91, 9715);
INSERT INTO Artist_Songs
VALUES(48, 52, 6265);
INSERT INTO Artist_Songs
VALUES(60, 16, 8045);
INSERT INTO Artist_Songs
VALUES(53, 130, 6176);
INSERT INTO Artist_Songs
VALUES(57, 86, 6514);
INSERT INTO Artist_Songs
VALUES(26, 76, 9065);
INSERT INTO Artist_Songs
VALUES(21, 132, 7546);
INSERT INTO Artist_Songs
VALUES(30, 91, 1548);
INSERT INTO Artist_Songs
VALUES(40, 193, 2872);
INSERT INTO Artist_Songs
VALUES(7, 14, 1373);
INSERT INTO Artist_Songs
VALUES(24, 151, 9146);
INSERT INTO Artist_Songs
VALUES(4, 174, 3529);
INSERT INTO Artist_Songs
VALUES(50, 89, 9574);
INSERT INTO Artist_Songs
VALUES(16, 46, 9964);
INSERT INTO Artist_Songs
VALUES(35, 78, 2607);
INSERT INTO Artist_Songs
VALUES(8, 134, 7610);
INSERT INTO Artist_Songs
VALUES(48, 172, 5089);
INSERT INTO Artist_Songs
VALUES(32, 167, 6268);
INSERT INTO Artist_Songs
VALUES(59, 95, 9289);
INSERT INTO Artist_Songs
VALUES(2, 123, 9612);
INSERT INTO Artist_Songs
VALUES(49, 191, 5357);
INSERT INTO Artist_Songs
VALUES(39, 111, 4348);
INSERT INTO Artist_Songs
VALUES(9, 178, 5972);
INSERT INTO Artist_Songs
VALUES(22, 88, 5808);
INSERT INTO Artist_Songs
VALUES(6, 52, 9533);
INSERT INTO Artist_Songs
VALUES(2, 39, 5679);
INSERT INTO Artist_Songs
VALUES(57, 177, 8061);
INSERT INTO Artist_Songs
VALUES(54, 101, 3566);
INSERT INTO Artist_Songs
VALUES(46, 123, 8415);
INSERT INTO Artist_Songs
VALUES(56, 76, 3692);
INSERT INTO Artist_Songs
VALUES(35, 88, 4761);
INSERT INTO Artist_Songs
VALUES(24, 168, 8315);
INSERT INTO Artist_Songs
VALUES(23, 103, 2779);
INSERT INTO Artist_Songs
VALUES(40, 163, 5259);
INSERT INTO Artist_Songs
VALUES(13, 104, 6375);
INSERT INTO Artist_Songs
VALUES(22, 42, 5238);
INSERT INTO Artist_Songs
VALUES(60, 187, 1981);
INSERT INTO Artist_Songs
VALUES(14, 43, 9487);
INSERT INTO Artist_Songs
VALUES(45, 151, 9276);
INSERT INTO Artist_Songs
VALUES(10, 62, 1347);
INSERT INTO Artist_Songs
VALUES(41, 106, 4507);
INSERT INTO Artist_Songs
VALUES(29, 162, 6211);
INSERT INTO Artist_Songs
VALUES(16, 115, 6685);
INSERT INTO Artist_Songs
VALUES(22, 40, 7352);
INSERT INTO Artist_Songs
VALUES(15, 32, 1387);
INSERT INTO Artist_Songs
VALUES(54, 88, 2909);
INSERT INTO Artist_Songs
VALUES(10, 127, 3143);
INSERT INTO Artist_Songs
VALUES(56, 26, 2032);
INSERT INTO Artist_Songs
VALUES(43, 16, 2838);
INSERT INTO Artist_Songs
VALUES(40, 142, 1420);
INSERT INTO Artist_Songs
VALUES(3, 40, 5144);
INSERT INTO Artist_Songs
VALUES(44, 151, 3359);
INSERT INTO Artist_Songs
VALUES(39, 109, 4865);
INSERT INTO Artist_Songs
VALUES(49, 184, 9434);
INSERT INTO Artist_Songs
VALUES(56, 88, 3946);
INSERT INTO Artist_Songs
VALUES(26, 87, 3080);
INSERT INTO Artist_Songs
VALUES(27, 132, 9934);
INSERT INTO Artist_Songs
VALUES(5, 41, 6630);
INSERT INTO Artist_Songs
VALUES(28, 36, 7442);
INSERT INTO Artist_Songs
VALUES(1, 122, 7248);
INSERT INTO Artist_Songs
VALUES(60, 170, 3532);
INSERT INTO Artist_Songs
VALUES(10, 64, 1422);
INSERT INTO Artist_Songs
VALUES(56, 101, 7947);
INSERT INTO Artist_Songs
VALUES(25, 126, 1831);
INSERT INTO Artist_Songs
VALUES(38, 194, 3508);
INSERT INTO Artist_Songs
VALUES(28, 15, 9153);
INSERT INTO Artist_Songs
VALUES(60, 110, 5192);
INSERT INTO Artist_Songs
VALUES(53, 10, 2883);
INSERT INTO Artist_Songs
VALUES(12, 177, 1759);
INSERT INTO Artist_Songs
VALUES(3, 168, 2480);
INSERT INTO Artist_Songs
VALUES(32, 88, 5985);
INSERT INTO Artist_Songs
VALUES(50, 171, 3190);
INSERT INTO Artist_Songs
VALUES(27, 194, 3930);
INSERT INTO Artist_Songs
VALUES(27, 121, 8914);
INSERT INTO Artist_Songs
VALUES(49, 173, 9591);
INSERT INTO Artist_Songs
VALUES(41, 130, 1794);
INSERT INTO Artist_Songs
VALUES(60, 60, 6174);
INSERT INTO Artist_Songs
VALUES(7, 110, 8266);
INSERT INTO Artist_Songs
VALUES(8, 27, 6799);
INSERT INTO Artist_Songs
VALUES(52, 192, 1539);
INSERT INTO Artist_Songs
VALUES(48, 59, 1162);
INSERT INTO Artist_Songs
VALUES(21, 113, 2885);
INSERT INTO Artist_Songs
VALUES(11, 70, 9662);
INSERT INTO Artist_Songs
VALUES(39, 150, 1180);
INSERT INTO Artist_Songs
VALUES(5, 27, 3755);
INSERT INTO Artist_Songs
VALUES(14, 56, 2817);
INSERT INTO Artist_Songs
VALUES(38, 75, 8324);
INSERT INTO Artist_Songs
VALUES(56, 158, 4018);
INSERT INTO Artist_Songs
VALUES(34, 121, 7400);
INSERT INTO Artist_Songs
VALUES(17, 84, 1340);
INSERT INTO Artist_Songs
VALUES(52, 8, 4157);
INSERT INTO Artist_Songs
VALUES(25, 4, 1793);
INSERT INTO Artist_Songs
VALUES(50, 166, 5345);
INSERT INTO Artist_Songs
VALUES(23, 54, 8922);
INSERT INTO Artist_Songs
VALUES(6, 144, 9607);
INSERT INTO Artist_Songs
VALUES(20, 178, 9097);
INSERT INTO Artist_Songs
VALUES(51, 111, 9027);
INSERT INTO Artist_Songs
VALUES(41, 193, 8209);
INSERT INTO Artist_Songs
VALUES(59, 46, 9761);
INSERT INTO Artist_Songs
VALUES(8, 137, 3209);
INSERT INTO Artist_Songs
VALUES(58, 97, 946);
INSERT INTO Artist_Songs
VALUES(22, 20, 6657);
INSERT INTO Artist_Songs
VALUES(50, 118, 4177);
INSERT INTO Artist_Songs
VALUES(4, 43, 3244);
INSERT INTO Artist_Songs
VALUES(5, 2, 3785);
INSERT INTO Artist_Songs
VALUES(31, 100, 6587);
INSERT INTO Artist_Songs
VALUES(13, 26, 2280);
INSERT INTO Artist_Songs
VALUES(14, 42, 2171);
INSERT INTO Artist_Songs
VALUES(29, 113, 5536);
INSERT INTO Artist_Songs
VALUES(49, 46, 2589);
INSERT INTO Artist_Songs
VALUES(20, 115, 6391);
INSERT INTO Artist_Songs
VALUES(16, 149, 1422);
INSERT INTO Artist_Songs
VALUES(7, 52, 859);
INSERT INTO Artist_Songs
VALUES(6, 134, 9619);
INSERT INTO Artist_Songs
VALUES(4, 51, 1843);
INSERT INTO Artist_Songs
VALUES(13, 190, 1721);
INSERT INTO Artist_Songs
VALUES(15, 72, 7402);
INSERT INTO Artist_Songs
VALUES(30, 141, 7859);
INSERT INTO Artist_Songs
VALUES(39, 52, 1947);
INSERT INTO Artist_Songs
VALUES(49, 150, 1453);
INSERT INTO Artist_Songs
VALUES(3, 113, 4265);
INSERT INTO Artist_Songs
VALUES(16, 108, 7270);
INSERT INTO Artist_Songs
VALUES(49, 138, 3151);
INSERT INTO Artist_Songs
VALUES(31, 44, 3134);
INSERT INTO Artist_Songs
VALUES(45, 47, 6935);
INSERT INTO Artist_Songs
VALUES(40, 115, 6682);
INSERT INTO Artist_Songs
VALUES(20, 76, 9551);
INSERT INTO Artist_Songs
VALUES(30, 185, 8528);
INSERT INTO Artist_Songs
VALUES(10, 88, 4346);
INSERT INTO Artist_Songs
VALUES(32, 79, 5265);
INSERT INTO Artist_Songs
VALUES(48, 115, 7521);
INSERT INTO Artist_Songs
VALUES(31, 161, 8835);
INSERT INTO Artist_Songs
VALUES(14, 157, 1561);
INSERT INTO Artist_Songs
VALUES(41, 110, 5094);
INSERT INTO Artist_Songs
VALUES(4, 64, 2053);
INSERT INTO Artist_Songs
VALUES(12, 34, 7057);
INSERT INTO Artist_Songs
VALUES(27, 104, 7769);
INSERT INTO Artist_Songs
VALUES(3, 13, 8529);
INSERT INTO Artist_Songs
VALUES(5, 79, 5619);
INSERT INTO Artist_Songs
VALUES(45, 168, 1589);
INSERT INTO Artist_Songs
VALUES(46, 93, 9616);
INSERT INTO Artist_Songs
VALUES(6, 59, 1814);
INSERT INTO Artist_Songs
VALUES(38, 164, 1501);
INSERT INTO Artist_Songs
VALUES(2, 49, 6573);
INSERT INTO Artist_Songs
VALUES(33, 104, 2769);
INSERT INTO Artist_Songs
VALUES(56, 44, 8814);
INSERT INTO Artist_Songs
VALUES(53, 123, 3403);
INSERT INTO Artist_Songs
VALUES(14, 187, 5245);
INSERT INTO Artist_Songs
VALUES(26, 10, 6829);
INSERT INTO Artist_Songs
VALUES(18, 138, 3360);
INSERT INTO Artist_Songs
VALUES(31, 36, 5435);
INSERT INTO Artist_Songs
VALUES(4, 88, 6615);
INSERT INTO Artist_Songs
VALUES(41, 58, 1843);
INSERT INTO Artist_Songs
VALUES(42, 66, 3004);
INSERT INTO Artist_Songs
VALUES(35, 106, 1201);
INSERT INTO Artist_Songs
VALUES(47, 79, 8406);
INSERT INTO Artist_Songs
VALUES(40, 12, 4515);
INSERT INTO Artist_Songs
VALUES(2, 196, 9101);
INSERT INTO Artist_Songs
VALUES(33, 103, 2935);
INSERT INTO Artist_Songs
VALUES(60, 79, 8318);
INSERT INTO Artist_Songs
VALUES(23, 104, 3945);
INSERT INTO Artist_Songs
VALUES(22, 164, 6903);
INSERT INTO Artist_Songs
VALUES(15, 30, 9452);
INSERT INTO Artist_Songs
VALUES(42, 191, 7518);
INSERT INTO Artist_Songs
VALUES(15, 77, 5283);
INSERT INTO Artist_Songs
VALUES(55, 45, 1887);
INSERT INTO Artist_Songs
VALUES(29, 107, 579);
INSERT INTO Artist_Songs
VALUES(37, 67, 3227);
INSERT INTO Artist_Songs
VALUES(41, 105, 6174);
INSERT INTO Artist_Songs
VALUES(54, 11, 4286);
INSERT INTO Artist_Songs
VALUES(14, 198, 7751);
INSERT INTO Artist_Songs
VALUES(28, 176, 2489);
INSERT INTO Artist_Songs
VALUES(7, 120, 5021);
INSERT INTO Artist_Songs
VALUES(47, 86, 2736);
INSERT INTO Artist_Songs
VALUES(38, 34, 2079);
INSERT INTO Artist_Songs
VALUES(11, 41, 5816);
INSERT INTO Artist_Songs
VALUES(13, 46, 2390);
-- Data for table user_community
INSERT INTO User_Community
VALUES(18, 37);
INSERT INTO User_Community
Values(13, 17);
INSERT INTO User_Community
Values(49, 54);
INSERT INTO User_Community
Values(20, 43);
INSERT INTO User_Community
Values(21, 47);
INSERT INTO User_Community
Values(60, 48);
INSERT INTO User_Community
Values(28, 30);
INSERT INTO User_Community
Values(8, 14);
INSERT INTO User_Community
Values(25, 24);
INSERT INTO User_Community
Values(29, 26);
INSERT INTO User_Community
Values(40, 52);
INSERT INTO User_Community
Values(3, 46);
INSERT INTO User_Community
Values(8, 7);
INSERT INTO User_Community
Values(25, 57);
INSERT INTO User_Community
Values(39, 11);
INSERT INTO User_Community
Values(26, 28);
INSERT INTO User_Community
Values(52, 58);
INSERT INTO User_Community
Values(14, 18);
INSERT INTO User_Community
Values(22, 41);
INSERT INTO User_Community
Values(44, 3);
INSERT INTO User_Community
Values(21, 4);
INSERT INTO User_Community
Values(2, 23);
INSERT INTO User_Community
Values(23, 50);
INSERT INTO User_Community
Values(5, 38);
INSERT INTO User_Community
Values(18, 4);
INSERT INTO User_Community
Values(4, 17);
INSERT INTO User_Community
Values(39, 34);
INSERT INTO User_Community
Values(14, 30);
INSERT INTO User_Community
Values(57, 32);
INSERT INTO User_Community
Values(52, 51);
INSERT INTO User_Community
Values(48, 57);
INSERT INTO User_Community
Values(44, 36);
INSERT INTO User_Community
Values(22, 8);
INSERT INTO User_Community
Values(37, 28);
INSERT INTO User_Community
Values(11, 42);
INSERT INTO User_Community
Values(27, 23);
INSERT INTO User_Community
Values(44, 12);
INSERT INTO User_Community
Values(11, 57);
INSERT INTO User_Community
Values(24, 23);
INSERT INTO User_Community
Values(28, 54);
INSERT INTO User_Community
Values(32, 13);
INSERT INTO User_Community
Values(29, 18);
INSERT INTO User_Community
Values(49, 21);
INSERT INTO User_Community
Values(23, 41);
INSERT INTO User_Community
Values(35, 24);
INSERT INTO User_Community
Values(14, 38);
INSERT INTO User_Community
Values(38, 49);
INSERT INTO User_Community
Values(10, 15);
INSERT INTO User_Community
Values(9, 6);
INSERT INTO User_Community
Values(30, 20);
INSERT INTO User_Community
Values(47, 15);
INSERT INTO User_Community
Values(17, 18);
INSERT INTO User_Community
Values(4, 1);
INSERT INTO User_Community
Values(39, 43);
INSERT INTO User_Community
Values(20, 16);
INSERT INTO User_Community
Values(24, 31);
INSERT INTO User_Community
Values(15, 41);
INSERT INTO User_Community
Values(36, 23);
INSERT INTO User_Community
Values(57, 51);
INSERT INTO User_Community
Values(31, 33);
INSERT INTO User_Community
Values(41, 11);
INSERT INTO User_Community
Values(25, 32);
INSERT INTO User_Community
Values(43, 54);
INSERT INTO User_Community
Values(13, 29);
INSERT INTO User_Community
Values(44, 59);
INSERT INTO User_Community
Values(7, 9);
INSERT INTO User_Community
Values(59, 56);
INSERT INTO User_Community
Values(32, 18);
INSERT INTO User_Community
Values(45, 33);
INSERT INTO User_Community
Values(10, 1);
INSERT INTO User_Community
Values(6, 8);
INSERT INTO User_Community
Values(5, 19);
INSERT INTO User_Community
Values(42, 9);
INSERT INTO User_Community
Values(24, 28);
INSERT INTO User_Community
Values(44, 40);
INSERT INTO User_Community
Values(48, 44);
INSERT INTO User_Community
Values(47, 3);
INSERT INTO User_Community
Values(36, 58);
INSERT INTO User_Community
Values(4, 23);
INSERT INTO User_Community
Values(56, 54);
INSERT INTO User_Community
Values(36, 25);
INSERT INTO User_Community
Values(8, 2);
INSERT INTO User_Community
Values(49, 12);
INSERT INTO User_Community
Values(9, 5);
INSERT INTO User_Community
Values(53, 11);
INSERT INTO User_Community
Values(41, 8);
INSERT INTO User_Community
Values(8, 10);
INSERT INTO User_Community
Values(47, 52);
INSERT INTO User_Community
Values(2, 47);
INSERT INTO User_Community
Values(55, 32);
INSERT INTO User_Community
Values(27, 59);
INSERT INTO User_Community
Values(11, 60);
INSERT INTO User_Community
Values(55, 8);
INSERT INTO User_Community
Values(58, 1);
INSERT INTO User_Community
Values(19, 29);
INSERT INTO User_Community
Values(45, 35);
INSERT INTO User_Community
Values(18, 14);
INSERT INTO User_Community
Values(51, 42);
INSERT INTO User_Community
Values(45, 55);
INSERT INTO User_Community
Values(1, 58);
INSERT INTO User_Community
Values(11, 10);
INSERT INTO User_Community
Values(25, 6);
INSERT INTO User_Community
Values(13, 25);
INSERT INTO User_Community
Values(32, 45);
INSERT INTO User_Community
Values(41, 22);
INSERT INTO User_Community
Values(11, 13);
INSERT INTO User_Community
Values(23, 16);
INSERT INTO User_Community
Values(27, 30);
INSERT INTO User_Community
Values(55, 47);
INSERT INTO User_Community
Values(44, 38);
INSERT INTO User_Community
Values(46, 60);
INSERT INTO User_Community
Values(14, 57);
INSERT INTO User_Community
Values(54, 30);
INSERT INTO User_Community
Values(27, 11);
INSERT INTO User_Community
Values(38, 27);
INSERT INTO User_Community
Values(60, 37);
INSERT INTO User_Community
Values(2, 39);
INSERT INTO User_Community
Values(10, 56);
INSERT INTO User_Community
Values(20, 26);
INSERT INTO User_Community
Values(56, 43);
INSERT INTO User_Community
Values(43, 32);
INSERT INTO User_Community
Values(28, 16);
INSERT INTO User_Community
Values(15, 48);
INSERT INTO User_Community
Values(44, 55);
INSERT INTO User_Community
Values(7, 13);
INSERT INTO User_Community
Values(11, 23);
INSERT INTO User_Community
Values(31, 40);
INSERT INTO User_Community
Values(38, 34);
INSERT INTO User_Community
Values(21, 43);
INSERT INTO User_Community
Values(51, 41);
INSERT INTO User_Community
Values(24, 14);
INSERT INTO User_Community
Values(5, 30);
INSERT INTO User_Community
Values(53, 31);
INSERT INTO User_Community
Values(18, 43);
INSERT INTO User_Community
Values(23, 12);
INSERT INTO User_Community
Values(56, 3);
INSERT INTO User_Community
Values(30, 56);
INSERT INTO User_Community
Values(5, 2);
INSERT INTO User_Community
Values(53, 21);
INSERT INTO User_Community
Values(20, 60);
INSERT INTO User_Community
Values(7, 20);
INSERT INTO User_Community
Values(3, 15);
INSERT INTO User_Community
Values(51, 12);
INSERT INTO User_Community
Values(43, 42);
INSERT INTO User_Community
Values(27, 60);
INSERT INTO User_Community
Values(57, 42);
INSERT INTO User_Community
Values(39, 21);
INSERT INTO User_Community
Values(29, 50);
INSERT INTO User_Community
Values(30, 3);
INSERT INTO User_Community
Values(34, 18);
INSERT INTO User_Community
Values(1, 31);
INSERT INTO User_Community
Values(56, 19);
INSERT INTO User_Community
Values(36, 2);
INSERT INTO User_Community
Values(15, 20);
INSERT INTO User_Community
Values(27, 32);
INSERT INTO User_Community
Values(6, 60);
INSERT INTO User_Community
Values(34, 8);
INSERT INTO User_Community
Values(25, 16);
INSERT INTO User_Community
Values(38, 40);
INSERT INTO User_Community
Values(39, 36);
INSERT INTO User_Community
Values(45, 26);
INSERT INTO User_Community
Values(23, 15);
INSERT INTO User_Community
Values(28, 41);
INSERT INTO User_Community
Values(15, 54);
INSERT INTO User_Community
Values(48, 8);
INSERT INTO User_Community
Values(33, 5);
INSERT INTO User_Community
Values(31, 4);
INSERT INTO User_Community
Values(60, 33);
INSERT INTO User_Community
Values(41, 37);
INSERT INTO User_Community
Values(55, 1);
INSERT INTO User_Community
Values(19, 31);
INSERT INTO User_Community
Values(26, 18);
INSERT INTO User_Community
Values(43, 22);
INSERT INTO User_Community
Values(3, 55);
INSERT INTO User_Community
Values(10, 4);
INSERT INTO User_Community
Values(59, 58);
INSERT INTO User_Community
Values(19, 19);
INSERT INTO User_Community
Values(50, 17);
INSERT INTO User_Community
Values(30, 60);
INSERT INTO User_Community
Values(55, 49);
INSERT INTO User_Community
Values(16, 19);
INSERT INTO User_Community
Values(40, 36);
INSERT INTO User_Community
Values(18, 56);
INSERT INTO User_Community
Values(58, 26);
INSERT INTO User_Community
Values(53, 41);
INSERT INTO User_Community
Values(44, 29);
INSERT INTO User_Community
Values(4, 20);
INSERT INTO User_Community
Values(50, 48);
INSERT INTO User_Community
Values(46, 59);
INSERT INTO User_Community
Values(49, 56);
INSERT INTO User_Community
Values(55, 33);
INSERT INTO User_Community
Values(12, 36);
INSERT INTO User_Community
Values(36, 55);
INSERT INTO User_Community
Values(11, 37);
INSERT INTO User_Community
Values(1, 25);
INSERT INTO User_Community
Values(39, 13);
INSERT INTO User_Community
Values(28, 1);
INSERT INTO User_Community
Values(35, 33);
INSERT INTO User_Community
Values(32, 16);
INSERT INTO User_Community
Values(22, 54);
-- Data for table user_following
INSERT INTO User_Following
Values(36, 16);
INSERT INTO User_Following
Values(3, 38);
INSERT INTO User_Following
Values(19, 41);
INSERT INTO User_Following
Values(14, 26);
INSERT INTO User_Following
Values(48, 44);
INSERT INTO User_Following
Values(35, 40);
INSERT INTO User_Following
Values(3, 7);
INSERT INTO User_Following
Values(22, 6);
INSERT INTO User_Following
Values(15, 55);
INSERT INTO User_Following
Values(9, 24);
INSERT INTO User_Following
Values(18, 36);
INSERT INTO User_Following
Values(13, 57);
INSERT INTO User_Following
Values(59, 40);
INSERT INTO User_Following
Values(24, 8);
INSERT INTO User_Following
Values(43, 10);
INSERT INTO User_Following
Values(14, 44);
INSERT INTO User_Following
Values(4, 36);
INSERT INTO User_Following
Values(38, 47);
INSERT INTO User_Following
Values(33, 17);
INSERT INTO User_Following
Values(37, 25);
INSERT INTO User_Following
Values(11, 47);
INSERT INTO User_Following
Values(9, 18);
INSERT INTO User_Following
Values(53, 32);
INSERT INTO User_Following
Values(60, 5);
INSERT INTO User_Following
Values(55, 1);
INSERT INTO User_Following
Values(4, 58);
INSERT INTO User_Following
Values(60, 56);
INSERT INTO User_Following
Values(21, 21);
INSERT INTO User_Following
Values(13, 38);
INSERT INTO User_Following
Values(39, 44);
INSERT INTO User_Following
Values(59, 48);
INSERT INTO User_Following
Values(53, 31);
INSERT INTO User_Following
Values(19, 11);
INSERT INTO User_Following
Values(10, 51);
INSERT INTO User_Following
Values(1, 26);
INSERT INTO User_Following
Values(9, 25);
INSERT INTO User_Following
Values(18, 56);
INSERT INTO User_Following
Values(6, 20);
INSERT INTO User_Following
Values(14, 19);
INSERT INTO User_Following
Values(10, 55);
INSERT INTO User_Following
Values(45, 24);
INSERT INTO User_Following
Values(60, 40);
INSERT INTO User_Following
Values(12, 13);
INSERT INTO User_Following
Values(2, 54);
INSERT INTO User_Following
Values(54, 31);
INSERT INTO User_Following
Values(4, 1);
INSERT INTO User_Following
Values(19, 34);
INSERT INTO User_Following
Values(6, 52);
INSERT INTO User_Following
Values(41, 14);
INSERT INTO User_Following
Values(51, 38);
INSERT INTO User_Following
Values(17, 15);
INSERT INTO User_Following
Values(59, 42);
INSERT INTO User_Following
Values(38, 3);
INSERT INTO User_Following
Values(30, 33);
INSERT INTO User_Following
Values(34, 5);
INSERT INTO User_Following
Values(38, 22);
INSERT INTO User_Following
Values(58, 39);
INSERT INTO User_Following
Values(19, 48);
INSERT INTO User_Following
Values(35, 52);
INSERT INTO User_Following
Values(60, 3);
INSERT INTO User_Following
Values(37, 45);
INSERT INTO User_Following
Values(2, 32);
INSERT INTO User_Following
Values(5, 21);
INSERT INTO User_Following
Values(52, 53);
INSERT INTO User_Following
Values(44, 20);
INSERT INTO User_Following
Values(47, 23);
INSERT INTO User_Following
Values(54, 35);
INSERT INTO User_Following
Values(11, 13);
INSERT INTO User_Following
Values(30, 6);
INSERT INTO User_Following
Values(55, 31);
INSERT INTO User_Following
Values(31, 28);
INSERT INTO User_Following
Values(28, 37);
INSERT INTO User_Following
Values(49, 48);
INSERT INTO User_Following
Values(59, 41);
INSERT INTO User_Following
Values(13, 16);
INSERT INTO User_Following
Values(31, 34);
INSERT INTO User_Following
Values(57, 13);
INSERT INTO User_Following
Values(55, 58);
INSERT INTO User_Following
Values(11, 58);
INSERT INTO User_Following
Values(51, 57);
INSERT INTO User_Following
Values(4, 37);
INSERT INTO User_Following
Values(40, 45);
INSERT INTO User_Following
Values(37, 14);
INSERT INTO User_Following
Values(31, 35);
INSERT INTO User_Following
Values(3, 3);
INSERT INTO User_Following
Values(39, 40);
INSERT INTO User_Following
Values(2, 59);
INSERT INTO User_Following
Values(58, 50);
INSERT INTO User_Following
Values(56, 22);
INSERT INTO User_Following
Values(42, 16);
INSERT INTO User_Following
Values(59, 26);
INSERT INTO User_Following
Values(48, 48);
INSERT INTO User_Following
Values(11, 51);
INSERT INTO User_Following
Values(40, 35);
INSERT INTO User_Following
Values(19, 36);
INSERT INTO User_Following
Values(26, 6);
INSERT INTO User_Following
Values(49, 8);
INSERT INTO User_Following
Values(42, 28);
INSERT INTO User_Following
Values(3, 9);
INSERT INTO User_Following
Values(19, 47);
INSERT INTO User_Following
Values(31, 3);
INSERT INTO User_Following
Values(34, 11);
INSERT INTO User_Following
Values(34, 20);
INSERT INTO User_Following
Values(22, 4);
INSERT INTO User_Following
Values(44, 25);
INSERT INTO User_Following
Values(45, 54);
INSERT INTO User_Following
Values(24, 14);
INSERT INTO User_Following
Values(50, 32);
INSERT INTO User_Following
Values(25, 43);
INSERT INTO User_Following
Values(20, 41);
INSERT INTO User_Following
Values(55, 39);
INSERT INTO User_Following
Values(34, 8);
INSERT INTO User_Following
Values(9, 21);
INSERT INTO User_Following
Values(18, 17);
INSERT INTO User_Following
Values(16, 10);
INSERT INTO User_Following
Values(52, 26);
INSERT INTO User_Following
Values(8, 41);
INSERT INTO User_Following
Values(36, 32);
INSERT INTO User_Following
Values(55, 4);
INSERT INTO User_Following
Values(35, 44);
INSERT INTO User_Following
Values(11, 42);
INSERT INTO User_Following
Values(34, 18);
INSERT INTO User_Following
Values(3, 8);
INSERT INTO User_Following
Values(5, 35);
INSERT INTO User_Following
Values(1, 11);
INSERT INTO User_Following
Values(6, 51);
INSERT INTO User_Following
Values(35, 22);
INSERT INTO User_Following
Values(40, 27);
INSERT INTO User_Following
Values(29, 52);
INSERT INTO User_Following
Values(20, 43);
INSERT INTO User_Following
Values(10, 13);
INSERT INTO User_Following
Values(1, 28);
INSERT INTO User_Following
Values(15, 4);
INSERT INTO User_Following
Values(55, 16);
INSERT INTO User_Following
Values(4, 27);
INSERT INTO User_Following
Values(3, 53);
INSERT INTO User_Following
Values(45, 12);
INSERT INTO User_Following
Values(22, 23);
INSERT INTO User_Following
Values(11, 41);
INSERT INTO User_Following
Values(37, 57);
INSERT INTO User_Following
Values(32, 36);
INSERT INTO User_Following
Values(46, 5);
INSERT INTO User_Following
Values(40, 11);
INSERT INTO User_Following
Values(51, 55);
INSERT INTO User_Following
Values(50, 4);
INSERT INTO User_Following
Values(57, 55);
INSERT INTO User_Following
Values(58, 6);
INSERT INTO User_Following
Values(29, 43);
INSERT INTO User_Following
Values(30, 53);
INSERT INTO User_Following
Values(23, 28);
INSERT INTO User_Following
Values(42, 32);
INSERT INTO User_Following
Values(20, 46);
INSERT INTO User_Following
Values(40, 54);
INSERT INTO User_Following
Values(30, 5);
INSERT INTO User_Following
Values(24, 12);
INSERT INTO User_Following
Values(5, 47);
INSERT INTO User_Following
Values(34, 55);
INSERT INTO User_Following
Values(42, 47);
INSERT INTO User_Following
Values(39, 4);
INSERT INTO User_Following
Values(36, 36);
INSERT INTO User_Following
Values(43, 24);
INSERT INTO User_Following
Values(12, 35);
INSERT INTO User_Following
Values(42, 57);
INSERT INTO User_Following
Values(53, 43);
INSERT INTO User_Following
Values(52, 25);
INSERT INTO User_Following
Values(26, 16);
INSERT INTO User_Following
Values(4, 30);
INSERT INTO User_Following
Values(43, 53);
INSERT INTO User_Following
Values(9, 46);
INSERT INTO User_Following
Values(16, 56);
INSERT INTO User_Following
Values(42, 17);
INSERT INTO User_Following
Values(21, 5);
INSERT INTO User_Following
Values(12, 44);
INSERT INTO User_Following
Values(13, 18);
INSERT INTO User_Following
Values(16, 20);
INSERT INTO User_Following
Values(18, 4);
INSERT INTO User_Following
Values(41, 35);
INSERT INTO User_Following
Values(3, 40);
INSERT INTO User_Following
Values(46, 24);
INSERT INTO User_Following
Values(37, 29);
INSERT INTO User_Following
Values(31, 12);
INSERT INTO User_Following
Values(38, 4);
INSERT INTO User_Following
Values(22, 16);
INSERT INTO User_Following
Values(43, 14);
INSERT INTO User_Following
Values(47, 13);
INSERT INTO User_Following
Values(8, 2);
INSERT INTO User_Following
Values(31, 7);
INSERT INTO User_Following
Values(11, 35);
INSERT INTO User_Following
Values(36, 21);
INSERT INTO User_Following
Values(50, 50);
INSERT INTO User_Following
Values(41, 3);
INSERT INTO User_Following
Values(14, 49);
INSERT INTO User_Following
Values(2, 20);
INSERT INTO User_Following
Values(6, 45);
INSERT INTO User_Following
Values(56, 30);
INSERT INTO User_Following
Values(24, 5);
INSERT INTO User_Following
Values(52, 4);
INSERT INTO User_Following
Values(42, 27);
INSERT INTO User_Following
Values(12, 33);
INSERT INTO User_Following
Values(21, 58);
-- Data for table UserArtist_Interaction
INSERT INTO UserArtist_Interactions
VALUES(1, 3, 'Nulla ac enim.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        33,
        25,
        'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        41,
        2,
        'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(38, 28, 'Nulla tellus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(46, 71, 'Nullam varius.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(49, 49, 'In eleifend quam a odio.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(38, 66, 'Proin eu mi.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(27, 36, 'Nulla suscipit ligula in lacus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        10,
        53,
        'Nulla ut erat id mauris vulputate elementum.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        24,
        34,
        'Morbi vel lectus in quam fringilla rhoncus.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(25, 2, 'Phasellus in felis.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(44, 76, 'In eleifend quam a odio.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(40, 71, 'Ut tellus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(36, 76, 'Proin eu mi.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(58, 15, 'Quisque porta volutpat erat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(48, 72, 'Aenean sit amet justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(31, 12, 'In blandit ultrices enim.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(22, 46, 'Fusce consequat.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        42,
        72,
        'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(31, 36, 'In hac habitasse platea dictumst.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(24, 21, 'Donec semper sapien a libero.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        18,
        77,
        'Proin at turpis a pede posuere nonummy.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(25, 39, 'Donec ut dolor.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(55, 53, 'Proin eu mi.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(53, 37, 'Fusce posuere felis sed lacus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        47,
        48,
        'Morbi non quam nec dui luctus rutrum.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        23,
        2,
        'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(58, 30, 'Ut tellus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        8,
        64,
        'In est risus, auctor sed, tristique in, tempus sit amet, sem.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(13, 6, 'Suspendisse potenti.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(26, 2, 'Proin risus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(41, 30, 'Etiam justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(51, 48, 'Duis aliquam convallis nunc.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(2, 6, 'Pellentesque ultrices mattis odio.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        4,
        38,
        'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(36, 44, 'Mauris sit amet eros.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(31, 41, 'Etiam justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(7, 80, 'Quisque ut erat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        59,
        50,
        'Donec quis orci eget orci vehicula condimentum.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        3,
        22,
        'Curabitur in libero ut massa volutpat convallis.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(29, 17, 'Duis ac nibh.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        26,
        19,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(38, 5, 'Nunc nisl.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(3, 7, 'Nullam molestie nibh in lectus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(49, 67, 'Nulla facilisi.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        18,
        43,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(43, 52, 'In hac habitasse platea dictumst.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(50, 53, 'Morbi a ipsum.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(16, 15, 'Sed accumsan felis.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(24, 12, 'Nulla mollis molestie lorem.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(7, 61, 'Nulla mollis molestie lorem.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        44,
        59,
        'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(14, 9, 'Nunc rhoncus dui vel sem.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(40, 36, 'Morbi porttitor lorem id ligula.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(9, 20, 'In hac habitasse platea dictumst.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(32, 25, 'Integer a nibh.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(48, 28, 'Aenean fermentum.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        33,
        5,
        'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        3,
        78,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(52, 27, 'Proin risus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(16, 17, 'Donec dapibus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        47,
        61,
        'Cras in purus eu magna vulputate luctus.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(52, 69, 'Aenean lectus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        34,
        42,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(19, 5, 'Sed accumsan felis.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(33, 9, 'Aliquam erat volutpat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(19, 10, 'In hac habitasse platea dictumst.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(29, 16, 'Aenean fermentum.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        27,
        24,
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(7, 32, 'Vestibulum rutrum rutrum neque.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        26,
        52,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(6, 36, 'Fusce consequat.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(60, 80, 'Praesent blandit lacinia erat.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        24,
        68,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        45,
        12,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(46, 64, 'Nulla facilisi.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        38,
        40,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(9, 41, 'Proin risus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(32, 30, 'Praesent blandit lacinia erat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(31, 13, 'Morbi ut odio.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(51, 25, 'Proin risus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(56, 14, 'Quisque ut erat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(41, 12, 'Pellentesque eget nunc.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(2, 36, 'Cras pellentesque volutpat dui.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        1,
        61,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        60,
        12,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(55, 26, 'Duis aliquam convallis nunc.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(25, 60, 'Nunc purus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(45, 18, 'Pellentesque viverra pede ac diam.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(28, 11, 'Praesent lectus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(44, 29, 'Pellentesque at nulla.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(12, 11, 'Donec posuere metus vitae ipsum.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        27,
        72,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(49, 63, 'Maecenas pulvinar lobortis est.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        20,
        71,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(13, 60, 'Donec vitae nisi.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        22,
        55,
        'Phasellus id sapien in sapien iaculis congue.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        30,
        72,
        'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(40, 74, 'Praesent blandit.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(4, 60, 'Suspendisse potenti.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(44, 33, 'Nam dui.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(26, 68, 'Aenean fermentum.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        39,
        47,
        'Maecenas ut massa quis augue luctus tincidunt.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(18, 23, 'Morbi porttitor lorem id ligula.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        31,
        69,
        'Praesent id massa id nisl venenatis lacinia.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        35,
        39,
        'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(15, 44, 'Suspendisse potenti.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        8,
        62,
        'Curabitur at ipsum ac tellus semper interdum.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(7, 68, 'Maecenas tincidunt lacus at velit.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(15, 56, 'Nam dui.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(19, 25, 'Nulla facilisi.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(34, 7, 'Etiam pretium iaculis justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(53, 16, 'Fusce consequat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        59,
        48,
        'Morbi quis tortor id nulla ultrices aliquet.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(24, 29, 'Aenean lectus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(43, 32, 'Nulla facilisi.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        13,
        42,
        'In est risus, auctor sed, tristique in, tempus sit amet, sem.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(8, 39, 'Sed accumsan felis.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(5, 78, 'Praesent lectus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        26,
        63,
        'Nulla ut erat id mauris vulputate elementum.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        29,
        79,
        'Mauris ullamcorper purus sit amet nulla.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(15, 52, 'Quisque ut erat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        37,
        34,
        'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(28, 10, 'Aenean lectus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        46,
        73,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(59, 12, 'Suspendisse potenti.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        23,
        74,
        'Praesent id massa id nisl venenatis lacinia.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        46,
        62,
        'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(35, 34, 'Nunc nisl.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(8, 65, 'In hac habitasse platea dictumst.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        33,
        78,
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        51,
        63,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(32, 32, 'Pellentesque viverra pede ac diam.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(17, 36, 'Pellentesque eget nunc.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        28,
        53,
        'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        44,
        30,
        'Praesent id massa id nisl venenatis lacinia.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(22, 49, 'Duis mattis egestas metus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(9, 68, 'In congue.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        60,
        4,
        'Curabitur in libero ut massa volutpat convallis.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        45,
        68,
        'Vestibulum ante ipsum primis incubilia Curae; Donec pharetra, magna.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(20, 34, 'Pellentesque viverra pede ac diam.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(42, 47, 'Integer tincidunt ante vel ipsum.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(37, 26, 'Proin eu mi.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(57, 44, 'Etiam vel augue.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        32,
        31,
        'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        23,
        79,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        25,
        54,
        'Vestibulum sed magna at nunc commodo placerat.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        31,
        25,
        'Cras non velit nec nisi vulputate nonummy.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(54, 71, 'Quisque ut erat.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(30, 39, 'Nunc rhoncus dui vel sem.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        5,
        47,
        'Morbi quis tortor id nulla ultrices aliquet.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        34,
        41,
        'Aliquam sit amet diam in magna bibendum imperdiet.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(15, 73, 'Nam tristique tortor eu pede.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        44,
        43,
        'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        57,
        33,
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(31, 4, 'Vivamus tortor.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        56,
        15,
        'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(48, 45, 'Nulla tellus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(54, 67, 'Donec dapibus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(1, 40, 'Mauris sit amet eros.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        6,
        53,
        'Mauris ullamcorper purus sit amet nulla.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        27,
        19,
        'Sed vel enim sit amet nunc viverra dapibus.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(55, 24, 'Nulla tempus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(58, 32, 'Etiam pretium iaculis justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(39, 63, 'Morbi non lectus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        25,
        18,
        'Maecenas ut massa quis augue luctus tincidunt.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(47, 11, 'Duis bibendum.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(37, 73, 'In congue.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(23, 77, 'Suspendisse potenti.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(50, 67, 'Praesent blandit.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        26,
        8,
        'Quisque id justo sit amet sapien dignissim vestibulum.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(46, 60, 'Suspendisse potenti.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(1, 5, 'Maecenas tincidunt lacus at velit.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(33, 72, 'Etiam pretium iaculis justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(16, 11, 'Quisque ut erat.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        44,
        57,
        'Proin at turpis a pede posuere nonummy.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(51, 21, 'Donec vitae nisi.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        59,
        47,
        'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        34,
        73,
        'Donec quis orci eget orci vehicula condimentum.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        60,
        13,
        'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(45, 13, 'Etiam pretium iaculis justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(58, 35, 'Nulla suscipit ligula in lacus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(34, 44, 'Aenean auctor gravida sem.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        22,
        8,
        'Vestibulum sed magna at nunc commodo placerat.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(21, 16, 'Integer tincidunt ante vel ipsum.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(26, 39, 'Duis bibendum.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(7, 71, 'Pellentesque eget nunc.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(41, 67, 'Cras pellentesque volutpat dui.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(34, 78, 'Suspendisse potenti.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(47, 25, 'Aenean auctor gravida sem.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(11, 48, 'In quis justo.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        36,
        19,
        'Vivamus in felis eu sapien cursus vestibulum.',
        FALSE
    );
INSERT INTO UserArtist_Interactions
VALUES(44, 27, 'Fusce posuere felis sed lacus.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(
        14,
        28,
        'Sed vel enim sit amet nunc viverra dapibus.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(
        17,
        8,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',
        TRUE
    );
INSERT INTO UserArtist_Interactions
VALUES(32, 37, 'Pellentesque eget nunc.', TRUE);
INSERT INTO UserArtist_Interactions
VALUES(31, 54, 'Praesent lectus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(38, 52, 'Maecenas pulvinar lobortis est.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(39, 9, 'Fusce posuere felis sed lacus.', FALSE);
INSERT INTO UserArtist_Interactions
VALUES(
        4,
        36,
        'Aliquam sit amet diam in magna bibendum imperdiet.',
        FALSE
    );
-- Data for table User_Song
INSERT INTO User_Song
Values(34, 27, 84);
INSERT INTO User_Song
Values(15, 25, 53);
INSERT INTO User_Song
Values(52, 74, 17);
INSERT INTO User_Song
Values(23, 179, 83);
INSERT INTO User_Song
Values(57, 39, 74);
INSERT INTO User_Song
Values(51, 70, 78);
INSERT INTO User_Song
Values(38, 7, 4);
INSERT INTO User_Song
Values(34, 175, 85);
INSERT INTO User_Song
Values(58, 187, 67);
INSERT INTO User_Song
Values(43, 71, 33);
INSERT INTO User_Song
Values(29, 179, 45);
INSERT INTO User_Song
Values(5, 135, 70);
INSERT INTO User_Song
Values(28, 152, 8);
INSERT INTO User_Song
Values(5, 129, 34);
INSERT INTO User_Song
Values(45, 13, 67);
INSERT INTO User_Song
Values(33, 120, 3);
INSERT INTO User_Song
Values(58, 189, 98);
INSERT INTO User_Song
Values(13, 121, 26);
INSERT INTO User_Song
Values(17, 196, 78);
INSERT INTO User_Song
Values(33, 13, 81);
INSERT INTO User_Song
Values(41, 79, 62);
INSERT INTO User_Song
Values(50, 195, 21);
INSERT INTO User_Song
Values(7, 181, 52);
INSERT INTO User_Song
Values(16, 78, 44);
INSERT INTO User_Song
Values(14, 130, 15);
INSERT INTO User_Song
Values(11, 1, 78);
INSERT INTO User_Song
Values(24, 60, 37);
INSERT INTO User_Song
Values(7, 19, 81);
INSERT INTO User_Song
Values(57, 15, 10);
INSERT INTO User_Song
Values(59, 89, 48);
INSERT INTO User_Song
Values(1, 152, 54);
INSERT INTO User_Song
Values(43, 161, 52);
INSERT INTO User_Song
Values(50, 149, 98);
INSERT INTO User_Song
Values(25, 131, 14);
INSERT INTO User_Song
Values(41, 80, 16);
INSERT INTO User_Song
Values(30, 125, 86);
INSERT INTO User_Song
Values(36, 88, 13);
INSERT INTO User_Song
Values(38, 32, 16);
INSERT INTO User_Song
Values(42, 79, 100);
INSERT INTO User_Song
Values(50, 95, 39);
INSERT INTO User_Song
Values(32, 149, 59);
INSERT INTO User_Song
Values(49, 84, 3);
INSERT INTO User_Song
Values(58, 113, 60);
INSERT INTO User_Song
Values(3, 149, 97);
INSERT INTO User_Song
Values(60, 109, 51);
INSERT INTO User_Song
Values(45, 169, 69);
INSERT INTO User_Song
Values(9, 198, 85);
INSERT INTO User_Song
Values(34, 70, 88);
INSERT INTO User_Song
Values(32, 126, 53);
INSERT INTO User_Song
Values(12, 48, 96);
INSERT INTO User_Song
Values(45, 67, 75);
INSERT INTO User_Song
Values(1, 125, 34);
INSERT INTO User_Song
Values(51, 109, 81);
INSERT INTO User_Song
Values(14, 101, 59);
INSERT INTO User_Song
Values(13, 123, 34);
INSERT INTO User_Song
Values(15, 153, 30);
INSERT INTO User_Song
Values(11, 127, 23);
INSERT INTO User_Song
Values(57, 169, 41);
INSERT INTO User_Song
Values(38, 109, 3);
INSERT INTO User_Song
Values(39, 49, 23);
INSERT INTO User_Song
Values(50, 179, 86);
INSERT INTO User_Song
Values(4, 6, 78);
INSERT INTO User_Song
Values(40, 65, 37);
INSERT INTO User_Song
Values(54, 130, 24);
INSERT INTO User_Song
Values(8, 185, 61);
INSERT INTO User_Song
Values(23, 20, 12);
INSERT INTO User_Song
Values(6, 14, 32);
INSERT INTO User_Song
Values(23, 33, 63);
INSERT INTO User_Song
Values(56, 94, 86);
INSERT INTO User_Song
Values(44, 90, 3);
INSERT INTO User_Song
Values(48, 182, 56);
INSERT INTO User_Song
Values(9, 82, 76);
INSERT INTO User_Song
Values(60, 171, 59);
INSERT INTO User_Song
Values(10, 179, 31);
INSERT INTO User_Song
Values(33, 32, 82);
INSERT INTO User_Song
Values(13, 98, 15);
INSERT INTO User_Song
Values(25, 135, 15);
INSERT INTO User_Song
Values(51, 174, 27);
INSERT INTO User_Song
Values(32, 197, 11);
INSERT INTO User_Song
Values(47, 195, 44);
INSERT INTO User_Song
Values(59, 110, 10);
INSERT INTO User_Song
Values(43, 155, 16);
INSERT INTO User_Song
Values(1, 143, 10);
INSERT INTO User_Song
Values(42, 138, 31);
INSERT INTO User_Song
Values(11, 37, 50);
INSERT INTO User_Song
Values(6, 167, 84);
INSERT INTO User_Song
Values(59, 31, 22);
INSERT INTO User_Song
Values(53, 127, 99);
INSERT INTO User_Song
Values(1, 154, 86);
INSERT INTO User_Song
Values(54, 124, 97);
INSERT INTO User_Song
Values(60, 121, 98);
INSERT INTO User_Song
Values(9, 17, 3);
INSERT INTO User_Song
Values(14, 73, 61);
INSERT INTO User_Song
Values(5, 67, 37);
INSERT INTO User_Song
Values(30, 56, 77);
INSERT INTO User_Song
Values(13, 152, 95);
INSERT INTO User_Song
Values(13, 114, 70);
INSERT INTO User_Song
Values(20, 21, 44);
INSERT INTO User_Song
Values(19, 157, 56);
INSERT INTO User_Song
Values(28, 107, 37);
INSERT INTO User_Song
Values(26, 89, 57);
INSERT INTO User_Song
Values(51, 185, 26);
INSERT INTO User_Song
Values(17, 108, 3);
INSERT INTO User_Song
Values(49, 74, 62);
INSERT INTO User_Song
Values(33, 124, 78);
INSERT INTO User_Song
Values(30, 53, 75);
INSERT INTO User_Song
Values(47, 50, 67);
INSERT INTO User_Song
Values(14, 110, 28);
INSERT INTO User_Song
Values(56, 6, 32);
INSERT INTO User_Song
Values(39, 45, 70);
INSERT INTO User_Song
Values(60, 19, 68);
INSERT INTO User_Song
Values(40, 132, 21);
INSERT INTO User_Song
Values(5, 73, 74);
INSERT INTO User_Song
Values(18, 102, 52);
INSERT INTO User_Song
Values(24, 107, 55);
INSERT INTO User_Song
Values(43, 130, 37);
INSERT INTO User_Song
Values(56, 73, 94);
INSERT INTO User_Song
Values(45, 149, 94);
INSERT INTO User_Song
Values(44, 40, 60);
INSERT INTO User_Song
Values(3, 150, 100);
INSERT INTO User_Song
Values(30, 58, 64);
INSERT INTO User_Song
Values(34, 26, 86);
INSERT INTO User_Song
Values(11, 34, 17);
INSERT INTO User_Song
Values(31, 78, 5);
INSERT INTO User_Song
Values(5, 141, 19);
INSERT INTO User_Song
Values(3, 17, 58);
INSERT INTO User_Song
Values(53, 170, 85);
INSERT INTO User_Song
Values(5, 106, 50);
INSERT INTO User_Song
Values(10, 71, 49);
INSERT INTO User_Song
Values(2, 85, 2);
INSERT INTO User_Song
Values(18, 177, 30);
INSERT INTO User_Song
Values(41, 124, 48);
INSERT INTO User_Song
Values(36, 48, 15);
INSERT INTO User_Song
Values(51, 106, 65);
INSERT INTO User_Song
Values(48, 71, 28);
INSERT INTO User_Song
Values(19, 87, 74);
INSERT INTO User_Song
Values(25, 166, 21);
INSERT INTO User_Song
Values(3, 117, 13);
INSERT INTO User_Song
Values(27, 98, 26);
INSERT INTO User_Song
Values(17, 180, 14);
INSERT INTO User_Song
Values(2, 113, 17);
INSERT INTO User_Song
Values(12, 134, 10);
INSERT INTO User_Song
Values(7, 2, 37);
INSERT INTO User_Song
Values(19, 79, 90);
INSERT INTO User_Song
Values(12, 172, 99);
INSERT INTO User_Song
Values(51, 54, 73);
INSERT INTO User_Song
Values(14, 117, 37);
INSERT INTO User_Song
Values(21, 120, 75);
INSERT INTO User_Song
Values(60, 9, 61);
INSERT INTO User_Song
Values(7, 124, 17);
INSERT INTO User_Song
Values(59, 169, 1);
INSERT INTO User_Song
Values(37, 153, 79);
INSERT INTO User_Song
Values(50, 35, 62);
INSERT INTO User_Song
Values(31, 18, 38);
INSERT INTO User_Song
Values(5, 143, 83);
INSERT INTO User_Song
Values(23, 60, 8);
INSERT INTO User_Song
Values(37, 50, 4);
INSERT INTO User_Song
Values(15, 136, 5);
INSERT INTO User_Song
Values(1, 140, 81);
INSERT INTO User_Song
Values(43, 110, 5);
INSERT INTO User_Song
Values(7, 74, 12);
INSERT INTO User_Song
Values(18, 72, 83);
INSERT INTO User_Song
Values(42, 6, 78);
INSERT INTO User_Song
Values(54, 97, 100);
INSERT INTO User_Song
Values(29, 74, 54);
INSERT INTO User_Song
Values(32, 119, 51);
INSERT INTO User_Song
Values(38, 30, 61);
INSERT INTO User_Song
Values(2, 98, 10);
INSERT INTO User_Song
Values(44, 4, 87);
INSERT INTO User_Song
Values(40, 196, 42);
INSERT INTO User_Song
Values(3, 46, 71);
INSERT INTO User_Song
Values(18, 7, 80);
INSERT INTO User_Song
Values(25, 99, 18);
INSERT INTO User_Song
Values(16, 58, 3);
INSERT INTO User_Song
Values(39, 80, 38);
INSERT INTO User_Song
Values(58, 16, 97);
INSERT INTO User_Song
Values(47, 11, 83);
INSERT INTO User_Song
Values(30, 176, 11);
INSERT INTO User_Song
Values(4, 191, 75);
INSERT INTO User_Song
Values(44, 12, 78);
INSERT INTO User_Song
Values(29, 103, 15);
INSERT INTO User_Song
Values(44, 39, 58);
INSERT INTO User_Song
Values(40, 160, 9);
INSERT INTO User_Song
Values(53, 119, 44);
INSERT INTO User_Song
Values(26, 3, 57);
INSERT INTO User_Song
Values(19, 67, 59);
INSERT INTO User_Song
Values(20, 25, 28);
INSERT INTO User_Song
Values(53, 39, 17);
INSERT INTO User_Song
Values(6, 166, 1);
INSERT INTO User_Song
Values(14, 131, 21);
INSERT INTO User_Song
Values(32, 67, 29);
INSERT INTO User_Song
Values(24, 149, 86);
INSERT INTO User_Song
Values(40, 122, 58);
INSERT INTO User_Song
Values(46, 152, 89);
INSERT INTO User_Song
Values(35, 88, 60);
INSERT INTO User_Song
Values(39, 44, 82);
INSERT INTO User_Song
Values(58, 73, 38);
INSERT INTO User_Song
Values(37, 107, 45);
INSERT INTO User_Song
Values(50, 19, 54);
INSERT INTO User_Song
Values(10, 72, 71);
-- Data for table Curator_Playlist
INSERT INTO Curator_Playlist
VALUES(9, 1);
INSERT INTO Curator_Playlist
VALUES(15, 2);
INSERT INTO Curator_Playlist
VALUES(38, 3);
INSERT INTO Curator_Playlist
VALUES(20, 4);
INSERT INTO Curator_Playlist
VALUES(20, 5);
INSERT INTO Curator_Playlist
VALUES(6, 6);
INSERT INTO Curator_Playlist
VALUES(11, 7);
INSERT INTO Curator_Playlist
VALUES(24, 8);
INSERT INTO Curator_Playlist
VALUES(49, 9);
INSERT INTO Curator_Playlist
VALUES(1, 10);
INSERT INTO Curator_Playlist
VALUES(7, 11);
INSERT INTO Curator_Playlist
VALUES(44, 12);
INSERT INTO Curator_Playlist
VALUES(9, 13);
INSERT INTO Curator_Playlist
VALUES(39, 14);
INSERT INTO Curator_Playlist
VALUES(21, 15);
INSERT INTO Curator_Playlist
VALUES(23, 16);
INSERT INTO Curator_Playlist
VALUES(18, 17);
INSERT INTO Curator_Playlist
VALUES(55, 18);
INSERT INTO Curator_Playlist
VALUES(47, 19);
INSERT INTO Curator_Playlist
VALUES(59, 20);
INSERT INTO Curator_Playlist
VALUES(32, 21);
INSERT INTO Curator_Playlist
VALUES(57, 22);
INSERT INTO Curator_Playlist
VALUES(19, 23);
INSERT INTO Curator_Playlist
VALUES(46, 24);
INSERT INTO Curator_Playlist
VALUES(27, 25);
INSERT INTO Curator_Playlist
VALUES(31, 26);
INSERT INTO Curator_Playlist
VALUES(18, 27);
INSERT INTO Curator_Playlist
VALUES(43, 28);
INSERT INTO Curator_Playlist
VALUES(2, 29);
INSERT INTO Curator_Playlist
VALUES(38, 30);
INSERT INTO Curator_Playlist
VALUES(51, 31);
INSERT INTO Curator_Playlist
VALUES(36, 32);
INSERT INTO Curator_Playlist
VALUES(11, 33);
INSERT INTO Curator_Playlist
VALUES(25, 34);
INSERT INTO Curator_Playlist
VALUES(55, 35);
INSERT INTO Curator_Playlist
VALUES(55, 36);
INSERT INTO Curator_Playlist
VALUES(34, 37);
INSERT INTO Curator_Playlist
VALUES(20, 38);
INSERT INTO Curator_Playlist
VALUES(26, 39);
INSERT INTO Curator_Playlist
VALUES(27, 40);
INSERT INTO Curator_Playlist
VALUES(44, 41);
INSERT INTO Curator_Playlist
VALUES(12, 42);
INSERT INTO Curator_Playlist
VALUES(3, 43);
INSERT INTO Curator_Playlist
VALUES(31, 44);
INSERT INTO Curator_Playlist
VALUES(29, 45);
INSERT INTO Curator_Playlist
VALUES(29, 46);
INSERT INTO Curator_Playlist
VALUES(12, 47);
INSERT INTO Curator_Playlist
VALUES(6, 48);
INSERT INTO Curator_Playlist
VALUES(43, 49);
INSERT INTO Curator_Playlist
VALUES(8, 50);
INSERT INTO Curator_Playlist
VALUES(41, 51);
INSERT INTO Curator_Playlist
VALUES(52, 52);
INSERT INTO Curator_Playlist
VALUES(55, 53);
INSERT INTO Curator_Playlist
VALUES(16, 54);
INSERT INTO Curator_Playlist
VALUES(30, 55);
INSERT INTO Curator_Playlist
VALUES(52, 56);
INSERT INTO Curator_Playlist
VALUES(26, 57);
INSERT INTO Curator_Playlist
VALUES(6, 58);
INSERT INTO Curator_Playlist
VALUES(48, 59);
INSERT INTO Curator_Playlist
VALUES(22, 60);
-- Data for table Curator_Post
INSERT INTO Curator_Post
VALUES (1, '2023-07-15', 3, 'In sagittis dui vel nisl.');
INSERT INTO Curator_Post
VALUES (2, '2023-08-30', 57, 'In blandit ultrices enim.');
INSERT INTO Curator_Post
VALUES (
        3,
        '2024-01-15',
        27,
        'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.'
    );
INSERT INTO Curator_Post
VALUES (4, '2023-09-30', 18, 'Vivamus tortor.');
INSERT INTO Curator_Post
VALUES (
        5,
        '2023-12-15',
        52,
        'Etiam faucibus cursus urna.'
    );
INSERT INTO Curator_Post
VALUES (
        6,
        '2023-11-09',
        52,
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.'
    );
INSERT INTO Curator_Post
VALUES (
        7,
        '2023-08-24',
        55,
        'Praesent blandit lacinia erat.'
    );
INSERT INTO Curator_Post
VALUES (
        8,
        '2023-11-06',
        41,
        'Etiam pretium iaculis justo.'
    );
INSERT INTO Curator_Post
VALUES (
        9,
        '2024-01-29',
        22,
        'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.'
    );
INSERT INTO Curator_Post
VALUES (10, '2023-05-01', 49, 'In congue.');
INSERT INTO Curator_Post
VALUES (11, '2023-06-26', 29, 'Nunc purus.');
INSERT INTO Curator_Post
VALUES (12, '2023-10-30', 58, 'Phasellus sit amet erat.');
INSERT INTO Curator_Post
VALUES (
        13,
        '2023-09-03',
        29,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    );
INSERT INTO Curator_Post
VALUES (
        14,
        '2023-04-27',
        18,
        'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.'
    );
INSERT INTO Curator_Post
VALUES (
        15,
        '2023-10-01',
        1,
        'Morbi quis tortor id nulla ultrices aliquet.'
    );
INSERT INTO Curator_Post
VALUES (16, '2023-10-03', 15, 'Suspendisse potenti.');
INSERT INTO Curator_Post
VALUES (
        17,
        '2023-12-10',
        35,
        'Nulla suscipit ligula in lacus.'
    );
INSERT INTO Curator_Post
VALUES (
        18,
        '2024-02-24',
        41,
        'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.'
    );
INSERT INTO Curator_Post
VALUES (19, '2024-03-05', 44, 'Morbi ut odio.');
INSERT INTO Curator_Post
VALUES (20, '2024-01-05', 9, 'Phasellus sit amet erat.');
INSERT INTO Curator_Post
VALUES (21, '2023-10-24', 40, 'Nullam varius.');
INSERT INTO Curator_Post
VALUES (
        22,
        '2023-05-21',
        24,
        'Praesent blandit lacinia erat.'
    );
INSERT INTO Curator_Post
VALUES (
        23,
        '2023-08-30',
        45,
        'In hac habitasse platea dictumst.'
    );
INSERT INTO Curator_Post
VALUES (
        24,
        '2024-01-13',
        3,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.'
    );
INSERT INTO Curator_Post
VALUES (
        25,
        '2023-10-03',
        32,
        'Vestibulum rutrum rutrum neque.'
    );
INSERT INTO Curator_Post
VALUES (26, '2023-11-11', 20, 'Ut tellus.');
INSERT INTO Curator_Post
VALUES (
        27,
        '2023-11-25',
        50,
        'Cras pellentesque volutpat dui.'
    );
INSERT INTO Curator_Post
VALUES (28, '2024-01-19', 49, 'Phasellus in felis.');
INSERT INTO Curator_Post
VALUES (
        29,
        '2023-08-23',
        41,
        'Mauris lacinia sapien quis libero.'
    );
INSERT INTO Curator_Post
VALUES (
        30,
        '2023-11-15',
        20,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.'
    );
INSERT INTO Curator_Post
VALUES (
        31,
        '2023-04-28',
        48,
        'In hac habitasse platea dictumst.'
    );
INSERT INTO Curator_Post
VALUES (32, '2023-05-15', 28, 'Proin risus.');
INSERT INTO Curator_Post
VALUES (33, '2023-05-09', 17, 'Mauris sit amet eros.');
INSERT INTO Curator_Post
VALUES (34, '2023-12-09', 22, 'Donec vitae nisi.');
INSERT INTO Curator_Post
VALUES (35, '2023-06-16', 58, 'Praesent lectus.');
INSERT INTO Curator_Post
VALUES (
        36,
        '2023-11-22',
        15,
        'Quisque porta volutpat erat.'
    );
INSERT INTO Curator_Post
VALUES (37, '2023-12-13', 7, 'Praesent blandit.');
INSERT INTO Curator_Post
VALUES (
        38,
        '2023-11-12',
        30,
        'Nulla ut erat id mauris vulputate elementum.'
    );
INSERT INTO Curator_Post
VALUES (
        39,
        '2024-04-07',
        16,
        'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.'
    );
INSERT INTO Curator_Post
VALUES (
        40,
        '2024-02-26',
        8,
        'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.'
    );
INSERT INTO Curator_Post
VALUES (41, '2024-01-30', 53, 'Nulla ac enim.');
INSERT INTO Curator_Post
VALUES (42, '2023-04-23', 45, 'Aliquam erat volutpat.');
INSERT INTO Curator_Post
VALUES (43, '2023-08-26', 19, 'Integer ac neque.');
INSERT INTO Curator_Post
VALUES (
        44,
        '2023-04-27',
        58,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.'
    );
INSERT INTO Curator_Post
VALUES (
        45,
        '2024-01-30',
        2,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    );
INSERT INTO Curator_Post
VALUES (
        46,
        '2024-01-12',
        11,
        'Morbi porttitor lorem id ligula.'
    );
INSERT INTO Curator_Post
VALUES (47, '2023-09-26', 1, 'Ut tellus.');
INSERT INTO Curator_Post
VALUES (48, '2023-09-03', 5, 'Duis ac nibh.');
INSERT INTO Curator_Post
VALUES (
        49,
        '2023-08-12',
        39,
        'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.'
    );
INSERT INTO Curator_Post
VALUES (50, '2023-06-17', 13, 'Nulla justo.');
INSERT INTO Curator_Post
VALUES (51, '2023-09-05', 3, 'Suspendisse potenti.');
INSERT INTO Curator_Post
VALUES (52, '2023-05-23', 17, 'Nunc purus.');
INSERT INTO Curator_Post
VALUES (53, '2023-06-25', 47, 'Integer ac leo.');
INSERT INTO Curator_Post
VALUES (
        54,
        '2023-06-24',
        37,
        'Curabitur in libero ut massa volutpat convallis.'
    );
INSERT INTO Curator_Post
VALUES (
        55,
        '2024-03-31',
        16,
        'Etiam faucibus cursus urna.'
    );
INSERT INTO Curator_Post
VALUES (
        56,
        '2024-02-10',
        48,
        'Donec ut mauris eget massa tempor convallis.'
    );
INSERT INTO Curator_Post
VALUES (
        57,
        '2023-10-12',
        26,
        'Nullam sit amet turpis elementum ligula vehicula consequat.'
    );
INSERT INTO Curator_Post
VALUES (58, '2023-04-25', 12, 'Aenean fermentum.');
INSERT INTO Curator_Post
VALUES (
        59,
        '2024-04-03',
        8,
        'Maecenas tincidunt lacus at velit.'
    );
INSERT INTO Curator_Post
VALUES (60, '2023-08-10', 23, 'Morbi a ipsum.');
INSERT INTO Curator_Post
VALUES (
        61,
        '2024-02-15',
        39,
        'Nullam sit amet turpis elementum ligula vehicula consequat.'
    );
INSERT INTO Curator_Post
VALUES (
        62,
        '2023-11-02',
        6,
        'Nulla ut erat id mauris vulputate elementum.'
    );
INSERT INTO Curator_Post
VALUES (63, '2024-03-05', 56, 'Nulla nisl.');
INSERT INTO Curator_Post
VALUES (64, '2024-03-15', 42, 'Donec vitae nisi.');
INSERT INTO Curator_Post
VALUES (
        65,
        '2023-12-13',
        18,
        'Proin at turpis a pede posuere nonummy.'
    );
INSERT INTO Curator_Post
VALUES (
        66,
        '2024-01-12',
        47,
        'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.'
    );
INSERT INTO Curator_Post
VALUES (
        67,
        '2023-12-16',
        55,
        'Vivamus vel nulla eget eros elementum pellentesque.'
    );
INSERT INTO Curator_Post
VALUES (
        68,
        '2023-06-15',
        37,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.'
    );
INSERT INTO Curator_Post
VALUES (
        69,
        '2024-04-11',
        24,
        'Quisque porta volutpat erat.'
    );
INSERT INTO Curator_Post
VALUES (70, '2023-07-01', 60, 'Phasellus sit amet erat.');
INSERT INTO Curator_Post
VALUES (
        71,
        '2023-06-15',
        41,
        'Vivamus vel nulla eget eros elementum pellentesque.'
    );
INSERT INTO Curator_Post
VALUES (
        72,
        '2024-04-09',
        20,
        'Suspendisse accumsan tortor quis turpis.'
    );
INSERT INTO Curator_Post
VALUES (
        73,
        '2023-12-31',
        56,
        'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.'
    );
INSERT INTO Curator_Post
VALUES (
        74,
        '2024-03-26',
        11,
        'Curabitur gravida nisi at nibh.'
    );
INSERT INTO Curator_Post
VALUES (75, '2023-09-24', 20, 'Pellentesque at nulla.');
INSERT INTO Curator_Post
VALUES (76, '2023-06-10', 20, 'Nulla facilisi.');
INSERT INTO Curator_Post
VALUES (77, '2023-06-08', 28, 'Sed ante.');
INSERT INTO Curator_Post
VALUES (78, '2024-01-13', 5, 'Nullam varius.');
INSERT INTO Curator_Post
VALUES (
        79,
        '2023-12-28',
        30,
        'Pellentesque viverra pede ac diam.'
    );
INSERT INTO Curator_Post
VALUES (
        80,
        '2023-07-16',
        18,
        'In hac habitasse platea dictumst.'
    );
-- Data for Playlist_Song
INSERT INTO Playlist_Songs
VALUES(21, 86);
INSERT INTO Playlist_Songs
VALUES(41, 38);
INSERT INTO Playlist_Songs
VALUES(3, 193);
INSERT INTO Playlist_Songs
VALUES(21, 110);
INSERT INTO Playlist_Songs
VALUES(29, 89);
INSERT INTO Playlist_Songs
VALUES(2, 160);
INSERT INTO Playlist_Songs
VALUES(19, 174);
INSERT INTO Playlist_Songs
VALUES(50, 45);
INSERT INTO Playlist_Songs
VALUES(2, 58);
INSERT INTO Playlist_Songs
VALUES(51, 154);
INSERT INTO Playlist_Songs
VALUES(6, 153);
INSERT INTO Playlist_Songs
VALUES(25, 53);
INSERT INTO Playlist_Songs
VALUES(26, 35);
INSERT INTO Playlist_Songs
VALUES(48, 72);
INSERT INTO Playlist_Songs
VALUES(17, 200);
INSERT INTO Playlist_Songs
VALUES(57, 16);
INSERT INTO Playlist_Songs
VALUES(9, 67);
INSERT INTO Playlist_Songs
VALUES(40, 38);
INSERT INTO Playlist_Songs
VALUES(55, 26);
INSERT INTO Playlist_Songs
VALUES(7, 153);
INSERT INTO Playlist_Songs
VALUES(55, 114);
INSERT INTO Playlist_Songs
VALUES(11, 185);
INSERT INTO Playlist_Songs
VALUES(50, 42);
INSERT INTO Playlist_Songs
VALUES(13, 112);
INSERT INTO Playlist_Songs
VALUES(46, 186);
INSERT INTO Playlist_Songs
VALUES(52, 84);
INSERT INTO Playlist_Songs
VALUES(7, 161);
INSERT INTO Playlist_Songs
VALUES(58, 127);
INSERT INTO Playlist_Songs
VALUES(15, 61);
INSERT INTO Playlist_Songs
VALUES(48, 83);
INSERT INTO Playlist_Songs
VALUES(58, 114);
INSERT INTO Playlist_Songs
VALUES(43, 83);
INSERT INTO Playlist_Songs
VALUES(23, 99);
INSERT INTO Playlist_Songs
VALUES(3, 144);
INSERT INTO Playlist_Songs
VALUES(30, 170);
INSERT INTO Playlist_Songs
VALUES(7, 139);
INSERT INTO Playlist_Songs
VALUES(13, 98);
INSERT INTO Playlist_Songs
VALUES(33, 96);
INSERT INTO Playlist_Songs
VALUES(35, 153);
INSERT INTO Playlist_Songs
VALUES(17, 192);
INSERT INTO Playlist_Songs
VALUES(50, 168);
INSERT INTO Playlist_Songs
VALUES(39, 93);
INSERT INTO Playlist_Songs
VALUES(8, 198);
INSERT INTO Playlist_Songs
VALUES(37, 12);
INSERT INTO Playlist_Songs
VALUES(29, 135);
INSERT INTO Playlist_Songs
VALUES(58, 52);
INSERT INTO Playlist_Songs
VALUES(49, 179);
INSERT INTO Playlist_Songs
VALUES(4, 163);
INSERT INTO Playlist_Songs
VALUES(21, 37);
INSERT INTO Playlist_Songs
VALUES(46, 144);
INSERT INTO Playlist_Songs
VALUES(32, 115);
INSERT INTO Playlist_Songs
VALUES(26, 174);
INSERT INTO Playlist_Songs
VALUES(51, 149);
INSERT INTO Playlist_Songs
VALUES(28, 51);
INSERT INTO Playlist_Songs
VALUES(37, 99);
INSERT INTO Playlist_Songs
VALUES(22, 23);
INSERT INTO Playlist_Songs
VALUES(40, 155);
INSERT INTO Playlist_Songs
VALUES(11, 96);
INSERT INTO Playlist_Songs
VALUES(59, 199);
INSERT INTO Playlist_Songs
VALUES(57, 52);
INSERT INTO Playlist_Songs
VALUES(8, 95);
INSERT INTO Playlist_Songs
VALUES(39, 139);
INSERT INTO Playlist_Songs
VALUES(42, 173);
INSERT INTO Playlist_Songs
VALUES(2, 118);
INSERT INTO Playlist_Songs
VALUES(7, 113);
INSERT INTO Playlist_Songs
VALUES(53, 53);
INSERT INTO Playlist_Songs
VALUES(55, 84);
INSERT INTO Playlist_Songs
VALUES(57, 199);
INSERT INTO Playlist_Songs
VALUES(3, 121);
INSERT INTO Playlist_Songs
VALUES(18, 195);
INSERT INTO Playlist_Songs
VALUES(7, 32);
INSERT INTO Playlist_Songs
VALUES(50, 150);
INSERT INTO Playlist_Songs
VALUES(5, 5);
INSERT INTO Playlist_Songs
VALUES(19, 127);
INSERT INTO Playlist_Songs
VALUES(54, 55);
INSERT INTO Playlist_Songs
VALUES(33, 12);
INSERT INTO Playlist_Songs
VALUES(27, 143);
INSERT INTO Playlist_Songs
VALUES(2, 131);
INSERT INTO Playlist_Songs
VALUES(42, 40);
INSERT INTO Playlist_Songs
VALUES(4, 30);
INSERT INTO Playlist_Songs
VALUES(30, 52);
INSERT INTO Playlist_Songs
VALUES(24, 169);
INSERT INTO Playlist_Songs
VALUES(47, 7);
INSERT INTO Playlist_Songs
VALUES(21, 143);
INSERT INTO Playlist_Songs
VALUES(39, 119);
INSERT INTO Playlist_Songs
VALUES(27, 58);
INSERT INTO Playlist_Songs
VALUES(38, 68);
INSERT INTO Playlist_Songs
VALUES(13, 188);
INSERT INTO Playlist_Songs
VALUES(56, 129);
INSERT INTO Playlist_Songs
VALUES(43, 189);
INSERT INTO Playlist_Songs
VALUES(52, 83);
INSERT INTO Playlist_Songs
VALUES(55, 123);
INSERT INTO Playlist_Songs
VALUES(41, 62);
INSERT INTO Playlist_Songs
VALUES(34, 153);
INSERT INTO Playlist_Songs
VALUES(39, 186);
INSERT INTO Playlist_Songs
VALUES(23, 137);
INSERT INTO Playlist_Songs
VALUES(34, 28);
INSERT INTO Playlist_Songs
VALUES(13, 130);
INSERT INTO Playlist_Songs
VALUES(20, 56);
INSERT INTO Playlist_Songs
VALUES(15, 189);
INSERT INTO Playlist_Songs
VALUES(45, 161);
INSERT INTO Playlist_Songs
VALUES(29, 191);
INSERT INTO Playlist_Songs
VALUES(20, 169);
INSERT INTO Playlist_Songs
VALUES(3, 166);
INSERT INTO Playlist_Songs
VALUES(18, 96);
INSERT INTO Playlist_Songs
VALUES(57, 92);
INSERT INTO Playlist_Songs
VALUES(7, 171);
INSERT INTO Playlist_Songs
VALUES(52, 60);
INSERT INTO Playlist_Songs
VALUES(27, 65);
INSERT INTO Playlist_Songs
VALUES(52, 67);
INSERT INTO Playlist_Songs
VALUES(5, 127);
INSERT INTO Playlist_Songs
VALUES(48, 131);
INSERT INTO Playlist_Songs
VALUES(33, 76);
INSERT INTO Playlist_Songs
VALUES(29, 17);
INSERT INTO Playlist_Songs
VALUES(5, 66);
INSERT INTO Playlist_Songs
VALUES(47, 81);
INSERT INTO Playlist_Songs
VALUES(2, 63);
INSERT INTO Playlist_Songs
VALUES(45, 137);
INSERT INTO Playlist_Songs
VALUES(27, 22);
INSERT INTO Playlist_Songs
VALUES(44, 41);
INSERT INTO Playlist_Songs
VALUES(33, 27);
INSERT INTO Playlist_Songs
VALUES(11, 137);
INSERT INTO Playlist_Songs
VALUES(14, 106);
INSERT INTO Playlist_Songs
VALUES(28, 26);
INSERT INTO Playlist_Songs
VALUES(14, 177);
INSERT INTO Playlist_Songs
VALUES(20, 11);
INSERT INTO Playlist_Songs
VALUES(43, 99);
INSERT INTO Playlist_Songs
VALUES(22, 136);
INSERT INTO Playlist_Songs
VALUES(17, 124);
INSERT INTO Playlist_Songs
VALUES(55, 87);
INSERT INTO Playlist_Songs
VALUES(2, 94);
INSERT INTO Playlist_Songs
VALUES(16, 110);
INSERT INTO Playlist_Songs
VALUES(25, 19);
INSERT INTO Playlist_Songs
VALUES(10, 186);
INSERT INTO Playlist_Songs
VALUES(9, 136);
INSERT INTO Playlist_Songs
VALUES(12, 44);
INSERT INTO Playlist_Songs
VALUES(10, 48);
INSERT INTO Playlist_Songs
VALUES(7, 114);
INSERT INTO Playlist_Songs
VALUES(25, 47);
INSERT INTO Playlist_Songs
VALUES(23, 166);
INSERT INTO Playlist_Songs
VALUES(35, 137);
INSERT INTO Playlist_Songs
VALUES(58, 2);
INSERT INTO Playlist_Songs
VALUES(20, 159);
INSERT INTO Playlist_Songs
VALUES(27, 73);
INSERT INTO Playlist_Songs
VALUES(25, 58);
INSERT INTO Playlist_Songs
VALUES(31, 31);
INSERT INTO Playlist_Songs
VALUES(58, 54);
INSERT INTO Playlist_Songs
VALUES(8, 84);
INSERT INTO Playlist_Songs
VALUES(1, 64);
INSERT INTO Playlist_Songs
VALUES(27, 113);
INSERT INTO Playlist_Songs
VALUES(26, 140);
INSERT INTO Playlist_Songs
VALUES(25, 177);
INSERT INTO Playlist_Songs
VALUES(28, 200);
INSERT INTO Playlist_Songs
VALUES(42, 180);
INSERT INTO Playlist_Songs
VALUES(10, 60);
INSERT INTO Playlist_Songs
VALUES(53, 68);
INSERT INTO Playlist_Songs
VALUES(27, 164);
INSERT INTO Playlist_Songs
VALUES(22, 76);
INSERT INTO Playlist_Songs
VALUES(13, 104);
INSERT INTO Playlist_Songs
VALUES(40, 7);
INSERT INTO Playlist_Songs
VALUES(53, 17);
INSERT INTO Playlist_Songs
VALUES(10, 155);
INSERT INTO Playlist_Songs
VALUES(50, 146);
INSERT INTO Playlist_Songs
VALUES(15, 80);
INSERT INTO Playlist_Songs
VALUES(1, 65);
INSERT INTO Playlist_Songs
VALUES(33, 145);
INSERT INTO Playlist_Songs
VALUES(19, 26);
INSERT INTO Playlist_Songs
VALUES(54, 54);
INSERT INTO Playlist_Songs
VALUES(53, 27);
INSERT INTO Playlist_Songs
VALUES(56, 149);
INSERT INTO Playlist_Songs
VALUES(14, 148);
INSERT INTO Playlist_Songs
VALUES(12, 26);
INSERT INTO Playlist_Songs
VALUES(11, 184);
INSERT INTO Playlist_Songs
VALUES(36, 120);
INSERT INTO Playlist_Songs
VALUES(57, 169);
INSERT INTO Playlist_Songs
VALUES(13, 44);
INSERT INTO Playlist_Songs
VALUES(6, 121);
INSERT INTO Playlist_Songs
VALUES(50, 9);
INSERT INTO Playlist_Songs
VALUES(19, 198);
INSERT INTO Playlist_Songs
VALUES(21, 127);
INSERT INTO Playlist_Songs
VALUES(46, 138);
INSERT INTO Playlist_Songs
VALUES(29, 76);
INSERT INTO Playlist_Songs
VALUES(19, 180);
INSERT INTO Playlist_Songs
VALUES(59, 36);
INSERT INTO Playlist_Songs
VALUES(19, 158);
INSERT INTO Playlist_Songs
VALUES(21, 162);
INSERT INTO Playlist_Songs
VALUES(7, 131);
INSERT INTO Playlist_Songs
VALUES(28, 66);
INSERT INTO Playlist_Songs
VALUES(39, 81);
INSERT INTO Playlist_Songs
VALUES(14, 172);
INSERT INTO Playlist_Songs
VALUES(55, 149);
INSERT INTO Playlist_Songs
VALUES(59, 11);
INSERT INTO Playlist_Songs
VALUES(28, 127);
INSERT INTO Playlist_Songs
VALUES(38, 50);
INSERT INTO Playlist_Songs
VALUES(20, 181);
INSERT INTO Playlist_Songs
VALUES(47, 63);
INSERT INTO Playlist_Songs
VALUES(19, 126);
INSERT INTO Playlist_Songs
VALUES(26, 143);
INSERT INTO Playlist_Songs
VALUES(2, 128);
INSERT INTO Playlist_Songs
VALUES(1, 193);
-- Data for table User_Downloads
INSERT INTO User_Downloads
VALUES(7, 29);
INSERT INTO User_Downloads
VALUES(50, 44);
INSERT INTO User_Downloads
VALUES(43, 54);
INSERT INTO User_Downloads
VALUES(48, 48);
INSERT INTO User_Downloads
VALUES(4, 15);
INSERT INTO User_Downloads
VALUES(59, 56);
INSERT INTO User_Downloads
VALUES(13, 47);
INSERT INTO User_Downloads
VALUES(57, 38);
INSERT INTO User_Downloads
VALUES(1, 21);
INSERT INTO User_Downloads
VALUES(44, 12);
INSERT INTO User_Downloads
VALUES(34, 20);
INSERT INTO User_Downloads
VALUES(38, 50);
INSERT INTO User_Downloads
VALUES(30, 56);
INSERT INTO User_Downloads
VALUES(53, 45);
INSERT INTO User_Downloads
VALUES(36, 56);
INSERT INTO User_Downloads
VALUES(41, 56);
INSERT INTO User_Downloads
VALUES(15, 42);
INSERT INTO User_Downloads
VALUES(22, 49);
INSERT INTO User_Downloads
VALUES(53, 31);
INSERT INTO User_Downloads
VALUES(9, 16);
INSERT INTO User_Downloads
VALUES(14, 13);
INSERT INTO User_Downloads
VALUES(8, 44);
INSERT INTO User_Downloads
VALUES(13, 43);
INSERT INTO User_Downloads
VALUES(45, 32);
INSERT INTO User_Downloads
VALUES(54, 32);
INSERT INTO User_Downloads
VALUES(56, 56);
INSERT INTO User_Downloads
VALUES(1, 8);
INSERT INTO User_Downloads
VALUES(39, 8);
INSERT INTO User_Downloads
VALUES(3, 27);
INSERT INTO User_Downloads
VALUES(34, 17);
INSERT INTO User_Downloads
VALUES(44, 1);
INSERT INTO User_Downloads
VALUES(58, 51);
INSERT INTO User_Downloads
VALUES(51, 15);
INSERT INTO User_Downloads
VALUES(56, 32);
INSERT INTO User_Downloads
VALUES(17, 48);
INSERT INTO User_Downloads
VALUES(35, 13);
INSERT INTO User_Downloads
VALUES(40, 22);
INSERT INTO User_Downloads
VALUES(46, 23);
INSERT INTO User_Downloads
VALUES(16, 3);
INSERT INTO User_Downloads
VALUES(31, 29);
INSERT INTO User_Downloads
VALUES(48, 8);
INSERT INTO User_Downloads
VALUES(39, 13);
INSERT INTO User_Downloads
VALUES(29, 48);
INSERT INTO User_Downloads
VALUES(11, 21);
INSERT INTO User_Downloads
VALUES(9, 53);
INSERT INTO User_Downloads
VALUES(46, 53);
INSERT INTO User_Downloads
VALUES(55, 38);
INSERT INTO User_Downloads
VALUES(58, 55);
INSERT INTO User_Downloads
VALUES(55, 54);
INSERT INTO User_Downloads
VALUES(58, 21);
INSERT INTO User_Downloads
VALUES(41, 37);
INSERT INTO User_Downloads
VALUES(21, 34);
INSERT INTO User_Downloads
VALUES(27, 43);
INSERT INTO User_Downloads
VALUES(2, 13);
INSERT INTO User_Downloads
VALUES(1, 17);
INSERT INTO User_Downloads
VALUES(58, 13);
INSERT INTO User_Downloads
VALUES(35, 52);
INSERT INTO User_Downloads
VALUES(45, 10);
INSERT INTO User_Downloads
VALUES(20, 51);
INSERT INTO User_Downloads
VALUES(4, 18);
INSERT INTO User_Downloads
VALUES(55, 40);
INSERT INTO User_Downloads
VALUES(21, 52);
INSERT INTO User_Downloads
VALUES(3, 52);
INSERT INTO User_Downloads
VALUES(16, 8);
INSERT INTO User_Downloads
VALUES(17, 46);
INSERT INTO User_Downloads
VALUES(8, 46);
INSERT INTO User_Downloads
VALUES(54, 59);
INSERT INTO User_Downloads
VALUES(55, 28);
INSERT INTO User_Downloads
VALUES(3, 29);
INSERT INTO User_Downloads
VALUES(18, 6);
INSERT INTO User_Downloads
VALUES(45, 41);
INSERT INTO User_Downloads
VALUES(28, 24);
INSERT INTO User_Downloads
VALUES(41, 29);
INSERT INTO User_Downloads
VALUES(27, 42);
INSERT INTO User_Downloads
VALUES(51, 34);
INSERT INTO User_Downloads
VALUES(25, 12);
INSERT INTO User_Downloads
VALUES(30, 6);
INSERT INTO User_Downloads
VALUES(1, 37);
INSERT INTO User_Downloads
VALUES(16, 12);
INSERT INTO User_Downloads
VALUES(42, 29);
INSERT INTO User_Downloads
VALUES(32, 4);
INSERT INTO User_Downloads
VALUES(4, 34);
INSERT INTO User_Downloads
VALUES(1, 14);
INSERT INTO User_Downloads
VALUES(45, 39);
INSERT INTO User_Downloads
VALUES(34, 9);
INSERT INTO User_Downloads
VALUES(31, 2);
INSERT INTO User_Downloads
VALUES(15, 25);
INSERT INTO User_Downloads
VALUES(26, 48);
INSERT INTO User_Downloads
VALUES(55, 52);
INSERT INTO User_Downloads
VALUES(11, 31);
INSERT INTO User_Downloads
VALUES(24, 27);
INSERT INTO User_Downloads
VALUES(14, 4);
INSERT INTO User_Downloads
VALUES(23, 26);
INSERT INTO User_Downloads
VALUES(34, 5);
INSERT INTO User_Downloads
VALUES(26, 39);
INSERT INTO User_Downloads
VALUES(12, 19);
INSERT INTO User_Downloads
VALUES(38, 48);
INSERT INTO User_Downloads
VALUES(8, 51);
INSERT INTO User_Downloads
VALUES(57, 54);
INSERT INTO User_Downloads
VALUES(1, 4);
INSERT INTO User_Downloads
VALUES(27, 37);
INSERT INTO User_Downloads
VALUES(37, 40);
INSERT INTO User_Downloads
VALUES(54, 43);
INSERT INTO User_Downloads
VALUES(45, 56);
INSERT INTO User_Downloads
VALUES(34, 36);
INSERT INTO User_Downloads
VALUES(36, 10);
INSERT INTO User_Downloads
VALUES(29, 58);
INSERT INTO User_Downloads
VALUES(43, 50);
INSERT INTO User_Downloads
VALUES(10, 15);
INSERT INTO User_Downloads
VALUES(30, 37);
INSERT INTO User_Downloads
VALUES(50, 20);
INSERT INTO User_Downloads
VALUES(34, 21);
INSERT INTO User_Downloads
VALUES(8, 5);
INSERT INTO User_Downloads
VALUES(57, 21);
INSERT INTO User_Downloads
VALUES(20, 28);
INSERT INTO User_Downloads
VALUES(1, 36);
INSERT INTO User_Downloads
VALUES(38, 59);
INSERT INTO User_Downloads
VALUES(4, 23);
INSERT INTO User_Downloads
VALUES(13, 49);
INSERT INTO User_Downloads
VALUES(41, 43);
INSERT INTO User_Downloads
VALUES(35, 48);
INSERT INTO User_Downloads
VALUES(7, 50);
INSERT INTO User_Downloads
VALUES(51, 4);
INSERT INTO User_Downloads
VALUES(45, 45);
INSERT INTO User_Downloads
VALUES(55, 39);
INSERT INTO User_Downloads
VALUES(50, 21);
INSERT INTO User_Downloads
VALUES(17, 47);
INSERT INTO User_Downloads
VALUES(27, 6);
INSERT INTO User_Downloads
VALUES(11, 3);
INSERT INTO User_Downloads
VALUES(44, 39);
INSERT INTO User_Downloads
VALUES(8, 40);
INSERT INTO User_Downloads
VALUES(58, 12);
INSERT INTO User_Downloads
VALUES(4, 20);
INSERT INTO User_Downloads
VALUES(29, 15);
INSERT INTO User_Downloads
VALUES(53, 55);
INSERT INTO User_Downloads
VALUES(1, 45);
INSERT INTO User_Downloads
VALUES(19, 35);
INSERT INTO User_Downloads
VALUES(12, 11);
INSERT INTO User_Downloads
VALUES(49, 47);
INSERT INTO User_Downloads
VALUES(7, 11);
INSERT INTO User_Downloads
VALUES(51, 49);
INSERT INTO User_Downloads
VALUES(27, 54);
INSERT INTO User_Downloads
VALUES(56, 40);
INSERT INTO User_Downloads
VALUES(33, 9);
INSERT INTO User_Downloads
VALUES(15, 31);
INSERT INTO User_Downloads
VALUES(13, 39);
INSERT INTO User_Downloads
VALUES(24, 42);
INSERT INTO User_Downloads
VALUES(30, 32);
INSERT INTO User_Downloads
VALUES(9, 4);
INSERT INTO User_Downloads
VALUES(52, 31);
INSERT INTO User_Downloads
VALUES(36, 49);
INSERT INTO User_Downloads
VALUES(31, 31);
INSERT INTO User_Downloads
VALUES(29, 57);
INSERT INTO User_Downloads
VALUES(4, 44);
INSERT INTO User_Downloads
VALUES(7, 55);
INSERT INTO User_Downloads
VALUES(24, 43);
INSERT INTO User_Downloads
VALUES(34, 19);
INSERT INTO User_Downloads
VALUES(33, 48);
INSERT INTO User_Downloads
VALUES(55, 31);
INSERT INTO User_Downloads
VALUES(54, 31);
INSERT INTO User_Downloads
VALUES(57, 31);
INSERT INTO User_Downloads
VALUES(18, 43);
INSERT INTO User_Downloads
VALUES(11, 17);
INSERT INTO User_Downloads
VALUES(35, 41);
INSERT INTO User_Downloads
VALUES(19, 20);
INSERT INTO User_Downloads
VALUES(56, 6);
INSERT INTO User_Downloads
VALUES(27, 38);
INSERT INTO User_Downloads
VALUES(47, 14);
INSERT INTO User_Downloads
VALUES(60, 55);
INSERT INTO User_Downloads
VALUES(44, 26);
INSERT INTO User_Downloads
VALUES(3, 37);
INSERT INTO User_Downloads
VALUES(1, 3);
INSERT INTO User_Downloads
VALUES(39, 43);
INSERT INTO User_Downloads
VALUES(59, 4);
INSERT INTO User_Downloads
VALUES(10, 39);
INSERT INTO User_Downloads
VALUES(38, 55);
INSERT INTO User_Downloads
VALUES(8, 7);
INSERT INTO User_Downloads
VALUES(30, 51);
INSERT INTO User_Downloads
VALUES(55, 4);
INSERT INTO User_Downloads
VALUES(15, 16);
INSERT INTO User_Downloads
VALUES(53, 7);
INSERT INTO User_Downloads
VALUES(12, 28);
INSERT INTO User_Downloads
VALUES(19, 16);
INSERT INTO User_Downloads
VALUES(10, 29);
INSERT INTO User_Downloads
VALUES(8, 26);
INSERT INTO User_Downloads
VALUES(35, 43);
INSERT INTO User_Downloads
VALUES(60, 56);
INSERT INTO User_Downloads
VALUES(6, 44);
INSERT INTO User_Downloads
VALUES(36, 9);
INSERT INTO User_Downloads
VALUES(47, 34);
INSERT INTO User_Downloads
VALUES(9, 5);
INSERT INTO User_Downloads
VALUES(24, 23);
INSERT INTO User_Downloads
VALUES(54, 20);
INSERT INTO User_Downloads
VALUES(55, 57);
INSERT INTO User_Downloads
VALUES(22, 19);
INSERT INTO User_Downloads
VALUES(56, 16);
INSERT INTO User_Downloads
VALUES(27, 9);
INSERT INTO User_Downloads
VALUES(49, 34);
INSERT INTO User_Downloads
VALUES(30, 52);
INSERT INTO User_Downloads
VALUES(14, 26);
-- Data for table UserCurator_Interact
INSERT INTO UserCurator_Interact
VALUES(5, 68, 'Nulla tempus.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        39,
        33,
        'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        11,
        25,
        'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        60,
        22,
        'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(13, 47, 'Ut tellus.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        23,
        65,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        57,
        31,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(13, 57, 'Curabitur convallis.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        51,
        55,
        'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        3,
        27,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        9,
        62,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(25, 24, 'In blandit ultrices enim.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(6, 80, 'Suspendisse potenti.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        13,
        17,
        'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        9,
        10,
        'Pellentesque ultrices mattis odio.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(58, 70, 'Proin risus.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        25,
        69,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        23,
        5,
        'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(11, 80, 'Morbi non lectus.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(6, 1, 'Mauris sit amet eros.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(7, 75, 'In congue.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        37,
        46,
        'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(53, 27, 'Donec semper sapien a libero.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        34,
        37,
        'Donec posuere metus vitae ipsum.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        10,
        10,
        'Curabitur at ipsum ac tellus semper interdum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(41, 67, 'Nulla justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(50, 55, 'Aenean fermentum.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(27, 16, 'Nulla ac enim.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(23, 77, 'Integer a nibh.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(31, 56, 'Morbi ut odio.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        7,
        31,
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        46,
        72,
        'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(29, 49, 'Suspendisse potenti.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(25, 3, 'Donec posuere metus vitae ipsum.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        19,
        28,
        'Maecenas ut massa quis augue luctus tincidunt.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        10,
        62,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        39,
        2,
        'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        31,
        72,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        4,
        67,
        'Duis consequat dui nec nisi volutpat eleifend.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(41, 77, 'Donec ut dolor.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        54,
        57,
        'Cras non velit nec nisi vulputate nonummy.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        24,
        17,
        'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        14,
        12,
        'Suspendisse accumsan tortor quis turpis.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(26, 18, 'Sed sagittis.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(16, 21, 'Aenean lectus.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        54,
        13,
        'In hac habitasse platea dictumst.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        2,
        24,
        'Morbi non quam nec dui luctus rutrum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        11,
        52,
        'V cubilia Curae; erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        52,
        2,
        'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(49, 51, 'Sed accumsan felis.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(41, 16, 'Vivamus tortor.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        57,
        44,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        39,
        36,
        'Integer tincidunt ante vel ipsum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        20,
        32,
        'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(17, 59, 'Duis ac nibh.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(7, 52, 'Aenean lectus.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(51, 46, 'Suspendisse potenti.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        39,
        4,
        'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(37, 70, 'Nunc nisl.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        6,
        53,
        'Morbi quis tortor id nulla ultrices aliquet.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        16,
        24,
        'Morbi non quam nec dui luctus rutrum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(38, 74, 'Aliquam non mauris.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(34, 71, 'Etiam vel augue.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(17, 39, 'Sed accumsan felis.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(41, 32, 'Etiam justo.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(23, 11, 'Aenean sit amet justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        59,
        47,
        'Proin interdum mauris non ligula pellentesque ultrices.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(19, 44, 'Phasellus in felis.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(16, 3, 'Etiam justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(48, 54, 'Proin eu mi.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        44,
        7,
        'Phasellus id sapien in sapien iaculis congue.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(58, 59, 'Morbi non lectus.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        40,
        19,
        'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(37, 12, 'Nunc rhoncus dui vel sem.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        17,
        21,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        48,
        36,
        'Praesent id massa id nisl venenatis lacinia.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        7,
        50,
        'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(21, 46, 'Nulla tempus.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        29,
        30,
        'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        51,
        15,
        'In hac habitasse platea dictumst.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(55, 68, 'Donec ut dolor.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(40, 49, 'In quis justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        43,
        32,
        'Vivamus in felis eu sapien cursus vestibulum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(45, 27, 'Etiam vel augue.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        60,
        60,
        'Pellentesque viverra pede ac diam.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(6, 35, 'In quis justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        42,
        64,
        'Vivamus in felis eu sapien cursus vestibulum.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(13, 37, 'Pellentesque at nulla.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(38, 38, 'Mauris sit amet eros.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(56, 28, 'Donec ut dolor.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(28, 7, 'Nulla justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        50,
        58,
        'Curabitur at ipsum ac tellus semper interdum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(29, 51, 'Nulla ac enim.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        19,
        11,
        'Morbi porttitor lorem id ligula.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        2,
        75,
        'Pellentesque viverra pede ac diam.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        13,
        13,
        'Vivamus in felis eu sapien cursus vestibulum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        58,
        76,
        'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        33,
        17,
        'Vivamus vel nulla eget eros elementum pellentesque.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(54, 41, 'Donec vitae nisi.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(19, 22, 'Morbi a ipsum.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        42,
        37,
        'Nullam sit amet turpis elementum ligula vehicula consequat.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        20,
        38,
        'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(35, 70, 'Aenean lectus.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(32, 67, 'Integer ac leo.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(1, 76, 'Donec semper sapien a libero.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        21,
        12,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        14,
        10,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(40, 63, 'Nulla nisl.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(21, 69, 'Morbi a ipsum.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(37, 64, 'Duis bibendum.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(5, 16, 'Morbi a ipsum.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        10,
        32,
        'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        9,
        51,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(2, 60, 'Suspendisse potenti.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        56,
        59,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        57,
        57,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        17,
        26,
        'Suspendisse ornare consequat lectus.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        52,
        11,
        'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(6, 19, 'Praesent blandit lacinia erat.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        13,
        14,
        'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(48, 20, 'Sed accumsan felis.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        24,
        44,
        'In hac habitasse platea dictumst.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(15, 23, 'Praesent blandit lacinia erat.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        17,
        38,
        'Curabitur in libero ut massa volutpat convallis.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        45,
        48,
        'Mauris ullamcorper purus sit amet nulla.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        27,
        74,
        'Maecenas ut massa quis augue luctus tincidunt.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(22, 7, 'Mauris sit amet eros.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(60, 2, 'In hac habitasse platea dictumst.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        30,
        59,
        'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(19, 51, 'In quis justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        49,
        5,
        'Cras in purus eu magna vulputate luctus.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        28,
        26,
        'Cras non velit nec nisi vulputate nonummy.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        32,
        78,
        'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        49,
        73,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(35, 22, 'Integer ac neque.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(42, 69, 'Sed ante.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(4, 4, 'Etiam justo.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        41,
        31,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(32, 24, 'Proin eu mi.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(27, 21, 'Praesent blandit.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        44,
        69,
        'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        50,
        4,
        'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        3,
        44,
        'Sed vel enim sit amet nunc viverra dapibus.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        22,
        46,
        'Curabitur at ipsum ac tellus semper interdum.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        6,
        42,
        'Quisque id justo sit amet sapien dignissim vestibulum.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(13, 68, 'Aenean lectus.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        9,
        30,
        'Nullam sit amet turpis elementum ligula vehicula consequat.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        34,
        44,
        'Mauris lacinia sapien quis libero.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        46,
        17,
        'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(16, 70, 'Quisque ut erat.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        20,
        70,
        'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        33,
        41,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(2, 34, 'Duis bibendum.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(37, 59, 'In eleifend quam a odio.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        16,
        44,
        'Mauris ullamcorper purus sit amet nulla.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        19,
        29,
        'Duis consequat dui nec nisi volutpat eleifend.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        39,
        57,
        'Vivamus vestibulum sagittis sapien.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(6, 70, 'Integer ac leo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(45, 32, 'Sed ante.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(35, 34, 'Nunc rhoncus dui vel sem.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        59,
        41,
        'Suspendisse ornare consequat lectus.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        50,
        29,
        'Cras in purus eu magna vulputate luctus.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(36, 45, 'Etiam pretium iaculis justo.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(4, 64, 'Duis bibendum.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        38,
        40,
        'Pellentesque ultrices mattis odio.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        2,
        7,
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(42, 33, 'In sagittis dui vel nisl.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        53,
        70,
        'In hac habitasse platea dictumst.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        32,
        21,
        'Integer tincidunt ante vel ipsum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(49, 29, 'Proin eu mi.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(29, 39, 'Aenean sit amet justo.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(50, 43, 'Quisque porta volutpat erat.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        33,
        2,
        'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(58, 74, 'Maecenas pulvinar lobortis est.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(59, 22, 'Etiam justo.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(48, 62, 'Morbi a ipsum.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        14,
        33,
        'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        32,
        55,
        'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        24,
        3,
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(44, 40, 'Nunc rhoncus dui vel sem.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        42,
        74,
        'Vivamus in felis eu sapien cursus vestibulum.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        11,
        14,
        'Pellentesque viverra pede ac diam.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(51, 80, 'Phasellus in felis.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        5,
        4,
        'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(
        24,
        48,
        'Curabitur at ipsum ac tellus semper interdum.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(41, 34, 'Nunc rhoncus dui vel sem.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(3, 41, 'Nullam molestie nibh in lectus.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(9, 72, 'Integer a nibh.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(45, 73, 'Vivamus tortor.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(53, 79, 'Suspendisse potenti.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(26, 27, 'Suspendisse potenti.', FALSE);
INSERT INTO UserCurator_Interact
VALUES(
        57,
        45,
        'Pellentesque viverra pede ac diam.',
        TRUE
    );
INSERT INTO UserCurator_Interact
VALUES(50, 39, 'Fusce consequat.', TRUE);
INSERT INTO UserCurator_Interact
VALUES(
        51,
        4,
        'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        44,
        44,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        59,
        77,
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        40,
        7,
        'Morbi quis tortor id nulla ultrices aliquet.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(
        55,
        25,
        'In est risus, auctor sed, tristique in, tempus sit amet, sem.',
        FALSE
    );
INSERT INTO UserCurator_Interact
VALUES(36, 21, 'Praesent lectus.', True);
INSERT INTO UserCurator_Interact
VALUES(
        37,
        23,
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',
        TRUE
    );