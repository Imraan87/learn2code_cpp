/*
 * DataParser.cpp
 *
 *  Created on: 9 Dec 2018
 *      Author: IIBRAH
 */

#include "DataParser.h"

string DataParser::getData(string &Log, string &IP)
{
	smatch match_section;
	regex epxr(SECTION_EXPR_STR);//partitionS
	basic_partition_t DataBlock;

	DataBlock = partition_txt(Log);

	while (regex_search (Log, match_section, epxr))
	{

		DataBlock = getPartitionBlock(match_section[0], Log);
		cout << DataBlock.header << endl << DataBlock.datastr << endl << DataBlock.header  << endl;
		Log = match_section.suffix().str();
	}
	return "";
}

basic_partition_t DataParser::partition_txt(string Log)
{
	smatch match_section;
	regex epxr(SECTION_EXPR_STR);
	basic_partition_t partitions;

	while (regex_search (Log, match_section, epxr))
	{

		partitions = getPartitionBlock(match_section[0], Log);
		Log        = match_section.suffix().str();

		cout << partitions.header << endl << partitions.datastr << endl << partitions.header  << endl;
	}
	return partitions;
}




basic_partition_t DataParser::getPartitionBlock(string Header, string Log)
{
	smatch match_section;
	regex epxr(SECTION_EXPR_STR);
	basic_partition_t Block;
	Block.isempty = false;
	Block.header = Header;

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
	//Block.datastr = getDataStr(Block.datastr);

	return Block;
}

string DataParser::getDataStr(string Log)
{

	smatch match_data;
	regex data_epxr(Data_EXPR_STR);

	string IPNO;
	string DataStr;


	DataStr.clear();


	while (regex_search (Log, match_data, data_epxr))
	{

		//cout << match_data[0] << endl;
		DataStr.append(match_data[0]);
		DataStr.append("\r");

		Log = match_data.suffix().str();
	}

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
