#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
HOME=${SCRIPT_DIR}

if [ -f ${SCRIPT_DIR}/.env ]; then
    set -o allexport
    source ${SCRIPT_DIR}/.env
    set +o allexport
fi

if [ ! -d ${HOME}/.venv ]; then
    python -m virtualenv "${HOME}/.venv"
fi
source ${HOME}/.venv/bin/activate
pip install --upgrade pip | grep -v 'Requirement already satisfied'
if [ -f ${SCRIPT_DIR}/requirements/base.txt ]; then
    pip install -q -r ${SCRIPT_DIR}/requirements/base.txt | grep -v 'Requirement already satisfied'
fi

python ${SCRIPT_DIR}/owi2plex.py -b Favourites -h 10.20.20.40 -o epg.xml

deactivate
exit
