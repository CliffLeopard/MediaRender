//
//  RenderEventReceiver.m
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/26.
//  此类用于C++ 回调 OC 代码
//

#import "RenderEventReceiver.hpp"
#import "RenderBridge.h"
#include "iostream"
using namespace std;

void RenderEventReceiver::onEvent(int type, const char* p1, const char* p2, const char* p3){
    [RenderBridge onEvent:type param1:p1 param2:p2 param3:p3];
}

