//
//  WelcomePage.swift
//  MVVM
//
//  Created by felix angcot jr on 2/5/26.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(1)

            TripsView()
                .tabItem {
                    Label("Trips", systemImage: "suitcase.fill")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(3)
        }
    }
}

struct HomeView: View {
    @State private var searchText: String = ""
    private let categories = ["Trending", "Beach", "Countryside", "City", "Ski", "Islands", "Castles", "Cabins"]
    private let listings: [Listing] = Listing.sample

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    heroHeader
                    searchBar
                    categoryChips
                    listingsGrid
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
        }
    }

    private var heroHeader: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=1600&auto=format&fit=crop&q=60")) { phase in
                switch phase {
                case .empty:
                    ZStack { Color.gray.opacity(0.15); ProgressView() }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Color.gray.opacity(0.2)
                @unknown default:
                    Color.gray.opacity(0.2)
                }
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                LinearGradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.45)], startPoint: .center, endPoint: .bottom)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            )
            .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 8)

            VStack(alignment: .leading, spacing: 6) {
                Text("Find your next stay")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                Text("Homes, cabins, and unique experiences")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.95))
            }
            .padding(16)
        }
        .padding(.horizontal)
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Where to?", text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            Spacer(minLength: 0)
            Image(systemName: "slider.horizontal.3")
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(.horizontal)
    }

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories, id: \.self) { cat in
                    Text(cat)
                        .font(.system(size: 13, weight: .semibold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule().fill(Color(.systemBackground))
                                .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
                        )
                        .overlay(
                            Capsule().stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal)
        }
    }

    private var listingsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(listings) { item in
                ListingCard(listing: item)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 24)
    }
}

struct Listing: Identifiable {
    let id = UUID()
    let title: String
    let location: String
    let pricePerNight: Int
    let rating: Double
    let imageURL: URL?

    static let sample: [Listing] = [
        .init(title: "Cozy Beachfront Bungalow", location: "Maui, Hawaii", pricePerNight: 220, rating: 4.8, imageURL: URL(string: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=1200&auto=format&fit=crop&q=60")),
        .init(title: "Modern City Loft", location: "New York, USA", pricePerNight: 310, rating: 4.7, imageURL: URL(string: "https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=1200&auto=format&fit=crop&q=60")),
        .init(title: "Mountain Cabin Retreat", location: "Aspen, USA", pricePerNight: 180, rating: 4.6, imageURL: URL(string: "https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=1200&auto=format&fit=crop&q=60")),
        .init(title: "Island Overwater Villa", location: "Maldives", pricePerNight: 540, rating: 4.9, imageURL: URL(string: "https://images.unsplash.com/photo-1501117716987-c8e2aeea9a96?w=1200&auto=format&fit=crop&q=60")),
        .init(title: "Countryside Cottage", location: "Cotswolds, UK", pricePerNight: 160, rating: 4.5, imageURL: URL(string: "https://images.unsplash.com/photo-1505691723518-36a5ac3b2b8f?w=1200&auto=format&fit=crop&q=60")),
        .init(title: "Ski-in Ski-out Chalet", location: "Zermatt, Switzerland", pricePerNight: 420, rating: 4.8, imageURL: URL(string: "https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1200&auto=format&fit=crop&q=60"))
    ]
}

struct ListingCard: View {
    let listing: Listing

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.tertiarySystemBackground))
                AsyncImage(url: listing.imageURL, transaction: Transaction(animation: .spring())) { phase in
                    switch phase {
                    case .empty:
                        ZStack { Color.clear; ProgressView() }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.secondary)
                            .padding(28)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(4/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

            Text(listing.title)
                .font(.system(size: 15, weight: .semibold))
                .lineLimit(2)
            Text(listing.location)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
            HStack {
                Label(String(format: "%.1f", listing.rating), systemImage: "star.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.yellow)
                Spacer()
                Text("$\(listing.pricePerNight)/night")
                    .font(.system(size: 13, weight: .bold))
            }
        }
        .padding(12)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
        .padding(.bottom, 2)
    }
}

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "globe.americas.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.blue)
                Text("Explore destinations")
                    .font(.title2).bold()
                Text("Use search and filters to find your perfect stay.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Explore")
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct TripsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "suitcase.rolling.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.orange)
                Text("Your trips")
                    .font(.title2).bold()
                Text("Sign in to see upcoming and past trips.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Trips")
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.purple)
                Text("Profile")
                    .font(.title2).bold()
                Text("Manage your account, payments, and preferences.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    WelcomePage()
}
