#!/bin/sh

echo "System setup: Oh My WSL!"
R=$HOME/.oh-my-wsl
echo "destination: $R"
mkdir -p $R/log
mkdir -p $R/cache
mkdir -p $R/services/available
mkdir -p $R/services/enabled
mkdir -p $R/env.d
echo

echo "install service supervisor"
./bin/esh -o $R/supervisor.conf etc/supervisor.conf dest=$R user="$USER"

echo -n "install services... "
cp env.d/*.sh $R/env.d/
for i in `find ./services -name '*.conf'`; do
	b=`basename $i`
	if [ -r $R/services/available/$b ]; then continue; fi
	./bin/esh -o $R/services/available/$b $i dest=$R user="$USER" home="$HOME"
	echo -n "$b "
	# activate by hand creating symlinks
	# ln -s $R/services/available/$b $R/services/enabled/$b
done
echo

echo "install the shell init"
./bin/esh -o $R/init.sh etc/init.sh dest=$R

function addshell() {
if [ -r $HOME/$1 ]; then
	grep 'Oh My WSL' $HOME/$1 >/dev/null
	if [ $? != 0 ]; then
		cat << EOF >> $HOME/$1

# added by Oh My WSL
. $R/init.sh

EOF
	echo -n "$1"
	fi
	echo
fi
}

addshell .bashrc
addshell .zshrc

echo "Oh My WSL setup completed!"
# optional installation of packages if root
# su -c './bin/pacapt install supervisor'

