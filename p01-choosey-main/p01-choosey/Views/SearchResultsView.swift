//
//  SeachResultsView.swift
//  p01
//
//  Created by Samuel Shi on 9/19/21.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var vm: BusinessListViewModel

    var body: some View {
        MySection(header: Text("Businesses")) {
            VStack {
                if vm.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else {
                    ForEach(vm.businesses.sorted(favoriteId: vm.highestRatedId), id: \.id) { business in
                        Button {
                            UIApplication.shared.openWebsite(for: business)
                        } label: {
                            BusinessView(business: BusinessViewModel(business: business), isHighestRated: isHighestRated(business: business))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
    
    func isHighestRated(business: Business) -> Bool {
        vm.highestRatedId == business.id
    }
}

struct SeachResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(vm: BusinessListViewModel())
    }
}
