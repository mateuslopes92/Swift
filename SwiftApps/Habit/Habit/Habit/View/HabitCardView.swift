//
//  HabitCardView.swift
//  Habit
//
//  Created by Mateus Lopes on 27/01/25.
//
import Foundation
import SwiftUI

struct HabitCardView: View {

    @State private var action = false

    let viewModel: HabitCardViewModel

    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink(
                destination: HabitDetailView(viewModel: HabitDetailViewModel(id: viewModel.id, name: viewModel.name, label: viewModel.label)),
                isActive: self.$action,
                label: {
                    EmptyView()
                }
            )

            Button(
                action: {self.action = true},
                label: {
                    HStack {
                        Image(systemName: "pencil")
                            .padding(.horizontal, 8)

                        Spacer()

                        HStack(alignment: .top){

                            Spacer()

                            VStack(alignment: .leading, spacing: 4){
                                Text(viewModel.name)
                                    .foregroundColor(Color.orange)

                                Text(viewModel.label)
                                    .foregroundColor(Color("textColor"))
                                    .bold()

                                Text(viewModel.date)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                            }.frame(maxWidth: 300, alignment: .leading)

                            Spacer()

                            VStack(alignment: .leading, spacing: 4){
                                Text("Registered")
                                    .foregroundColor(Color.orange)
                                    .multilineTextAlignment(.leading)
                                    .bold()

                                Text(viewModel.value)
                                    .foregroundColor(Color("textColor"))
                                    .multilineTextAlignment(.leading)
                                    .bold()
                            }

                            Spacer()
                        }
                        Spacer()
                    }
                    .padding()
                    .cornerRadius(4)
                }
            )
            Rectangle()
                .foregroundColor(viewModel.state)
                .frame(width: 12)
                .offset(x: 1, y: 0)
        }
        .background(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.orange, lineWidth: 1.5)
                .shadow(color: .gray, radius: 2, x: 2, y: 2)
        )
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            NavigationView {
                List {
                    HabitCardView(
                        viewModel:
                            HabitCardViewModel(
                                id: 1,
                                icon: "https://placehold.co/600x400/000000/FFF",
                                date: "01/01/2025",
                                name: "Play guitar",
                                label: "hours",
                                value: "2",
                                state: .green
                            )
                    )

                    HabitCardView(
                        viewModel:
                            HabitCardViewModel(
                                id: 1,
                                icon: "https://placehold.co/600x400/000000/FFF",
                                date: "01/01/2025",
                                name: "Play guitar",
                                label: "hours",
                                value: "2",
                                state: .green
                            )
                    )
                }
                .navigationTitle("Test")
                .listStyle(.plain)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
        }
    }
}
