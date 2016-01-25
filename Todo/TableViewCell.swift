//
//  TableViewCell.swift
//  Todo
//
//  Created by Petr Grishin on 21.02.15.
//  Copyright (c) 2015 Petr Grishin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    var controller: ViewController!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var dateText: UILabel!
    @IBOutlet var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //fatalError("NSCoding not supported")
        
        let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
 
    }
    
    override func layoutSubviews() {
        stateAsShowing()
    }
    
    func stateAsShowing() {
        deleteButton.hidden = true;
        title.hidden = false;
        dateText.hidden = false;
    }
    
    func stateAsRemoving() {
        title.hidden = true
        dateText.hidden = true
        deleteButton.hidden = false
    }

    func handlePan(recognizer: UIPanGestureRecognizer) {
        // 1
        if recognizer.state == .Began {
            // when the gesture begins, record the current center location
            originalCenter = center
        }
        // 2
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/complete?
            var offset = frame.origin.x
            if offset < 0 {
                offset = -offset;
            }
            
            let realWidth = frame.size.width;
            deleteOnDragRelease =  offset > realWidth/2.0
        }
        // 3
        if recognizer.state == .Ended {
            // the frame this cell had before user dragged it
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                    width: bounds.size.width, height: bounds.size.height)
            if deleteOnDragRelease {
                stateAsRemoving()
            }

            // if the item is not being deleted, snap back to the original location
            UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
        }
    }
    
    @IBAction func deleteCell(sender: UIButton) {
        controller.removeItem(self)
    }

    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
}
