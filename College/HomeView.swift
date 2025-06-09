import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Выберите программу для работы с массивами и матрицами")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            ScrollView {
                VStack(spacing: 20) {
                    ProgramBlock(
                        title: "Работа с массивом",
                        description: "Обработка одномерного массива: поиск максимального элемента, сумма модулей и преобразование массива",
                        systemImage: "list.number",
                        destinationValue: .arrayProgram
                    )
                    
                    ProgramBlock(
                        title: "Работа с матрицей",
                        description: "Обработка двумерного массива: поиск строк с положительными элементами и уплотнение матрицы",
                        systemImage: "square.grid.3x3",
                        destinationValue: .matrixProgram
                    )
                }
                .padding(.horizontal, 40)
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                Text("Выход из программы")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.accentRed)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.white,
                    Color.white.opacity(0.95),
                    Color.white.opacity(0.9)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .preferredColorScheme(.light)
        .navigationTitle("Алгоритмы и структуры данных")
    }
}

struct ProgramBlock: View {
    let title: String
    let description: String
    let systemImage: String
    let destinationValue: ProgramDestination
    
    var body: some View {
        NavigationLink(value: destinationValue) {
            HStack {
                Image(systemName: systemImage)
                    .font(.title)
                    .foregroundColor(.blue)
                    .frame(width: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.headline)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(AppColors.cardBackground)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HomeView()
} 