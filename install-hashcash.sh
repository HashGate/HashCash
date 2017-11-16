#!/bin/bash
#This script will install HashCash with all of it's requirements.

#Installing general requirements
if [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.04 ]] ; then
	sudo apt-get -y install python-software-properties
	sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
	sudo apt-get update
	sudo apt-get -y install gcc-4.8 g++-4.8 rlwrap git cmake build-essential libunbound-dev
	
elif [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.10 ]] ; then
	sudo apt-get -y install python-software-properties
	sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
	sudo apt-get update
    sudo apt-get -y install build-essential python-dev gcc-4.9 g++-4.9 git cmake librocksdb-dev
    

elif [[$VERSION=8 && $ID=debian]] ; then
	apt-get -y install python-software-properties
	add-apt-repository -y ppa:ubuntu-toolchain-r/test
	apt-get update
	apt-get -y install gcc-4.8 g++-4.8 rlwrap git cmake build-essential libunbound-dev

else
    echo "Only Ubuntu 16.04, Ubuntu 16.10 and Debian 8 are supported (actually)"
	
fi	

cd ~
clear
echo "This is the HashCash installation script. It will install HashCash with all it's requirements, starting with the latest boost-version, plus CPUMiner"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "[1] INSTALL HashCash essentials (wallet + solominer)"
echo "[2] INSTALL Wolf's poolminer"
echo "[3] INSTALL Everything"
echo "[6] UPDATE  HashCash essentials (wallet + solominer)"
echo "[7] UPDATE  Wolf's poolminer"
echo "[8] UPDATE  Everything"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

#Cases
read NUM

########################	
#Boost 1.55 Installation 
########################

if [[ $NUM == "1" || $NUM == "3" ]]; then

	echo "You are about to install Boost 1.55."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "Do you want to install it from the repositories or let the scipt do an automated manual build? Installation over repositories (recommended)	[y/n]? Saying no will do an automated full build."
	read a	
	if [[ $a == "Y" || $a == "y" ]]; then
		
		#Adding PPA and installing boost
		if [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.04 ]] ; then
			#Adding PPA and installing boost
			sudo add-apt-repository -y ppa:boost-latest/ppa
			sudo apt-get update
			sudo apt-get -y install libboost1.55-all-dev
			
		elif [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.10 ]] ; then
			sudo add-apt-repository -y ppa:boost-latest/ppa
			sudo apt-get update
			sudo apt-get -y install libboost1.61-all-dev
			
		elif [[$VERSION=8 && $ID=debian]] ; then
		# simple search to get and grab the files required
			apt-get update
			apt-get -y install python-dev autotools-dev libicu-dev build-essential libbz2-dev 
		#Downloading boost. Change Link if you want a different version
			echo "Downloading boost"
			cd ~
			wget -O boost_1_55_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download
		#Extracting boost
			echo "Extracting boost"
			tar xzvf boost_1_55_0.tar.gz
			cd boost_1_55_0/
		# boost's bootsrap setup
			./bootstrap.sh --prefix=/usr/local
		# If we want MPI then we need to set the flag in the user-config.jam file
			user_configFile=`find $PWD -name user-config.jam`
			echo "using mpi ;" >> $user_configFile
		# Find the number of available hardware threads
			n=$(nproc)

		# Install boost in parallel
			if [$n !== 1]
			then
				$n = $n / 2
				./b2 --with=all -j $n install 
			else 
				./b2 --with=all install
			fi
		fi
	else	
	
	if [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.04 ]] ; then
		# simple search to get and grab the files required
		sudo apt-get update
		sudo apt-get -y install python-dev autotools-dev libicu-dev build-essential libbz2-dev 

		#Downloading boost. Change Link if you want a different version
		echo "Downloading boost"
		cd ~
		wget -O boost_1_55_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download
	
		#Extracting boost
		echo "Extracting boost"
		tar xzvf boost_1_55_0.tar.gz
		cd boost_1_55_0/
	
		# boost's bootsrap setup
		./bootstrap.sh --prefix=/usr/local
    
		# If we want MPI then we need to set the flag in the user-config.jam file
		user_configFile=`find $PWD -name user-config.jam`
		echo "using mpi ;" >> $user_configFile
    
		# Find the number of available hardware threads
		n=$(nproc)

		# Install boost in parallel
		if [$n !== 1]
		then
			$n = $n / 2
			sudo ./b2 --with=all -j $n install 
		else 
			sudo ./b2 --with=all install
		fi
		# Reset the ldconfig, assumes you have /usr/local/lib setup already. Else you can add it to your LD_LIBRARY_PATH, running this anyway
		# will not hurt.
		sudo ldconfig  
		echo "Boost installation complete."
	elif [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.10 ]] ; then
		# simple search to get and grab the files required
		sudo apt-get update
		sudo apt-get -y install python-dev autotools-dev libicu-dev build-essential libbz2-dev 

		#Downloading boost. Change Link if you want a different version
		echo "Downloading boost"
		cd ~
		wget -O boost_1_61_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz/download
	
		#Extracting boost
		echo "Extracting boost"
		tar xzvf boost_1_61_0.tar.gz
		cd boost_1_61_0/
	
		# boost's bootsrap setup
		./bootstrap.sh --prefix=/usr/local
    
		# If we want MPI then we need to set the flag in the user-config.jam file
		user_configFile=`find $PWD -name user-config.jam`
		echo "using mpi ;" >> $user_configFile
    
		# Find the number of available hardware threads
		n=$(nproc)

		# Install boost in parallel
		if [$n !== 1]
		then
			$n = $n / 2
			sudo ./b2 --with=all -j $n install 
		else 
			sudo ./b2 --with=all install
		fi
		# Reset the ldconfig, assumes you have /usr/local/lib setup already. Else you can add it to your LD_LIBRARY_PATH, running this anyway
		# will not hurt.
		sudo ldconfig  
		echo "Boost installation complete."
	elif [[$VERSION=8 && $ID=debian]] ; then
		# simple search to get and grab the files required
			apt-get update
			apt-get -y install python-dev autotools-dev libicu-dev build-essential libbz2-dev 
		#Downloading boost. Change Link if you want a different version
			echo "Downloading boost"
			cd ~
			wget -O boost_1_55_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download
		#Extracting boost
			echo "Extracting boost"
			tar xzvf boost_1_55_0.tar.gz
			cd boost_1_55_0/
		# boost's bootsrap setup
			./bootstrap.sh --prefix=/usr/local
		# If we want MPI then we need to set the flag in the user-config.jam file
			user_configFile=`find $PWD -name user-config.jam`
			echo "using mpi ;" >> $user_configFile
		# Find the number of available hardware threads
			n=$(nproc)

		# Install boost in parallel
			if [$n !== 1]
			then
				$n = $n / 2
				./b2 --with=all -j $n install 
			else 
				./b2 --with=all install
			fi	
	fi
