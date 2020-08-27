//
//  ImageSaver.swift
//  Fiftygram
//
//  Created by Juan Diego Soteldo on 8/13/20.
//  Copyright © 2020 CS50. All rights reserved.
//

import UIKit
 
class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
}
