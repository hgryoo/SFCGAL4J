/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/Point.h>
#include "SFGeometry.h"
#include "SFCoordinate.h"

class SFPoint : public SFGeometry{
public:
	SFPoint() : SFGeometry(new SFCGAL::Point()) { }
	SFPoint(SFCoordinate& coordinate) : SFGeometry(new SFCGAL::Point(coordinate.get_data())) { }
	SFPoint(double x, double y) : SFGeometry(new SFCGAL::Point(x, y)) { }
	SFPoint(double x, double y, double z) : SFGeometry(new SFCGAL::Point(x, y, z)) { }
	SFPoint(double x, double y, double z, double m) : SFGeometry(new SFCGAL::Point(x, y, z, m)) { }
	//SFPoint(const SFCGAL::Kernel::FT& x, const SFCGAL::Kernel::FT& y);
	//SFPoint(const SFCGAL::Kernel::FT& x, const SFCGAL::Kernel::FT& y, const SFCGAL::Kernel::FT& z, const double& m = SFCGAL::NaN());
	//SFPoint(const SFCGAL::Kernel::Point2& other) : data(other) { }
	//SFPoint(const Kernel::Point3& other) : data(other) { }
	SFPoint(const SFPoint& other) : SFGeometry(other.data) { }
	SFPoint(const SFCGAL::Point& other) : SFGeometry(new SFCGAL::Point(other)) { }
	SFPoint(SFCGAL::Point* other) : SFGeometry(other) { }

	
	SFPoint& operator=(const SFPoint& other) {
		data = other.data;
		
		return *this;
	}
	
	~SFPoint() { }
	
	
	//--SFCGAL::Geometry
	SFPoint* clone() const {
		return new SFPoint(*this);
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

	double x() const {
		return CGAL::to_double(((SFCGAL::Point *)data)->x());
	}

	double y() const {
		return CGAL::to_double(((SFCGAL::Point *)data)->y());
	}

	double z() const {
		return CGAL::to_double(((SFCGAL::Point *)data)->z());
	}

	double m() const {
		return ((SFCGAL::Point *)data)->m();
	}
	
	void setM(const double& m) {
		((SFCGAL::Point *)data)->setM(m);
	}

	bool operator<(const SFPoint& other) const {
		return ( *((SFCGAL::Point *)data) < *((SFCGAL::Point *)other.data) ) ;
	}

	bool operator==(const SFPoint& other) const {
		return ( *((SFCGAL::Point *)data) == *((SFCGAL::Point *)other.data) ) ;
	}

	bool operator!=(const SFPoint& other) const {
		return ( *((SFCGAL::Point *)data) != *((SFCGAL::Point *)other.data) ) ;
	}
	
	//void accept( GeometryVisitor& visitor);
	//void accept( ConstGeometryVisitor& visitor) const;

	/*
	Kernel::Vector_2 toVector_2() const {
		return data.toVector_2();
	}
	
	Kernel::Vector_3 toVector_3() const {
		return data.to_vector_3();
	}

	Kernel::Point_2 toPoint_2() const {
		return data.toPoint_2();
	}
	
	Kernel::Point_3 toPoint_3() const {
		return data.toPoint_3();
	}
	*/
	
	SFCoordinate& coordinate() {		
		return *(new SFCoordinate(((SFCGAL::Point *)data)->coordinate()));
	}
	
	SFCoordinate& coordinate() const {
		return *(new SFCoordinate(((SFCGAL::Point *)data)->coordinate()));
	}
};
