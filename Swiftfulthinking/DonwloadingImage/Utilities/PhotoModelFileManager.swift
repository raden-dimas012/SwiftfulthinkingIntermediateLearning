//
//  PhotoModelFileManager.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "donwloaded_photos"
    
    private init() {
        createFolderIFNeeded()
    }
    
    private func createFolderIFNeeded() {
        guard let url = getFolderPath() else {
            return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Created Folder")
                
            } catch let error {
                print("Failed Creating folder\(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    // ... /donwloaded_photos
    // ... /donwloaded_photos/image_name.png
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String,value: UIImage) {
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key) else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to file manager. \(error)")
        }
        
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else {
            
            return nil
            
        }
        return UIImage(contentsOfFile: url.path)
    }
}

