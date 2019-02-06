/*
 * LogFile.cpp
 *
 *  Created on: 4 Dec 2018
 *      Author: IIBRAH
 */

#include "LogFile.h"

LogFile::LogFile(string filename) {
	Name = filename;

	read();
	setChipName();

}

LogFile::~LogFile() {
	reset();
}

void LogFile::read(){

	ifstream ifs(Name.c_str(), ios::in | ios::binary | ios::ate);

	ifstream::pos_type fileSize = ifs.tellg();
	ifs.seekg(0, ios::beg);

	vector<char> bytes(fileSize);
	ifs.read(bytes.data(), fileSize);

	_Log = string (bytes.data(), fileSize);

}

void LogFile::setChipName(){

	smatch m;

    //regex e ("chip name      = (\w+) (\w+)");
	//regex e ("chip name      = \\S+");
	regex e ("chip name      = (.*) (.*)");

	if(regex_search (_Log,m,e))
	{
		_ChipName = m.str(1); // 0 = full match str, 1 = actual chip name, 2 variant
     }
}

void LogFile::reset(){
	_Log.clear();
	_ChipName.clear();

}

string LogFile::getChipName(){

	return _ChipName;

}

string LogFile::outputLog(){

return _Log;

}

pll_t LogFile::getPLLData(){

	smatch m;
	pll_t pll;
	string s = _Log;

	//regex e ("chip name      = (\w+) (\w+)");
	//regex e ("chip name      = \\S+");
	regex e ("<:[a-z]+ [0-9]+:>");//("<:pll [0-9]+:>"); //("<:pll (.*):>");

	if(regex_search (_Log,m,e))
	{
		cout << m.size() << endl << m.position(0) << endl;

//		for (unsigned i=0; i<m.size(); ++i) {
//		    std::cout << "[" << m[i] << "] ";
//		  }
		while (regex_search (s,m,e)) {
		    for (auto x:m) cout << x << " ";
		    cout << endl;
		    s = m.suffix().str();
		  }

	}

	return pll;
}


