call tool/md5 s2built.bin md5
if "%md5%" equ "a460bf633579a80eebbc09d6809e1b09" (
      echo MD5 identical!
) else (
      echo MD5 does not match.
)
pause