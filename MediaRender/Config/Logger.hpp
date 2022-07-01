//
//  Logger.hpp
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/30.
//

#ifndef Logger_hpp
#define Logger_hpp

#include <stdio.h>
class Logger {
    public:
        static void log(char const * format,...);
};
#endif /* Logger_hpp */
