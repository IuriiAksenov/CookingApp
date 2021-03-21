#!/bin/bash

### create cooking_app folder

sudo mkdir /var/www/cooking_app # rwx rwx r-- ocs_root ocs_root

sudo mkdir /var/www/cooking_app/media    # rwx rwx r-- ocs_root ocs_root
sudo mkdir /var/www/cooking_app/media/recipes    # rwx rwx r-- www-data ocs_root

sudo mkdir /var/www/cooking_app/front # rwx rwx r-- ocs_cicd ocs_dev
sudo mkdir /var/www/cooking_app/front/v0.1 # rwx rwx r-- ocs_cicd ocs_dev

sudo mkdir /var/www/cooking_app/back # rwx rwx r-- ocs_dev ocs_root
sudo mkdir /var/www/cooking_app/back/v0.1 # rwx rwx r-- ocs_dev ocs_root

sudo mkdir /var/www/cooking_app/back/v0.1/logs # rwx rwx r-- www-data ocs_root
sudo mkdir /var/www/cooking_app/back/v0.1/services # rwx rwx r-- ocs_cicd ocs_dev

### change roles
# tips:
# change subfolders
# find /path_to_file/* -type d -exec chmod 755 {} \+
# change files
# find /path_to_file/* -type f -exec chmod 664 {} \+


# change groups for whole cooking_app directory in order to allow ocs_root change all info
# /var/www/cooking_app
sudo chown -R ocs_root:ocs_root /var/www/cooking_app

sudo chmod 755 /var/www/cooking_app/back
sudo chmod 755 /var/www/cooking_app/back/v0.1
sudo chmod 755 /var/www/cooking_app/front
sudo chmod 755 /var/www/cooking_app/front/v0.1
sudo chmod 755 /var/www/cooking_app/media

## /var/www/cooking_app/media

# /var/www/cooking_app/media/recipes
sudo chmod 755 /var/www/cooking_app/media/recipes

sudo chown www-data /var/www/cooking_app/media/recipes
sudo chown -R www-data /var/www/cooking_app/media/recipes
sudo chmod 775 /var/www/cooking_app/media/recipes
sudo find /var/www/cooking_app/media/recipes* -type d -exec chmod 775 {} \+
sudo find /var/www/cooking_app/media/recipes* -type f -exec chmod 664 {} \+

### /var/www/cooking_app/front
sudo chown -R ocs_cicd /var/www/cooking_app/front
sudo chown -R ocs_cicd /var/www/cooking_app/front/v0.1
sudo chmod 775 /var/www/cooking_app/front
sudo chmod 775 /var/www/cooking_app/front/v0.1

### /var/www/cooking_app/back_v0.1
sudo chown -R ocs_dev:ocs_dev /var/www/cooking_app/back
sudo chown -R ocs_dev:ocs_dev /var/www/cooking_app/back/v0.1
sudo chmod 775 /var/www/cooking_app/back
sudo chmod 775 /var/www/cooking_app/back/v0.1

sudo chown -R www-data:www-data /var/www/cooking_app/back/v0.1/logs
sudo chmod 775 /var/www/cooking_app/back/v0.1/logs
sudo chmod -R 664 /var/www/cooking_app/back/v0.1/logs/*
sudo chmod 775 /var/www/cooking_app/back/v0.1/logs/*

sudo chown -R ocs_cicd:ocs_cicd /var/www/cooking_app/back/v0.1/services
sudo chmod 775 /var/www/cooking_app/back/v0.1/services
sudo find /var/www/cooking_app/back/v0.1/services/* -type d -exec chmod 775 {} \+
sudo find /var/www/cooking_app/back/v0.1/services/* -type f -exec chmod 664 {} \+

### add folders which are owned by users

# ocs_root
sudo ln -s /var/www/cooking_app /home/ocs_root/cooking_app

# ocs_dev
sudo ln -s /var/www/cooking_app/front /home/ocs_dev/front
sudo ln -s /var/www/cooking_app/back /home/ocs_dev/back

# ocs_cicd
sudo ln -s /var/www/cooking_app/front/home/ocs_cicd/front
sudo ln -s /var/www/cooking_app/back/v0.1/services /home/ocs_cicd/back_v0.1_services
