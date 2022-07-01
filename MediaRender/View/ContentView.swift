//
//  ContentView.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/5/25.
//

import SwiftUI

struct ContentView: View {
    let controller: AliPlayerVM = AliPlayerVM(true)
    @EnvironmentObject var sourceCenter:MeidaSourceCenter
    var body: some View {
        VStack{
            AliVideoView(vm:controller)
            Spacer()
            Button(action: {
                RenderCenter.share.start()
            }) {
                Text("注册MediaRender")
            }
            
            Spacer()
            
            Button(action: {
                RenderCenter.share.stop()
            }) {
                Text("停止MediaRender")
            }
            
            Spacer()
            Button(action: {
                RenderCenter.share.destroy()
            }) {
                Text("注销MediaRender")
            }
            Spacer()
        }
      
    }
    
    init(){
        RenderCenter.share.addRenderReceiver(receiver: self.controller)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
