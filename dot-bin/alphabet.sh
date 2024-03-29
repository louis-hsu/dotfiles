#!/bin/bash
# Set some default values:
ALPHA=unset
BRAVO=unset
CHARLIE=unset
DELTA=unset

usage()
{
  echo "Usage: alphabet [ -a | --alpha ] [ -b | --bravo ]
                        [ -c | --charlie CHARLIE ] 
                        [ -d | --delta   DELTA   ] filename(s)"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n alphabet -o abc:d: --long alpha,bravo,charlie:,delta: -- "$@")
# the return of getopt
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

echo "PARSED_ARGUMENTS is $PARSED_ARGUMENTS"
eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    -a | --alpha)   ALPHA=1      ; shift   ;;
    -b | --bravo)   BRAVO=1      ; shift   ;;
    -c | --charlie) CHARLIE="$2" ; shift 2 ;;
    -d | --delta)   DELTA="$2"   ; shift 2 ;;
    # -- means the end of the arguments; drop this, and break out of the while loop
    --) shift; break ;;
    # If invalid options were passed, then getopt should have reported an error,
    # which we checked as VALID_ARGUMENTS when getopt was called...
    *) echo "Unexpected option: $1 - this should not happen."
       usage ;;
  esac
done

echo "ALPHA   : $ALPHA"
echo "BRAVO   : $BRAVO "
echo "CHARLIE : $CHARLIE"
echo "DELTA   : $DELTA"
echo "Parameters remaining are: $@"
