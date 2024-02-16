//
//  RepositoryRow.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import SwiftUI

struct RepositoryRow: View {
    let viewModel: RepositoriesListViewModel.RepositoryRowViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: viewModel.avatarUrl) { phase in
                switch phase {
                case let .success(image):
                    image
                case .empty, .failure:
                    Image(systemName: "photo.circle")
                @unknown default:
                    fatalError()
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text(viewModel.description ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2, reservesSpace: true)
            }
            
            Spacer()
            
            Image(systemName: "star.fill")
                .font(.body)
                .foregroundStyle(.yellow)
            Text("\(viewModel.starsCount)")
                .font(.body)
                .foregroundStyle(.yellow)
            
            Image(systemName: "chevron.right")
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
}
