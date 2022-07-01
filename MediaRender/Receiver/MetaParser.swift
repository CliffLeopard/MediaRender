//
//  MetaParser.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/30.
//

import Foundation

class MetaParser: NSObject,XMLParserDelegate {
    
    var currentTag:String!
    var xmlDict = [String:String]()
    var mediaInfo:MediaInfo = MediaInfo()
    var comletion: (MediaInfo) ->Void = { _ in }
    
    func parseMeta(url:String,meta:String, comletion: @escaping(MediaInfo) ->Void) {
        let parser = XMLParser(data: meta.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).data(using: .utf8)!)
        self.mediaInfo.url = url
        self.comletion = comletion
        parser.delegate = self
        parser.parse()
    }
    
    // 开始标签
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch(elementName){
        case "DIDL-Lite":
            debugPrint("parse begin")
            xmlDict["xmlns"] = attributeDict["xmlns"]
            xmlDict["xmlnsDc"] = attributeDict["xmlns:dc"]
            xmlDict["xmlnsUpnp"] = attributeDict["xmlns:upnp"]
            currentTag = elementName
        case "item":
            debugPrint("get item")
            xmlDict["id"] = attributeDict["id"]
            xmlDict["parentID"] = attributeDict["parentID"]
            xmlDict["restricted"] = attributeDict["restricted"]
            currentTag = elementName
        case "res":
            debugPrint("get res")
            xmlDict["protocolInfo"] = attributeDict["protocolInfo"]
            currentTag = elementName
        case "dc:title":
            currentTag = "title"
        case "upnp:storageMedium":
            currentTag = "storageMedium"
        case "upnp:writeStatus":
            currentTag = "writeStatus"
        case "upnp:longDescription":
            currentTag = "longDescription"
        case "upnp:class":
            currentTag = "unpnpClass"
        default:
            currentTag = elementName
        }
    }
    
    // 字符串
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let tagContent = xmlDict[currentTag] {
            xmlDict[currentTag] = tagContent + string
        } else {
            xmlDict[currentTag] = string
        }
    }
    
    // 结束标签
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?) {
        if elementName == "DIDL-Lite" {
            debugPrint("finish Parse")
            debugPrint(xmlDict)
            parseToMediaInfo()
        }
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        debugPrint("parser found cdata")
    }
    
    func parseToMediaInfo() {
        self.mediaInfo.xmlns = self.xmlDict["xmlns"]
        self.mediaInfo.xmlnsDc = self.xmlDict["xmlnsDc"]
        self.mediaInfo.xmlnsUpnp = self.xmlDict["xmlnsUpnp"]
        self.mediaInfo.id = self.xmlDict["id"]
        self.mediaInfo.parentID = self.xmlDict["parentID"]
        self.mediaInfo.restricted = self.xmlDict["restricted"]
        self.mediaInfo.tittle = self.xmlDict["title"]
        self.mediaInfo.storageMedium = self.xmlDict["storageMedium"]
        self.mediaInfo.writeStatus = self.xmlDict["writeStatus"]
        self.mediaInfo.longDescription = self.xmlDict["longDescription"]
        self.mediaInfo.protocolInfo = self.xmlDict["protocolInfo"]
        self.mediaInfo.res = self.xmlDict["res"]
        self.mediaInfo.unpnpClass = self.xmlDict["unpnpClass"]
        self.mediaInfo.albumArtURI = self.xmlDict["albumArtURI"]
        self.comletion(self.mediaInfo)
    }
}
