
if [ -d "lattice" ]
then
cd books
git pull
cd ..
else
git clone https://github.com/hailongz/php.git lattice
fi

if [ -d "lattice/org.hailong.configs" ]
then
svn update lattice/org.hailong.configs
else
svn checkout http://svn.hailong.org:8082/Projects/hailong/books/trunk/php/org.hailong.configs books/org.hailong.configs
fi

if [ -d "lattice/com.9vteam.lattice" ]
then
svn update books/com.9vteam.books
else
svn checkout http://svn.hailong.org:8082/Projects/hailong/books/trunk/php/com.9vteam.books books/com.9vteam.books
fi


