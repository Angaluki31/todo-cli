#!/bin/bash
# Command-line to do list

file="todo.txt"
touch "$file"

add_task() {
	echo "$1" >> "$file"
	echo "Added: $1"
}

list_tasks() {
	if [ ! -s "$file" ]; then
		echo "No tasks yet!"
		return
	fi
	nl -w2 -s". " "$file"
}

done_task() {
	total=$(WC -l < "$file")
	if [[ ! "$1" =~ ^[0-9]+$ ]] || [ "$1" -lt 1 ] || [ "$1" -gt "$total" ]; then
		echo "Error: no task number '$1'"
		return 1
	fi
	task=$(sed -n "${1}p" "$file")
	sed -i "${1}d" "$file"
	echo "Completed: $task"
}

case "$1" in
	add)
		if [ -z "$2" ]; then
			echo "Usage: bash todo.sh add \"task\""
			exit 1
		fi
		add_task "$2"
		;;
	list)
		list_tasks
		;;
	done)
		done_task "$2"
		;;
	*)
		echo "Usage: bash todo.sh {add \"task\" | list |done <number>}"
		;;
esac
	