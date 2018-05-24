/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 * @author Donguk Seo
 *
 */
#pragma once

#include <SFCGAL/PreparedGeometry.h>
#include <stdint.h>
#include "SFGeometry.h"

//typedef uint32_t srid_t;
typedef SFCGAL::srid_t srid_t;

class SFPreparedGeometry{
	SFCGAL::PreparedGeometry data;
public:
	typedef SFCGAL::PreparedGeometry cpp_base;
	const cpp_base& get_data() const { return data; }
	cpp_base& get_data() { return data; }

	SFPreparedGeometry() : data() { }
	SFPreparedGeometry(SFGeometry& g, srid_t srid) : data(g.get_data(), srid) { }
	//SFPreparedGeometry(SFCGAL::PreparedGeometry* other) : data(*other) { }

	~SFPreparedGeometry() { }
/*
	const SFGeometry& geometry() const { // not used
		return *(new SFGeometry(data.geometry()));
	}
*/
	SFGeometry& geometry() {
		return *(new SFGeometry(data.geometry()));
	}

	void resetGeometry( SFGeometry* geom ) {
		data.resetGeometry(geom->get_data());
	}

	srid_t& SRID() {
		return data.SRID();
	}

	void resetSRID(srid_t srid) {
		data.SRID()=srid;
	}

	//const Envelope& envelope() const // not used
	SFEnvelope& envelope() const {
		return *(new SFEnvelope(data.envelope()));
	}

	void invalidateCache() {
		data.invalidateCache();
	}

	std::string asEWKT( const int numDecimals ) const {
		return data.asEWKT(numDecimals);
	}
};