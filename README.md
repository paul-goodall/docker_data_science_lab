# Docker Data Science Lab

This project was created for data science consultants who are often victims of multiple OS environments and machines.  I wanted to create a reliable and reproducible setup that works on-the-fly if I am moving from my own machine (usually a mac) to a client machine (usually windows) - without losing time getting setup and installing bespoke things.  This allows me to take a "ready-to-go" Ubuntu (focal) setup with me wherever I go, complete with the majority of the additional Data Science toolkit that I commonly use/need to install.

The amazing [rocker](https://github.com/rocker-org/rocker) stack forms the basis of the images here, with a bunch of bespoke additional Unix tools thrown in to put the icing on the cake.  Visit [rocker-project.org](https://rocker-project.org) for more about available Rocker images, configuration, and use.

To run the data science lab, only the `run_ddsl.sh` script is actually needed, as it will pull the image from DockerHub.

The ingredients for building this image and tailoring for your own use is in the `build/` directory, but I would recommend going directly to the [rocker](https://github.com/rocker-org/rocker) repo as a more reliable source of truth.

## Requirements

- Install docker
- [optional] for macintosh: `brew install socat` if you'd like to make use of x11win forwarding between the container and your mac.
- [optional] for windows: (x11 support tbc - any tips please submit pull requests)

## Notes on getting started

- download the [run_ddsl.sh](https://raw.githubusercontent.com/paul-goodall/docker_data_science_lab/main/run_ddsl.sh) file. (or just do `wget https://raw.githubusercontent.com/paul-goodall/docker_data_science_lab/main/run_ddsl.sh`)
- move the `run_ddsl.sh` file to wherever you wish to mount the Ubuntu home (the default behaviour is that a new folder `rstudio/` will be created in the same directory as the `run_ddsl.sh` file, and mapped to `/home/rstudio` in the container.  You can change this behaviour by editing the file before running, specifically the variables `local_magic_home` and/or `local_magic_path`)
- on the first running, the `rstudio/` folder (or whatever you changed it to) is created and the session is treated as a fresh start.  If the folder `rstudio/` already exists, it will assume you are resuming from a previous session, with all the relevant settings (and dotfiles etc) from your home dir.
- Only the `/home/rstudio` folder in the container is persisted and mapped with your local machine, everything else is ephemeral.

## Mac usage:

Open a terminal and follow the commands below:

- Check the script to ensure you are happy with the default behaviour, or ammend as required
- Make the script executable:  `chmod 755 run_ddsl.sh`
- Run the Data Science Lab `./run_ddsl.sh`

When your session is finished:
- Stop the data science lab container: `docker container stop data_science_lab; docker container prune -f`

## Win usage:

Open a Command Prompt and run:
`sh run_ddsl.sh`

## Data Science Tools that ship with this container:

