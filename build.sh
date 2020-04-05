#!/usr/bin/env bash

## VoEnabler
createVersion(){
	 zip -r ./${VFILE} META-INF module.prop system.prop customize.sh README.md
}

usage(){
  echo -e "\n$0:\t [d,f,h,v]"
  echo -e "\t-v\tversion: define version for zip filename."
  echo -e "\t-d\tDryRun: is set, then no zip file is created"
  echo -e "\t-f\tForce, overwrite existing zip if any"
  echo -e "\t-h\tHelp: this help"
}

#Main
#process options
VERSION=""
FORCE=0
DRYRUN=0

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
  v)
    VERSION=$OPTARG
    ;;
  esac
done

VFILE=voenabler-v${VERSION}.zip

if [[ ! ${VERSION} =~ [0-9]\.[0-9]$ ]]; then
	echo -e "\nError, VERSION string is incorrect (${VERSION}): expected x.y where x and y are integers\n"
	exit 1
fi

if [[ ${FORCE} -eq 1 ]]; then 
	createVersion ${VERSION}
else if [[ ${DRYRUN} -eq 0 ]]; then
	if [[ -f ${VFILE} ]]; then
		echo "Error, ${VFILE} exists, use -f to overwrite, -h for help"
		exit 1;
	else 
		createVersion ${VERSION}
	fi
	else
	echo "DRYRUN:${DRYRUN}, ${VFILE} not created"	
	fi
fi

