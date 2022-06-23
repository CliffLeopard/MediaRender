//
//  RenderParams.h
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/25.
//

#ifndef RenderParams_h
#define RenderParams_h
#import <UIKit/UIKit.h>
@interface RenderParams : NSObject {
    @public
    char* name;
    @public
    bool showIp;
    @public
    char* uuid;
}
-(id)initWithName:(char*)aname  ShowIp:(bool)aShowIp    Uuid:(char*)aUuid;
@end
#endif /* RenderParams_h */