fi

############################################################
#Installation of HashCash and other requirements besides boost
############################################################


if [[ $NUM == "1" || $NUM == "3" || $NUM == "6" || $NUM == "8" ]]; then

	echo "You are about to install the HashCash essentials. If you want to configure it, read this script first. Do you wish to continue	[y/n]?"

	cd ~
	
	if [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.04 ]] ; then
		#relinking symlinks for gcc and g++
		sudo cp /usr/bin/gcc /usr/bin/gcc.oldsymlink
		sudo rm /usr/bin/gcc
		sudo ln -s /usr/bin/gcc-4.8 /usr/bin/gcc

		sudo cp /usr/bin/g++ /usr/bin/g++.oldsymlink
		sudo rm /usr/bin/g++
		sudo ln -s /usr/bin/g++-4.8 /usr/bin/g++
	elif [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.10 ]] ; then
		#relinking symlinks for gcc and g++
		sudo cp /usr/bin/gcc /usr/bin/gcc.oldsymlink
		sudo rm /usr/bin/gcc
		sudo ln -s /usr/bin/gcc-4.9 /usr/bin/gcc

		sudo cp /usr/bin/g++ /usr/bin/g++.oldsymlink
		sudo rm /usr/bin/g++
		sudo ln -s /usr/bin/g++-4.9 /usr/bin/g++
	elif [[$VERSION=8 && $ID=debian]] ; then
		cp /usr/bin/gcc /usr/bin/gcc.oldsymlink
		rm /usr/bin/gcc
		ln -s /usr/bin/gcc-4.8 /usr/bin/gcc

		cp /usr/bin/g++ /usr/bin/g++.oldsymlink
		rm /usr/bin/g++
		ln -s /usr/bin/g++-4.8 /usr/bin/g++
	fi
	
	

	#Cloning github project 
	echo "Downloading HashCash essentials"
	if [[ $NUM == "6" || $NUM == "8" ]]; then
		cd ~/hashcash/ 
		git pull
	else
		cd ~
		git clone git://github.com/HashGate/HashCash.git
	fi
	
	# Find the number of available hardware threads
    n=$(nproc)
	
	#Setting compilation update
	cd ./hashcash
	mkdir ./build
	
	#Decision to compile tests
	echo "Do you want to compile tests too? This subdirectory is related to not yet implemented features, which need further testing. 
		Not installing it will significantly speed up your compilation time. Do you want to install it	[y/n]?"
	if [[ $a == "Y" || $a == "y" ]]; then
       sed -i '/^add_subdirectory(tests)$/d' CMakeLists.txt
	fi
	
	#Building with maximum number of cores
	if [$n !== 1] 
	then
		$n = $n / 2
		make -j $n
	else
		make
	fi
	
	if [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.04 ]] ; then
		#linking symlinks back to old gcc/g++ versions
		sudo rm /usr/bin/gcc
		sudo cp /usr/bin/gcc.oldsymlink /usr/bin/gcc
		sudo rm /usr/bin/gcc.oldsymlink
		
		sudo rm /usr/bin/g++
		sudo cp /usr/bin/g++.oldsymlink /usr/bin/g++
		sudo rm /usr/bin/g++.oldsymlink
	elif [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.10 ]] ; then
		#linking symlinks back to old gcc/g++ versions
		sudo rm /usr/bin/gcc
		sudo cp /usr/bin/gcc.oldsymlink /usr/bin/gcc
		sudo rm /usr/bin/gcc.oldsymlink
		
		sudo rm /usr/bin/g++
		sudo cp /usr/bin/g++.oldsymlink /usr/bin/g++
		sudo rm /usr/bin/g++.oldsymlink

	elif [[$VERSION=8 && $ID=debian]] ; then
		#linking symlinks back to old gcc/g++ versions
		rm /usr/bin/gcc
		cp /usr/bin/gcc.oldsymlink /usr/bin/gcc
		rm /usr/bin/gcc.oldsymlink
		
		rm /usr/bin/g++
		cp /usr/bin/g++.oldsymlink /usr/bin/g++
		rm /usr/bin/g++.oldsymlink
	fi

	
	
	
	
	echo "HashCash installation complete"
	
	##############################
	#Downloading latest blockchain	
	##############################
	
	cd ~
	echo "Do you want to download the latest blockchain (atm only 64bit. 64bit and 32bit are not compatible)	[y/n]?"
	read x
		if [[ $x == "N" || $x == "n" ]]; then
		echo "You choosed no"
	else
		#Creating directory
		mkdir ~/.hashcash/
		cd ~/.hashcash/
		rm -f blocks.dat
		rm -f blockindexes.dat
		rm -f p2pstate.bin
		
		cd ..
		
		git clone https://github.com/HashGate/HashCash-Blockchain.git ~/.hashcash/
		
		
	
		#Downloading blockchain
		
	
		echo "Download completed"
	fi
