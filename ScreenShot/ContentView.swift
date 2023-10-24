import SwiftUI
import Foundation

struct ContentView: View {
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @State private var circleColors: [Color] = [.red, .green, .blue]
    
    var body: some View {
        HomeView()
        if screenshotDetector.showView {
            ZStack {
                // Background
                Color.white.edgesIgnoringSafeArea(.all)
                
                // Rectangle in the upper right-hand corner
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 150)
                    .foregroundColor(.blue)
                    .position(x: UIScreen.main.bounds.size.width - 50, y: 75)
                    .onTapGesture {
                        print("Tapped main box")
                        screenshotDetector.restartTimer()
                    }
                // Three small circles inside the rectangle
                HStack {
                    VStack {
                        // Make this stack have same tap property as parent rect for timer
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                            .onTapGesture {
                                print("Added photo to Red album") // delete
                                if let mostRecentImage = PhotoHelper().fetchMostRecentImage() {
                                    let albumName = "Red Album" // Replace with your desired album name
                                    PhotoHelper().addImageToAlbum(image: mostRecentImage, albumName: albumName)
                                }
                            }
                        
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                            .onTapGesture {
                                print("Added photo to Green album") // delete
                                if let mostRecentImage = PhotoHelper().fetchMostRecentImage() {
                                    let albumName = "Green Album" // Replace with your desired album name
                                    PhotoHelper().addImageToAlbum(image: mostRecentImage, albumName: albumName)
                                }
                            }
                        
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                // Call createNewPhotoAlbum()
                                print("Tapped lowest circle")
                            }
                    }
                }
                .position(x: UIScreen.main.bounds.size.width - 50, y: 75)
            }
            /*
             ZStack {
             Rectangle()
             .fill(Color.gray.opacity(0.3))
             .frame(width: 100, height: 150)
             .position(x: UIScreen.main.bounds.width - 50, y: 75)
             .onTapGesture {
             print("Tapped gray box")
             screenshotDetector.restartTimer()
             }
             .gesture(
             TapGesture()
             .onEnded { _ in
             // Rotate the colors of the circles
             let lastColor = circleColors.popLast()
             circleColors.insert(lastColor ?? .red, at: 0)
             }
             )
             
             VStack(spacing: 20) {
             ForEach(0..<3, id: \.self) { index in
             Circle()
             .fill(circleColors[index])
             .frame(width: 50, height: 50)
             .position(x: UIScreen.main.bounds.width - 50, y: 75)
             .onTapGesture {
             withAnimation {
             circleColors[index] = getRandomColor()
             }
             }
             }
             }
             }*/
        }
    }
    
    private func getRandomColor() -> Color {
        let colors: [Color] = [.red, .green, .blue, .orange, .purple, .pink]
        return colors.randomElement() ?? .gray
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

struct HomeView: View {
    var body: some View {
        Text("Take a screenshot!")
    }
}

