/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */

#include "SFTriangle.h"
#include "SFPolygon.h"

SFPolygon& SFTriangle::toPolygon() {
	return *(new SFPolygon(((SFCGAL::Triangle *)data)->toPolygon()));
}
