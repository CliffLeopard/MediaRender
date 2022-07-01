//
//  MediaRenderer.cpp
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/25.
//

#include <Neptune/Neptune.h>
#include "MediaRenderer.h"
#include "Logger.hpp"
#include "CallbackTypes.h"
#import "RenderEventReceiver.hpp"
#include "iostream"
using namespace std;

NPT_SET_LOCAL_LOGGER("MediaRenderer")

MediaRenderer::MediaRenderer(const char *friendly_name,
                             bool show_ip,
                             const char *uuid,
                             unsigned int port,
                             bool port_rebind)
: PLT_MediaRenderer(friendly_name, show_ip, uuid, port) {
    Logger::log("%s","MediaRenderer::MediaRenderer");
    Logger::log("Name[%s], Show IP[%d], UUID[%s], Port[%u], Port Rebind[%d]",
                friendly_name, show_ip, uuid, port, port_rebind);
}


MediaRenderer::~MediaRenderer() {
    Logger::log("%s","MediaRenderer::~MediaRenderer()");
}

NPT_Result MediaRenderer::SetupServices() {
    Logger::log("%s","MediaRenderer::SetupServices()");
    NPT_CHECK(PLT_MediaRenderer::SetupServices());
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnNext(PLT_ActionReference &action) {
    Logger::log("%s","MediaRenderer::OnNext()");
    NPT_String uri, meta;
    PLT_Service *service;
    NPT_CHECK_SEVERE(FindServiceByType("urn:schemas-upnp-org:service:AVTransport:1", service));
    NPT_CHECK_SEVERE(action->GetArgumentValue("NextURI", uri));
    NPT_CHECK_SEVERE(action->GetArgumentValue("NextURIMetaData", meta));
    service->SetStateVariable("NextAVTransportURI", uri);
    service->SetStateVariable("NextAVTransportURIMetaData", meta);
    NPT_CHECK_SEVERE(action->SetArgumentsOutFromStateVariable());
    DoOCCallback(CALLBACK_EVENT_ON_NEXT, uri, meta);
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnPause(PLT_ActionReference &action) {
    Logger::log("%s","MediaRenderer::OnPause()");
    PLT_Service *service;
    DoOCCallback(CALLBACK_EVENT_ON_PAUSE);
    NPT_CHECK_SEVERE(FindServiceByType("urn:schemas-upnp-org:service:AVTransport:1", service));
    service->SetStateVariable("TransportState", "PAUSED_PLAYBACK");
    service->SetStateVariable("TransportStatus", "OK");
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnPrevious(PLT_ActionReference &action) {
    Logger::log("%s","MediaRenderer::OnPrevious()");
    DoOCCallback(CALLBACK_EVENT_ON_PREVIOUS);
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnStop(PLT_ActionReference &action) {
    Logger::log("%s","MediaRenderer::OnStop()");
    PLT_Service *service;
    DoOCCallback(CALLBACK_EVENT_ON_STOP);
    NPT_CHECK_SEVERE(FindServiceByType("urn:schemas-upnp-org:service:AVTransport:1", service));
    service->SetStateVariable("TransportState", "STOPPED");
    service->SetStateVariable("TransportStatus", "OK");
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnPlay(PLT_ActionReference &action) {
    Logger::log("%s","MediaRenderer::OnPlay()");
    NPT_String uri, meta;
    PLT_Service *service;
    NPT_CHECK_SEVERE(FindServiceByType("urn:schemas-upnp-org:service:AVTransport:1", service));
    NPT_CHECK_SEVERE(service->GetStateVariableValue("AVTransportURI", uri));
    NPT_CHECK_SEVERE(service->GetStateVariableValue("AVTransportURIMetaData", meta));
    service->SetStateVariable("TransportState", "TRANSITIONING");
    service->SetStateVariable("TransportStatus", "OK");
    DoOCCallback(CALLBACK_EVENT_ON_PLAY, uri, meta);
    service->SetStateVariable("TransportState", "PLAYING");
    service->SetStateVariable("TransportStatus", "OK");
    service->SetStateVariable("AVTransportURI", uri);
    service->SetStateVariable("AVTransportURIMetaData", meta);
    service->SetStateVariable("NextAVTransportURI", "");
    service->SetStateVariable("NextAVTransportURIMetaData", "");
    NPT_CHECK_SEVERE(action->SetArgumentsOutFromStateVariable());
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnSeek(PLT_ActionReference &action) {
//    PLT_ActionDesc desc = action->GetActionDesc();
    NPT_String instanceId,unit, target;
    NPT_CHECK_SEVERE(action->GetArgumentValue("InstanceID", instanceId));
    NPT_CHECK_SEVERE(action->GetArgumentValue("Unit", unit));
    NPT_CHECK_SEVERE(action->GetArgumentValue("Target", target));
    Logger::log("MediaRenderer:OnSeek() [%s],  unit:[%s], target:[%s]",instanceId.GetChars(), unit.GetChars(), target.GetChars());
//    if (!unit.Compare("REL_TIME")) {
        NPT_UInt32 seconds;
        NPT_CHECK_SEVERE(PLT_Didl::ParseTimeStamp(target, seconds));
        const char *secondString = NPT_String::FromInteger(seconds).GetChars();
        DoOCCallback(CALLBACK_EVENT_ON_SEEK, unit, target, secondString);
//    }
    return NPT_SUCCESS;
}


NPT_Result MediaRenderer::OnSetAVTransportURI(PLT_ActionReference &action) {
    Logger::log("%s","MediaRenderer::OnSetAVTransportURI()");
    NPT_String uri, meta;
    PLT_Service *service;
    NPT_CHECK_SEVERE(FindServiceByType("urn:schemas-upnp-org:service:AVTransport:1", service));
    NPT_CHECK_SEVERE(action->GetArgumentValue("CurrentURI", uri));
    NPT_CHECK_SEVERE(action->GetArgumentValue("CurrentURIMetaData", meta));
    service->SetStateVariable("TransportState", "STOPPED");
    service->SetStateVariable("TransportStatus", "OK");
    service->SetStateVariable("TransportPlaySpeed", "1");
    service->SetStateVariable("AVTransportURI", uri);
    service->SetStateVariable("AVTransportURIMetaData", meta);
    service->SetStateVariable("NextAVTransportURI", "");
    service->SetStateVariable("NextAVTransportURIMetaData", "");
    NPT_CHECK_SEVERE(action->SetArgumentsOutFromStateVariable());
    DoOCCallback(CALLBACK_EVENT_ON_SET_AV_TRANSPORT_URI, uri.GetChars(), meta.GetChars());
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnSetVolume(PLT_ActionReference &action) {
    NPT_String volume;
    NPT_CHECK_SEVERE(action->GetArgumentValue("DesiredVolume", volume));
    DoOCCallback(CALLBACK_EVENT_ON_SET_VOLUME, volume.GetChars());
    Logger::log("MediaRenderer::OnSetVolume(): %s", volume.GetChars());
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::OnSetMute(PLT_ActionReference &action) {
    Logger::log("%s","MediaRenderer::OnSetMute()");
    NPT_String mute;
    NPT_CHECK_SEVERE(action->GetArgumentValue("DesiredMute", mute));
    DoOCCallback(CALLBACK_EVENT_ON_SET_MUTE, mute.GetChars());
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::ProcessHttpGetRequest(NPT_HttpRequest &request,
                                                const NPT_HttpRequestContext &context,
                                                NPT_HttpResponse &response) {
    NPT_String ip_address = context.GetRemoteAddress().GetIpAddress().ToString();
    NPT_String method = request.GetMethod();
    NPT_String protocol = request.GetProtocol();
    NPT_HttpUrl url = request.GetUrl();
    Logger::log("Http: IP: %s\nMethod: %s\nProtocol: %s\nUrl: %s",
                ip_address.GetChars(), method.GetChars(), protocol.GetChars(), url.ToString().GetChars());
    return PLT_DeviceHost::ProcessHttpGetRequest(request, context, response);
}

NPT_Result MediaRenderer::DoOCCallback(int type, const char *param1,
                                         const char *param2,
                                         const char *param3) {
    
    RenderEventReceiver::onEvent(type, param1,param2,param3);
    return NPT_SUCCESS;
}

NPT_Result MediaRenderer::UpdateServices(int cmd, const char *param1,const char *param2) {
    Logger::log("MediaRenderer::UpdateServices(), cmd = %d, param1 = %s, param2 = %s", cmd, param1, param2);
    PLT_Service *service;
    NPT_CHECK_SEVERE(FindServiceByType("urn:schemas-upnp-org:service:AVTransport:1", service));
    if (cmd == CALLBACK_EVENT_ON_SET_MEDIA_DURATION) {
        service->SetStateVariable("CurrentTrackDuration", param1);
        service->SetStateVariable("CurrentMediaDuration", param1);
    } else if (cmd == CALLBACK_EVENT_ON_SET_MEDIA_POSITION) {
        service->SetStateVariable("RelativeTimePosition", param1);
        service->SetStateVariable("AbsoluteTimePosition", param1);
    } else if (cmd == CALLBACK_EVENT_ON_SET_MEDIA_PLAYING_STATE) {
        service->SetStateVariable("TransportState", param1);
        service->SetStateVariable("TransportStatus", "OK");
    }
    return NPT_SUCCESS;
}


