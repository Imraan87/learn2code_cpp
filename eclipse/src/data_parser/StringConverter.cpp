/*
 * StringConverter.cpp
 *
 *  Created on: 26 Feb 2019
 *      Author: IIBRAH
 */

#include "StringConverter.h"


void StringConverter::str2num(char *num, std::string  str, int  mx_sz)
{
	std::string::size_type sz;
	for (int ii  = 0; ii < mx_sz; ii++)
	{
		*num   = char(std::stoi(str, &sz));
		num++;
		str      = str.substr(sz);
	}
}

void StringConverter::str2num(int *num, std::string  str, int  mx_sz)
{
	std::string::size_type sz;
	for (int ii  = 0; ii < mx_sz; ii++)
	{
		*num     = std::stoi (str, &sz);
		str      = str.substr(sz);
		num++;
	}
}

void StringConverter::str2num(float *num, std::string  str, int  mx_sz)
{
	std::string::size_type sz;
	for (int ii  = 0; ii < mx_sz; ii++)
	{
		*num   = std::stof(str, &sz);
		str      = str.substr(sz);
		num++;
	}
}

void StringConverter::str2num(double *num, std::string  str, int  mx_sz)
{
	std::string::size_type sz;
	for (int ii  = 0; ii < mx_sz; ii++)
	{
		*num   = std::stof(str, &sz);
		str      = str.substr(sz);
		num++;
	}
}
