//
//  RepositoryRow.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 30.01.26.
//

import SwiftUI

struct RepositoryRow: View {
    let repo: Repository

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(repo.name)
                    .font(.headline)

                if repo.isPrivate {
                    Text("Private")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

