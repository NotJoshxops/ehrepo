# Rootful Sunshine Glow Effect

A beautiful iOS UIView component that creates a warm summer atmosphere with animated sunshine effects perfect for rootful jailbreak theming.

## Features

- **☀️ Animated Sun Core** - Smooth pulsing golden sun with 1.0x to 1.2x scale animation
- **✨ Golden Particle System** - 50 particles radiating outward with fade effects
- **🌈 Expanding Glow Rings** - Three staggered concentric rings expanding and fading
- **🎨 Warm Color Palette** - Professional summer theme colors (gold, yellow, orange, sky blue)
- **🔆 Shadow & Glow Effects** - Professional lighting effects for depth
- **Infinite Loop** - Continuous smooth animations

## Installation

Add these files to your Xcode project:
- `SunshineGlowEffect.swift` - Main effect component
- `RootfulSummerTheme.swift` - Theme configuration and extensions

## Quick Start

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the sunshine effect
        let sunshineView = SunshineGlowEffect(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        view.addSubview(sunshineView)
        
        // Start the animation
        sunshineView.startAnimation()
    }
}
```

## Usage Examples

### Basic Animation
```swift
let sunshineView = SunshineGlowEffect(frame: CGRect(x: 50, y: 50, width: 400, height: 400))
view.addSubview(sunshineView)
sunshineView.startAnimation()
```

### Apply Theme to Views
```swift
let customView = UIView()
customView.applySunshineGlow()
customView.applySunsetBackground()
```

### Stop Animation
```swift
sunshineView.stopAnimation()
```

### Check Glow Intensity
```swift
let intensity = sunshineView.getGlowIntensity() // Returns 0.0 to 1.0
```

## Customization

### Change Sun Color
```swift
// In SunshineGlowEffect.swift, modify setupSunLayer()
sunLayer.fillColor = UIColor.red.cgColor
```

### Adjust Animation Duration
```swift
// Modify the pulseAnimation.duration in animateSunGlow()
pulseAnimation.duration = 3.0 // Changed from 2.0
```

### Change Particle Count
```swift
// In setupParticleEmitter(), modify:
cell.birthRate = 100 // Increase from 50
```

### Modify Glow Ring Count
```swift
// In animateGlowRings(), change the range:
for i in 1...5 { // Increase from 1...3
```

## Performance Notes

- Particle emitter and animations are GPU-accelerated
- Uses CAEmitterLayer for efficient particle rendering
- Recommended view size: 300x300 to 500x500 points
- Memory efficient with proper cleanup on stopAnimation()
- Works well on iPhone 8 and newer

## Color Palette

| Color | RGB Value | Purpose |
|-------|-----------|----------|
| Sun Gold | (1.0, 0.84, 0.0) | Primary sun color |
| Sunny Yellow | (1.0, 0.9, 0.2) | Particles & highlights |
| Warm Orange | (1.0, 0.6, 0.2) | Accent rings |
| Sky Blue | (0.53, 0.81, 0.92) | Gradient background |
| Deep Orange | (0.96, 0.4, 0.1) | Gradient end |

## License

Part of the ehrepo iOS research project.

## Contributing

To improve the effect:
1. Test on different iOS versions
2. Optimize for lower-end devices
3. Add new animation variations
4. Report performance issues

---

**Created for**: Rootful iOS Jailbreak Theme
**Use Case**: Home screen customization, loading screens, UI accents
