import UIKit
import ZenText
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    setupZenText()
    return true
  }
}

func setupZenText() {
  ZenText.manager.config.styles = { name in
    switch name {
    case "test":
      return Style(
        color: .red,
        fontSize: 24
      )
    case "underlined":
      return Style(
        underline: true
      )
    case "small":
      return Style(
        fontSize: 10
      )
    default:
      return Style()
    }
  }
}

