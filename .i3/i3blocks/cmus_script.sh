ARTIST=$( cmus-remote -Q 2>/dev/null | grep 'tag artist' | cut -d " " -f 3- )
TITLE=$( cmus-remote -Q 2>/dev/null | grep 'tag title' | cut -d " " -f 3- )

if [ -z "$ARTIST" ];
then
echo "▶ Nothing"
else
echo "▶ $ARTIST - $TITLE"
fi