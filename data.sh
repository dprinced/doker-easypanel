#!/bin/bash

if [ ! -e /data/home ]; then
    mv -f /mydata/* /data/
fi
