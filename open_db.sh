if [[ $# -eq 0 ]] ; then
    echo "Specify db file to open"
    exit 0
fi


cd ~/repositories/dbs_stateless/
git pull

subl $( find . -name "*$1*" )