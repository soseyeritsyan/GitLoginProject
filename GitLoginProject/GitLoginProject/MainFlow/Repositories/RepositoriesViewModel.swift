//
//  RepositoriesViewModel.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 28.01.26.
//

import SwiftUI
import Combine

@MainActor
final class RepositoriesViewModel: ObservableObject {
    
    @Published private(set) var repositories: [Repository] = []
    @Published var isLoading = false
    
    private let githubApiManager = GithubApiManager()

    private var page = 1
    private var canLoadMore = true

    func loadInitial() async {
        page = 1
        canLoadMore = true
        repositories.removeAll()
        await loadMore()
    }

    func loadMore() async {
        guard !isLoading, canLoadMore else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let newRepos = try await githubApiManager.fetchRepositories(page: page)

            if newRepos.isEmpty {
                canLoadMore = false
            } else {
                repositories.append(contentsOf: newRepos)
                page += 1
            }
        } catch {
            print("Failed to load repos:", error)
        }
    }
}
