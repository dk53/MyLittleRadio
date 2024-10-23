import SwiftUI

struct AnimationIDs {
    let text: Int
    let background: Int
    let namespace: Namespace.ID?

    init(textId: String, backgroundId: String, namespace: Namespace.ID?) {
        self.text = textId.hashValue
        self.background = backgroundId.hashValue
        self.namespace = namespace
    }
}
