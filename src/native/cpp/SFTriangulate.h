/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/triangulate/triangulatePolygon.h>

#include "SFGeometry.h"
#include "SFTriangulatedSurface.h"

void triangulatePolygon3D(const SFGeometry& g, const SFTriangulatedSurface& triangulatedSurface) {
	SFCGAL::triangulate::triangulatePolygon3D(*(g.get_data()), *(SFCGAL::TriangulatedSurface *)(triangulatedSurface.get_data()));
}
