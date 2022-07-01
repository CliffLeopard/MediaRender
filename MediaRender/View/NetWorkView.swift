//
//  NetWorkView.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/27.
//

import SwiftUI
import CoreTelephony
struct NetWorkView: View {
    var body: some View {
        NavigationView {
            VStack{
                Button("请求网络权限"){
                    getNetState()
                }
                
                NavigationLink("进入DLNA Render") {
                    ContentView()
                }
            }
        }
    }
    
    func getNetState(){
        let celData = CTCellularData.init()
        switch celData.restrictedState {
        case .restricted:
            print("restricted")
        case .notRestricted:
            print("notRestricted")
        case .restrictedStateUnknown:
            print("restrictedStateUnknown")
            request()
        @unknown default:
            print("@unknown")
        }
    }
    
    func request() {
        let url:URL = URL(string: "https://www.baidu.com")!;
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, response, error in
            debugPrint("data",data ?? "nil")
            debugPrint("response",response ?? "nil")
        }
        task.resume()
    }
}

struct NetWorkView_Previews: PreviewProvider {
    static var previews: some View {
        NetWorkView()
    }
}
