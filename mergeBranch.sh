ALL_BRANCHES=`git ls-remote . | cut -d $'\t' -f 2` # THIS WILL INCLUDE THE FOLDER AS PREFIX

string1="/refs/remotes/origin"
string2="heads"
string3="HEAD"
IFS=, read -a patterns <<< "$string1"
$INCLUDE_PATTERN
#for pattern in "${patterns[@]}"; do
  #includePattern+=" -e $REMOTE_FOLDER$pattern"
 # includePattern+=" -e $pattern"
#done

#branches=`echo "$ALL_BRANCHES" | eval "grep -P $includePattern"`
branches=`echo "$ALL_BRANCHES" | eval "grep -Pvw $string3" | eval "grep -Pvw $string2" | eval "grep -Pvw $string1"`
#branches=`echo "$ALL_BRANCHES" | eval "grep -Pvw $string1"`
#branches=`echo "$ALL_BRANCHES" | eval "grep $includePattern" | cut -d $'\t' -f 2 | cut -d $'/' -f 4`
#echo "B = $branches"
#echo $branches
#echo "C = git merge -q --no-edit $branches"

#git merge -q --no-edit $branches
#git checkout $branches

read -a arr <<<$branches

for childBranch in ${arr[@]}; do
 #echo
 echo "1 " $childBranch
 git remote update
 git fetch
 git checkout $childBranch
 git merge -v --no-edit origin/master
done

