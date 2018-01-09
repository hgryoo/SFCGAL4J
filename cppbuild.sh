#!/bin/bash
set -eu

which cmake3 &> /dev/null && CMAKE3="cmake3" || CMAKE3="cmake"
[[ -z ${CMAKE:-} ]] && CMAKE=$CMAKE3
[[ -z ${MAKEJ:-} ]] && MAKEJ=4
[[ -z ${OLDCC:-} ]] && OLDCC="gcc"
[[ -z ${OLDCXX:-} ]] && OLDCXX="g++"
[[ -z ${OLDFC:-} ]] && OLDFC="gfortran"

KERNEL=(`uname -s | tr [A-Z] [a-z]`)
ARCH=(`uname -m | tr [A-Z] [a-z]`)
case $KERNEL in
    darwin)
        OS=macosx
        ;;
    mingw32*)
        OS=windows
        KERNEL=windows
        ARCH=x86
        ;;
    mingw64*)
        OS=windows
        KERNEL=windows
        ARCH=x86_64
        ;;
    *)
        OS=$KERNEL
        ;;
esac
case $ARCH in
    arm*)
        ARCH=arm
        ;;
    i386|i486|i586|i686)
        ARCH=x86
        ;;
    amd64|x86-64)
        ARCH=x86_64
        ;;
esac
PLATFORM=$OS-$ARCH
echo "Detected platform \"$PLATFORM\""

while [[ $# > 0 ]]; do
    case "$1" in
        install)
            OPERATION=install
            ;;
        clean)
            OPERATION=clean
            ;;
    esac
    shift
done

mkdir -p cppbuild
cd cppbuild
TOP_PATH=`pwd`

function download {
    mkdir -p "$TOP_PATH/downloads"
    if [[ ! -e "$TOP_PATH/downloads/$2" ]]; then
        echo "Downloading $1"
        curl -L "$1" -o "$TOP_PATH/downloads/$2" --fail
        DOWNLOADSTATUS=$?
        if [ "$DOWNLOADSTATUS" -eq 28 ]
        then
		echo "Download timed out, waiting 5 minutes then trying again"
		rm "$TOP_PATH/downloads/$2"
		sleep 600
        	curl -L "$1" -o "$TOP_PATH/downloads/$2" --fail
        	if [ $? -ne 0 ]
        	then
			echo "File still could not be downloaded!"
			rm "$TOP_PATH/downloads/$2"
			exit 1
    		fi
        elif [ "$DOWNLOADSTATUS" -ne 0 ]
        then
		echo "File could not be downloaded!"
		rm "$TOP_PATH/downloads/$2"
		exit 1
        fi
    fi
    #ln -sf "$TOP_PATH/downloads/$2" "$2"
}


mkdir -p $PLATFORM
cd $PLATFORM
INSTALL_PATH=`pwd`

if [[ -e $INSTALL_PATH/lib/libSFCGAL.so ]]; then
	echo "SFCGAL is already installed"
else
	case $OPERATION in
	    install)
			download https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz/download boost-1.63.tar.gz
			download https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.10.1/CGAL-4.10.1.tar.xz CGAL-4.10.1.tar.xz
			download https://github.com/Oslandia/SFCGAL/archive/v1.3.2.tar.gz SFCGAL-1.3.2.tar.gz
			
			#download https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz gmp-6.1.2.tar.xz
			#download http://www.mpfr.org/mpfr-current/mpfr-4.0.0.tar.xz mpfr-4.0.0.tar.xz
			
			mkdir -p include lib bin
			
			tar -xzf ../downloads/boost-1.63.tar.gz
			tar -xf ../downloads/CGAL-4.10.1.tar.xz
			tar -xzf ../downloads/SFCGAL-1.3.2.tar.gz
	
			case $PLATFORM in
			    linux-x86_64)
			    	 # building boost
			    	 cd boost_1_63_0
			        ./bootstrap.sh "--prefix=$INSTALL_PATH" --with-libraries=filesystem,system,thread,date_time,serialization,
			        ./b2 -d0 install "--prefix=$INSTALL_PATH" link=static,shared "address-model=64" "toolset=gcc"
			        cd ../

				ln -sf libboost_thread.a lib/libboost_thread-mt.a
				ln -sf libboost_thread.so lib/libboost_thread-mt.so
				
				export BOOST_ROOT="$INSTALL_PATH/boost_1_63_0"		
				export BOOST_INCLUDEDIR="$INSTALL_PATH/include/boost"
				export BOOST_LIBRARYDDIR="$INSTALL_PATH/lib/"
				export BOOST_THREAD_LIBRARY_RELEASE="$INSTALL_PATH/lib/libboost_thread.so"
	
			        # building cgal
			        cd CGAL-4.10.1
			        cmake "-DCMAKE_INSTALL_PREFIX=$INSTALL_PATH" "-DBUILD_SHARED_LIBS=TRUE"
			        make
			        make install
			        cd ../
			
			        # building sfcgal
			        cd SFCGAL-1.3.2
			        
			        export CGAL_DIR="$INSTALL_PATH/CGAL-4.10.1"
			        export CGAL_INCLUDE_DIRS="$INSTALL_PATH/CGAL-4.10.1/include"
			        
			        cmake "-DCMAKE_INSTALL_PREFIX=$INSTALL_PATH" "-DSFCGAL_USE_STATIC_LIBS=FALSE"
			        make
			        make install
			        cd ../
			        ;;
		    	*)
			        echo "Error: Platform \"$PLATFORM\" is not supported"
			        ;;
				esac
				
				cd ../..
		        ;;
	    clean)
	        echo "Cleaning \"$INSTALL_PATH\""
	        rm -Rf $INSTALL_PATH/
	        ;;
	esac
fi

