//
//  UserCell.swift
//  VKClient
//
//  Created by Alex Larin on 03.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class UserCell: ASCellNode{
 //   private let nameNode = ASTextNode()
//    private let imageNode = ASImageNode()
    private let imageNetWork = ASNetworkImageNode()
 //   private let imageHeight: CGFloat = 200
    private let aspectRatio: CGFloat
    private let urlImage: String
   
    //  var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width)}
    
    init(aspectRatio: CGFloat, urlImage: String) {
        self.aspectRatio = aspectRatio
        self.urlImage = urlImage
        super .init()
        backgroundColor = #colorLiteral(red: 0.239143461, green: 0.437407434, blue: 0.7932939529, alpha: 1)
        setupSubnodes()
    }
    
    private func setupSubnodes() {
        
     //   nameNode.attributedText = NSAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold)])
      //  addSubnode(nameNode)
    
        imageNetWork.shouldRenderProgressImages = true
        imageNetWork.contentMode = .scaleAspectFill
        imageNetWork.url = URL(string: urlImage)
        addSubnode(imageNetWork)
    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Задаем размер изображения, так как при загрузке из сети он изначально неизвестен
        let width = constrainedSize.max.width
        
        imageNetWork.style.preferredSize = CGSize(width: width, height: width * aspectRatio)
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let imageWithInset = ASInsetLayoutSpec(insets: insets, child: imageNetWork)
      //  let imageCenterSpec = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: imageNetWork)
        let horizontalSpec = ASStackLayoutSpec()
        horizontalSpec.direction = .horizontal
        horizontalSpec.children = [imageWithInset]
        return horizontalSpec
    }
}
