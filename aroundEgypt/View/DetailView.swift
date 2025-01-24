//
//  ListItemSwiftUIView.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @State private var imageSaved: Bool = false
    @State private var cachedExperience: SingleExperienceModel?
    @State private var cachedLike: LikeCacheModel?
    @State private var likePressed: Bool = false
    @ObservedObject var singleviewModel: SingleExperienceViewModel
    @ObservedObject var likeviewModel: LikeExperienceViewModel
    @ObservedObject var networkMonitor = NetworkMonitor()

    private let cache = Cache<SingleExperienceModel>(memory: MemoryCache(countLimit: 100), disk: DiskCache(fileManager: DefaultFileManager()))
    private let cache2 = Cache<LikeCacheModel>(memory: MemoryCache(countLimit: 100), disk: DiskCache(fileManager: DefaultFileManager()))
    private let cacheKey: String
    private let cacheKey2: String

    init(singleviewModel: SingleExperienceViewModel, likeviewModel: LikeExperienceViewModel) {
        self.singleviewModel = singleviewModel
        self.cacheKey = "singleExperience_\(singleviewModel.experience?.data.id ?? "100")"
        self.cacheKey2 = "likeExperience_\(singleviewModel.experience?.data.id ?? "200")"
        self.likeviewModel = likeviewModel
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack(alignment: .bottomLeading) {
                            if let imageUrl = singleviewModel.experience?.data.coverPhoto, !imageUrl.isEmpty {
                                WebImage(url: URL(string: imageUrl))
                                    .cancelOnDisappear(true)
                                    .resizable()
                                    .onSuccess { image, _, _ in
                                        saveImage(image: image)
                                    }
                                    .frame(height: 300)
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10.0)
                            }
                            HStack(alignment: .bottom) {
                                Image(systemName: "eye.fill")
                                    .foregroundColor(.white)
                                Text(String(singleviewModel.experience?.data.viewsNo ?? 0))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "photo.on.rectangle")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text(singleviewModel.experience?.data.title ?? "Title")
                                        .font(.title2.bold())
                                        .padding(.horizontal, 8)
                                    Text((singleviewModel.experience?.data.city.name ?? "City") + ", Egypt")
                                        .font(.title2)
                                        .padding(.horizontal, 8)
                                }
                                Spacer()
                                Button(action: {
                                    likeviewModel.postServerData(id: singleviewModel.experience?.data.id ?? "")
                                    self.likePressed = true
                                    saveLikeToCache(isLiked: true) // Save updated likePressed to cache
                                }) {
                                    Image(systemName: self.likePressed ? "heart.fill" : "heart")
                                        .foregroundColor(Color(red: 241/255, green: 135/255, blue: 87/255))
                                }
                                Text(String(singleviewModel.experience?.data.likesNo ?? 0))
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 8)
                            }
                            
                            Divider()
                                .padding(.horizontal, 8)
                         
                            VStack(alignment: .leading) {
                                Text("Description")
                                    .font(.title.bold())
                                    .padding(.horizontal, 8)
                                Text(singleviewModel.experience?.data.description ?? "Description")
                                    .foregroundStyle(Color(.systemGray))
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .preferredColorScheme(.light)
            }
            .onAppear {
                if networkMonitor.isConnected {
                    loadLikeFromCache(id: singleviewModel.experience?.data.id ?? "7351979e-7951-4aad-876f-49d5027438bf")
                } else {
                    
                    loadFromCache()
                    loadLikeFromCache(id: singleviewModel.experience?.data.id ?? "7351979e-7951-4aad-876f-49d5027438bf")
                }
            }
        }
    }

    // Save Image to Photo Album
    func saveImage(image: UIImage?) {
        guard let image = image else { return }
        DispatchQueue.global(qos: .background).async {
            let imageSaver = ImageSaver()
            imageSaver.writeToPhotoAlbum(image: image)
            DispatchQueue.main.async {
                imageSaved = true
            }
        }
    }

    // Load Data from Cache
    private func loadFromCache() {
        if let cachedObject = try? cache.value(forKey: cacheKey) {
            cachedExperience = cachedObject
            singleviewModel.experience = cachedExperience
        }
    }
        
    private func loadLikeFromCache(id: String) {
        if let cachedLikeObject = try? cache2.value(forKey: cacheKey2) {
            if cachedLikeObject.id == id {
                cachedLike = cachedLikeObject
                likePressed = cachedLike?.isLiked ?? false
            }
        }
    }

    // Save Like State to Cache
    private func saveLikeToCache(isLiked: Bool) {
        cachedLike = LikeCacheModel(id: singleviewModel.experience?.data.id ?? "7351979e-7951-4aad-876f-49d5027438bf" , isLiked: likePressed)
        let likeObject = cachedLike ?? LikeCacheModel(id: "7351979e-7951-4aad-876f-49d5027438bf", isLiked: false)
        cachedLike = likeObject
        do {
            try cache2.save(likeObject, forKey: cacheKey2)
        } catch {
            print("Error saving likePressed to cache: \(error)")
        }
    }
}

// MARK: - Preview
#Preview {
    DetailView(
        singleviewModel: SingleExperienceViewModel(service: SingleExperienceService(), id: "7351979e-7951-4aad-876f-49d5027438bf"),
        likeviewModel: LikeExperienceViewModel(service: LikeExperienceService(), id: "7351979e-7951-4aad-876f-49d5027438bf")
    )
}
