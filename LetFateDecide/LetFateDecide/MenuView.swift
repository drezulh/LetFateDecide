//
//  MenuView.swift
//  LetFateDecide
//
//  Created by Gorkem Turan on 27.12.2022.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 0.1, green: 0.2, blue: 0.45))
            .font(.title)
            .foregroundColor(.white)
    }
}

struct MenuView: View {
    @Binding var buttonPressed : Bool
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Title()
                    .padding()
                GeometryReader { geo in
                    Image("GameImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                Spacer()
                Spacer()
                Spacer()
                Button("Start the game!",
                       action: {
                    buttonPressed.toggle()
                })
                .modifier(ButtonStyle())
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(buttonPressed: .constant(false))
    }
}
