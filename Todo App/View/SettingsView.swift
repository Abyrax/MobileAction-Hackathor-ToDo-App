//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com 
//

import SwiftUI

struct SettingsView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var iconSettings: IconNames
  
  // THEME
  
  let themes: [Theme] = themeData
  @ObservedObject var theme = ThemeSettings.shared
  @State private var isThemeChanged: Bool = false
  
  // MARK: - BODY
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center, spacing: 0) {
        // MARK: - FORM
        
        Form {
          // MARK: - SECTION 2
          
          Section(header:
            HStack {
              Text("Choose the app theme")
              Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(themes[self.theme.themeSettings].themeColor)
            }
          ) {
            List {
              ForEach(themes, id: \.id) { item in
                Button(action: {
                  self.theme.themeSettings = item.id
                  UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                  self.isThemeChanged.toggle()
                }) {
                  HStack {
                    Image(systemName: "circle.fill")
                      .foregroundColor(item.themeColor)
                    
                    Text(item.themeName)
                  }
                } //: BUTTON
                  .accentColor(Color.primary)
              }
            }
          } //: SECTION 2
            .padding(.vertical, 3)
            .alert(isPresented: $isThemeChanged) {
              Alert(
                title: Text("SUCCESS!"),
                message: Text("App has been changed to the \(themes[self.theme.themeSettings].themeName)!"),
                dismissButton: .default(Text("OK"))
              )
          }
        } //: FORM
          .listStyle(GroupedListStyle())
          .environment(\.horizontalSizeClass, .regular)
        
        // MARK: - FOOTER
        
        
      } //: VSTACK
        .navigationBarItems(trailing:
          Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "xmark")
          }
        )
        .navigationBarTitle("Settings", displayMode: .inline)
        .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
    } //: NAVIGATION
      .accentColor(themes[self.theme.themeSettings].themeColor)
      .navigationViewStyle(StackNavigationViewStyle())
  }
}

// MARK: - PREIVEW

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView().environmentObject(IconNames())
      .previewDevice("iPhone 12 Pro")
  }
}
