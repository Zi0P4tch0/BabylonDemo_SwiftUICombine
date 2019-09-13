import SwiftUI

private class BundleHelper { }
private let bundle = Bundle(for: BundleHelper.self)

private func localizedValue(for key: String) -> String {
    NSLocalizedString(key,
                      tableName: nil,
                      bundle: bundle,
                      value: "**\(key)**",
                      comment: "")
}

// MARK: - SwiftUI

struct Localized: View {

    let text: Text

    init(_ localizedKey: String) {
        text = Text(verbatim: localizedValue(for: localizedKey))
    }

    init(_ localizedKey: String, args: CVarArg...) {
        let value = String(format: localizedValue(for: localizedKey),                                 arguments: args)
        text = Text(verbatim: value)
    }

    var body: some View {
        text
    }

}

// MARK: - Foundation

extension String {

    func localized() -> String {
        localizedValue(for: self)
    }

}
