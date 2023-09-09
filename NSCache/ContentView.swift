//
//  ContentView.swift
//  NSCache
//
//  Created by Batuhan Küçükyıldız on 10.09.2023.
//

import SwiftUI



class CacheManager {
    
    static let shared = CacheManager() // Singleton
    private init(){}
    
    var imageCache : NSCache<NSString , UIImage> = {
        let cache = NSCache<NSString , UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    
    func add(image : UIImage , name : String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func remove(name : String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    func get(name : String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}


class CacheViewModel : ObservableObject {
    @Published var startingImage : UIImage? = nil
    @Published var cacheImage : UIImage? = nil
    let manager = CacheManager.shared
    let imageName : String = "person"
    
    init() {
        getImageFromAssetsFolder()
    }
    func getImageFromAssetsFolder(){
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache(){
        guard let image = startingImage else{return}
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    func getFromCache(){
        cacheImage = manager.get(name: imageName)
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
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        vm.getFromCache()
                    }, label: {
                        Text("Get from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    })
                    
                }
                if let image = vm.cacheImage{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200 , height: 200)
                        .clipped()
                        .cornerRadius(10)
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
