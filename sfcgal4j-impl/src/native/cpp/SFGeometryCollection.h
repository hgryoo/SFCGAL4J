/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/GeometryCollection.h>
#include "SFGeometry.h"

class SFGeometryCollection : public SFGeometry {
public:	
	SFGeometryCollection() : SFGeometry(new SFCGAL::GeometryCollection()) { }
	
	//SFGeometryCollection(const SFGeometryCollection& other) : SFGeometry(other.data) { }
	SFGeometryCollection(const SFCGAL::GeometryCollection& other) : SFGeometry(new SFCGAL::GeometryCollection(other)) { }
	//SFGeometryCollection(SFCGAL::GeometryCollection& other) : SFGeometry(new SFCGAL::GeometryCollection(other)) { }
	SFGeometryCollection(SFCGAL::GeometryCollection* other) : SFGeometry(other) { }

	SFGeometryCollection& operator=(const SFGeometryCollection& other) {
		data = other.data;
		
		return *this;
	}
	
	~SFGeometryCollection() { }
	
	
	//--SFCGAL::Geometry
	SFGeometryCollection* clone() const {
		return new SFGeometryCollection(*this);
	}
	
	std::string geometryType() const {
		return data->geometryType();
	}	
	
	int geometryTypeId() const {
		return data->geometryTypeId();
	}
	
	int dimension() const {
		return data->dimension();	
	}
	
	int coordinateDimension() const {
		return data->coordinateDimension();
	}

	bool isEmpty() const {
		return data->isEmpty();
	}

	bool is3D() const {
		return data->is3D();
	}
	
	bool isMeasured() const {
		return data->isMeasured();
	}

	size_t numGeometries() const {
		return data->numGeometries();
	}


	const SFGeometry& geometryN(size_t const& n) const {
		return *(new SFGeometry( ((SFCGAL::GeometryCollection *)data)->geometryN(n) ));
	}

	SFGeometry& geometryN(size_t const& n) {
		return *(new SFGeometry( ((SFCGAL::GeometryCollection *)data)->geometryN(n) ));
	}
	
	void addGeometry(SFGeometry* geometry) {
		((SFCGAL::GeometryCollection *)data)->addGeometry(geometry->get_data());
	}

	void addGeometry(const SFGeometry& geometry){
		((SFCGAL::GeometryCollection *)data)->addGeometry(*geometry.get_data());
	}
	
	// iterator begin() ;
	// iterator end() ;

	//void accept(GeometryVisitor& visitor);
	//void accept(ConstGeometryVisitor& visitor) const ;
};