import UIKit
import QuartzCore

/// A rootful sunshine glow effect that creates a warm summer atmosphere
/// with animated radial gradients and particle effects
class SunshineGlowEffect: UIView {
    
    // MARK: - Properties
    
    private let glowLayer = CAShapeLayer()
    private let sunLayer = CAShapeLayer()
    private let particleEmitterLayer = CAEmitterLayer()
    
    private var isAnimating = false
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    // MARK: - Setup
    
    private func setupLayers() {
        backgroundColor = .clear
        
        // Setup glow layer with radial gradient
        setupGlowLayer()
        
        // Setup sun core
        setupSunLayer()
        
        // Setup particle emitter
        setupParticleEmitter()
    }
    
    private func setupGlowLayer() {
        glowLayer.fillColor = UIColor.clear.cgColor
        glowLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(glowLayer)
    }
    
    private func setupSunLayer() {
        sunLayer.fillColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0).cgColor
        layer.addSublayer(sunLayer)
    }
    
    private func setupParticleEmitter() {
        particleEmitterLayer.emitterShape = .circle
        particleEmitterLayer.renderMode = .additive
        particleEmitterLayer.birthRate = 1.0
        
        let cell = CAEmitterCell()
        cell.birthRate = 50
        cell.lifetime = 2.0
        cell.velocity = 30
        cell.velocityVariation = 15
        cell.emissionRange = .pi * 2
        cell.alphaSpeed = -0.5
        cell.scale = 0.01
        cell.scaleVariation = 0.005
        
        // Create a simple particle image (golden/yellow circle)
        if let particleImage = createParticleImage() {
            cell.contents = particleImage.cgImage
        }
        
        particleEmitterLayer.emitterCells = [cell]
        layer.addSublayer(particleEmitterLayer)
    }
    
    // MARK: - Rendering
    
    private func createParticleImage() -> UIImage? {
        let size = CGSize(width: 8, height: 8)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        UIColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 0.8).setFill()
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // MARK: - Animation
    
    /// Start the sunshine glow animation
    func startAnimation() {
        guard !isAnimating else { return }
        isAnimating = true
        
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let maxRadius = max(bounds.width, bounds.height) / 2
        
        // Animate sun position and glow
        animateSunGlow(from: centerPoint, maxRadius: maxRadius)
        
        // Start particle emission
        particleEmitterLayer.emitterPosition = centerPoint
        particleEmitterLayer.birthRate = 1.0
    }
    
    /// Stop the sunshine glow animation
    func stopAnimation() {
        isAnimating = false
        particleEmitterLayer.birthRate = 0
        glowLayer.removeAllAnimations()
        sunLayer.removeAllAnimations()
    }
    
    private func animateSunGlow(from center: CGPoint, maxRadius: CGFloat) {
        // Animate sun core
        let sunPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        sunLayer.path = sunPath.cgPath
        
        // Create pulsing animation for sun
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.2
        pulseAnimation.duration = 2.0
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.repeatCount = .infinity
        pulseAnimation.autoreverses = true
        sunLayer.add(pulseAnimation, forKey: "pulse")
        
        // Create glow rings
        animateGlowRings(from: center, maxRadius: maxRadius)
    }
    
    private func animateGlowRings(from center: CGPoint, maxRadius: CGFloat) {
        for i in 1...3 {
            let delay = Double(i) * 0.3
            let radius = 40 + CGFloat(i) * 25
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.createGlowRing(center: center, radius: radius, index: i)
            }
        }
    }
    
    private func createGlowRing(center: CGPoint, radius: CGFloat, index: Int) {
        let ringLayer = CAShapeLayer()
        let ringPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        ringLayer.path = ringPath.cgPath
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.strokeColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 0.6).cgColor
        ringLayer.lineWidth = 3
        ringLayer.lineCap = .round
        
        layer.addSublayer(ringLayer)
        
        // Animate ring expansion and fade
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.5
        scaleAnimation.duration = 1.5
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, scaleAnimation]
        groupAnimation.duration = 1.5
        groupAnimation.repeatCount = .infinity
        groupAnimation.beginTime = CACurrentMediaTime()
        
        ringLayer.add(groupAnimation, forKey: "glowRing\(index)")
    }
    
    // MARK: - Public Methods
    
    /// Get the current glow intensity (0.0 to 1.0)
    func getGlowIntensity() -> CGFloat {
        return isAnimating ? 1.0 : 0.0
    }
}
