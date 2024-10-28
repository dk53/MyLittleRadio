import SwiftUI

struct StationHeaderView: View {

    // MARK: - Constants

    private enum Constants {

        static let padding: CGFloat = 16
        static let crossIconName = "xmark"
    }

    // MARK: - Properties

    private let title: String
    private let foregroundColor: Color
    private let onDismiss: () -> Void

    // MARK: - Init

    init(title: String, foregroundColor: Color, onDismiss: @escaping () -> Void) {
        self.title = title
        self.foregroundColor = foregroundColor
        self.onDismiss = onDismiss
    }

    // MARK: - Body

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(foregroundColor)

            Spacer()

            Button(action: onDismiss) {
                Image(systemName: Constants.crossIconName)
                    .foregroundColor(foregroundColor)
                    .padding()
            }
        }
        .padding(.top, Constants.padding)
    }
}
