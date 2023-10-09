set -e

function dir_exists {
  if [[ ! -d $webjar_root/$1 ]]; then
    echo "Directory does not exist: $1"
    exit 2
  else
    echo "Directory exists: $1"
  fi
}

function file_exists {
  if [[ ! -f $webjar_root/$1 ]]; then
    echo "File does not exist: $1"
    exit 3
  else
    echo "File exists: $1"
  fi
}

function file_contains {
  file_exists $1

  if [[ "" == "$3" ]]; then
    grep_flags="-i"
  else
    grep_flags="${@:3}"
  fi

  if grep $grep_flags "$2" $webjar_root/$1 > /dev/null; then
    echo "File $1 does contain '$2'"
  else
    echo "File $1 does not contain: '$2'"
    exit 4
  fi
}

if [[ "" == "$1" ]]; then
  echo "You must specify the webjar root directory."
  exit 1
fi

webjar_root=$1

echo "Validating generated webjar..."
echo "=============================="
source validate_.sh
echo "=============================="
echo "Validation was successful."
