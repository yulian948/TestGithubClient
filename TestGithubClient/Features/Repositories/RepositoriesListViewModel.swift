//
//  RepositoriesListViewModel.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Combine
import Foundation

class RepositoriesListViewModel: ObservableObject {
    struct RepositoryRowViewModel: Identifiable, Hashable {
        let id: Int
        let name: String
        let description: String?
        let avatarUrl: URL?
        let htmlUrl: URL
        let starsCount: Int
        
        init(withRepository repository: Repository) {
            self.id = repository.id
            self.name = repository.name
            self.description = repository.description
            self.avatarUrl = repository.owner?.avatarURL
            self.htmlUrl = repository.htmlURL
            self.starsCount = repository.stargazersCount
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var respositoryRowViewModels: [RepositoryRowViewModel] = []
    @Published private(set) var isInitialLoading: Bool = false
    @Published private(set) var isNextPageLoading: Bool = false
    
    @Published var query: String = ""
    
    private let repositoriesFetcher: RepositoriesFetcherProtocol
    
    private var currentPage = 1
    private(set) var hasMorePages = false
    
    init(repositoriesFetcher: RepositoriesFetcherProtocol) {
        self.repositoriesFetcher = repositoriesFetcher
        
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.currentPage = 1
                self?.searchRepositories()
            }
            .store(in: &cancellables)
    }
    
    private func searchRepositories() {
        guard !query.isEmpty else {
            isNextPageLoading = false
            return
        }
        
        isInitialLoading = true
        
        repositoriesFetcher.fetchRepositories(query: query, page: currentPage)
            .map({ repositoriesResponse in
                var respositoryRowViewModels: [RepositoryRowViewModel] = []
                for repository in repositoriesResponse.items {
                    respositoryRowViewModels.append(RepositoryRowViewModel(withRepository: repository))
                }
                let hasMore = repositoriesResponse.totalCount > self.respositoryRowViewModels.count + respositoryRowViewModels.count
                return (respositoryRowViewModels, hasMore)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // TODO: Handle errors
            }, receiveValue: { (respositoryRowViewModels, hasMorePages) in
                self.isInitialLoading = false
                self.isNextPageLoading = false
                self.hasMorePages = hasMorePages
                if self.currentPage == 1 {
                    self.respositoryRowViewModels = respositoryRowViewModels
                } else {
                    self.respositoryRowViewModels += respositoryRowViewModels
                }
            })
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
        currentPage += 1
        
        isNextPageLoading = true
        searchRepositories()
    }
}
