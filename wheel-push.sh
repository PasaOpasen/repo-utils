#
# pushes the wheel to pypi with credentials reading
#
# credentials is the file usually called pypi.sh (in the parent directory) with next variables:
#   PYPI_USERNAME=__token__
#   PYPI_PASSWORD=pypi-AgEIcHlwaS5vcmcCJG...
#
# usage:
#   bash wheel-push pypi-file(=../pypi.sh)
#

set -e

PYTHON=$(bash get-python.sh)

pypi_creds=${1:-../pypi.sh}

if [ -f "${pypi_creds}" ]
then 
    echo "read creadentials from ${pypi_creds}"
    source ${pypi_creds}
fi

U=${PYPI_USERNAME}
P=${PYPI_PASSWORD}

cd ../

if [ -n "$U" ] && [ -n "$P" ]
then 
    $PYTHON -m twine upload -u $U -p $P dist/* --skip-existing
else
    echo "credentials not found"
    $PYTHON -m twine upload dist/* --skip-existing
fi

