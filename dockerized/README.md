# Dockerized Unifed-Agent

## About
The Dockerized Unifed-Agent project provides a Dockerfile template containing different package managers (e.g. maven, npm...).
The file includes installation commands that allow creating a more suitable and customizable run environment for scanning projects/files.

The user has the ability to add/remove package managers according to his needs just by commenting/uncommenting 
relevant lines from the Dockerfile.

## Available in Dockerfile
0.  Ubuntu:18.04 (base image)
1.  required utility apps
2.  Java (1.8)
3.  Maven (3.5.4)
4.  Node.js (8.9.4)
5.  NPM (5.6.0)
6.  Yarn (1.5.1)
7.  Bower (1.8.2)
8.  Gradle (6.0.1)
9.  python 2.7 + 3.6 + pip + pip3 + pipenv
10. python 3.7
11. python 3.8
12. Poetry (python)
13. Ruby, rbenv and ruby-build
14. Go (1.12.6)
15. Scala 2.12.6, Sbt 1.1.6
16. PHP (7.2)
17. Composer
18. PHP Plugins
19. Mix, Hex, Erlang and Elixir
20. Cocoapods (1.5.3)
21. R + Packrat
22. Haskel + Cabal
23. Paket
24. dotnet-sdk-2.2,dotnet cli and NuGet
25. Cargo

## Files
#### wss_agent.sh / wss_agent.bat
- creates a directory `wss` 
- downloads the latest `wss-unified-agent.config` configuration template file (requires editing after being downloaded) 
- downloads the latest `wss-unified-agent.jar`

#### Dockerfile
The Dockerfile contains a list of languages and package managers installations.

Default installations are:
- utility apps
- java 1.8
- maven
- npm/ nodejs/ yarn
- gradle
- python 2.7, python3.6
 
## Running the dockerized agent
1. run `wss_agent.*` script to download the agent jar and configurations template file
2. edit the configuration `./wss/wss-unified-agent.config`
3. select the directory to scan (let's call it `Data`) 
4. build the docker image according to below options

#### Option 1: 
Using the docker volume mounts:
example command:
`docker run 
--mount type=bind,source="$(pwd)"/wss,target=/home/wss-scanner/wss 
--mount type=bind,source="$(pwd)"/data/,target=/home/wss-scanner/Data/ 
<image>:<tag> 
java -jar ./wss/wss-unified-agent.jar -c ./wss/wss-unified-agent.config -d ./Data`

#### Option 2: 
Add the config file, the agent jar and the Data to the image (using docker `COPY` or `ADD` commands in the Dockerfile, 
this option requires a new image build each time. 

#### Option 3:
Combine both options, like adding the `wss/*` to the image and use mounting for the `Data` directory
 

## Tips 
It's possible to use the [Whitesource Unified-Agent configuration](https://whitesource.atlassian.net/wiki/spaces/WD/pages/804814917/Unified+Agent+Configuration+File+and+Parameters)
properties: `whiteSourceFolderPath` and `log.files.path` 
To save scan results and logs outside of the running container with combination of docker volume mounts.
