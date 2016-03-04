import UIKit

public extension UIView {
    func constraintsForViewToAllEdges(
        view: UIView,
        insets: UIEdgeInsets = UIEdgeInsetsZero
        ) -> [NSLayoutConstraint] {
            let edges: [NSLayoutAttribute] = [.Leading, .Trailing, .Top, .Bottom]
            return self.constraintsForView(view, edges: edges, insets: insets)
    }
    
    func constrainViewToAllEdges(view: UIView, insets: UIEdgeInsets = UIEdgeInsetsZero) {
        let edges: [NSLayoutAttribute] = [.Leading, .Trailing, .Top, .Bottom]
        self.constrainView(view, edges: edges, insets: insets)
    }
    
    func constrainView(
        view: UIView,
        edges: [NSLayoutAttribute],
        insets: UIEdgeInsets = UIEdgeInsetsZero,
        priority: Float? = nil
        ) {
            
            let constraints = self.constraintsForView(
                view,
                edges: edges,
                insets: insets,
                priority: priority
            )
            self.addConstraints(constraints)
    }
    
    func constraintsForView(
        view: UIView,
        edges: [NSLayoutAttribute],
        insets: UIEdgeInsets,
        priority: Float? = nil
        ) -> [NSLayoutConstraint] {
            return edges.map({ (edge) -> NSLayoutConstraint in
                return self.constrainView(view, toEdge: edge, insets: insets, priority: priority)
            })
    }
    
    func constrainView(
        view: UIView,
        toEdge edge: NSLayoutAttribute,
        insets: UIEdgeInsets = UIEdgeInsetsZero,
        priority: Float?
        ) -> NSLayoutConstraint {
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let inset: CGFloat = {
                switch edge {
                case .Leading: return insets.left
                case .Trailing: return -1 * insets.right
                case .Bottom: return -1 * insets.bottom
                case .Top: return insets.top
                default: return 0
                }
            }()
            
            let constraint = NSLayoutConstraint(
                item: view,
                attribute: edge,
                relatedBy: .Equal,
                toItem: self,
                attribute: edge,
                multiplier: 1,
                constant: inset
            )
            
            if let priority = priority {
                constraint.priority = priority
            }
            return constraint
    }
}
