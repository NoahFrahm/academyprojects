//
//  ContentView.swift
//  Choosey Woosey
//
//  Created by Samuel Shi on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = BusinessListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchView(vm: vm)

                    if !vm.businesses.isEmpty || vm.isLoading {
                        SearchResultsView(vm: vm)
                    }

                    Spacer()
                }
            }
            .fullscreenBackground(Color(.systemGray6))
            .navigationTitle("Choosey")
            .alert(isPresented: $vm.showError, content: { alert })
        }
    }

    var alert: Alert {
        Alert(title: Text("Something went wrong..."), message: Text(vm.errorMessage), dismissButton: .default(Text("OK")))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
