# Official Ubuntu Repository BD Server
This script is used to replace existing repository with the official repository from Ubuntu.
### List Repository
- 18.04 ( Bionic Beaver )
- 20.04 ( Focal Fossa )
- 22.04 ( Jammy Jellyfish )
- 24.04 ( Noble Numbat )
### Usage
- Curl
```
bash <(curl -s https://raw.githubusercontent.com/sohag1192/Ubuntu-Repository-BD/refs/heads/main/repository.sh)
```
- Wget
```
bash <(wget -qO- https://raw.githubusercontent.com/sohag1192/Ubuntu-Repository-BD/refs/heads/main/repository.sh)
```
### Old Repository File
You can see your old repositories here /etc/apt/sources.list.backup or you can type this command in your ubuntu terminal to display a list of your old repositories.
```
cat /etc/apt/sources.list.backup
```
### Official Ubuntu  BD Server 

    http://mirrors.ubuntu.com/BD.txt
