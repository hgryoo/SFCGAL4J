/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/MultiSolid.h>
#include "SFGeometryCollection.h"
#include "SFSolid.h"

class SFMultiSolid : public SFGeometryCollection {
public:
	SFMultiSolid() : SFGeometryCollection(new SFCGAL::MultiSolid()) { }
	//SFMultiSolid(const SFMultiSolid& other) : SFGeometry(other.data) { }
	SFMultiSolid(const SFCGAL::MultiSolid& other) : SFGeometryCollection(new SFCGAL::MultiSolid(other)) { }
	//SFMultiSolid(SFCGAL::MultiSolid& other) : SFGeometry(new SFCGAL::MultiSolid(other)) { }
	SFMultiSolid(SFCGAL::MultiSolid* other) : SFGeometryCollection(other) { }

	SFMultiSolid& operator=(const SFMultiSolid& other) {
		data = other.data;

		return *this;
	}

	~SFMultiSolid() { }


	//--SFCGAL::Geometry
	SFMultiSolid* clone() const {
		return new SFMultiSolid(*this);
	}

	std::string geometryType() const {
		return data->geometryType();
	}

	int geometryTypeId() const {
		return data->geometryTypeId();
	}


	const SFSolid& solidN( size_t const & n) const {
		return *(new SFSolid(((SFCGAL::MultiSolid *)data)->solidN(n)));
	}

	SFSolid& solidN(size_t const& n) {
		return *(new SFSolid(((SFCGAL::MultiSolid *)data)->solidN(n)));
	}

};
