# Django Auth0 Demo

This demo application uses Django web framework to serve a simple todo application secured with Auth0 for SSO


## Development Environment

You will need the following to build the application locally

* [docker](https://www.docker.com/)
* [vscode](https://code.visualstudio.com/)
* [remote - containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

Building the app

```
make build
```

Running the app

```
make run
```

Connecting to the development container

* run vscode command and choose "Remote Containers : Attach to running container"
* choose the web container. This will install required tooling on the container and now you can open terminal and access cli

Running migrations
```
python manage.py migrate

# sample output
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  No migrations to apply.
```