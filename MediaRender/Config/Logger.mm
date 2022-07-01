//
//  Logger.cpp
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/30.
//

#include "Logger.hpp"
#include <Foundation/Foundation.h>
void Logger::log(char const * format,...){
    NSString * fmt = [[NSString alloc] initWithCString:format encoding:NSUTF8StringEncoding];
    va_list paramList;
    va_start(paramList, format);
    NSString* logP = [[NSString alloc] initWithFormat:fmt arguments:paramList];
    NSLog(@"%@",logP);
}
