import SwiftUI

struct ArrayProgramView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var n: String = ""
    @State private var a: String = ""
    @State private var b: String = ""
    @State private var inputArray: [Double] = []
    @State private var outputResults: [String] = []
    
    var body: some View {
        ZStack {
            Color(AppColors.background)
                .ignoresSafeArea(.all)
            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Входные данные")
                            .font(.headline)
                            .padding(.leading, 20)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Размер массива (n):")
                                    .frame(width: 150, alignment: .trailing)
                                TextField("Введите размер массива", text: $n)
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
                                Text("Нижняя граница (a):")
                                    .frame(width: 150, alignment: .trailing)
                                TextField("Введите значение a", text: $a)
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
                                Text("Верхняя граница (b):")
                                    .frame(width: 150, alignment: .trailing)
                                TextField("Введите значение b", text: $b)
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
                        Text("Исходный массив")
                            .font(.headline)
                            .padding(.leading, 20)
                            
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(inputArray, id: \.self) { value in
                                    Text(String(format: "%.2f", value))
                                        .padding(.vertical, 4)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .padding(.horizontal, 20)
                        }
                        .frame(height: 100)
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
                        .frame(height: 150)
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
                
                Button(action: processArray) {
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
            .navigationTitle("Работа с массивом")
        }
    }
    
    private func processArray() {
        guard let nValue = Int(n),
              let aValue = Double(a),
              let bValue = Double(b) else {
            outputResults = ["Ошибка: введите корректные числовые значения"]
            return
        }
        
        inputArray = (0..<nValue).map { _ in Double.random(in: -10...10) }
        
        let maxIndex = inputArray.enumerated().max(by: { abs($0.element) < abs($1.element) })?.offset ?? 0
        
        var sum = 0.0
        var foundPositive = false
        for value in inputArray {
            if !foundPositive && value > 0 {
                foundPositive = true
                continue
            }
            if foundPositive {
                sum += abs(value)
            }
        }
        
        var transformed = inputArray.filter { floor($0) >= aValue && floor($0) <= bValue }
        transformed.append(contentsOf: inputArray.filter { !(floor($0) >= aValue && floor($0) <= bValue) })
        
        outputResults = [
            "Индекс максимального по модулю элемента: \(maxIndex)",
            "Сумма модулей после первого положительного элемента: \(String(format: "%.2f", sum))",
            "Преобразованный массив:"
        ]
        outputResults.append(contentsOf: transformed.map { String(format: "%.2f", $0) })
    }
}
