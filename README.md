# OpenLDAP Docker

This repository contains the recipe to create a container image with OpenLDAP inside an Alpine 3.

Currently, the entrypoint is empty, to test it just use `--entrypoint=/bin/sh`.

The OpenLDAP utilities are located here: `/usr/local/`.

## Things to be implemented

* a real entrypoint script that starts openldap as daemon.
* version selection using environment variables (`BERKELEYDB_RELEASE`, `OPENLDAP_RELEASE`, etc.).