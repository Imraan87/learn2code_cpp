/*
 * LogFile.h
 *
 *  Created on: 4 Dec 2018
 *      Author: IIBRAH
 */

#pragma once

#include <iostream>
#include <fstream>
#include <vector>
#include <regex>

#include "../data_parser/data_def.h"

using namespace std;

class LogFile {
public:
	LogFile(string filename);
	virtual ~LogFile();

	string Name;

	void read();
	void setChipName();
	void reset();
	string outputLog();
	string getChipName();
	pll_t getPLLData();

protected:
	string _Log;
	string _ChipName;

};

