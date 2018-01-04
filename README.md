# SFCGAL for Java

Java wrapper for [Simple Feature CGAL (SFCGAL)](http://sfcgal.org) which is a C++ wrapper library around [CGAL](http://www.cgal.org) with the aim of supporting ISO 19107:2013 and OGC Simple Features Access 1.2 for 3D operations. Since SFCGAL is C++ library, this module employs [JavaCPP](https://github.com/bytedeco/javacpp) as a bridge between C++ and Java. Due to dependency on SFCGAL, there exist limitations such as supported platforms. If you need 3D operations in gt-geometry, you have to install [SFCGAL](http://sfcgal.org) manually.

## Supported platform
  * GNU/Linux

## Prerequisites
 * CMake
 * Boost
 * CGAL
 * GMP
 * MPFR
 * SFCGAL
 
## License of third party libraries
SFCGAL is distributed under the terms of the [LGPL](http://www.gnu.org/licenses/old-licenses/lgpl-2.0.html)(v2+). Starting from release 4.0. CGAL is available under the [GPL](http://www.gnu.org/copyleft/gpl.html)(v3+)/[LGPL](http://www.gnu.org/copyleft/lesser.html)(v3+). JavaCPP is available under Apache License(v2.0)/[GPL](http://www.gnu.org/copyleft/gpl.html)(v2+) with "Classpath" exception. GeoTools licensed under the [LGPL](http://www.gnu.org/licenses/old-licenses/lgpl-2.0.html)(v2+).

## Building
This project uses Apache Maven. To build this project run maven from the root of the repository.  
```
mvn clean install
```

## Authors
Hyung-Gyu Ryoo / Pusan National University (hgryoo@pnu.edu)
Donguk Seo / Pusan National University (donguk.seo@pnu.edu)

