#!/bin/sh

set -e

#if [ "${1:0:1}" = '-' ]; then
#    set -- gurobi "$@"
#fi

#if [[ "$VERBOSE" = "yes" ]]; then
#    set -x
#fi


#GUROBI_LICENSE="bc813f4e-fc70-11e8-b639-02e454ff9c50"

#echo '' | grbgetkey bc813f4e-fc70-11e8-b639-02e454ff9c50

license=/home/gurobi/gurobi.lic
if [ -f $license ]; then
    echo "Skipping license creation"
    #./gurobi.sh $1
else
    echo "Configure license $GUROBI_LICENSE"
    echo '' | grbgetkey $GUROBI_LICENSE
    #./gurobi.sh $1
fi

