
if [ -d "lattice" ]
then
cd lattice
git pull
else
git clone https://github.com/hailongz/php.git lattice
cd lattice
fi

if [ -d "lattice" ]
then
cd lattice
git pull
else
git clone https://github.com/hailongz/lattice.git lattice
fi


