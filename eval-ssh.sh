#!/bin/bash

sudo chmod 600 ~/.ssh/id_ed25519
sudo chmod 600 ~/.ssh/id_ed25519.pub 
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519