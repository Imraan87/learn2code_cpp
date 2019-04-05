/*
 * pllparser.cpp
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#include "pllparser.h"

pll_parser::pll_parser() {
	IP = "pll";
	//ip_epxr1(IP_EXPR);

}

pll_parser::~pll_parser() {
	// TODO Auto-generated destructor stub
}

pll_t pll_parser::getData1(string Log){


	string DataStr = getData(Log);

	cout << DataStr << endl;











	smatch match_ip;
	smatch match_data;
	regex ip_epxr(IP_EXPR_STR);
	regex data_epxr(Data_EXPR_STR);
	pll_t data;
	string IPNO;
	//string DataStr;


	while (regex_search (Log, match_ip, ip_epxr))
	{
		cout << match_ip[0] << endl;
		cout << IP << endl;
		cout << match_ip[1] << endl;
		cout << match_ip.size() << endl;
		if (IP.compare(match_ip[1].str()) != 0)
		{
			Log = match_ip.suffix().str();
		}
		else
		{
			IPNO = match_ip[2].str();
			cout << "IP Number:" << IPNO << endl;
			Log = match_ip.suffix().str();
			if (regex_search (Log, match_ip, ip_epxr))
			{
				DataStr = match_ip.prefix().str();
			}
			while (regex_search (DataStr, match_data, data_epxr))
			{
				cout << match_data[0] << endl;
				DataStr = match_data.suffix().str();
			}
		}
	}

	return data;

}


