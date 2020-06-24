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
    // @IBOutlet weak var newsTextHeight: NSLayoutConstraint! (для работы мотода1 или метода2)
    
    @IBAction func showMoreButtonTapped(_ sender: AnyObject){
        guard let index = indexPath else {return}
        // при нажатии на кнопку перезагружаем ячейку с помощью метода объявленного в делегате:
        delegate?.onShowMoreTaped(indexPath: index)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // конфигурация ячейки(кнопка есть - кнопка скрыта):

    func configur(){
        if NewsTextView.text == ""  {
           // newsTextHeight.constant = 0
            ShowMore.isHidden = true
        } else if NewsTextView.text?.count ?? 0 < 200{
            ShowMore.isHidden = true
        } else {
            ShowMore.isHidden = false
        }
    }
    
    /*
    // МЕТОД 1 расчет высоты textView:
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
     */
    // МЕТОД 2 расчет высоты textView в зависимости от текста и шрифта:
    func getRowHeightFromText(text : String!) -> CGFloat{
        let width = NewsTextView.bounds.width - NewsTextView.textContainerInset.left - NewsTextView.textContainerInset.right
        return text.boundingRect(with: .init(width: width, height: .infinity),
                                 options: .usesLineFragmentOrigin,
                                 attributes: [.font: NewsTextView.font!],
            context: nil).height 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
// делегат перезагрузки ячейки:
protocol NewsTextCellDelegate: class {
    func onShowMoreTaped(indexPath: IndexPath)
}
