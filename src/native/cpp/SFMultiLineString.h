/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/MultiLineString.h>
#include "SFGeometryCollection.h"
#include "SFLineString.h"

class SFMultiLineString : public SFGeometryCollection {
public:	
	SFMultiLineString() : SFGeometryCollection(new SFCGAL::MultiLineString()) { }
	//SFMultiLineString(const SFMultiLineString& other) : SFGeometry(other.data) { }
	SFMultiLineString(const SFCGAL::MultiLineString& other) : SFGeometryCollection(new SFCGAL::MultiLineString(other)) { }
	//SFMultiLineString(SFCGAL::MultiLineString& other) : SFGeometry(new SFCGAL::MultiLineString(other)) { }
	SFMultiLineString(SFCGAL::MultiLineString* other) : SFGeometryCollection(other) { }

	SFMultiLineString& operator=(const SFMultiLineString& other) {
		data = other.data;
		
		return *this;
	}
	
	~SFMultiLineString() { }
	
	
	//--SFCGAL::Geometry
	SFMultiLineString* clone() const {
		return new SFMultiLineString(*this);
	}
	
	std::string geometryType() const {
		return data->geometryType();
	}	
	
	int geometryTypeId() const {
		return data->geometryTypeId();
	}
	

	const SFLineString& lineStringN( size_t const & n) const {
		return *(new SFLineString(((SFCGAL::MultiLineString *)data)->lineStringN(n)));
	}
	
	SFLineString& lineStringN(size_t const& n) {
		return *(new SFLineString(((SFCGAL::MultiLineString *)data)->lineStringN(n)));
	}
	
};