#! /bin/bash

HWNO=$1
BASE_PATH=/n/ursa/A288P/
HW_PATH=ASTR288P/homework/
class_list=(bbennett eben288p hcameron jsmiller mwa288p mwilkin sme288p dpercine jliang ktregoni mwasiak qwil288p vcar288p)

for index in ${!class_list[@]}; do
    #echo $((index+1))/${#class_list[@]} = "${class_list[index]}"
    STUDENT=${class_list[index]}
    echo "Student: " $STUDENT

    FILE_PATH=${BASE_PATH}/${STUDENT}/ASTR288P/homework
    echo "Contnts of homework dir:"
    ls $FILE_PATH
    
    SUBMIT_DIR=${HOME}/ASTR288P/homework/collected/${HWNO}/${STUDENT}
    mkdir --parents $SUBMIT_DIR
    EXTENSIONS=(sh log)
    for EXT in ${EXTENSIONS[@]}; 
    do
	FILE=${FILE_PATH}"/"${STUDENT}_hw${HWNO}.${EXT}
	
	echo "Looking for: " $FILE
	if [ -f $FILE ]; then
	    echo "File submitted! Copying..."
	    cp $FILE $SUBMIT_DIR
	else
	    echo $STUDENT "has not submitted " $FILE "yet"
	fi
    done

    echo "Looking for bonus submission."
    FILE=${FILE_PATH}"/"${STUDENT}_hw${HWNO}.tar
    if [ -f ${FILE_PATH}"/"${STUDENT}_hw${HWNO}.tar ]; then
	echo "Bonus submitted to hw dir!."
	cp ${FILE_PATH}"/"${STUDENT}_hw${HWNO}.tar $SUBMIT_DIR
    elif [ -f ${FILE_PATH}"/../"${STUDENT}_hw${HWNO}.tar ]; then
	echo "Bonus submitted to main dir."
	cp ${FILE_PATH}"/../"${STUDENT}_hw${HWNO}.tar $SUBMIT_DIR
    else 
	echo "Bonus not submitted!"
    fi
    echo 
    echo
done

