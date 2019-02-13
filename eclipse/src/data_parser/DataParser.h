/*
 * DataParser.h
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#pragma once

#include <regex>
#include <iostream>

using namespace std;


//regex Expr1("<:([a-z_]+) ([0-9]+):>");
//regex Expr2("\\[:([a-z_]+) ([0-9]+) :\\] (.*) \\[::\\]");


struct basic_partition_t
{
	bool isempty = true;
	string header;
	string datastr;
};

class DataParser {
public:
	//const char *IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	const char *SECTION_EXPR_STR  = "<:(.*):>";
	const char *IP_EXPR_STR       = "<:([a-z_]+) (.*):>";//"<:([a-z_]+) ([0-9]+):>";
	const char *Data_EXPR_STR     = "\\[:(.*) :\\] (.*) \\[::\\]";//"\\[:([a-z_]+) ([0-9]+) :\\] (.*) \\[::\\]";
	//regex IP_EXPR("<:[a-z]+ [0-9]+:>");
	//const regex IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	//const regex Data_EXPR = "\\[:([a-z]+) ([0-9]+) :\\]";
	//string IP;
	int sz     = 0;
	int max_sz = 1000;
	basic_partition_t partitions[1000];

	string getData(string &Log, string &IP);
	void partition_txt(string Log);
	basic_partition_t getPartitionBlock(string Header, string Log);
	string getDataStr(string Log);
	string getDataStrOrig(string &Log, string &IP);
	//regex ip_epxr;// = &Expr1;



};


