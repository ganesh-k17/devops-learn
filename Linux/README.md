# Linux Basics

* Lunux CLI
* VI Editor
* Package Management
* Service Management

## Shell types

* Bourne Shell (Sh shell) - oldest shell
* C Shell (csh or tcsh)
* Z Shell (zsh)
* Bourne again Shell (bash) - supports many advanced operations like math.

echo $SHELL

## Basic commands

```sh
echo Hi
>> Hi

ls
>> File.txt my_dir1 file2.conf

cd my_dir1

pwd
/home/my_dir1

mkdir new_directory

cd new_directory;mkedir www; pwd
>> /home/my_dir1/new_directory

# Make directory Hierarcy (normal method) (tmp/asia/india/bangalore)

mkdir /tmp/asia
mkdir /tmp/asia/india
mkdir /tmp/asia/india/bangalore

# better method

mkdir -p /tmp/asia/india/bangalore

rm -r /tmp/my_dir1

cp -r my_dir1 /tmp/my_dir1

# files commands

touch new_file.txt

cat > new_file.txt  # adding conennts
>> This is some sample contents [cntrl+D]

cat new_file.txt # view the file content

cp new_file.txt copy_file.txt

mv new_file.txt sample_file.txt # renaming of file is moving a file within a same directory with a different name

rm new_file.txt
```




