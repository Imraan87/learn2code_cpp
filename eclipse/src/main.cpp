/*
 * main.cpp
 *
 *  Created on: 4 Dec 2018
 *      Author: IIBRAH
 */




#include "logfile\LogFile.h"
#include "data_parser\pllparser.h"

int main(){

	LogFile Log = LogFile("C:\\Users\\Imraan\\Documents\\mculogparser\\learn2code_cpp\\eclipse\\src\\log_examples\\FULL_X_4_Y_0_wafid_21_lotid_0CC38_d2018_11_28_t09_14_17.txt");

	//cout << Log.outputLog() << endl << endl;

	//cout << Log.getChipName() << endl;

	//Log.reset();

	//cout << Log.outputLog() << endl << endl;




	DataParser b;

	string LogOut = Log.outputLog();

	b.getData(LogOut);



	return 0;
}
