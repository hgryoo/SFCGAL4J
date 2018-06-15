# SFCGAL for Java

Java wrapper for [Simple Feature CGAL (SFCGAL)](http://sfcgal.org) which is a C++ wrapper library around [CGAL](http://www.cgal.org) with the aim of supporting ISO 19107:2013 and OGC Simple Features Access 1.2 for 3D operations. Since SFCGAL is C++ library, this module employs [JavaCPP](https://github.com/bytedeco/javacpp) as a bridge between C++ and Java. Due to dependency on SFCGAL, there exist limitations such as supported platforms. If you need 3D operations in gt-geometry, you have to install [SFCGAL](http://sfcgal.org) manually.

## Documentation
  * User Guide - unavailable now
  * [Java Doc](https://hgryoo.github.io/SFCGAL4J/apidocs/)

## Supported platform
  * GNU/Linux

## Prerequisites
 * JDK 8 or newer
 * CMake
 * GMP
 * MPFR
 * Boost, CGAL, SFCGAL
 * (Optional) OpenSceneGraph
  
## License of third party libraries
 * SFCGAL is distributed under the terms of the [LGPL](http://www.gnu.org/licenses/old-licenses/lgpl-2.0.html)(v2+).  
 * Starting from release 4.0. CGAL is available under the [GPL](http://www.gnu.org/copyleft/gpl.html)(v3+)/[LGPL](http://www.gnu.org/copyleft/lesser.html)(v3+).  
 * JavaCPP is available under Apache License(v2.0)/[GPL](http://www.gnu.org/copyleft/gpl.html)(v2+) with "Classpath" exception. 

## Building
This project uses Apache Maven. To build this project run maven from the root of the repository.
Boost, CGAL and SFCGAL libraries will be installed automatically.
If you don't want to install it, set javacpp.cppbuild.skip=True
```
mvn clean install
```

## Usage
After building this project, insert following a dependency code to pom.xml in your maven project.
```$xml
  <dependency>
    <groupId>edu.pnu.stemlab</groupId>
    <artifactId>sfcgal4j-platform</artifactId>
    <version>1.0.0-SNAPSHOT</version>
  </dependency>
```

# Note
This project is based on [SFCGAL](sfcgal.org) and [JavaCPP](https://github.com/bytedeco/javacpp)

## Authors
 * Hyung-Gyu Ryoo / Pusan National University (hgryoo@pnu.edu)  
 * Donguk Seo / Pusan National University (donguk.seo@pnu.edu)
