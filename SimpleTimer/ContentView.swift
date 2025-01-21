//
//  ContentView.swift
//  SimpleTimer
//
//  Created by 長橋和敏 on 2025/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView { // 画面全体をナビゲーションで包む
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                
                // リンク付きボタン
                NavigationLink(destination: DetailView()) {
                    Text("Go to Detail Screen") // ボタンの表示内容
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
