import SwiftUI

struct MatrixProgramView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var rows: String = ""
    @State private var var_cols: String = ""
    @State private var inputMatrix: [[Int]] = []
    @State private var outputResults: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Входные данные")
                        .font(.headline)
                        .padding(.leading, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Количество строк:")
                                .frame(width: 150, alignment: .trailing)
                            TextField("Введите количество строк", text: $rows)
                                .textFieldStyle(.plain)
                                .padding(5)
                                .background(AppColors.cardBackground)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(AppColors.border, lineWidth: 1)
                                )
                                .contentShape(Rectangle())
                        }
                        
                        HStack {
                            Text("Количество столбцов:")
                                .frame(width: 150, alignment: .trailing)
                            TextField("Введите количество столбцов", text: $var_cols)
                                .textFieldStyle(.plain)
                                .padding(5)
                                .background(AppColors.cardBackground)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(AppColors.border, lineWidth: 1)
                                )
                                .contentShape(Rectangle())
                        }
                    }
                    .background(AppColors.cardBackground)
                    .cornerRadius(10)
                    .padding()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Исходная матрица")
                        .font(.headline)
                        .padding(.leading, 20)
                        
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(inputMatrix, id: \.self) { row in
                                Text(row.map { String($0) }.joined(separator: "\t"))
                                    .padding(.vertical, 4)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 150)
                    .background(AppColors.resultFieldBackground)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColors.border, lineWidth: 1)
                    )
                    .padding()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Результаты")
                        .font(.headline)
                        .padding(.leading, 20)
                        
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(outputResults, id: \.self) { result in
                                Text(result)
                                    .padding(.vertical, 4)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 200)
                    .background(AppColors.resultFieldBackground)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColors.border, lineWidth: 1)
                    )
                    .padding()
                }
            }
            .padding(.horizontal, 40)
            
            Button(action: processMatrix) {
                Text("Выполнить")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.accentBlue)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
        }
        .padding(.top, 30)
        .background(AppColors.background)
        .navigationTitle("Работа с матрицей")
    }
    
    private func processMatrix() {
        guard let rowsValue = Int(rows),
              let colsValue = Int(var_cols),
              rowsValue > 0,
              colsValue > 0 else {
            outputResults = ["Ошибка: введите корректные размеры матрицы"]
            return
        }
        
        // Генерация случайной матрицы
        inputMatrix = (0..<rowsValue).map { _ in
            (0..<colsValue).map { _ in Int.random(in: -10...10) }
        }
        
        // Поиск первой строки с положительным элементом
        var firstPositiveRow = -1
        for (i, row) in inputMatrix.enumerated() {
            if row.contains(where: { $0 > 0 }) {
                firstPositiveRow = i
                break
            }
        }
        
        // Удаление строк, состоящих из нулей
        let filteredRows = inputMatrix.filter { row in
            !row.allSatisfy { $0 == 0 }
        }
        
        // Удаление столбцов, состоящих из нулей
        if !filteredRows.isEmpty {
            let newCols = filteredRows[0].count
            var isZeroCol = Array(repeating: true, count: newCols)
            
            for j in 0..<newCols {
                for i in 0..<filteredRows.count {
                    if filteredRows[i][j] != 0 {
                        isZeroCol[j] = false
                        break
                    }
                }
            }
            
            var compacted: [[Int]] = []
            for row in filteredRows {
                var newRow: [Int] = []
                for j in 0..<newCols {
                    if !isZeroCol[j] {
                        newRow.append(row[j])
                    }
                }
                compacted.append(newRow)
            }
            
            // Формирование результатов
            outputResults = ["Уплотнённая матрица:"]
            outputResults.append(contentsOf: compacted.map { row in
                row.map { String($0) }.joined(separator: "\t")
            })
        } else {
            outputResults = ["После удаления строк осталась пустая матрица."]
        }
        
        if firstPositiveRow != -1 {
            outputResults.append("Номер первой строки с положительным элементом: \(firstPositiveRow)")
        } else {
            outputResults.append("Положительных элементов в матрице не найдено.")
        }
    }
}

#Preview {
    MatrixProgramView()
} 