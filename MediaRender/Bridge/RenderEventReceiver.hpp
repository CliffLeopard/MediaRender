//
//  RenderEventReceiver.h
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/26.
//  此类用于 C++ 回调 OC 代码。 文件格式为OC,内容格式为C++
//

#ifndef RenderEventReceiver_h
#define RenderEventReceiver_h
class RenderEventReceiver {
    public:
        static void onEvent(int type, const char* p1, const char* p2, const char* p3);
};

#endif /* RenderEventReceiver_h */
