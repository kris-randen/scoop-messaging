//
//  AlgoliaSetupExample.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/30/22.
//

import SwiftUI
import InstantSearchSwiftUI
import InstantSearchCore

struct StockItem: Codable {
    let name: String
}

class AlgoliaController {
    
    let searcher: HitsSearcher
    
    let searchBoxInteractor: SearchBoxInteractor
    let searchBoxController: SearchBoxObservableController
    
    let hitsInteractor: HitsInteractor<StockItem>
    let hitsController: HitsObservableController<StockItem>
    
    init() {
        self.searcher = HitsSearcher(
            appID: "latency",
            apiKey:"1f6fd3a6fb973cb08419fe7d288fa4db",
            indexName: "bestbuy")
        self.searchBoxInteractor = .init()
        self.searchBoxController = .init()
        self.hitsInteractor = .init()
        self.hitsController = .init()
        
        setupConnections()
    }
    
    func setupConnections() {
        searchBoxInteractor.connectSearcher(searcher)
        searchBoxInteractor.connectController(searchBoxController)
        hitsInteractor.connectSearcher(searcher)
        hitsInteractor.connectController(hitsController)
    }
}

struct AlgoliaSetupExample: View {
    
    @ObservedObject var searchBoxController: SearchBoxObservableController
    @ObservedObject var hitsController: HitsObservableController<StockItem>
    
    @State private var isEditing = false
    
    var body: some View {
        VStack(spacing: 7) {
            HitsList(hitsController) { hit, _ in
                VStack(alignment: .leading, spacing: 10) {
                    Text(hit?.name ?? "")
                        .padding(.all, 10)
                    Divider()
                }
            } noResults: {
                Text("No Results")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .searchable(text: $searchBoxController.query)
        .navigationBarTitle("Algolia & SwiftUI")
    }
}

struct AlgoliaSetupExample_Previews: PreviewProvider {
    
    static let algoliaController = AlgoliaController()
    
    static var previews: some View {
        NavigationView {
            AlgoliaSetupExample(searchBoxController: algoliaController.searchBoxController, hitsController: algoliaController.hitsController)
        }.onAppear {
            algoliaController.searcher.search()
        }
    }
}
