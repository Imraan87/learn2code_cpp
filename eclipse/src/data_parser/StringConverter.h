/*
 * StringConverter.h
 *
 *  Created on: 26 Feb 2019
 *      Author: IIBRAH
 */
#include <string>
#include <typeinfo>
#include <iostream>

#ifndef SRC_DATA_PARSER_STRINGCONVERTER_H_
#define SRC_DATA_PARSER_STRINGCONVERTER_H_

class StringConverter
{
public:

protected:
	void str2num(char *num, std::string  str, int  mx_sz);
	void str2num(int *num, std::string  str, int  mx_sz);
	void str2num(float *num, std::string  str, int  mx_sz);
	void str2num(double *num, std::string  str, int  mx_sz);
};

#endif /* SRC_DATA_PARSER_STRINGCONVERTER_H_ */
