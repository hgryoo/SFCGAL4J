
/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/Triangle.h>
#include "SFPoint.h"
#include "SFSurface.h"

class SFPolygon;

class SFTriangle : public SFSurface {
public:
	SFTriangle() : SFSurface(new SFCGAL::Triangle()) { }
	SFTriangle(const SFPoint& p, const SFPoint& q, const SFPoint& r)
	 : SFSurface(new SFCGAL::Triangle(*(SFCGAL::Point *)(p.get_data()),
					*(SFCGAL::Point *)(q.get_data()),
					*(SFCGAL::Point *)(r.get_data())) ) { }

	//SFTriangle(const SFTriangle& other) : SFSurface(new SFCGAL::Triangle(*other.data)) { }
	SFTriangle(const SFCGAL::Triangle& other) : SFSurface(new SFCGAL::Triangle(other)) { }
	SFTriangle(SFCGAL::Triangle* other) : SFSurface(other) { }
	//SFTriangle( const CGAL::Triangle_2& other );
	//SFTriangle( const CGAL::Triangle_3& other );
	SFTriangle& operator=(const SFTriangle& other) {
		data = other.data;

		return *this;
	}

	~SFTriangle() { }


	//--SFCGAL::Geometry
	SFTriangle* clone() const {
		return new SFTriangle(*this);
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


	void reverse() {
		((SFCGAL::Triangle *)data)->reverse();
	}

	SFPolygon& toPolygon();

	SFPoint& vertex(const int& i) const { // not used
		return *(new SFPoint(((SFCGAL::Triangle *)data)->vertex(i)));
	}

	SFPoint& vertex(const int &i) {
		return *(new SFPoint(((SFCGAL::Triangle *)data)->vertex(i)));
	}

	//Kernel::Triangle_2 toTriangle_2() const;
	//Kernel::Triangle_3 toTriangle_3() const;


	//void accept(GeometryVisitor& visitor);
	//void accept(ConstGeometryVisitor& visitor) const ;
};
