#!/usr/bin/env bash

## VoEnabler
createZip() {
  #remove if force enabled
  [[ ${2} -eq 1 ]] && [[ -f ${1} ]] && rm -f ${1}

  if [[ ${3} -eq 1 ]]; then
    echo "DRYRUN:${DRYRUN}, ${VFILE} not created"
  else
    #create archive
    zip -r ./${1} META-INF module.prop system.prop customize.sh README.md
  fi
}

usage() {
  echo -e "\n$0:\t [d,f,h,v]"
  echo -e "\t-v\tversion: define version for zip filename."
  echo -e "\t-d\tDryRun: is set, then no zip file is created"
  echo -e "\t-f\tForce, overwrite existing zip if any"
  echo -e "\t-h\tHelp: this help"
  echo -e "\t-l\tlatest: build zip with latest commit"
}

#Main
#process options
VERSION=""
FORCE=0
DRYRUN=0
LATEST=0

while getopts "dfhv:" option; do
  case $option in
  d)
    DRYRUN=1
    ;;
  f)
    FORCE=1
    ;;
  h)
    usage
    exit 1
    ;;
  l)
    LATEST=1
    FORCE=1
    ;;
  v)
    VERSION=$OPTARG
    ;;
  esac
done

#set filename
if [[ ${LATEST} == 1 ]]; then
  VFILE=voenabler-latest.zip
else
  VFILE=voenabler-v${VERSION}.zip
fi

#check version naming
if [[ ! ${VERSION} =~ [0-9]\.[0-9]$ ]] && [[ ${LATEST} == 0 ]]; then
  echo -e "\nError, VERSION string is incorrect (${VERSION}): expected x.y where x and y are integers\n"
  exit 1
fi

createZip ${VFILE} ${FORCE} ${DRYRUN}
