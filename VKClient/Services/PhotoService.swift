//
//  PhotoService.swift
//  VKClient
//
//  Created by Alex Larin on 10.05.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import Alamofire
class PhotoService {
// временной интервал хранения в кэше:
    private let cacheLifeTime: TimeInterval = 60 * 5
    private static let pathName: String = {
        let pathName = "images"
//создаем в кэш директории папку "images" и путь к ней:
    guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
    
        return pathName
    }()
// функция для создания пути к файлу (который будет находиться в папке "images") для хранения изображения. На входе функции URL изображения:
    func getFilePath(url: String) -> String? {
    
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
// функция сохранения изображения в кэше, на входе URL изображения и сама картинка:
    private func saveImageToChache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
        let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
// функция загрузки изображения из файловой системы. На входе URL -> возвращает изображение:
    private func getImageFromChache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return nil }
          
        let lifeTime = Date().timeIntervalSince(modificationDate)
       
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
            images[url] = image // передаем картинку в свойство images - кэш в оперативной памяти с минимальным временем доступа
        return image
    }
    
    private var images = [String: UIImage]()
    let apiService = ApiService()
  // метод загрузки изображения из сети:
 
    let syncQueue = DispatchQueue(label: "photo.cache.queue")
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
            Alamofire.request(url).responseData(queue: syncQueue) { [weak self] response in
                guard
                    let data = response.data,
                    let image = UIImage(data: data) else { return }
                
                self?.images[url] = image
                self?.saveImageToChache(url: url, image: image)
                DispatchQueue.main.async {
                    self?.container.reloadRow(atIndexpath: indexPath)
                }
                
            }
    }

   
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
            } else if let photo = getImageFromChache(url: url) {
                image = photo
            } else {
                loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
            return image
    }
   
    private let container: DataReloadable
   
        init(container: UITableView) {
            self.container = Table(table: container)
        }
    
        init(container: UICollectionView) {
            self.container = Collection(collection: container)
        }
}


fileprivate protocol DataReloadable {
        func reloadRow(atIndexpath indexPath: IndexPath)
}


extension PhotoService {
    
        private class Table: DataReloadable {
            let table: UITableView
        
            init(table: UITableView) {
                self.table = table
            }
        
            func reloadRow(atIndexpath indexPath: IndexPath) {
                table.reloadRows(at: [indexPath], with: .none)
            }
        }

        private class Collection: DataReloadable {
            let collection: UICollectionView
        
            init(collection: UICollectionView) {
                self.collection = collection
            }
        
            func reloadRow(atIndexpath indexPath: IndexPath) {
                collection.reloadItems(at: [indexPath])
            }
        }
}
    
