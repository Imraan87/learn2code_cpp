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
#include <typeinfo>
#include "data_def.h"
#include "StringConverter.h"


using namespace std;


//regex Expr1("<:([a-z_]+) ([0-9]+):>");
//regex Expr2("\\[:([a-z_]+) ([0-9]+) :\\] (.*) \\[::\\]");




typedef enum {
    I,
    Q,
	None,
} chan_t;

typedef enum {
    section_expr,
    data_expr,
} expr_t;






struct header_t
{
	string Str;
	string IP;
	int IPNo  = 0;
	int Dim2Sz = 0;
	chan_t chan;
};


struct basic_partition_t
{
	bool isempty = true;
	header_t header;
	string datastr;
};


struct basic_data_t
{

	header_t* header;
    string Name;
	string Value;
	int sz;
};





class DataParser : StringConverter{
public:
	//const char *IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	const char *SECTION_EXPR_STR  = "<:(.*):>";//"<:([A-Za-z0-9]+) (.*):>";//"<:(.*):>";
	const char *IP_EXPR_STR       = "<:([a-z_]+) (.*):>";//"<:([a-z_]+) ([0-9]+):>";
	const char *Data_EXPR_STR     = "\\[:(.*) ([0-9]+) :\\] (.*) \\[::\\]";//"\\[:(.*) :\\] (.*) \\[::\\]";//"\\[:([a-z_]+) ([0-9]+) :\\] (.*) \\[::\\]";
	//regex IP_EXPR("<:[a-z]+ [0-9]+:>");
	//const regex IP_EXPR   = "<:[a-z]+ [0-9]+:>";
	//const regex Data_EXPR = "\\[:([a-z]+) ([0-9]+) :\\]";
	//string IP;
	int sz[2]     = {0, 0};
	int max_sz[2] = {0, 0};
	basic_partition_t *partitions = nullptr;
	basic_data_t      *trace      = nullptr;

	DataParser();

	string getData(string &Log);
	//void regex_Iterator(string Txt, string EXPR_STR, int& i, void(*do_this)(string, smatch, int));
	void regex_Iterator(string Txt, string EXPR_STR, int& i, const function<void(string&, smatch&, int)>& do_this);
	void partitionHeader(header_t& Header, string Str);
	void partition_txt(string Log);
	int matches_found(string Log, string Expr_Str);
	string getPartitionBlock(string Log);
	string getDataStr(string Log);
    void min_indx(int &indx);
	string getDataStrOrig(string &Log, string &IP);
	void testconversion(basic_data_t& data);
	//regex ip_epxr;// = &Expr1;



};


