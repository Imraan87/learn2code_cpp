/*
 * DataParser.cpp
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#include "DataParser.h"

string DataParser::getData(string &Log, string &IP)
{

	max_sz[0] = matches_found(Log,SECTION_EXPR_STR);
	max_sz[1] = matches_found(Log,Data_EXPR_STR);


	basic_partition_t pt[max_sz[0]];
	basic_data_t      dt[max_sz[1]];

	partitions = &pt[0];
	trace      = &dt[0];

	partition_txt(Log);



    //cout <<  getDataStr(partitions[160].datastr) << endl   << partitions[160].header << endl;

	//cout << partitions[sz].header << endl   << sz << endl;// << DataBlock[sz].datastr << endl << DataBlock[sz].header << endl;



	return "";
}

void DataParser::min_indx(int &indx)
{
	if (indx <= 0)
	{
		indx = 0;
	}
}

void DataParser::regex_Iterator(string Txt, string EXPR_STR, int& i, const function<void(string&, smatch&, int)>& do_this)
{
	smatch matches;
	regex epxr(EXPR_STR);

	while (regex_search (Txt, matches, epxr))
	{
		do_this(Txt, matches, i);
		i++;
	}
}

int DataParser::matches_found(string Txt, string Expr_Str)
{
	int i        = 0;
	auto do_this = [&](string& Txt, smatch& match_section, int i)
		{
		 Txt = match_section.suffix().str();
		};

	regex_Iterator(Txt, Expr_Str, i, do_this);

	i = i - 1;
	cout <<  i << endl;
	min_indx(i);

	return i;
}

void DataParser::partition_txt(string Log)
{
	smatch match_section;
	regex epxr(SECTION_EXPR_STR);

	int& i = sz[section_expr];

	while (regex_search (Log, match_section, epxr))
	{
		cout << match_section.size();
		partitions[i].header = match_section[0];
		partitions[i]        = getPartitionBlock(Log);
		Log                   = match_section.suffix().str();
		i                    = i + 1;
	}

	//sz[section_expr] = i - 1;
	min_indx(i);

	return;
}


basic_partition_t DataParser::getPartitionBlock(string Log)
{
	smatch match_section;
	regex epxr(SECTION_EXPR_STR);
	basic_partition_t Block;
	Block.isempty = false;


	if (regex_search (Log, match_section, epxr))
	{
		Log = match_section.suffix().str();
		if (regex_search (Log, match_section, epxr))
		{
			Block.datastr = match_section.prefix().str();
		}
		else
		{
			Block.datastr = Log;
		}
	}
	//cout <<  Block.datastr << endl;
	Block.datastr = getDataStr(Block.datastr);

	return Block;
}

string DataParser::getDataStr(string Log)
{

	smatch match_data;
	regex data_epxr(Data_EXPR_STR);

	string DataStr;

	int& i = sz[data_expr];
	int& j = sz[section_expr];


	DataStr.clear();


	while (regex_search (Log, match_data, data_epxr))
	{

		//cout << match_data[1] << endl << match_data.size() << endl;
		DataStr.append(match_data[0]);
		DataStr.append("\r");
		trace[i].Group  = partitions[j].header;
		trace[i].Name   = match_data[1];
		trace[i].sz     = match_data[2];
		trace[i].Value  = match_data[3];

		cout << trace[i].Group << endl << trace[i].Name << endl << trace[i].sz << endl << trace[i].Value << endl;

		Log = match_data.suffix().str();
		i = i + 1;
	}

	//i = i - 1;

	min_indx(i);

	return DataStr;
}


string DataParser::getDataStrOrig(string &Log, string &IP)
{
	smatch match_ip;
	smatch match_data;
	regex ip_epxr(IP_EXPR_STR);
	regex data_epxr(Data_EXPR_STR);

	string IPNO;
	string DataStr;


	while (regex_search (Log, match_ip, ip_epxr))
	{

		if (IP.compare(match_ip[1].str()) != 0)
		{
			Log = match_ip.suffix().str();
		}
		else
		{
			Log = match_ip.suffix().str();
			if (regex_search (Log, match_ip, ip_epxr))
			{
				return match_ip.prefix().str();
			}
		}
	}
	return "";
}
