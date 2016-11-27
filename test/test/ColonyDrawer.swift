import UIKit
class ColonyDrawer: UIView {
    let size: CGFloat = 150.0
    let lineWidth: CGFloat = 3
    init(origin: CGPoint) {
        super.init(frame: CGRectMake(0.0, 0.0, size, size))
        self.center = origin
        self.backgroundColor = UIColor.clearColor()
    }
    
    // We need to implement init(coder) to avoid compilation errors
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        let insetRect = CGRectInset(rect, lineWidth / 2, lineWidth / 2)
        
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: 10)
        
        
        UIColor.redColor().setFill()
        path.fill()
        
        path.lineWidth = self.lineWidth
        UIColor.blackColor().setStroke()
        path.stroke()
    }

    
}