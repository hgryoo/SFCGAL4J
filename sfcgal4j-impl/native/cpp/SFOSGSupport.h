/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 *
 */
#pragma once

#include <string>
#include <SFCGAL/io/osg.h>

#include "SFGeometry.h"

void writeOSGFile( const SFGeometry& g, const std::string& filepath ) {
    SFCGAL::io::osgWriteFile(*(g.get_data()), filepath);
}