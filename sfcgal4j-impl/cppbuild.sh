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
			windows-x86_64)
			    	download https://sourceforge.net/projects/boost/files/boost/1.67.0/boost_1_67_0.zip/download boost.zip
			    	download https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.11.1/CGAL-4.11.1.zip CGAL.zip
			    	download https://github.com/Oslandia/SFCGAL/archive/v1.3.5.zip SFCGAL-1.3.5.zip
					
					echo "Unzipping boost.zip"
			    	unzip -qo ../downloads/boost.zip
			    	
			    	echo "Unzipping CGAL.zip"
					unzip -qo ../downloads/CGAL.zip
			    	
			    	echo "Unzipping SFCGAL.zip"
			    	unzip -qo ../downloads/SFCGAL.zip
			    	
			    	#download https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.10.1/CGAL-4.10.1-Setup.exe CGAL-4.10.1-Setup.exe
			    	
			    	#echo "Unzipping CGAL-4.10.1.zip"
			    	#unzip -z -n ../downloads/CGAL-4.10.1.zip
			    	#../downloads/CGAL-4.10.1-Setup.exe
			    	
			    	# building boost
			    	cd boost_1_67_0/
			        ./bootstrap.bat "--prefix=$INSTALL_PATH" "--with-libraries=filesystem,system,thread,date_time,serialization,timer"
			        ./b2 "--prefix=$INSTALL_PATH" "link=static,shared" "address-model=64" install
			        cd ../
					
			        #export BOOST_BUILD_PATH="$INSTALL_PATH/boost_1_63_0/boost_build/bin"
			        #cd ../
			        #cd ../../
			        #$INSTALL_PATH/boost_1_63_0/boost_build/bin/b2 "--prefix=$INSTALL_PATH" link=shared "address-model=64" "toolset=gcc" install
			        #cd ../../../
					#cd ../
					#ln -sf libboost_thread.a lib/libboost_thread-mt.a
					
					#cd boost_1_63_0/
			        #./bootstrap.bat g++
			        #./b2 clean
					#./b2 -j4 -a --toolset=g++ "--prefix=$INSTALL_PATH" variant=release link=shared threading=multi address-model=64
			        #cd ../

					ln -sf libboost_thread-mgw72-mt-1_63.dll lib/libboost_thread-mt.dll
					
					export BOOST_ROOT="$INSTALL_PATH/boost_1_63_0"		
					export BOOST_INCLUDEDIR="$INSTALL_PATH/include/boost"
					export BOOST_LIBRARYDDIR="$INSTALL_PATH/lib/"
					export BOOST_THREAD_LIBRARY_RELEASE="$INSTALL_PATH/lib/libboost_thread-mgw72-mt-1_63.dll"
			        
			        export GMP_DIR="$INSTALL_PATH/CGAL-4.10.1/auxiliary/gmp/"
			        export GMP_INC_DIR="$INSTALL_PATH/CGAL-4.10.1/auxiliary/gmp/include"
			        export GMP_LIB_DIR="$INSTALL_PATH/CGAL-4.10.1/auxiliary/gmp/lib"
			        
			        export MPFR_INC_DIR="$INSTALL_PATH/CGAL-4.10.1/auxiliary/gmp/include"
			        export MPFR_LIB_DIR="$INSTALL_PATH/CGAL-4.10.1/auxiliary/gmp/lib"
			        
			        export CMAKE_CXX_COMPILER=g++;
			        export CMAKE_C_COMPILER=gcc;
			        
			        # building cgal
			        cd CGAL-4.10.1/
			        cmake -G"MinGW Makefiles" "-DCMAKE_INSTALL_PREFIX=$INSTALL_PATH" "-DBUILD_SHARED_LIBS=TRUE"
			        mingw32-make
			        cd ../
			        
			        # building sfcgal
			        cd SFCGAL-1.3.2/
			        
			        export CGAL_DIR="$INSTALL_PATH/CGAL-4.10.1"
			        export CGAL_INCLUDE_DIRS="$INSTALL_PATH/CGAL-4.10.1/include"
			        
			        cmake -G "MinGW Makefiles" "-DCMAKE_INSTALL_PREFIX=$INSTALL_PATH" "-DSFCGAL_USE_STATIC_LIBS=OFF"
			        mingw32-make
			        cd ../
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
