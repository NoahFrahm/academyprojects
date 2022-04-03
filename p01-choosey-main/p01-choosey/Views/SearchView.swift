//
//  SearchView.swift
//  p01
//
//  Created by Samuel Shi on 9/19/21.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var vm: BusinessListViewModel

    var body: some View {
        VStack(spacing: 10) {
            MySection(header: Text("What are you interested in?")) {
                TextField("Enter a search term here...", text: $vm.searchTerm)
            }

            MySection(header: Text("How far are you willing to go?")) {
                Stepper(stepperCopy, value: $vm.radius)
            }

            MySection(header: EmptyView(), background: Color.blue) {
                Button(action: vm.getPlaces) { searchButton }
            }
            .padding(.vertical)
        }
        .buttonStyle(PlainButtonStyle())
    }

    var searchButton: some View {
        HStack {
            Spacer()

            Label("Search", systemImage: "magnifyingglass")
                .frame(alignment: .center)
                .foregroundColor(.white)

            Spacer()
        }
        .background(Color.blue)
    }
    
    var stepperCopy: String {
        "\(vm.radius) mile\(vm.radius == 1 ? "" : "s")"
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(vm: BusinessListViewModel())
    }
}
