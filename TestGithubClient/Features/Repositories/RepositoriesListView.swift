//
//  RepositoriesListView.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import SwiftUI

struct RepositoriesListView: View {
    @ObservedObject var viewModel: RepositoriesListViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isInitialLoading {
                    HStack(alignment: .center) {
                        Spacer()
                        ProgressView("Loading repositories")
                        Spacer()
                    }
                }
                ForEach(viewModel.respositoryRowViewModels) { repositoryRowViewModel in
                    Link(destination: repositoryRowViewModel.htmlUrl) {
                        RepositoryRow(viewModel: repositoryRowViewModel)
                            .onAppear {
                                if repositoryRowViewModel == viewModel.respositoryRowViewModels.last,
                                   viewModel.hasMorePages {
                                    viewModel.loadNextPage()
                                }
                            }
                    }
                }
                if viewModel.isNextPageLoading {
                    HStack(alignment: .center) {
                        Spacer()
                        ProgressView("Loading next page")
                        Spacer()
                    }
                }
            }
            .searchable(text: $viewModel.query)
            .navigationBarTitle("GitHub Repositories")
        }
    }
}

#Preview {
    RepositoriesListView(viewModel: RepositoriesListViewModel(repositoriesFetcher: RepositoriesFetcher(apiClient: APIClient())))
}