fi

#############################################################
#Installing Wolf's CPUMiner. A fast pool miner utilizing AES
#############################################################

if [[ $NUM == "2" || $NUM == "3" || $NUM == "7" || $NUM == "8" ]]; then

	echo "The following part will build CPUMiner. CPUMiner supports pool mining for multiple algos, including CryptoNight. Do you want to build it now	[y/n]?"

	cd ~
	
	if [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.04 ]] ; then
		#Installing required packages
		echo "Installing required packages"
		sudo apt-get install -y automake libcurl4-openssl-dev pkg-config
		sudo apt-get update
	elif [[ $DISTRIB_ID=Ubuntu && $DISTRIB_RELEASE == 16.10 ]] ; then
		#Installing required packages
		echo "Installing required packages"
		sudo apt-get install -y automake libcurl4-openssl-dev pkg-config
		sudo apt-get update

	elif [[$VERSION=8 && $ID=debian]] ; then
		#Installing required packages
		echo "Installing required packages"
		apt-get install -y automake libcurl4-openssl-dev pkg-config
		apt-get update
	fi
	
	
	#Preparing
	cd ~/HashCash
	rm -rf cpuminer 
	mkdir cpuminer
	cd cpuminer
	
	#Building CPUMiner
	if [[ $NUM == "7" || $NUM == "8" ]]; then
		pushd cpuminer-multi
		git pull
	else
		git clone https://github.com/wolf9466/cpuminer-multi 
		pushd cpuminer-multi
	fi
	
	./autogen.sh
	export CFLAGS="-march=native"
	./configure
	
	#Building with maximum number of cores
	n=$(nproc)
	if [$n !== 1] 
	then
		$n = $n / 2
		make -j $n
	else
		make
	fi
	
	#Unsetting flag and leaving dir
	unset CFLAGS
	popd
	
	echo "Finished building"
fi

echo "The script has finished"