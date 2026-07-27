---

layout: home
title: Make
permalink: /make/
nav_order: 6

---

# [**1. Make**](downloads/make.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

- build: implementation in py
    - get target dependecies from rules (target e.g game)
    - dependencies: e.g main.o, graphics.o, etc and run build recursively on each dependency
    - then see if can run commands for each recursive dependency

- build incremental compilation instead  
1) target exists or not
2) source changed or not - modification time

## **Make Command Line Args**
- make args are targets, build just those targets
    - -n opt: print what it would do to create targets & don't execute commands
- parser = argparse.ArgumentParser()
    - use to parse in different args e.g sed options without need to continually to manually check number of args, etc.
    - access using `parser.add_argument(), parser.parse_args()`

## **MakeFile: Vars & Comments-**
- make var: `CFLAGS=-Wall`
- to access variables: e.g `$(CFLAGS)`

## **make in parallel**
- `make -jn` : for `n` parallel processes

### **Virtualisation**
- separation of resource from the underlying hardware
    - hypervisor manages virtual machine create
    - create virtual machines to better hardware utilise, isolation of virtual machine, flexibility
    - container: lightweight, isolated env
        - diff with virtual machine, does not contain own OS
        - share OS kernel

- Docker: 
    - platform that creates & manages containers
    - `docker run --privileged --name linux -it debian: latest bash`
    
    - --privileged: gives container almost all privileges of host
    - --name: assigns container a name
    - -it: gives interactive shell
    - debian:latest : the Docker image to use
    - bash: starts Bash shell
    - `docker ps` : show all currently running containers