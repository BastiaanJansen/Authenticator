//
//  SettingsView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import LocalAuthentication
import UIKit

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var settingsVM = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Security")) {
                    if let type = BiometricAuthService.shared.biometricType, BiometricAuthService.shared.biometricType != .none {
                        Toggle(isOn: $settingsVM.biometricAuthenticationIsEnabled) {
                            SettingsRowView(
                                text: type == .faceID ? "Face ID" : "Touch ID",
                                icon: Image(systemName: type == .faceID ? "faceid" : "touchid"),
                                iconColor: type == .faceID ? .green : .red
                            )
                        }.toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    }
                }
                
                Section(header: Text("Appearance")) {
                    NavigationLink(destination: AlternateAppIconsListView()) {
                        SettingsRowView(
                            text: "App icon",
                            icon: Image(systemName: "app"),
                            iconColor: .accentColor
                        )
                    }
                    
                }
                
                Section(header: Text("About"), footer: Text("Version: \(settingsVM.getAppVersion() ?? "unknown")")) {
                    Button(action: {
                        URL.open(link: URL.Link.github)
                    }) {
                        SettingsRowView(
                            text: "GitHub",
                            icon: Image(systemName: "link"),
                            iconColor: .accentColor,
                            iconSize: .medium
                        )
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                }
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
            SettingsView().preferredColorScheme(.dark)
            SettingsView().previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
