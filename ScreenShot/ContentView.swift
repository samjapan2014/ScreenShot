import SwiftUI
import Foundation

struct ContentView: View {
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @State private var isShowing = false
    
    var body: some View {
        DisappearingView()
        /*
        if screenshotDetector.isScreenshotDetected {
            Text("This view will disappear after 3 seconds.")
                .padding()
        } else {
            // Show the regular content when no screenshot is detected
            Text("Regular Content")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
         */
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(ScreenshotDetector())
        }
    }
    
    struct DisappearingView: View {
        @State private var isShowing = true

        var body: some View {
            if isShowing {
                Text("This view will disappear after 3 seconds.")
                    .padding()
                    .onAppear {
                        // Start a timer to hide the view after 3 seconds
                        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
    }
    
    struct WidgetView: View {
        @State private var isAlertViewVisible = false
        var body: some View {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.height / 5)
                .cornerRadius(20)
                .foregroundColor(.blue)
                .padding(.trailing, 20)
                .padding(.top, 20)
            
            VStack(spacing: 10) {
                // Placeholder 1
                CircleView().onTapGesture {
                    
                }
                // Placeholder 2
                CircleView().onTapGesture {
                    
                }
                // Placeholder 3
                CircleView().onTapGesture {
                    isAlertViewVisible = true
                }
            }
            .padding(.trailing, 20)
            .padding(.top, 20)
        }
    }
    
    struct CircleView: View {
        var body: some View {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                )
        }
    }
    
    struct AlertView: View {
        @State private var showingAlert = false
        @State private var enteredText = ""
        var body: some View {
            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Enter new photo album name", isPresented: $showingAlert) {
                TextField("Enter text", text: $enteredText)
                Button() {
                    // Handle the deletion.
                    PhotoHelper.createNewPhotoAlbum(albumName: enteredText)
                } label: {
                    Text("Submit")
                }
                Button("Cancel", role: .cancel) {
                    // Handle the retry action.
                    print("User cancelled photo album selection.")
                }
            }
            .padding()
        }
    }
    
    
    /*struct AlertView: View {
     @State private var showingAlert = false
     var body: some View {
     Alert("Important message") {
     Button("OK", role: .cancel) { }
     }
     }
     }*/
    
    struct TextBoxView: View {
        @State public var enteredText = ""
        var body: some View {
            Rectangle()
                .fill(Color.white)
                .frame(width: 300, height: 100)
                .cornerRadius(10)
                .shadow(radius: 5)
                .overlay(
                    VStack {
                        TextField("Enter text", text: $enteredText)
                            .padding()
                    }
                )
                .zIndex(1) // Bring the popup to the front
                .transition(.scale)
        }
    }
    
}
