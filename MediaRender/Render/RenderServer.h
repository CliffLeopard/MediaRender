//
//  DLNAServer.h
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/25.
//

#ifndef PLATINUMMEDIA_DLNASERVER_H
#define PLATINUMMEDIA_DLNASERVER_H

#include <Platinum/PltUPnP.h>
#include "MediaRenderer.h"

class RenderServer {
public:
    RenderServer();

    ~RenderServer();

    NPT_Result Start(const char *friendly_name, bool show_ip = false, const char *uuid = NULL,
                     unsigned int port = 0, bool port_rebind = false);

    NPT_Result Stop();

    MediaRenderer *getMediaRenderer();

private:
    PLT_UPnP mUPnP;
    PLT_DeviceHostReference mDevice;
    MediaRenderer *mediaRenderer;
};


#endif //PLATINUMMEDIA_DLNASERVER_H
