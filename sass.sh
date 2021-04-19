#by aoliadi
#! /usr/bin/bash

mainSassContent='
    @import "./global/normalize/import-now";\n\n@import "./project/base/reset";\n@import "./project/base/typography";\n@import "./project/base/color";\n\n@import "./project/utils/variables";\n@import "./project/utils/mixins";\n@import "./project/utils/placeholders";\n@import "./project/utils/functions";\n\n@import "./project/components/anchor-tags";\n@import "./project/components/buttons";\n\n@import "./project/pages/homepage/home";
'

createFile() {
    touch $1;
}

createFolder() {
    mkdir $1;
}

enterFolder() {
    cd $1;
}
#check if folder exists

collectFolderName() {
    echo "what would you like to name the folder?";
    read FOLDER_NAME;
    doesItExist "$FOLDER_NAME";
}

doesItExist() {
    if [[ -d "$1" || -f "$1" ]]
    then
        echo -e "Another folder with the same name exists.\nPlease, input another name"
        read NEW_FOLDER_NAME
        doesItExist "$NEW_FOLDER_NAME"
    else
        createRootFolder $1
    fi
}

# create the folder
createRootFolder() {
    createFolder $1

    goIntoRootFolder $1
}

goIntoRootFolder() {
    enterFolder $1

    createMainSassFile
    createTheOtherFolders
}

createMainSassFile() {
    createFile main.scss

    echo -e $mainSassContent  >> main.scss
}

createTheOtherFolders() {
    globalFolder
    cd ..
    projectFolder
}

globalFolder() {
    createFolder global
    enterFolder global
    # npm install normalize
}

directories=( base components layout pages utils vendors )
base=( reset typography color )
components=( buttons links )
pages=( homepage about )
utils=( functions mixins placeholders variables )

projectFolder() {
    createFolder project
    enterFolder project

    # array=( base components layout pages utils vendors )
    for dir in "${directories[@]}"
    # for dir in "${array[@]}"
    do
        createFolder $dir
        enterFolder $dir
        # getChildrenArray $dir
        createChildrenFiles $dir
        # createChildrenFiles ${array[$dir]}
    done
}

createChildrenFiles() {
    ARRAY_NAME=$1

    if [[ $ARRAY_NAME = "pages" ]]
    then
        for folder in "${ARRAY_NAME[@]}"
        do
            createFolder "${folder}"
        done
    else
        for folder in "${ARRAY_NAME[@]}"
        do
            createFile "_${folder}.scss"
        done
    fi

    cd ..
}

collectFolderName