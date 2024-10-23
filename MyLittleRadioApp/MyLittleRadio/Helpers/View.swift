import SwiftUI

extension View {
    func ifLet<T, Content: View>(_ optional: T?, content: (Self, T) -> Content) -> some View {
        if let value = optional {
            return AnyView(content(self, value))
        } else {
            return AnyView(self)
        }
    }
}
