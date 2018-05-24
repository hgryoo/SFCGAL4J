
/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/MultiPoint.h>
#include "SFGeometryCollection.h"
#include "SFPoint.h"

class SFMultiPoint : public SFGeometryCollection {
public:	
	SFMultiPoint() : SFGeometryCollection(new SFCGAL::MultiPoint()) { }
	//SFMultiPoint(const SFMultiPoint& other) : SFGeometry(other.data) { }
	SFMultiPoint(const SFCGAL::MultiPoint& other) : SFGeometryCollection(new SFCGAL::MultiPoint(other)) { }
	//SFMultiPoint(SFCGAL::MultiPoint& other) : SFGeometry(new SFCGAL::MultiPoint(other)) { }
	SFMultiPoint(SFCGAL::MultiPoint* other) : SFGeometryCollection(other) { }

	SFMultiPoint& operator=(const SFMultiPoint& other) {
		data = other.data;
		
		return *this;
	}
	
	~SFMultiPoint() { }
	
	
	//--SFCGAL::Geometry
	SFMultiPoint* clone() const {
		return new SFMultiPoint(*this);
	}
	
	std::string geometryType() const {
		return data->geometryType();
	}	
	
	int geometryTypeId() const {
		return data->geometryTypeId();
	}
	

	const SFPoint& pointN( size_t const & n) const {
		return *(new SFPoint(((SFCGAL::MultiPoint *)data)->pointN(n)));
	}
	
	SFPoint& pointN(size_t const& n) {
		return *(new SFPoint(((SFCGAL::MultiPoint *)data)->pointN(n)));
	}
	
};