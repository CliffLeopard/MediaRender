//
//  RenderBridge.m
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/25.
//
#import "RenderBridge.h"
#import "RenderServer.h"
#import "CallbackTypes.h"
#import "Logger.hpp"

static RenderServer * server;
static id<RenderEventProtocal>  receiver;
@implementation RenderBridge

// 初始化
+ (void) initBridge:(id<RenderEventProtocal>) eventReceiver{
    receiver = eventReceiver;
    server = new RenderServer;
}

// 开始监听
+ (int)  start:(RenderParams*) params {
    NPT_Result ret = NPT_ERROR_INVALID_STATE;
    if (server != nil) {
        Logger::log("%s","regist to local network");
        ret =  server->Start(params->name, params->showIp, params->uuid,0,true);
    } else {
        Logger::log("%s","MediaRenderer is Null!");
    }
    return ret;
}
// 执行指令
+ (int)  execute:(int) cmd param1:(char*) p1 param2:(char*)p2  param3:(char*)p3 {
    NPT_Result ret = NPT_ERROR_INVALID_STATE;
    if(server != nil) {
        Logger::log("Execute:[%d],  param1:[%s], param2:[%s], param3:[%u]",cmd, p1, p2, p3);
        MediaRenderer *renderer = server->getMediaRenderer();
        ret =  renderer->UpdateServices(cmd,p1, p2);
    } else {
        Logger::log("%s","MediaRenderer is Null!");
    }
    return ret;
    
}
// 关闭
+ (int)  stop {
    NPT_Result ret = NPT_ERROR_INVALID_STATE;
    if (server != nil) {
        Logger::log("%s","stop listining");
        ret =  server->Stop();
    } else {
        Logger::log("%s","MediaRenderer is Null!");
    }
    return ret;
    
}
// 销毁
+ (int)  destroy {
    NPT_Result ret = NPT_ERROR_INVALID_STATE;
    if (server != 0L) {
        Logger::log("%s","destroy register");
        delete server;
        ret = NPT_SUCCESS;
    } else {
        Logger::log("%s","MediaRenderer is Null!");
    }
    
    return ret;
}

// 事件回调
+ (void) onEvent:(int) type param1:(const char*) p1 param2:(const char*)p2  param3:(const char*)p3 {
    NSString * str1 = [[NSString alloc] initWithCString:p1 encoding:NSUTF8StringEncoding];
    NSString * str2 = [[NSString alloc] initWithCString:p2 encoding:NSUTF8StringEncoding];
    NSString * str3 = [[NSString alloc] initWithCString:p3 encoding:NSUTF8StringEncoding];
    Logger::log("onEvent:[%d],  param1:[%s], param2:[%s], param3:[%s]",type, p1, p2, p3);
    [receiver onEvent:type param1:str1  param2:str2 param3:str3];
    
}
@end



