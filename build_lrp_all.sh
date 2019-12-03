#cd ..

export LRP=$PWD
echo $LRP
#source "export LRP="$PWD""
mkdir software
cd software


#Open MPI
#curl "https://download.open-mpi.org/release/open-mpi/v3.0/openmpi-3.0.0.tar.gz"  --output openmpi-3.0.0.tar.gz
wget "https://download.open-mpi.org/release/open-mpi/v3.0/openmpi-3.0.0.tar.gz"

tar -xvf openmpi-3.0.0.tar.gz
cd openmpi-3.0.0
./configure --prefix=${LRP}/software/ompi --enable-mpi-thread-multiple

make all install

#Make sure that libmpi.so exists

cd ..

#Pin
#curl "https://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-71313-gcc.4.4.7-linux.tar.gz" --output pin-2.14-71313-gcc.4.4.7-linux
wget "https://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-71313-gcc.4.4.7-linux.tar.gz"
tar -xvf pin-2.14-71313-gcc.4.4.7-linux.tar.gz
cd ..

#Libxml2
$FILE="/usr/include/libxml2"
if [ -d "$FILE" ]; then
    echo "$FILE Path (libxml2) exist"

else
	echo -n "Do you want to install Libxml2 (y/n)? "
	read answer
	answer="Y"
		if [ "$answer" != "${answer#[Yy]}" ] ;then
	    		echo Yes
	    		sudo apt-get install libxml2-dev
		else
	   		echo No		 
		fi
fi

#sudo apt-get install libxml2-dev

git clone https://github.com/dananjayamahesh/primesim.git
cd primesim
git checkout dimp

#Make sure all the paths are correct
#########################################################
source env.sh
#########################################################
source env.sh

#Please check your libxml2
echo "Building Prime and LRP"
make -B
echo "Building Prime and LRP Finished"
echo "Building Benchmarks"

export PBENCH_PATH="$LRP/pbench/syncbench"
pbench_path=pbench/syncbench
cd pbench/syncbench
make -B
cd ../..
echo "Finished Building Benchmarks: PBench"
echo "Build-Complete"
echo "If no errors You are ready to run the experiments. See README.md inside primesim"
#RUN a simple test
#sh run_all.sh simple-test
