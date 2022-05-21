# Docker Data Science Lab

This project was created for data science consultants who are often victims of multiple OS environments and machines.  I wanted to create a reliable and reproducible setup that works on-the-fly if I am moving from my own machine (usually a mac) to a client machine (usually windows) - without losing time getting setup and installing bespoke things.  This allows me to take a "ready-to-go" Ubuntu (focal) setup with me wherever I go, complete with the majority of the additional Data Science toolkit that I commonly use/need to install.

The amazing [rocker](https://github.com/rocker-org/rocker) stack forms the basis of the images here, with a bunch of bespoke additional Unix tools thrown in to put the icing on the cake.  Visit [rocker-project.org](https://rocker-project.org) for more about available Rocker images, configuration, and use.

To run the data science lab, only the `run_ddsl.sh` script is actually needed, as it will pull the image from DockerHub.

The ingredients for building this image and tailoring for your own use is in the `build/` directory, but I would recommend going directly to the [rocker](https://github.com/rocker-org/rocker) repo as a more reliable source of truth.

## Requirements

- Install docker
- [optional] for macintosh: `brew install socat` if you'd like to make use of x11win forwarding between the container and your mac.
- [optional] for windows: (x11 support tbc - any tips please submit pull requests)

Running the scripts below with create a use a local directory called `magic_home` in the current directory of this cloned repo, as a common fileshare between the local machine and the docker container.  If the `magic_home` directory already exists, it will be treated as a resumed session, otherwise it will be created.

## Mac usage:

Open a terminal and run:
`./run_ddsl.sh`

## Win usage:

Open a Command Prompt and run:
`sh run_ddsl.sh`
