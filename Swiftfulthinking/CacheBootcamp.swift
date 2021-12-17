//
//  CacheBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 26/10/21.
//

import SwiftUI


class CacheManager {
    
    static let instance = CacheManager()
    
    private init() {
        
    }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    func add(image: UIImage,name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        
        return "Added to cache!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        
        return "Removed from cache"
    }
    
    func get(name: String) -> UIImage? {
        
        return imageCache.object(forKey: name as NSString)
        
    }
    
    
    
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cacheImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "Valorant"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetFolder()
    }
    
    func getImageFromAssetFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
       infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
       infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        
        if let returnImage = manager.get(name: imageName) {
            cacheImage = returnImage
            infoMessage = "Got image from cache"
        } else {
            infoMessage = "Image not founf in cache"
        }
        
//        cacheImage = manager.get(name: imageName)
    }
    
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10.0)
                    
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
            
                HStack {
                    Button(action: {vm.saveToCache()}, label: {
                        Text("Save to cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    })
                    
                    Button(action: {vm.removeFromCache()}, label: {
                        Text("Delete from cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10.0)
                    })
                }
                
                Button(action: {vm.getFromCache()}, label: {
                    Text("Get from cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10.0)
                })
                
                if let image = vm.cacheImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10.0)
                    
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}
