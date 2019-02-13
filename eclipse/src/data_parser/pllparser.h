/*
 * pllparser.h
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#pragma once
#include "data_def.h"
#include "DataParser.h"

class pll_parser: public DataParser {
public:
	pll_parser();
	virtual ~pll_parser();
	const char *ID   = "pll";
	string IP;

	pll_t getData1(string Log);
};

