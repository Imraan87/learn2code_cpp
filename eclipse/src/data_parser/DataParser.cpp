/*
 * DataParser.cpp
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#include "DataParser.h"

DataParser::DataParser()
{

}

string DataParser::getData(string &Log)
{

	max_sz[0] = matches_found(Log,SECTION_EXPR_STR);
	max_sz[1] = matches_found(Log,Data_EXPR_STR);


	basic_partition_t pt[max_sz[0] + 1];
	basic_data_t      dt[max_sz[1] + 1];


	partitions = &pt[0];
	trace      = &dt[0];

	int i;

	partition_txt(Log);
	i = sz[data_expr];



	cout << dt[i].header->IP << " " << dt[i].header->IPNo << " " << dt[i].header->chan << endl;
	cout << dt[i].Name << " " << dt[i].sz << endl << dt[i].Value << endl;



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

	min_indx(i);

	return i;
}

void DataParser::partitionHeader(header_t& Header, string Str)
{
	smatch match_section;
	string wCard = "(.*)";
	string ExprStr;

	ExprStr.clear();
	ExprStr.append(wCard);

	if(Str[Str.size()-1]==' ')
	{
		Header.Str = Str.substr(0, Str.size() - 1);
	}
	else
	{
		Header.Str = Str;
	}

	Str = Header.Str;





	unsigned int j = 0;

	for (unsigned int ii = 0; ii < Str.size(); ii++)
	{
		if(Str[ii]==' ')
		{
			j++;
		}
	}



	for (unsigned int ii  = 0; ii < j; ii++)
	 {
		ExprStr.append(" ");
		ExprStr.append(wCard);
	 }



	regex Expr(ExprStr);
	regex_search (Str, match_section, Expr);

	printSmatchDebug(Str, match_section);

	switch (match_section.size())
	{
	case 5: str2num(&Header.Dim2Sz, match_section[4], 1); // @suppress("No break at end of case")
	case 4:
		{
			if(match_section[3]=='I')
			{
				Header.chan = chan_t::I;
			}
			else if(match_section[3]=='Q')
			{
				Header.chan = chan_t::Q;
			}
			else
			{
				str2num(&Header.Dim2Sz, match_section[3], 1);
			}
		} // @suppress("No break at end of case")
	case 3: str2num(&Header.IPNo, match_section[2], 1); // @suppress("No break at end of case")
	default: Header.IP   = match_section[1];
	    ;
	}

/*
	if (match_section.size() > 3)
	{
		Header.IP   = match_section[1];
		str2num(&Header.IPNo, match_section[2], 1);
	}
	else if ()
	{
		Header.IP   = match_section[1];
		str2num(&Header.IPNo, match_section[2], 1);
	}
	/*/
}

void DataParser::partition_txt(string Log)
{
	smatch match_section;
	regex epxr(SECTION_EXPR_STR);

	int& i       = sz[section_expr];
	auto do_this = [&](string& Txt, smatch& match_section, int i)
			{
		     //partitions[i].header.Str    = match_section[1];
		     partitionHeader(partitions[i].header,match_section[1]);
		     partitions[i].datastr   = getPartitionBlock(Txt);
			 Txt                     = match_section.suffix().str();
			};

	regex_Iterator(Log, SECTION_EXPR_STR, i, do_this);
	i = i - 1;

	return;
}


string DataParser::getPartitionBlock(string Log)
{
	smatch match_section;
	regex epxr(SECTION_EXPR_STR);
	string Str;



	if (regex_search (Log, match_section, epxr))
	{
		Log = match_section.suffix().str();
		if (regex_search (Log, match_section, epxr))
		{
			Str = match_section.prefix().str();
		}
		else
		{
			Str = Log;
		}
	}
	Str = getDataStr(Str);

	return Str;
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

		DataStr.append(match_data[0]);
		DataStr.append("\r");
		trace[i].header = &partitions[j].header;
		trace[i].Name   = match_data[1];
		trace[i].sz     = stoi(match_data[2]);
		trace[i].Value  = match_data[3];
		testconversion(trace[i]);


		Log = match_data.suffix().str();
		i = i + 1;
	}

	i = i -1;

	min_indx(i);

	return DataStr;
}

void DataParser::testconversion(basic_data_t& data)
{
	pll_t pll;

	string str1, str2;

	str1 = "vsign_wide";
	str2 = "act_wide";

	if (data.Name.compare(str1) == 0)
	{
		str2num(pll.vsign_wide, data.Value, data.sz);
	}
	else if (data.Name.compare(str2) == 0)
	{
		str2num(pll.act_wide, data.Value, data.sz);
	}
	else
	{

	}




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

void DataParser::printSmatchDebug(string &mystr, smatch match_section)
{
	cout << "Input Str: " << mystr << "\n";
	cout << match_section.size() << " matches found:" << "\n";
	for (unsigned  i = 0; i < match_section.size(); i++) {
	  cout <<  i << ":" << match_section[i] << "\n";
	}
	cout << "\n" << endl;
}
