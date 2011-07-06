# Some crazy thing to make rpsec2 work 
# http://www.ruby-forum.com/topic/206187
export OMP_NUM_THREADS=4
export RUBYOPT=rubygems
export RUBYLIB=~/lib
export RSPEC=true
export RDOCOPT="-S -f html"

export PATH=$HOME/bin:$PATH
# add recursive PATH, taken from 
# http://stackoverflow.com/questions/657108/bash-recursively-adding-subdirectories-to-the-path
export PATH=$PATH:$(find -L ~/bin -type d | sed '/\/\./ d' | tr '\n' ':' | sed 's/:$//')

export PATH=$HOME/local/vim/bin:$PATH
export PATH=$HOME/local/node/bin:$PATH
export PATH=$HOME/local/mongo/bin:$PATH
export PATH=$HOME/local/couchdb/bin:$PATH
export PATH=$HOME/local/redis/bin:$PATH
export PATH=$HOME/local/erlang/bin:$PATH
export PATH=$HOME/local/imagemagick/bin:$PATH
export PATH=$HOME/local/firefox:$PATH
export PATH=$PATH:./bin:${PATH//:\.\/bin:} 

export PERL5LIB=$PERL5LIB:$PATH

# Lines configured by zsh-newuser-install
export EDITOR="vim"
export HISTFILE=~/.histfile
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt autocd 
setopt pushdignoredups
setopt autopushd
setopt rmstarsilent
setopt extended_glob
setopt extended_history
unsetopt beep

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
autoload zmv
compinit

. ~/bin/git-prompt.sh
. ~/.zaliases


#ZLS_COLORS=$LS_COLORS
# End of lines added by compinstalli
export TERM=xterm-color
PS1=$'$(prompt_git_info)%{$terminfo[bold]$fg[blue]%}:%{\e[0m%}%{$terminfo[bold]$fg[green]%}%~%{\e[0m%} $ '

export AWS_CREDENTIALS_FILE=~/aws_credentials
export AWS_CREDENTIAL_FILE=~/aws_credentials
export FOG_RC=~/secret-credentials/.fog

export JAVA_HOME=/usr/lib/jvm/java-6-sun-1.6.0.16
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib:$HOME/local/imagemagick/lib:$LD_LIBRARY_PATH

# Rails Vars
export AUTOFEATURE=true
# Configure firefox so save_and_open_path command in capybara works in launchy
export LAUNCHY_BROWSER=/usr/bin/google-chrome

# Text color variables
export txtund=$(tput sgr 0 1)     # Underline
export txtbld=$(tput bold)        # Bold
export txtred=$(tput setaf 1)     # Red
export txtgrn=$(tput setaf 2)     # Green
export txtylw=$(tput setaf 3)     # Yellow
export txtblu=$(tput setaf 4)     # Blue
export txtpur=$(tput setaf 5)     # Purple
export txtcyn=$(tput setaf 6)     # Cyan
export txtwht=$(tput setaf 7)     # White
export txtrst=$(tput sgr0)        # Text reset
export txtund=$(tput sgr 0 1)           # Underline
export txtbld=$(tput bold)              # Bold
export blink=$(tput blink)            # Blink
export bldred=${txtbld}$(tput setaf 1)  #  red
export bldblu=${txtbld}$(tput setaf 4)  #  blue
export bldwht=${txtbld}$(tput setaf 7)  #  white
export bldgrn=${txtbld}${txtgrn}
export alert=${bldgrn}
export txtrst=$(tput sgr0)              # Reset
info=${bldwht}*${txtrst}         # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}!${txtrst}

if [[ -s ~/.rvm/scripts/rvm ]] ; then 
	source ~/.rvm/scripts/rvm ; 
fi


# Shortcut to initialize rails apps with templates
function rapp {
    appname=$1
    template=$2
    rails new $appname --skip-gemfile -JTm https://github.com/sid137/rails-templates/raw/master/${template:-rails3}.rb 
}



# Utility script for geveloping ruby gems with rvm
# Kills the gemset, and starts fresh to test a gem
# installation 
function gem_build {
    # Assume that we've created a gemset with the same name as our gem
    gemname=$(basename `pwd`)
    gemset=$gemname
    version=$(cat VERSION)
    gemver=$gemname-$version.gem
    rvm gemset empty $gemset
    gem install bundler --no-ri --no-rdoc
    rake build
    echo "Installing gem $gemver..."
    gem install pkg/$gemver --no-ri --no-rdoc
}

# User sqlitebrowser to browse rails test dbs
function sqb {
    sqlitebrowser db/${1:-development}.sqlite3
}

# commit git repo and push to github
function gpm {
    message=$1
    git commit -a -m $message
    git push --all
}

function git-clean-branch {
    branch=$1
    optional_starting_point = $2
    git checkout --orphan $branch $optional_starting_point
    git rm -rf .
    echo "${alert} Empty branch ${bldwht}$1${alert} created!"
}


function rt {
    app_name=$1
    rm -rI $app_name
    rapp $app_name
    cd $app_name
    rake features
}

function create_chef_cookbook {
    rake new_cookbook COOKBOOK=$1
}

# spp hostname user
# #to copy my ssh key to login to host as user
function copy_public_ssh_key_to_host {
    host=${1:=${VPS}}
    user=$2 
    : ${user:=root}
    ssh-copy-id -i ~/.ssh/id_rsa $user@$host
}

function install_rvm {
    bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
}


src () {mv $1 $src}
base (){
  usage='Usage: base filename suffix'
  #removes extension of filename in $1
  #concatenantes $2 if provided
  if (( $# == 0 )) then;
    echo $usage
  else
    var=`echo $1 | sed "s/\([^.*]\)\.\(.*\)*$/\1/g"`
    echo ${var}${2}
  fi
}

function color-list {
    # Text color variables
    txtund=$(tput sgr 0 1)          # Underline
    txtbld=$(tput bold)             # Bold
    bldred=${txtbld}$(tput setaf 1) #  red
    bldblu=${txtbld}$(tput setaf 4) #  blue
    bldwht=${txtbld}$(tput setaf 7) #  white
    txtrst=$(tput sgr0)             # Reset
    info=${bldwht}*${txtrst}        # Feedback
    pass=${bldblu}*${txtrst}
    warn=${bldred}!${txtrst}

    echo
    echo -e "$(tput bold) reg  bld  und   tput-command-colors$(tput sgr0)"

    for i in $(seq 1 7); do
    echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
    done

    echo ' Bold            $(tput bold)'
    echo ' Underline       $(tput sgr 0 1)'
    echo ' Reset           $(tput sgr0)'
}


function column-count {
# Usage: gawk $filename
#
# Returns the number of columns in a tab-delimited file $fileename
#
# Improvements: pass options to specify the delimiter character.  Currently only
# uses the tab delimiter

    gawk 'BEGIN {FS="\t"} ; END{print NF}'
}

function find_and_replace  {
# Usage: find_and_replace $target $replacement
#
# Recursively search the files in the child directories for the target string,
# and replace the target string in place with replacement
#
# Improvements:  Could pass options to ack to improve filetypes searched

    target=$1
    replacement=$2
    ack -l $target | xargs -n 1 sed -i "s/$target/$replacement/g"
}




