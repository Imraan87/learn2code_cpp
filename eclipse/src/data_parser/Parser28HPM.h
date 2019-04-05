/*
 * Parser28HPM.h
 *
 *  Created on: 15 Feb 2019
 *      Author: IIBRAH
 */

#pragma once
#include "data_def.h"
#include "StringConverter.h"


class Parser28HPM  : StringConverter {
public:

	//adc_t& ADC;
	//dac_t& DAC;



	virtual ~Parser28HPM();
	Parser28HPM();
	void setDataset(adc_t *adc, dac_t *dac);




};

