# array=( base components layout pages utils vendors ); 
# value='utils';

# for i in "${!array[@]}"; 
# do 
#     if [[ "${array[$i]}" = "${value}" ]]
#     then 
#         echo "${i}"; 
#     fi 
# done


# declare -A myArray; 
# myArray=( [red]=1 [blue]=2 ); 

# echo ${myArray['blue']}


declare -A myArray; 
myArray=( [red]=1 [blue]=2 ); 
# myArray=( red blue ); 
for item in "${!myArray[@]}"; 
do 
    echo $item
done
# echo ${myArray['blue']}