import UIKit
import MBProgressHUD

struct MBProgressHUDModel: Equatable {
    let message: String?
}

extension UIViewController {

    var progressHUD: MBProgressHUDModel? {
        get {
            nil
        }
        set {
            guard let model = newValue else {
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
            let hud = MBProgressHUD(for: self.view) ??
                      MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = model.message
        }
    }

}
