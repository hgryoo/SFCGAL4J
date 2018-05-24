/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/MultiPolygon.h>
#include "SFGeometryCollection.h"
#include "SFPolygon.h"

class SFMultiPolygon : public SFGeometryCollection {
public:
	SFMultiPolygon() : SFGeometryCollection(new SFCGAL::MultiPolygon()) { }
	//SFMultiPolygon(const SFMultiPolygon& other) : SFGeometry(other.data) { }
	SFMultiPolygon(const SFCGAL::MultiPolygon& other) : SFGeometryCollection(new SFCGAL::MultiPolygon(other)) { }
	//SFMultiPolygon(SFCGAL::MultiPolygon& other) : SFGeometry(new SFCGAL::MultiPolygon(other)) { }
	SFMultiPolygon(SFCGAL::MultiPolygon* other) : SFGeometryCollection(other) { }

	SFMultiPolygon& operator=(const SFMultiPolygon& other) {
		data = other.data;

		return *this;
	}

	~SFMultiPolygon() { }


	//--SFCGAL::Geometry
	SFMultiPolygon* clone() const {
		return new SFMultiPolygon(*this);
	}

	std::string geometryType() const {
		return data->geometryType();
	}

	int geometryTypeId() const {
		return data->geometryTypeId();
	}


	const SFPolygon& polygonN( size_t const & n) const {
		return *(new SFPolygon(((SFCGAL::MultiPolygon *)data)->polygonN(n)));
	}

	SFPolygon& polygonN(size_t const& n) {
		return *(new SFPolygon(((SFCGAL::MultiPolygon *)data)->polygonN(n)));
	}

};
