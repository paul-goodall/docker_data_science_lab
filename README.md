# Docker Data Science Lab (DDSL)

### 0.0 - TOC:

- 0.0 - TOC (recursive error)
- 1.0 - Intro / About DDSL
- 2.0 - Setup
- 3.0 - Running DDSL
- 4.0 - Build a custom DDSL image

## 1.0 - Intro / About

This project was created for data science consultants who are often victims of multiple OS environments and machines.  I wanted to create a reliable and reproducible setup that works on-the-fly if I am moving from my own machine (usually a mac) to a client machine (usually windows) - without losing time getting setup and installing bespoke things.  This allows me to take a "ready-to-go" Ubuntu (focal) setup with me wherever I go, complete with the majority of the additional Data Science toolkit that I commonly use/need to install.

The amazing [rocker](https://github.com/rocker-org/rocker) stack forms the basis of the images here, with a bunch of bespoke additional Unix tools thrown in to put the icing on the cake.  Visit [rocker-project.org](https://rocker-project.org) for more about available Rocker images, configuration, and use.

The ingredients for building this image and tailoring for your own use is in the `build/` directory, but I would recommend going directly to the [rocker](https://github.com/rocker-org/rocker) repo as a more reliable source of truth.

## 2.0 - Setup

### 2.1 - Requirements

- Install docker (that's it!)

### 2.2 - Optional installs

If you'd like to use x11win from the Ubuntu container, you'll need to make sure the host also can support it:

For `macintosh`: 
- Install XQuartz (and enable network connections in preferences - first time only)
- Install the window manager: `brew install socat`

For `windows`:
- Install the x11 support and display manager: `choco install vcxsrv`  (or see vcxsrv webpage if you don't use choco package manager for windows)

## 3.0 - Running DDSL

This container image is not small! (~15GB) The first usage may take a few mins to download the image.
To run the image (as-is) - you only need the relevant run-script for mac or windows, as below.

### 3.1 - Mac usage:

Open a Terminal and follow the commands below:

- Download the mac run script: 
  - `wget https://raw.githubusercontent.com/paul-goodall/docker_data_science_lab/main/mac_run_ddsl.sh`
- Inspect the script to ensure you are happy with the default behaviour/settings, or amend as required (see section 3.5 - About the run scripts)
- Make the script executable:  
  - `chmod 755 mac_run_ddsl.sh`
- Run the Data Science Lab
  - `./mac_run_ddsl.sh`

### 3.2 - Win usage:

Open a Command Prompt and follow the commands below:
- Check the script to ensure you are happy with the default behaviour, or amend as required
- Make the script executable:  `chmod 755 win_run_ddsl.bat`
- Run the Data Science Lab `win_run_ddsl.bat`

### 3.3 - Using DDSL

Once running, the DDSL dashboard webpage should present itself, allowing you to get started quickly.

Alternatively, you can connect to the Docker Data Science lab through any of the following methods:
- `ssh -XY rstudio@localhost -p 2222` - the default password is "password" but you can change this during docker run by editing the `run_ddsl` script
- `http://localhost:8787` - Rstudio server  (A convenient browser-based IDE for running and testing R+Python code)
- `http://localhost:3838` - R Shiny server  (For hosting the apps you develop)
- `http://localhost:8888` - Jupyter notebooks  (Excellent for documentation of your code)

### 3.4 - Stopping DDSL

When your session is finished:
- Stop the data science lab: `docker container stop data_science_lab; docker container prune -f`
- Your `rstudio` directory will persist on your host machine in the location you specified.

### 3.5 - About the run scripts

The below has the following options / disclaimers:
- HOST_OS can be "win" or "mac"
- YOUR_MACHINE_IP - this is only really needed to enable x11 support
- MAGIC_FOLDER ==> This cannot be changed here (would need to rebuild the image).  Will be removed as an argument in future builds
- YOUR_LOCAL_MOUNT_PATH = e.g. `$HOME/rstudio` or `C:\...\Documents\...\rstudio` (or whatever you wish to mount it)
- DISABLE_AUTH ==> applies to the rstudio-server login.  See [rocker](https://github.com/rocker-org/rocker) if you prefer to set a password.

```bash
docker run -d -p 8787:8787 -p 3838:3838 -p 8888:8888 \
              --name data_science_lab \
              -e HOST_OS="mac" \
              -e "YOUR_MACHINE_IP:0" \
              -e MAGIC_FOLDER="/Volumes/Abyss/rstudio" \
              -e FRESH_START="yes" \
              -v "YOUR_LOCAL_MOUNT_PATH:/Volumes/Abyss/rstudio" \
              -e DISABLE_AUTH=true \
              goodsy/docker_data_science_lab:latest
```


## Data Science Tools that ship with this container:
