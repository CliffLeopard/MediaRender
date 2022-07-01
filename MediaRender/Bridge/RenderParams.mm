//
//  RenderParams.m
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/25.
//

#import "RenderParams.h"
@implementation RenderParams
-(id)initWithName:(char*) aname  ShowIp:(bool)aShowIp    Uuid:(char*)aUuid {
    if (self = [super init]) {
        name = aname;
        showIp = aShowIp;
        uuid = aUuid;
    }
    return self;
}
@end

