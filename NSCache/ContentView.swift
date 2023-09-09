//
//  ContentView.swift
//  NSCache
//
//  Created by Batuhan Küçükyıldız on 10.09.2023.
//

import SwiftUI






class CacheViewModel : ObservableObject {
    @Published var startingImage : UIImage? = nil
    let imageName : String = "person"
    
    init() {
        getImageFromAssetsFolder()
    }
    func getImageFromAssetsFolder(){
        startingImage = UIImage(named: imageName)
    }
}


struct ContentView: View {
    @StateObject var vm = CacheViewModel()
    var body: some View {
        NavigationView{
            VStack{
                if let image = vm.startingImage{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200 , height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack{
                    Button(action: {}, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Button(action: {}, label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
