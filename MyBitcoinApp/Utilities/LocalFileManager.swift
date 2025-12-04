//
//  LocalFileManager.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 19/11/25.
//

/*
* function saveImage {
 
 CreateFolderIfNeaded
 
 GetImageUrl
 
 save image with path
  
 }
 
* function getImage (takes imageName and folderName) -> returns an UIImage
 
* function CreateFolderIfNeaded (takes folderName) { GetFolderURl(folderName) if not exist create a new folder }
 
* function GetFolderURl (takes folderName) -> return an URL?
 
* function GetImageUrl  (takes imageName and foldername) -> returns an URL?
 */


import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, foldeName: String) {
        
        // Create folder
        CreateFolderIfNeeded(folderName: foldeName)
        
        // get path for image
        guard
            let data = image.pngData(),
            let url = getImageURL(imageName: imageName, folderName: foldeName)
        else {return}
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. ImageName: \(imageName). \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getImageURL(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
 
    func CreateFolderIfNeeded(folderName: String) {
        guard let url = getFolderURL(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
        }
    }
    
    func getFolderURL(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getFolderURL(folderName: folderName) else {
            return nil
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
}

