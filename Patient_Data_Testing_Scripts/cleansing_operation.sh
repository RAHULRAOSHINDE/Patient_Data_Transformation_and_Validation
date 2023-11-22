# unix command to perform cleansing operation by removing all the delimiters except ":" 
#Approach to perform cleansing operation 

#Display the contents of the file 
#Remove the consecutive spaces into a single space
#Replace the single space into colon
#Replace the consecutive colons into a single colon
#sort the lines in text file and remove duplicate files
#remove the remaining duplicates from the sorted input
#redirect the output to a new file

cat /root/Desktop/user_repo/To_Participant/AdditionalSuppliedFiles/patient_initial.txt|tr -s " "|tr " " ":"|tr -s ":"|sort -u|uniq > /root/Desktop/patient.txt