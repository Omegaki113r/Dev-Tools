//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import desktop_window
import flutter_libserialport
import screen_retriever
import window_manager
import window_size

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DesktopWindowPlugin.register(with: registry.registrar(forPlugin: "DesktopWindowPlugin"))
  FlutterLibserialportPlugin.register(with: registry.registrar(forPlugin: "FlutterLibserialportPlugin"))
  ScreenRetrieverPlugin.register(with: registry.registrar(forPlugin: "ScreenRetrieverPlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
  WindowSizePlugin.register(with: registry.registrar(forPlugin: "WindowSizePlugin"))
}
