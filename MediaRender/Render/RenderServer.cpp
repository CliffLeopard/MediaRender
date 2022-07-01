//
//  DLNAServer.cpp
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/25.
//
#include "RenderServer.h"
#include "MediaRenderer.h"
#include "Logger.hpp"


RenderServer::RenderServer() {
    Logger::log("%s","DLNAServer::DLNAServer()");
}

RenderServer::~RenderServer() {
    Logger::log("%s","DLNAServer::~DLNAServer()");
}

NPT_Result RenderServer::Start(const char *friendly_name, bool show_ip, const char *uuid,
                  unsigned int port, bool port_rebind) {
    MediaRenderer *renderer = new MediaRenderer(friendly_name, show_ip, uuid, port, port_rebind);
    mDevice = renderer;
    mediaRenderer = renderer;
    mUPnP.AddDevice(mDevice);
    return mUPnP.Start();
}

NPT_Result RenderServer::Stop() {
    if (mDevice.IsNull()|| !mUPnP.IsRunning()) {
        return NPT_FAILURE;
    }
    mUPnP.Stop();
    return 0;
}

MediaRenderer *RenderServer::getMediaRenderer() {
    return mediaRenderer;
}
