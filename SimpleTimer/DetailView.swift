//
//  DetailView.swift
//  SimpleTimer
//
//  Created by 長橋和敏 on 2025/01/21.
//

import SwiftUI

struct DetailView: View {
    @State private var timeRemaining: Int = 60 // 初期値: 60秒
    @State private var isRunning: Bool = false // タイマーが動作中かどうか
    @State private var showAlert: Bool = false // アラート表示のフラグ
    
    // Timer? : Optional型
    // オプショナルとは、「値があるかもしれないし、nil（値がない）かもしれない」という状態を表す
    @State private var timer: Timer? // タイマーインスタンス
    
    var body: some View {
        VStack(spacing: 20) {
            // 残り時間を表示
            Text("\(formatTime(timeRemaining))")
                .font(.largeTitle)
                .padding()
            
            // タイマースタートボタン
            Button(action: {
                startTimer()
            }) {
                Text(isRunning ? "タイマーリセット" : "スタート")
                    .font(.title2)
                    .padding()
                    .background(isRunning ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("タイマー終了"), message: Text("時間がゼロになりました！"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
    // タイマー開始/リセットロジック
    func startTimer() {
        if isRunning {
            // タイマーリセット処理
            resetTimer()
        } else {
            // タイマー開始処理
            isRunning = true
            // クロージャに引数が渡されるが、ここではその引数を使わないため、無視する意味で_を使用
            // **_ in**は、クロージャの引数を無視するための記述
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    stopTimer()
                    showAlert = true
                }
            }
        }
    }
    
    // タイマー停止処理
    func stopTimer() {
        // オプショナルチェーン
        // timerがnilの場合、invalidate()を呼び出さず、エラーを防ぐ
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    // タイマーリセット処理
    func resetTimer() {
        stopTimer()
        timeRemaining = 60 // 初期値に戻す
    }
    
    // 時間を分:秒形式でフォーマット
    // アンダースコア（_）は、呼び出し時に引数ラベルを省略できることを示す
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        // フォーマット指定子"%02d:%02d"を使用して、分と秒を2桁のゼロ埋めで表示（例: 01:09）
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
