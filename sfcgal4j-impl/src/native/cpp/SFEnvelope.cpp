/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */

#include "SFEnvelope.h"
#include "SFLineString.h"
#include "SFPolygon.h"
#include "SFSolid.h"

SFLineString& SFEnvelope::toRing() const {
	std::auto_ptr<SFCGAL::LineString> p = data.toRing();
	
	SFLineString *lineString = new SFLineString(p.release());

	return *lineString;
}

SFPolygon& SFEnvelope::toPolygon() const {
	std::auto_ptr<SFCGAL::Polygon> p = data.toPolygon();

	SFPolygon *polygon = new SFPolygon(p.release());

	return *polygon;
}

SFSolid& SFEnvelope::toSolid() const {
	std::auto_ptr<SFCGAL::Solid> p = data.toSolid();

	SFSolid *solid = new SFSolid(p.release());

	return *solid;
}
