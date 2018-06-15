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
		exit 1G
        fi
    fi
    #ln -sf "$TOP_PATH/downloads/$2" "$2"
}


mkdir -p $PLATFORM
cd $PLATFORM
INSTALL_PATH=`pwd`


case $OPERATION in
	    install)
		mkdir -p include lib bin

		case $PLATFORM in
		    linux-x86_64)
			if [[ -e $INSTALL_PATH/lib/libSFCGAL.so ]]; then
				echo "Required libraries are already installed"
			else
			    download https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz boost.tar.gz
			    download https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.11.1/CGAL-4.11.1.tar.xz CGAL.tar.xz
				download https://github.com/Oslandia/SFCGAL/archive/v1.3.5.tar.gz SFCGAL.tar.gz

                mkdir -p boost
                mkdir -p CGAL
                mkdir -p SFCGAL

                tar -xzf ../downloads/boost.tar.gz -C boost --strip-components 1
				tar -xf ../downloads/CGAL.tar.xz -C CGAL --strip-components 1
				tar -xzf ../downloads/SFCGAL.tar.gz -C SFCGAL --strip-components 1

				cd boost
                ./bootstrap.sh --prefix=$INSTALL_PATH "--with-libraries=filesystem,system,thread,date_time,serialization,timer"

                ./b2 -j8
                ./b2 -d0 install "--prefix=$INSTALL_PATH" link=shared "address-model=64" "toolset=gcc"
                cd ../

                #ln -sf libboost_thread.so lib/libboost_thread-mt.so

                export BOOST_ROOT="$INSTALL_PATH"
                export BOOST_INCLUDEDIR="$INSTALL_PATH/include/boost/"
                export BOOST_LIBRARYDIR="$INSTALL_PATH/lib/"
                #export BOOST_THREAD_LIBRARY_RELEASE="$INSTALL_PATH/lib/libboost_thread.so"

				# building cgal
				cd CGAL
				cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH
				make
				make install
				cd ../

				# building sfcgal
				cd SFCGAL

				export CGAL_DIR="$INSTALL_PATH/lib/CGAL"
				export CGAL_INCLUDE_DIRS="$INSTALL_PATH/include/"
				export CGAL_LIBRARY_DIRS="$INSTALL_PATH/lib/"

				cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH -DSFCGAL_WITH_OSG=ON

				make
				make install
				cd ../
			fi
			;;
	    	*)
		        echo "Error: Platform \"$PLATFORM\" is not supported"
		        ;;
			esac

			cd ../..
	        ;;
    clean)
        #echo "Cleaning \"$INSTALL_PATH\""
        #TODO
        ;;
esac
