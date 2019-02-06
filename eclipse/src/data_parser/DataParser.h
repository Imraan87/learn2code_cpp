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

class DataParser {
public:
	//const char *IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	const char *IP_EXPR_STR     = "<:([a-z_]+) ([0-9]+):>";
	const char *Data_EXPR_STR   = "\\[:([a-z_]+) ([0-9]+) :\\] (.*) \\[::\\]";
	//regex IP_EXPR("<:[a-z]+ [0-9]+:>");
	//const regex IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	//const regex Data_EXPR = "\\[:([a-z]+) ([0-9]+) :\\]";
	//string IP;
	string getDataStr(string &Log, string &IP);
	//regex ip_epxr;// = &Expr1;



};


