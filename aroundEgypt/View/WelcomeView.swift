//
//  ContentView.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import SwiftUI
import Network

struct WelcomeView: View {
    @State private var searchText = ""
    
    
    
    @ObservedObject var recommendedViewModel: RecommendedExperiencesViewModel
    @ObservedObject var mostRecentViewModel: MostRecentExperiencesViewModel
    @ObservedObject var searchViewModel: SearchExperiencesViewModel

    private let monitor = NWPathMonitor()
    @State private var isNetworkAvailable = true

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                headerSection
                recommendedSection
                mostRecentSection
                
                    .padding()
                    
                   
                    .onAppear {
                        startMonitoringNetwork()
                        if isNetworkAvailable {
                            saveToCache()
                        }
                    }
            }
        }.searchable(text: $searchText, prompt: "Try \"Luxor\"") {
            searchResults
        }
        .onChange(of: searchText) { searchText in
            searchViewModel.getServerData(searchText: searchText)
        }
    }

    
    
    private func saveToCache() {
        guard let recommendedData = recommendedViewModel.experiences else { return }
        guard let mostRecentData = mostRecentViewModel.experiences else { return }
        let memoryCache = MemoryCache<RecommendedExperiencesModel>(countLimit: 100)
        let memoryCache2 = MemoryCache<MostRecentExperiencesModel>(countLimit: 100)
        let fileManager = DefaultFileManager()
        let diskCache = DiskCache<RecommendedExperiencesModel>(fileManager: fileManager)
        let diskCache2 = DiskCache<MostRecentExperiencesModel>(fileManager: fileManager)
        let cache = Cache<RecommendedExperiencesModel>(memory: memoryCache, disk: diskCache)
        let cache2 = Cache<MostRecentExperiencesModel>(memory: memoryCache2, disk: diskCache2)
        
        do {
            try cache.save(recommendedData, forKey: "recommended")
            try cache2.save(mostRecentData, forKey: "mostrecent")
        } catch {
            print("Error saving to cache: \(error)")
        }
    }
    
    private func startMonitoringNetwork() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                isNetworkAvailable = (path.status == .satisfied)
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        
    }
}

// MARK: - Private Views
private extension WelcomeView {
    /// Header Section
    var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome!")
                .font(.title)
                .fontWeight(.bold)
            Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                .fontWeight(.semibold)
            
            
        }
    }
    
    /// Recommended Section
    var recommendedSection: some View {
        RecommendedSectionView(
            title: "Recommended Experiences",
            recommendedviewModel: recommendedViewModel,
            cacheKey: "recommended",
            isNetworkAvailable: isNetworkAvailable
        )
    }
    
    /// Most Recent Section
    var mostRecentSection: some View {
        MostRecentSectionView(
            title: "Most Recent",
            mostrecentviewModel: mostRecentViewModel,
            cacheKey: "mostrecent",
            isNetworkAvailable: isNetworkAvailable
        )
    }
    
    /// Search Results
    var searchResults: some View {
        ForEach(searchViewModel.searchExperiences?.data ?? []) { item in
            NavigationLink(
                destination: SearchDetailView(likeviewModel: LikeExperienceViewModel(service: LikeExperienceService(), id: item.id), item: item)
            ) {
                SearchItemView(item: item)
            }
        }
    }
}

// MARK: - Section View
struct RecommendedSectionView: View {
    let title: String
    @ObservedObject var recommendedviewModel: RecommendedExperiencesViewModel
    let cacheKey: String
    let isNetworkAvailable: Bool

    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    if isNetworkAvailable {
                        ForEach(recommendedviewModel.experiences?.data ?? []) { item in
                            NavigationLink(
                                destination: RecommendedDetailView(likeviewModel: LikeExperienceViewModel(service: LikeExperienceService(), id: item.id), item: item)
                            ) {
                                RecommendedItemView(item: item)
                            }
                        }
                    } else {
                        loadFromCache(forKey: cacheKey)
                    }
                }
            }
            .frame(height: 200)
        }
    }
    
   
    private func loadFromCache(forKey key: String) -> some View {
        let memoryCache = MemoryCache<RecommendedExperiencesModel>(countLimit: 100)
        let fileManager = DefaultFileManager()
        let diskCache = DiskCache<RecommendedExperiencesModel>(fileManager: fileManager)
        let cache = Cache<RecommendedExperiencesModel>(memory: memoryCache, disk: diskCache)

        return Group {
            if let cachedObject = try? cache.value(forKey: key) {
                ForEach(cachedObject.data) { item in
                    NavigationLink(
                        destination: RecommendedDetailView(likeviewModel: LikeExperienceViewModel(service: LikeExperienceService(), id: item.id), item:  item)
                    ) {
                        RecommendedItemView(item: item)
                    }
                }
            } else {
                Text("No data available in the cache.")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct MostRecentSectionView: View {
    
    
    let title: String
    @ObservedObject var mostrecentviewModel: MostRecentExperiencesViewModel
    let cacheKey: String
    let isNetworkAvailable: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    if isNetworkAvailable {
                        ForEach(mostrecentviewModel.experiences?.data ?? []) { item in
                            NavigationLink(
                                destination: MostRecentDetailView( likeviewModel: LikeExperienceViewModel(service: LikeExperienceService(), id: item.id), item: item)
                            ) {
                                MostRecentItemView(item: item)
                            }
                        }
                    } else {
                        loadFromCache(forKey: cacheKey)
                    }
                }
            }
            .frame(height: 200)
        }
    }
    
        }
    
    private func loadFromCache(forKey key: String) -> some View {
        let memoryCache = MemoryCache<MostRecentExperiencesModel>(countLimit: 100)
        let fileManager = DefaultFileManager()
        let diskCache = DiskCache<MostRecentExperiencesModel>(fileManager: fileManager)
        let cache = Cache<MostRecentExperiencesModel>(memory: memoryCache, disk: diskCache)

        return Group {
            if let cachedObject = try? cache.value(forKey: key) {
                ForEach(cachedObject.data) { item in
                    NavigationLink(
                        destination: MostRecentDetailView(likeviewModel: LikeExperienceViewModel(service: LikeExperienceService(), id: item.id), item: item)
                    ) {
                        MostRecentItemView(item: item)
                    }
                }
            } else {
                Text("No data available in the cache.")
                    .foregroundColor(.gray)
            }
        }
    }




// MARK: - Preview
#Preview {
    WelcomeView(
        recommendedViewModel: RecommendedExperiencesViewModel(service: RecommendedExperiencesService()),
        mostRecentViewModel: MostRecentExperiencesViewModel(service: MostRecentExperiencesService()),
        searchViewModel: SearchExperiencesViewModel(service: SearchExperiencesService(), searchText: "Luxor")
    )
}
