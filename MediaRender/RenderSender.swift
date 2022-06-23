//
//  RenderSender.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/6/22.
//  向视频源设备发送消息。上报当前播放状态
//

import Foundation

extension RenderCenter {
    func start() {
        let params = buildRenderParam()
        let result = RenderBridge.start(params)
        debugPrint("start:",result)
    }
    
    func stop() {
        let result = RenderBridge.stop()
        debugPrint("stop:",result)
        self.execute(cmd: 1013, p1: "STOPPED", p2: "", p3: "")
    }
    
    func destroy() {
        let result = RenderBridge.destroy()
        debugPrint("destroy:",result)
    }
    
    func setMediaDuration(duration:Int64){
        debugPrint("时长",self.msToStr(duration))
        self.execute(cmd: 1011,p1: self.msToStr(duration))
    }

    func setMediaPosition(position:Int64) {
        debugPrint("视频当前播放位置回调",self.msToStr(position))
        self.execute(cmd: 1012,p1: self.msToStr(position))
    }

    func setMeidaPlayubgState(state:String) {
        self.execute(cmd: 1013 ,p1:state)
    }
    
    func execute(cmd:Int32, p1:String = "" , p2:String = "" , p3:String = "") {
        let result = RenderBridge.execute(cmd, param1: toChar(p1),
                             param2: toChar(p2),
                             param3: toChar(p3))
        debugPrint("execute:",result)
    }
    
    private func toChar(_ p:String) -> UnsafeMutablePointer<CChar>{
        let nsP: NSString = NSString(string: p)
        return UnsafeMutablePointer<CChar>(mutating:nsP.utf8String)!
    }
    
    private func msToStr(_ time:Int64) -> String {
        var second:Int64 = time / 1000
        var minutes:Int64 = second / 60
        second = second % 60
        let hours = minutes / 60
        minutes = minutes % 60
        var timeStr:String = ""
        if hours < 10 {
            timeStr += "0"
        }
        timeStr += String(hours) + ":"
        if minutes < 10 {
            timeStr += "0"
        }
        timeStr += String(minutes) + ":"
        
        if second < 10 {
            timeStr += "0"
        }
        timeStr += String(second)
        return timeStr
    }
    
    private func buildRenderParam() -> RenderParams {
        let cName = toChar(name)
        let cUUid = toChar(uuid)
        return RenderParams(name: cName,showIp: showIp, uuid: cUUid)
    }
}

//    service->SetStateVariableRate("LastChange", NPT_TimeInterval(0.2f));
//    service->SetStateVariable("A_ARG_TYPE_InstanceID", "0");
//
//    // GetCurrentTransportActions
//    service->SetStateVariable("CurrentTransportActions", "Play,Pause,Stop,Seek,Next,Previous");
//
//    // GetDeviceCapabilities
//    service->SetStateVariable("PossiblePlaybackStorageMedia", "NONE,NETWORK,HDD,CD-DA,UNKNOWN");
//    service->SetStateVariable("PossibleRecordStorageMedia", "NOT_IMPLEMENTED");
//    service->SetStateVariable("PossibleRecordQualityModes", "NOT_IMPLEMENTED");
//
//    // GetMediaInfo
//    service->SetStateVariable("NumberOfTracks", "0");
//    service->SetStateVariable("CurrentMediaDuration", "00:00:00");
//    service->SetStateVariable("AVTransportURI", "");
//    service->SetStateVariable("AVTransportURIMetadata", "");;
//    service->SetStateVariable("NextAVTransportURI", "NOT_IMPLEMENTED");
//    service->SetStateVariable("NextAVTransportURIMetadata", "NOT_IMPLEMENTED");
//    service->SetStateVariable("PlaybackStorageMedium", "NONE");
//    service->SetStateVariable("RecordStorageMedium", "NOT_IMPLEMENTED");
//    service->SetStateVariable("RecordMediumWriteStatus", "NOT_IMPLEMENTED");
//
//    // GetPositionInfo
//    service->SetStateVariable("CurrentTrack", "0");
//    service->SetStateVariable("CurrentTrackDuration", "00:00:00");
//    service->SetStateVariable("CurrentTrackMetadata", "");
//    service->SetStateVariable("CurrentTrackURI", "");
//    service->SetStateVariable("RelativeTimePosition", "00:00:00");
//    service->SetStateVariable("AbsoluteTimePosition", "00:00:00");
//    service->SetStateVariable("RelativeCounterPosition", "2147483647"); // means NOT_IMPLEMENTED
//    service->SetStateVariable("AbsoluteCounterPosition", "2147483647"); // means NOT_IMPLEMENTED
