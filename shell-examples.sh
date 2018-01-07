#Asyncronous
#!/bin/bash
echo "Parent: starting......"
echo "Parent: launching child scripts..."
async-child &
pid=$!
echo "Parent: child (PID=$pid) launched."
echo "Parent: continuing..."
echo "Parent: after child launched tasks."
sleep 3
for i in {1..10};do
	echo "in for loop"
	echo $i
	sleep 1
done
echo "Parent: pausing to wait for child to finish..."
wait $pid
echo "Parent: child is finished. Continuing..."
echo "Parent: parent is done. Exiting."


# case

#!/bin/bash
#case word in
#	[pattern [| pattern]...) commands ;;]...
#esac
#case-menu:a menu driven system information program
clear
echo "
Please Select:
	1.Display System Information
	2.Display Disk Space
	3.Display Home Space Utilization
	0.Quit
"
read -p "Enter selection [0-3] >"
case $REPLY in
	0)	echo "Program terminated"
		exit
		;;&
	1)	echo "		Hostname: $HOSTNAME"
		uptime
		;;&
	2)	df -h
		;;&
	3)	if [[ $(id -u) -eq 0 ]];then
			echo "Home Space Utilization(All Users)"
			du -sh /home/*
		else
			echo "Home Space Utilization($USER)"
			du -sh $HOME
		fi
		;;&
	[[:alpha:]])	echo "is a single alphabetic character."
		;;&
	[ABC][0-9])	echo "is a A,B or C followed by a digit."
		;;&
	???)	echo "is three character long."
		;;&
	*.txt)	echo "is a word ending in '.txt'"
		;;&
	[[:upper:]])	echo "'$REPLY' is a upper case.";;&
	[[:lower:]])	echo "'$REPLY' is a lower case.";;&
	[[:digit:]])	echo "'$REPLY' is a digit.";;&
	[[:graph:]])	echo "'$REPLY' is a visible character.";;&
	[[:punct:]])	echo "'$REPLY' is a punctuation character.";;&
	[[:space:]])	echo "'$REPLY' is a whitespace character.";;&
	[[:xdigit:]])	echo "'$REPLY' is a hexadecimal digit.";;&
	*)	echo "Invalid entry" >&2
		exit 1
		;;
esac


# for
#!/bin/bash
#conventional format:
#for variable [in words];do
#	commands
#done
while [[ -n $1 ]];do 
	if [[ -r $1 ]];then
		max_word=
		max_len=0
		for i in $(strings $1);do
			len=$(echo $i |wc -c)
			if (( len > max_len ));then
				max_len=$len
				max_word=$i
			fi
		done
		echo "$1: '$max_word' ($max_len characters)"
	fi
	shift
done

# for 2
#!/bin/bash
# for loop without [in word]
for i; do
	if [[ -r $i ]];then
		max_word=
		max_len=0
		for j in $(strings $i);do
			len=$(echo $j |wc -c)
			if (( len > max_len ));then
				max_len=$len
				max_word=$j
			fi
		done
		echo "$i: '$max_word' ($max_len characters)"
	fi
done


# hours
#!/bin/bash
#hours:script to count files by modification time
usage(){
	echo "usage: $(basename $0) directory" >&2
}
#check that argument is a directory
if [[ ! -d $1 ]];then
	usage
	exit 1
fi
#Initialize array
for i in {0..23};do hours[i]=0;done
#Collect data
for i in $(stat -c %y "$1"/* |cut -c 12-13);do
	j=${i/#0}
	((++hours[j]))
	((++count))
done
#Display data
echo -e "Hour\tFiles\tHour\Files"
echo -e "----\t-----\t----\t-----"
for i in {0..11};do
	j=$((i+12))
	printf "%02d\t%d\t%02d\t%d\n" $i ${hours[i]} $j ${hours[j]}
done
printf "\nTotal files = %d\n" $count


# if 
#!/bin/bash
#input1=$1
#input2=$2
#input3=$3
#input4=$4
#I_got=5
#echo "your input is $@"
#if [ "$input1" = 5 ];then
#	echo "input1 equals $I_got"
#elif [ "$input2" = 5 ];then
#	echo "input2 equals $I_got"
#elif [ "$input3" = 5 ];then
#	echo "input3 equals $I_got"
#elif [ "$input4" = 5 ];then
#	echo "input4 equals $I_got"
#fi
echo '$#:'"$#"
echo '$0:'"$0"
echo '$1:'"$1"
echo '$@:'"$@"
echo '$*:'"$*"
echo '$$:'"$$"
echo '$?:'"$?"
#follows are test expression:
#file1 -ef file2 file1 has the same inode number as file2
#file1 -nt file2 file1 is newer than file2
#file1 -ot file2 file2 is newer than file1
#-b file exists and is block file
#-c file exists and is character file
#-d file exists and is a directory
#-e file file exists.
#-f file exists and is regular file
#-g file exists and is set-group-ID
#-G file exists and is owned by the effective group ID
#-k file exists and has its sticky bit set.
#-L file exists and is a symbolic link
#-O file exists and is owned by the effective user ID
#-p file eixsts and is a named pipe
#-r file exists and is readable(has readable permission for the effective user)
#-s file exists and has length greater than zero.
#-S file exists and is a network socket.
#-t fd  fd is a file descriptor directed to/from the terminal.This can be userd\
#	to determine whether standard input/output/error is being redirected.
#-u file exists and is setuid
#-w file exists and is writable(has writable permission for the effective user)
#-x file exists and is executable(has executable/search permission for the effective user)

#Test file :evaluate the status of a file
FILE=~/.bashrc
if [ -e "$FILE" ];then
	if [ -f "$FILE" ];then
		echo "$FILE is a regular file."
	fi
	if [ -d "$FILE" ];then
		echo "$FILE is a directory."
	fi
	if [ -r "$FILE" ];then
		echo "$FILE is readable."
	fi
	if [ -w "$FILE" ];then
		echo "$FILE is writable."
	fi
	if [ -x "$FILE" ];then
		echo "$FILE is executable/searchable."
	fi
else
	echo "$FILE does not exist."
	exit 1
fi
#we can mutate it into a function
Test_file() {
	#Test file :evaluate the status of a file
	FILE=~/.bashrc
	if [ -e "$FILE" ];then
		if [ -f "$FILE" ];then
			echo "$FILE is a regular file."
		fi
		if [ -d "$FILE" ];then
			echo "$FILE is a directory."
		fi
		if [ -r "$FILE" ];then
			echo "$FILE is readable."
		fi
		if [ -w "$FILE" ];then
			echo "$FILE is writable."
		fi
		if [ -x "$FILE" ];then
			echo "$FILE is executable/searchable."
		fi
	else
		echo "$FILE does not exist."
		return 1 #here we use return instead of exit.
	fi
}
echo "below is test_file() function's output"
Test_file
echo "test_file function executed."

#the expression of string
#string string is not null
#-n string length of string is greater than zero
#-z string length of string is zero
#string1 = string2 
#string1 == string2 string1 and string2 are equal.Single or double equal signs mybe used ,but use of double equal signs is greatly preferred.
#string1 != string2 string1 and string2 are not equal.
#string1 > string2 string1 sorts after string2
#string1 < string2 string1 sorts before string2
# note that < > expression operators must be quoted in case that the shell might interpret them into redirection.

#test-string: evaluate the value of a string.
ANSWER=maybe
if [ -z "$ANSWER" ];then
	echo "There is no answer." >&2
	exit 1
fi
if [ "$ANSWER" = "yes" ];then
	echo "The answer is YES."
elif [ "$ANSWER" = "no" ];then
	echo "The answer is NO."
elif [ "$ANSWER" = "maybe" ];then
	echo "The answer is MAYBE."
else
	echo "The answer is UNKNOWN."
fi

#integer expression
#int1 -eq int2 int1 is equal to int2
#int1 -ne int2 int1 is not equal to int2
#int1 -le int2 int1 is less than or equal to int2
#int1 -lt int2 int1 is less than int2
#int1 -ge int2 int1 is greater than or equal to int2
#int1 -gt int2 int1 is greater than int2

#test-integer evaluate the value of an integer.
INT=-5
if [ -z "$INT" ];then
	echo "INT is empty." >&2
	exit 1
fi
if [ $INT -eq 0 ];then
	echo "INT is zero."
else
	if [ $INT -lt 0 ];then
		echo "INT is negative."
	else
		echo "INT is positive."
	fi
	if [ $((INT % 2)) -eq 0 ];then
		echo "INT is even."
	else
		echo "INT is odd."
	fi
fi
#recent version of test use : [[expression]]
#add one important expression: 
#string1 =~ regex
#it returns true if string1 match the extended RE regex.
#now let's improve the integer script.

INT=5
if [[ "$INT" =~ ^-?[0-9]+$ ]];then # [[: not found error,not clear.
	if [ $INT -eq 0 ];then
		echo "INT is zero."
	else
		if [ $INT -lt 0 ];then
			echo "INT is negative."
		else
			echo "INT is positive."
		fi
		if [ $((INT % 2)) -eq 0 ];then
			echo "INT is even."
		else
			echo "INT is odd."
		fi
	fi
else
	echo "INT is not an integer." >&2
fi

# == operator supports pattern matching.
FILE=foo.jar
if [[ "$FILE" == foo.* ]];then 
	echo "$FILE matches pattern 'foo.*'" 
fi
#(()) used for evaluating arithmatic truth.
IN=-5
if [[ "$IN" =~ ^-?[0-9]+$ ]];then
	if ((IN ==0));then
		echo "INT is zero."
	else
		if ((IN < 0));then
			echo "$IN is negative."
		else
			echo "$IN is positive."
		fi
		if (( $((IN % 2)) == 0 ));then
			echo "$IN is even."
		else
			echo "$IN is odd."
		fi
	fi
else
	echo "IN is not an integer." >&2
fi

#read from standard input
echo -n "Please enter an integer -> "
read int
if [[ "$int" =~ ^-?[0-9]+$ ]];then
	if [ $int -eq 0 ];then
		echo "$int is zero."
	else
		if [ $int -lt 0 ];then
			echo "$int is negative."
		else
			echo "$int is positive."
		fi
		if [ $((int %2 )) -eq 0 ];then
			echo "$int is even."
		else
			echo "$int is odd."
		fi
	fi
else
	echo "Input value is not an integer." >&2
fi


# IFS
#!/bin/bash
#read-ifs:read fields from a file
FILE=/etc/passwd
read -p "Enter a user name > " user_name
file_info=$(grep "^$user_name:" $FILE)
if [ -n "$file_info" ];then
	IFS=":" read user pw uid gid name home shell <<< "$file_info"
	cat <<- EOF
	User = $user
	UID = $uid
	GID = $gid
	Full Name = $name
	Home Dir = $home
	shell = $shell
	EOF
else
	echo "No such user '$user_name' " >&2
fi

# interactive mode
#!/bin/bash
#interactive mode
if [[ -n $interactive ]];then
	while true;do
		read -p "Enter name of output file:" filename
		if [[ -e $filename ]];then
			read -p "'$filename' exists. Overwrite?[y/n/q] >"
			case $REPLY in
			Y|y)	break
					;;
			Q|q)	echo "Program terminated."
					exit
					;;
			*)		continue
					;;
			esac
		elif [[ -z $filename ]];then
			continue
		else
			break
		fi
	done
fi

# menu

#!/bin/bash
#read-menu: a menu driven system information program
clear
echo "
please select:

	1.Display System Information
	2.Display Disk Space
	3.DIsplay Home Space Utilization
	0.Quit
"
read -p "Enter selection [0-3] >"
if [[ "$REPLY" =~ ^[0-3]$ ]];then
	if [[ "$REPLY" == 0 ]];then
		echo "Program terminated."
		exit
	fi
	if [[ "$REPLY" == 1 ]];then
		echo "Hostname: $HOSTNAME"
		uptime
		exit
	fi
	if [[ "$REPLY" == 2 ]];then
		df -h
		exit
	fi
	if [[ "$REPLY" == 3 ]];then
		if [[ $(id -u) -eq 0 ]];then
			echo "Home Space Utilization(All Users)"
			du -sh /home/*
		else
			echo "Home Space Utilization($USER)"
			du -sh $HOME
		fi
		exit
	fi
else
	echo "Invalid entry." >&2
	exit 1
fi

# modulo
#!/bin/bash
for ((i=1;i<=200;i++));do
	rem=$((i % 5))
	if [[ $rem == 0 ]];then
		printf "<%d>" $i
	else
		printf "%d" $i
	fi
done
printf "\n"

# read
#!/bin/bash
echo -n "Enter on or more values > "
read var1 var2 var3 var4 var5
cat <<- EOF
var1 = $var1
var2 = $var2
var3 = $var3
var4 = $var4
var5 = $var5
EOF
#read-secret:input a secret pass phrase
if read -t 10 -sp "Enter secret pass phrase > " secret_pass;then
	echo -e "\nSecret pass phrase = '$secret_pass'"
else
	echo -e "\nInput timed out" >&2
fi


# readfile
#!/bin/bash
#while-read2: read lines from a file
sort -k 2n dis |while read dis version release;do
	printf "Distro: %s\tVersion: %s\tReleased: %s\n" \
		$dis \
		$version \
		$release
done

# position parameters
#!/bin/bash
#positioin-parameters: script to demonstrate $* and $@
print_params() {
	echo "\$1 = $1"
	echo "\$2 = $2"
	echo "\$3 = $3"
	echo "\$4 = $4"
}
pass_params(){
	echo -e "\n" '$* :'; print_params $*
	echo -e "\n" '"$*" :'; print_params "$*"
	echo -e "\n" '$@ :'; print_params $@
	echo -e "\n" '"$@" :'; print_params "$@"
}
pass_params "word" "words with spaces"

# report 
#!/bin/bash
#report_home_space()
report_home_space(){
	local format="%8s%10s%10s\n"
	local i dir_list total_files total_dirs total_size user_name
	if [[ $(id -u) -eq 0 ]];then
		dir_list=/home/*
		user_name="All Users"
	else
		dir_list=$HOME
		user_name=$USER
	fi
	echo "<H2>Home Space Utilization ($user_name)</H2>"
	for i in $dir_list;do
		total_files=$(find $i -type f |wc -l)
		total_dirs=$(find $i -type d |wc -l)
		total_size=$(du -sh $i | cut -f 1)
		echo "<H3>$i</H3>"
		echo "<PRE>"
		printf "$format" "Dirs" "Files" "Size"
		printf "$format" "----" "-----" "----"
		printf "$format" $total_dirs $total_files $total_size
		echo "</PRE>"
	done
	return
}
report_home_space


# shift
#!/bin/bash
#posit-param2: script to display all arguments
count=1
echo "\$#:"$#
echo "\"\$*\":""$*"
echo "\$*:"$*
echo "\$@:"$@
echo "\"\$@:\"""$@"
while [[ $# -gt 0 ]];do
	echo "Argument $count = $1"
	count=$((count + 1))
	shift
done

# sys_info (html)
#!/bin/bash
#Version 1.0
#sys_info_page:program to output a system information page
PROGRAME=$(basename $0)
TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %Z")
TIMESTAMP="Generated $CUTTENT_TIME,by $USER"
report_uptime(){
	cat <<- EOF
		<H2>System Uptime</H2>
		<PRE>$(uptime)</PRE>
	EOF
	return
}
report_disk_space(){
	cat <<- EOF
		<H2>Disk Space Utilization</H2>
		<PRE>$(df -h)</PRE>
	EOF
	return
}
report_home_space(){
	if [[ $(id -u) -eq 0 ]];then
		cat <<- EOF
			<H2>Home Space Utilization(ALL USERS)</H2>
			<PRE>$(du -sh /home/*)</PRE>
		EOF
	else
		cat <<- EOF
			<H2>Home Space Utilization($USER)</H2>
			<PRE>$(du -sh $HOME)</PRE>
		EOF
	fi
	return
}
usage(){
	echo "$PROGNAME: usage: $PROGNAME [ -f file | -i]"
	return
}
#process command line options
interactive=
filename=
while [[ -n $1 ]];do
	case $1 in
	-f | --file)	shift
					filename=$1
					;;
	-i | --interactive)	interactive=1
					;;
	-h | --help)	usage
					exit
					;;
	*)				usage >&2
					exit 1
					;;
	esac
	shift
done

if [[ -n $interactive ]];then
	while true;do
		read -p "Enter name of output file:" filename
		if [[ -e $filename ]];then
			read -p "'$filename' exists. Overwrite?[y/n/q] >"
			case $REPLY in
			Y|y)	break
					;;
			Q|q)	echo "Program terminated."
					exit
					;;
			*)		continue
					;;
			esac
		elif [[ -z $filename ]];then
			continue
		else
			break
		fi
	done
fi
#write_html_page
write_html_page(){
	cat <<- _EOF_
		<HTML>
			<HEAD>
				<TITLE>$TITLE</TITLE>
			</HEAD>
			<BODY>
				<H1>$TITLE</H1>
				<P>$TIMESTAMP</P>
				$(report_uptime)
				$(report_disk_space)
				$(report_home_space)
			</BODY>
		</HTML>
	_EOF_
}
#output html page
if [[ -n $filename ]];then
	if touch $filename && [[ -f $filename ]];then
		write_html_page > $filename
	else
		echo "$PROGNAME: Cannot write file '$filename'"
		exit 1
	fi
else
	write_html_page
fi


# until
#!/bin/bash
#until-count:display a seires of numbers
count=1
until [ $count -gt 5 ];do
	echo $count
	count=$((count + 1))
done
echo "Finished."


# validate
#!/bin/bash
#read-validate: validate input
invalid_input() {
	echo "Invalid input '$REPLY'" >&2
	exit 1
}
read -p "Enter a single item >"
#input is empty (invalid)
[[ -z $REPLY ]] && invalid_input
#input is multiple items(invalid)
(( $(echo $REPLY |wc -w) > 1 )) && invalid_input
#is input a valid filename?
if [[ $REPLY =~ ^[-[:alnum:]\._]+$ ]];then
	echo "'$REPLY' is a valid filename."
	if [[ -e $REPLY ]];then
		echo "And file '$REPLY' exists."
	else
		echo "However,file '$REPLY' does not exist."
	fi
	#is input a floating point number?
	if [[ $REPLY =~ ^-?[[:digit:]]*\.[[:digit:]]+$ ]];then
		echo "'$REPLY' is a floating point number."
	else
		echo "'$REPLY' is not a floating point number."
	fi
	if [[ $REPLY =~ ^-?[[:digit:]]+$ ]];then
		echo "'$REPLY' is an integer."
	else
		echo "'$REPLY' is not an integer."
	fi
else
	echo "The string '$REPLY' is not a valid filename."
fi


# while
#!/bin/bash
#while-count : display a series of numbers;
count=1
while [ $count -le 5 ];do
	echo $count
	count=$((count + 1))
done
echo "Finished."
#while-menu:a menu driven system information program
DE=3 #Number of seconds to display results
while [[ $REPLY != 0 ]];do
	clear
	cat <<- _EOF_
			Please Select:
			1.Display System Information
			2.Display Disk Space
			3.Display Home Space Utilization
			0.Quit
	_EOF_
	read -p "Enter selection [0-3] >"
	if [[ $REPLY =~ ^[0-3]$ ]];then
		if [[ $REPLY == 1 ]];then
			echo "Hostname:$HOSTNAME"
			uptime
			sleep $DE
			continue
		fi
		if [[ $REPLY == 2 ]];then
			df -h
			sleep $DE
			continue
		fi
		if [[ $REPLY == 3 ]];then
			if [[ $(id -u) -eq 0 ]];then
				echo "Home Space Utilization(All Users)"
				du -sh /home/*
			else
				echo "Home Space Utilization($USER)"
				du -sh $HOME
			fi
		sleep $DE
		continue
		fi
		else
			echo "Invalid entry."
			sleep $DE
			continue
		fi
done
echo "Program terminated."

