# Mongo Syphon with Docker

origin: [MongoSyphon](https://github.com/johnlpage/MongoSyphon)

> Run MongoSyphon with docker container

## Prerequisites

- build a docker image with Dockerfile
  - or you can pull image from [docker hub](https://hub.docker.com/r/wkdwoo/mongo-syphon)
- run container with docker-compose
  - `ports 6379, 26379, 30000` are needed
  - `port 6379` will be soruce(RDBMS)
  - `port 26379` will be sink, our MongoDB.
- create JSON formatted configuration file at the directory `'./settings'`

<br>

## HOW TO USE

### JSON formatted setting file

```
{
	start: {
		source: {
			uri:  "jdbc:mysql://localhost:3306/sdemo?useSSL=false&allowPublicKeyRetrieval=true&useSSL=false",
			user: "root",
			password: "root"
		},
		target: {
			mode: "insert",
			uri: "mongodb://localhost:27017/",
			namespace: "sdemo.owners"
		},
		template: {
			_id: "$ownerid",
			name: "$name",
			address : "$address",
			pets : [ "@petsection" ]
		},
		query:{
		   sql: 'SELECT * FROM owner'
		}
	},

	petsection: {
		template: {
			petid: "$petid",
			name: "$name",
			species : "@speciessection"
		},
		query:{
			sql: 'SELECT * FROM pet where owner = ?'
		},
		params: [ "ownerid" ]
	},

	speciessection: {
		template: {
			_value : "$species"
		},
		query: {
			sql: 'SELECT * from species where speciesid = ?'
		},
		params : [ "species" ]
	}
}

```

```
docker exec -it mongo-syphon-container java -jar /engineer/MongoSyphon/bin/MongoSyphon.jar -c /engineer/settings/test.json
```

```

```
