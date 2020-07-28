cmake_minimum_required(VERSION 3.13)
project(src)

set(CMAKE_CXX_STANDARD 14)

include_directories(data_parser)
include_directories(logfile)

add_executable(src
        data_parser/data_def.h
        data_parser/DataParser.cpp
        data_parser/DataParser.h
        data_parser/Parser28HPM.cpp
        data_parser/Parser28HPM.h
        data_parser/pllparser.cpp
        data_parser/pllparser.h
        data_parser/StringConverter.cpp
        data_parser/StringConverter.h
        logfile/LogFile.cpp
        logfile/LogFile.h
        main.cpp)
