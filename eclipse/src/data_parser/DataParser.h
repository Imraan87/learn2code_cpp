/*
 * DataParser.h
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#pragma once

#include <regex>
#include <iostream>
#include <functional>

using namespace std;


//regex Expr1("<:([a-z_]+) ([0-9]+):>");
//regex Expr2("\\[:([a-z_]+) ([0-9]+) :\\] (.*) \\[::\\]");


struct basic_partition_t
{
	bool isempty = true;
	string header;
	string datastr;
};

struct basic_data_t
{
	string Group;
	string No;
	string Chan;
	string Indx;
	string Name;
	string Value;
	string sz;
};



typedef enum {
    I,
    Q,
	None,
} chan_t;

typedef enum {
    section_expr,
    data_expr,
} expr_t;

class DataParser {
public:
	//const char *IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	const char *SECTION_EXPR_STR  = "<:(.*):>";
	const char *IP_EXPR_STR       = "<:([a-z_]+) (.*):>";//"<:([a-z_]+) ([0-9]+):>";
	const char *Data_EXPR_STR     = "\\[:(.*) ([0-9]+) :\\] (.*) \\[::\\]";//"\\[:(.*) :\\] (.*) \\[::\\]";//"\\[:([a-z_]+) ([0-9]+) :\\] (.*) \\[::\\]";
	//regex IP_EXPR("<:[a-z]+ [0-9]+:>");
	//const regex IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	//const regex Data_EXPR = "\\[:([a-z]+) ([0-9]+) :\\]";
	//string IP;
	int sz[2]     = {0, 0};
	int max_sz[2] = {0, 0};
	basic_partition_t *partitions;
	basic_data_t      *trace;

	string getData(string &Log, string &IP);
	//void regex_Iterator(string Txt, string EXPR_STR, int& i, void(*do_this)(string, smatch, int));
	void regex_Iterator(string Txt, string EXPR_STR, int& i, const function<void(string&, smatch&, int)>& do_this);
	void partition_txt(string Log);
	int matches_found(string Log, string Expr_Str);
	basic_partition_t getPartitionBlock(string Log);
	string getDataStr(string Log);
    void min_indx(int &indx);
	string getDataStrOrig(string &Log, string &IP);
	//regex ip_epxr;// = &Expr1;



};


