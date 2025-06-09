import SwiftUI

enum ProgramDestination: Hashable {
    case arrayProgram
    case matrixProgram
}

@main
struct CollegeApp: App {
    @State private var navigationPath = NavigationPath()

    var body: some Scene {
        Window("Алгоритмы и структуры данных", id: "main-app-window") {
            NavigationStack(path: $navigationPath) {
                HomeView()
                    .navigationDestination(for: ProgramDestination.self) { destination in
                        switch destination {
                        case .arrayProgram:
                            ArrayProgramView()
                        case .matrixProgram:
                            MatrixProgramView()
                        }
                    }
            }
        }
    }
} 