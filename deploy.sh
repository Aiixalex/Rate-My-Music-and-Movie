#!/bin/bash

if [ -d ".venv" ]
then
    source .venv/bin/activate
    python3 wsgi.py
else
    python3 -m venv .venv
    source .venv/bin/activate
    python3 wsgi.py
fi