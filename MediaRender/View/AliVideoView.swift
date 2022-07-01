//
//  AliVideoView.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/6/6.
//

import Foundation
import SwiftUI
import UIKit


struct AliVideoView: View {
//    let url = "https://alivc-demo-cms.alicdn.com/video/videoAD.mp4"    @StateObject var vm:AliPlayerVM
    @StateObject var vm:AliPlayerVM
    var mediaInfo : MediaInfo? = nil
    var body: some View {
        AVideoView(vm: self.vm)
            .frame(height: vm.height, alignment: .center)
            .overlay(GeometryReader{ geo -> AnyView in
                DispatchQueue.main.async {
                    let displayWidth = geo.size.width
                    if vm.width != displayWidth {
                        vm.width = displayWidth
                    }
                }
                return AnyView(EmptyView())
            })
            .overlay(
                LoadingView(state: self.$vm.state,touching: self.$vm.touching)
                    .foregroundColor(Color.white)
                    .frame(width: 40, height: 40, alignment: .center)
            )
            .onTapGesture {
                onTouch()
            }
            .onAppear {
                vm.backSender?.addRenderReceiver(receiver: vm)
                if let info = self.mediaInfo {
                    vm.onSetAVTransportUri(info)
                    vm.onPlay(info)
                }
            }
            .onDisappear {
                vm.backSender?.removeReceiver(receiver: vm)
            }
    }
    
    func onTouch() {
        if (vm.state == .pausing || vm.state == .complete) {
            vm.play()
        } else {
            if vm.touching {
                vm.touching = false
                vm.pause()
            } else {
                vm.touching = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    vm.touching = false
                }
            }
        }
    }
}

final class AVideoView : UIViewRepresentable {
    @ObservedObject var vm:AliPlayerVM
    
    init(vm:AliPlayerVM) {
        self.vm = vm
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        vm.setPlayerView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
