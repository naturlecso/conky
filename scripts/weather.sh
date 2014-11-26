#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: $0 [info|n] [param]"
  echo "Info params: city, sunrise, sunset, day(sunrise - sunset)"
  echo "Day params:  day, high|temp, low, image"
  exit 0
fi

CACHE_FILE=~/.conky/cache/weather

if [ ! -f $CACHE_FILE ]; then
  echo "N/A"
  exit 0
fi

filter(){
  echo $(cat $CACHE_FILE | grep $1 | awk "{ print \$$2 }")
}

to_sun() {
  srise=$(filter $1 3)
  sset=$(filter $1 4)
  echo "$srise - $sset"
}

case $1 in
  'info')
    case $2 in
      'city') echo $(filter $1 2);;
      'sunrise') echo $(filter $1 3);;
      'sunset') echo $(filter $1 4);;
      'sun') echo $(to_sun $1);;
      *) echo "N/A";;
    esac
  ;;
  0|1|2|3|4|5)
    case $2 in
      'day') echo $(filter "day$1" 2);;
      'high'|'temp') echo $(filter "day$1" 3);;
      'low') echo $(filter "day$1" 4);;
      'image')
        case $(filter "day$1" 5) in
          36) echo 'A';;
          31|32|34) echo 'B';;
          33) echo 'C';;
          19|20|21|22|23) echo 'E';;
          24) echo 'F';;
          25) echo 'G';;
          28|30) echo 'H';;
          27|29) echo 'I';;
          26|44) echo 'N';;
          1|2|3|4|37|38|39|40) echo 'P';;
          9) echo 'Q';;
          10|11|12|45|47) echo 'R';;
          8|13|14) echo 'U';;
          15|16|41|42|43|46) echo 'W';;
          5|6|7|17|18|35) echo 'X';;
          *) echo ')';;
        esac
        ;;
      *) echo "N/A";;
    esac
  ;;
  *)
    echo "N/A"
    exit 0
  ;;
esac
