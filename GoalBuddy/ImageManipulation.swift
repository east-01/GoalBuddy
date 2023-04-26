//
//  ImageManipulation.swift
//  GoalBuddy
//
//  Created by Ethan Mullen on 4/2/23.
//

import Foundation
import UIKit

//<<<<<<< HEAD
//func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
//
//    let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
//
//    let contextSize: CGSize = contextImage.size
//
//    var posX: CGFloat = 0.0
//    var posY: CGFloat = 0.0
//    var cgwidth: CGFloat = CGFloat(width)
//    var cgheight: CGFloat = CGFloat(height)
//
//    // See what size is longer and create the center off of that
//    if contextSize.width > contextSize.height {
//        posX = ((contextSize.width - contextSize.height) / 2)
//        posY = 0
//        cgwidth = contextSize.height
//        cgheight = contextSize.height
//    } else {
//        posX = 0
//        posY = ((contextSize.height - contextSize.width) / 2)
//        cgwidth = contextSize.width
//        cgheight = contextSize.width
//    }
//
//    let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
//
//    // Create bitmap image from context using the rect
//    let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
//
//    // Create a new image based on the imageRef and rotate back to the original orientation
//    let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
//
//    return image
//}
//
//func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
//
//    let scale = newWidth / image.size.width
//    let newHeight = image.size.height * scale
//    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
//    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//
//    return newImage
//}
//=======
func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(origin: .zero, size: newSize)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}

func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)

        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
//>>>>>>> main
