---

layout: home
title: Linux
permalink: /linux/
nav_order: 7

---

# [**1. Linux**](downloads/linux.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Users**
- root user: most powerful user, able to do most system actions
- apt: software management package
- `su`: to switch between users
- `sudo`: allows command to be run as root
    - very powerful: need to be careful

## **Building Tiny Linux System**
- `qemu` - a vmachine emulator
    - Emulation: replicate behaviour of program or system using src code
    - Simulation: try to model & evaluate behaviour, you write the simulation code
    - qemu can emulator entire virtual machine
    - provides virtualization: but must be same architecture as host

- cross compiler: compiler gens machine code for diff platform
    - e.g might run on x86 (Intel) but gen code for MIPS

- dynamic vs static link
    - dynamic: large benefits but breaks if run program without libraries present
    - gcc -static opt: include all library code in binary will be larger 

- `tar` : archive/unarchive files & directories
    - in tar format
    - other formats: zip, deb, ar shar, cpio
    - options:
        - -c: create archive
        - -f: archive filename
        - -z: compress with gzip  
        - -x: extract an archive
        - -v: (verbose) print filenames when extracting
        - -f: archive filename
    - e.g `tar -zcf nth_prime.tar.gz nth_prime*`
    - e.g `tar -xvf nth_prime.tar.gz `
