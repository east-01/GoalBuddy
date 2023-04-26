//
//  ImageManipulation.swift
//  GoalBuddy
//
//  Created by Ethan Mullen on 3/29/23.
//

import Foundation
import UIKit

func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

    let contextImage: UIImage = UIImage(cgImage: image.cgImage!)

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

    let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)

    // Create bitmap image from context using the rect
    let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!

    // Create a new image based on the imageRef and rotate back to the original orientation
    let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

    return image
}

func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}
