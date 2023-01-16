## Cypress Workspace

This is a repository to setup test development environment with Cypress. 

### Pre-requisite

#### Docker Desktop

Docker Desktop needs to be installed beforehand because docker compose is used to boot up the development environment. Please following official Docker Desktop installation guide:

https://docs.docker.com/engine/install/

#### Make Utility

`make` is used in adminsitration script to manage containers in Cypress workspace.

#### XQuartz X11 Server

XQuartz is required to run Cypress interactive Test Runner (GUI) on Mac OS. For other Linux distribution, please refer to Cypress installation document to install necessary dependencies.

##### Install XQuartz

If you have brew installed, XQuartz installation will be extremely simple:

```
brew install --cask xquartz
```

##### Run XQuartz

Start XQuartz from command line:

```
open -a XQuartz
```

In XQuartz "Settings ...", go to the "Security" tab and make sure option "Allow connections from network clients" is checked.

##### Setup host IP for Docker Compose

Please run the following make command to generate host-ip.env for Docker Compose so Docker containers can direct X11 display to the host machine properly:

```
make update.host-ip

XX.XX.XX.XX being added to access control list
```

You can view the host IP assigned by running the following command:

```
make show.host-ip
```

### Up & Run Cypress Workspace

To start Cypress Workspace:

```
make up
```

To stop Cypress Workspace:

```
make down
```

To check the status of Cypress Workspace:

```
make ps
```

You can check the demo app from your browser with the following URL:

```
http://demo.cypress.127.0.0.1.nip.io
```

You can check the Nginx log:

```
make logs.nginx
```

To create a new Cypress project from scratch:

```
make new.app app=demo.test
```

Cypress Test Runner (GUI) will be open as well.

To open an existing Cypress project from scratch:

```
make open.app app=demo.test
```

Cypress Test Runner (GUI) will be open as well.

To run tests in an existing Cypress project (headless):

```
make run.test app=demo.test
```

### Troubleshooting

#### Cypress fails to open

If your host machine's network connection is changed (like switching WIFI), the host IP might change. In such case, you need to update your host IP to docker compose and restart the container services accordingly; otherwise, X11 display redirection might fail which means Cypress Test Runner (GUI) will fail to open.

To update the host IP for docker compose: 

```
make update.host-ip
```

After update the host IP, you need to restart the containers:

```
make down
make up
```
