//
//  RenderEventProtocal.h
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/26.
//  此类用于OC 回调 Swift
//

#ifndef RenderEventProtocal_h
#define RenderEventProtocal_h

@protocol RenderEventProtocal <NSObject>

- (void) onEvent:(int) type param1:(NSString*) p1 param2:(NSString*)p2  param3:(NSString*)p3;

@end

#endif /* RenderEventProtocal_h */
