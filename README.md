# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers:

1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers

**Important** - you need Docker Desktop installed

1. Clone this repository.
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL.
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp.
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`. To run in detached mode, run `docker compose up -d`.

## Developers:

AgentKettlepot - Keith Yao (NUID: 002603831)
beastmodeactivated123 - Ray Gutierrez (NUID: 002935468)
michaelp2002 - Michael Ault (NUID: 001014770)

## Spotigram

Spotigram is a software that combines Spotify and Instagram. Users can not only listen to music, but they can also message each other and recommend new songs for others. They can also join communities centered around specific artists or genres to engage with other users with similar interests and tastes. Artists can use these communities to interact with their audiences and promote interest in new songs and albums. Additionally, users can follow artists so they can stay updated on their ongoing projects, new releases, and upcoming tours. They can also directly support their favorite artists through sending donations. Users can sign up to become curators, who can create their own publicly viewed playlists. Curators have individual pages that display the playlists they have created. Creators, including curators, singers, producers, podcasters, and others that share their work through Spotigram, are able to track metrics indicating level of interest in their playlists or songs. Listeners are also able to view changes in their listening trends over time. Artists also have individual pages that display the songs and albums that they released and are credited in. Users are also able to listen to or host podcasts. Users are able to follow specific podcasts, so they stay updated on new episodes and news from the host. Podcast hosts each have a page that displays their podcasts and other work. Podcast hosts are also able to track their growth statistics per episode.
