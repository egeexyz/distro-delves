#!/bin/env bash

curl -L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.5/MangoHud-0.6.5.r0.ge42002c.tar.gz -o /tmp/MangoHud.tar.gz
tar -C /tmp/ -xf /tmp/MangoHud.tar.gz
bash /tmp/MangoHud/mangohud-setup.sh install
