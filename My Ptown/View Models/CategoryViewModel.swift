//
//  PtownViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 21.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol CategoryListViewModelProtocol: class {
    func didGetCategoryData()
}

class CategoryListViewModel {
    weak var delegate: CategoryListViewModelProtocol?
    var getMenuName: String?
    var getMenuUrl: String?
    var getMenuImage: String?
    var mekanlar: [Results?] = []
    
     func getData() {
        if let categoryBaseUrl = self.getMenuUrl {
            let url = "\(CATEGORY_BASEURL)\(categoryBaseUrl)"
            NetworkManager().performRequest(url: url) { [weak self] (response: NetworkResponse<CategoryData, NetworkError>) in
                guard let self = self else { return }
                
                switch response {
                case .success(let result):
                    self.mekanlar = result.results
                    self.delegate?.didGetCategoryData()
                    break
                case .failure(let error):
                    print(error.errorMessage)
                }

            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return self.mekanlar.count
    }
    
    func ptownAtIndex(_ index: Int) -> Results? {
       return mekanlar[index]
    }
    
    func getLocations() -> [Location?] {
        var locations = [Location?]()
        for mekan in self.mekanlar {
            locations.append(mekan?.geometry.location)
        }
        return locations
    }
}
