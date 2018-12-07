/*
 * LogFile.h
 *
 *  Created on: 4 Dec 2018
 *      Author: IIBRAH
 */

#ifndef LOGFILE_H_
#define LOGFILE_H_

#include <iostream>
#include <fstream>
#include <vector>
#include <regex>

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

protected:
	string _Log;
	string _ChipName;

};

#endif /* LOGFILE_H_ */
