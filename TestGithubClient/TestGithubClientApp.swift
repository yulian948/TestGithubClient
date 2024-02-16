//
//  TestGithubClientApp.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import SwiftUI

@main
struct TestGithubClientApp: App {
    var body: some Scene {
        WindowGroup {
            RepositoriesListView(viewModel: RepositoriesListViewModel(repositoriesFetcher: RepositoriesFetcher(apiClient: APIClient())))
        }
    }
}
