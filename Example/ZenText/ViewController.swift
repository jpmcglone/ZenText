import UIKit
import ZenText
import SnapKit

class ViewController: UIViewController {
  let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(label)
    
    let message = "Hey @robbie how's it going? This is @jpmcglone!"
    let atUserRegex = "(@[A-Za-z0-9_]*)"
    
    let mutableAttributedString = NSMutableAttributedString(string: message)
    
    mutableAttributedString.style("test", regex: atUserRegex)
    
//    mutableAttributedString.regexFind(atUserRegex, addStyle: "token")

//    label.attributedText = ZenText.manager.attributedString(
//      ["Hello".style("test underlined"),
//       " ",
//       "$0!".style("underlined small")],
//      args: [name]
//    )
    
    label.attributedText = mutableAttributedString
    
    label.snp.makeConstraints { make in
      make.center.equalTo(view.snp.centerX)
    }
  }
}

