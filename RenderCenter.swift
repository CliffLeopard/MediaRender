//
//  DLNACenter.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/26.
//

import Foundation

class RenderCenter : NSObject,RenderEventProtocal {
    let name:String = "Links"
    let showIp = true
    let uuid:String = "awecadvgfrbvuusrtyvfcadfr235sdvsfg"
    var receivers = [RenderReceiverProtocal]()
    
    static var share:RenderCenter!
    static func initShare(){
        debugPrint("Init DLNA")
        RenderCenter.share = RenderCenter()
        RenderBridge.initBridge(RenderCenter.share)
    }
    
    func start() {
        let params = buildRenderParam()
        let result = RenderBridge.start(params)
        debugPrint("start:",result)
    }
    
    func stop() {
        let result = RenderBridge.stop()
        debugPrint("stop:",result)
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
    
    
    func onEvent(_ type: Int32, param1 p1: String, param2 p2: String, param3 p3: String) {
        RenderEventParser.parse(type: type, p1: p1, p2: p2, p3: p3,receiver:self)
    }
    

    func addRenderReceiver(receiver:RenderReceiverProtocal){
        self.removeReceiver(receiver: receiver)
        self.receivers.append(receiver)
    }
    
    func removeReceiver(receiver:RenderReceiverProtocal){
        self.receivers.removeAll { aRecevier in
            return aRecevier.hashValue() == receiver.hashValue()
        }
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
    
    private override init() {}
    override class func copy() -> Any { return share ?? "nil" }
    override class func mutableCopy() -> Any { return share ?? "nil"}
    
    
    
    
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
    
}
