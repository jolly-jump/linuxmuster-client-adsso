# create share links in documents folder
#
# thomas@linuxmuster.net
# 20181101
#

SHAREFOLDER="$HOME/$share_folder"

# first cleanup
[ -e "$HOME/$student_homes" ] && rm -f "$HOME/$student_homes"
if [ -d "$SHAREFOLDER" ]; then
  find "$SHAREFOLDER" -type l -exec rm '{}' \;
fi

# only if SROLE was defined earlier
if [ -n "$SROLE" ]; then

  mkdir -p "$SHAREFOLDER"
  ln -srf "$SCHOOLSHARE" "$SHAREFOLDER/$school_share"
  if [ "$SROLE" = "teacher" ]; then
    ln -srf "$STUDENTHOMES" "$HOME/$student_homes"
    ln -srf "$TEACHERSHARE" "$SHAREFOLDER/$teachers_share"
  fi
  # do class shares
  for foldername in $STUDENTGROUPS; do
    classshare="$CLASSSHARES/$foldername"
    [ -d "$classshare" ] && ln -srf "$classshare" "$SHAREFOLDER/$foldername"
  done
fi