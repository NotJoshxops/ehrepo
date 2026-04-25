import UIKit

/// Rootful Summer Theme configuration with warm sunshine colors
struct RootfulSummerTheme {
    
    // MARK: - Colors
    
    static let sunGold = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
    static let sunnyYellow = UIColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0)
    static let warmOrange = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
    static let skyBlue = UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0)
    static let deepOrange = UIColor(red: 0.96, green: 0.4, blue: 0.1, alpha: 1.0)
    
    // MARK: - Gradients
    
    static func sunsetGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [
            skyBlue.cgColor,
            sunnyYellow.cgColor,
            warmOrange.cgColor,
            deepOrange.cgColor
        ]
        gradient.locations = [0.0, 0.3, 0.6, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }
    
    static func radialGlowGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [
            sunnyYellow.cgColor,
            sunGold.cgColor,
            UIColor.clear.cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.type = .radial
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }
    
    // MARK: - Shadows
    
    static let glowShadow: (color: UIColor, offset: CGSize, blur: CGFloat, opacity: Float) = (
        color: sunGold,
        offset: CGSize(width: 0, height: 0),
        blur: 20,
        opacity: 0.8
    )
    
    // MARK: - Extensions
}

extension UIView {
    
    /// Apply a warm sunshine glow effect
    func applySunshineGlow() {
        layer.shadowColor = RootfulSummerTheme.glowShadow.color.cgColor
        layer.shadowOffset = RootfulSummerTheme.glowShadow.offset
        layer.shadowRadius = RootfulSummerTheme.glowShadow.blur
        layer.shadowOpacity = RootfulSummerTheme.glowShadow.opacity
        layer.masksToBounds = false
    }
    
    /// Apply sunset gradient background
    func applySunsetBackground() {
        let gradient = RootfulSummerTheme.sunsetGradient()
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}

extension CALayer {
    
    /// Add a radial glow effect
    func addRadialGlow() {
        let glowLayer = RootfulSummerTheme.radialGlowGradient()
        glowLayer.frame = bounds
        insertSublayer(glowLayer, at: 0)
    }
}
