 #!/bin/bash

userid=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
script_name=$(echo $0 | cut -d "." -f1)
logfile=/tmp/$script_name-$timestamp.log
r="\e[31m"
g="\e[32m"
y="\e[33m"
n="\e[0m"


validate(){
    if [ $1 -ne 0 ]
    then    
        echo -e "$2...$r failure $n"
        exit 1
    else
        echo -e "$2...$g success $n"
    fi

    
}

if [ $userid -ne 0 ]
then
    echo "please run this script with root access"
    exit 1
else
    echo "you are super user"
fi

dnf install mysql-server -y &>>$logfile
validate $? "installing mysql server"

systemctl enable mysqld &>>$logfile
validate $? "enabling my sql server"
 
systemctl start mysqld &>>$logfile
validate $? "starting my sql server"

mysql_secure_installation --set-root-pass expenseapp@1 &>>$logfile
validate $? "setting up root password"



