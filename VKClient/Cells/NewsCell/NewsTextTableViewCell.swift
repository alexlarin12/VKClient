//
//  NewsTextTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 14.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {
    
    weak var delegate: NewsTextCellDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var NewsTextLabel: UILabel!
    @IBOutlet weak var NewsTextView: UITextView!
    @IBOutlet weak var ShowMore: UIButton!
    @IBOutlet weak var newsTextHeight: NSLayoutConstraint!
    
    
    @IBAction func showMoreButtonTapped(_ sender: AnyObject){
        guard let index = indexPath else {return}
        delegate?.onShowMoreTaped(indexPath: index)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configur(){
        if NewsTextView.text == ""  {
            newsTextHeight.constant = 0
            ShowMore.isHidden = true
        }else if NewsTextView.text?.count ?? 0 < 200{
            ShowMore.isHidden = true
        } else {
            ShowMore.isHidden = false
        }
    }
    func getRowHeightFromText(text : String!) -> CGFloat
       {
        let textView = UITextView(frame: CGRect(x: self.NewsTextView.frame.origin.x,
                                                   y: 0,
                                                   width: self.NewsTextView.frame.size.width - 64,
                                                   height: 0))
           textView.text = text
           textView.sizeToFit()
           
           var textFrame : CGRect! = CGRect()
           textFrame = textView.frame
           
           var size : CGSize! = CGSize()
           size = textFrame.size
           
           size.height = textFrame.size.height + 25
        return size.height
        
       }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
protocol NewsTextCellDelegate: class {
    func onShowMoreTaped(indexPath: IndexPath)
}
