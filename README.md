# Usage

## Install XCode CommandLine Tools
Exec `xcode-select --install`

## Install HomeBrew.

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Install openssl for ansible via homebrew.

```
brew install openssl
```

## Install ansible

```
python -m ensurepip
sudo pip install ansible
```

## Clone this repo and exec ansible

```
git clone https://github.com/wasabi0522/local-ansible.git
cd local-ansible
vi playbooks/localhost.yml
mkdir roles/ssh/files && cp something roles/ssh/files/
sh run.sh
```
