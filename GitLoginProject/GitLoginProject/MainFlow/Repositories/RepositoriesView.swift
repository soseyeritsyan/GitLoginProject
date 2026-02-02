//
//  RepositoroesView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 26.01.26.
//

import SwiftUI

struct RepositoriesView: View {
    @StateObject private var viewModel = RepositoriesViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.repositories) { repo in
                    RepositoryRow(repo: repo)
                        .onAppear {
                            if repo.id == viewModel.repositories.last?.id {
                                Task {
                                    await viewModel.loadMore()
                                }
                            }
                        }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Repositories")
        .task {
            await viewModel.loadInitial()
        }
    }
}
