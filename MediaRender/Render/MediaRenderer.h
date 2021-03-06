//
//  MediaRenderer.h
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/25.
//

#ifndef PLATINUMMEDIA_MEDIARENDER_H
#define PLATINUMMEDIA_MEDIARENDER_H

#include <Platinum/Platinum.h>
#include <Platinum/PltMediaRenderer.h>

class MediaRenderer : public PLT_MediaRenderer {
public:
    MediaRenderer(const char *friendly_name,
                  bool show_ip = false,
                  const char *uuid = NULL,
                  unsigned int port = 0,
                  bool port_rebind = false);

    ~MediaRenderer() override;

    NPT_Result ProcessHttpGetRequest(NPT_HttpRequest &request, const NPT_HttpRequestContext &context,
                          NPT_HttpResponse &response) override;

    NPT_Result OnNext(PLT_ActionReference &action) override;

    NPT_Result OnPause(PLT_ActionReference &action) override;

    NPT_Result OnPlay(PLT_ActionReference &action) override;

    NPT_Result OnPrevious(PLT_ActionReference &action) override;

    NPT_Result OnStop(PLT_ActionReference &action) override;

    NPT_Result OnSeek(PLT_ActionReference &action) override;

    NPT_Result OnSetAVTransportURI(PLT_ActionReference &action) override;

    NPT_Result OnSetVolume(PLT_ActionReference &action) override;

    NPT_Result OnSetMute(PLT_ActionReference &action) override;

    NPT_Result UpdateServices(int type, const char *param1, const char *param2);

private:
    NPT_Result SetupServices() override;

    NPT_Result DoOCCallback(int type, const char *param1 = "",
                              const char *param2 = "",
                              const char *param3 = "");
};


#endif //PLATINUMMEDIA_MEDIARENDER_H
