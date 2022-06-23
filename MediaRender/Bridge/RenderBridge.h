//
//  MediaRenderBridge.h
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/25.
//

#ifndef RenderBridge_h
#define RenderBridge_h
#import "RenderParams.h"
#import "RenderEventProtocal.h"
#import "OCNptResults.h"
#import "CallbackTypes.h"

@interface RenderBridge: NSObject

// 初始化
+ (void) initBridge:(id<RenderEventProtocal>) eventReceiver;

// 开始监听
+ (int)  start:(RenderParams*) params;

// 执行指令
+ (int)  execute:(int) cmd param1:(char*) p1 param2:(char*)p2  param3:(char*)p3;

// 关闭
+ (int)  stop;

// 销毁
+ (int)  destroy;

// 事件回调
+ (void) onEvent:(int) type param1:(const char*) p1 param2:(const char*)p2  param3:(const char*)p3;

@end

#endif /* RenderBridge_h */
