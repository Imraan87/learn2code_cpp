/*
 * DataParser.cpp
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#include "DataParser.h"

string DataParser::getDataStr(string &Log, string &IP)
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
