//
//  SearchDetailView.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 25/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchDetailView: View {
    var item: Datum3
    @State private var imageSaved: Bool = false
    @State private var likePressed: Bool = false

    @ObservedObject var likeviewModel: LikeExperienceViewModel
    @ObservedObject var networkMonitor = NetworkMonitor()

    init(likeviewModel: LikeExperienceViewModel, item: Datum3) {
        self.likeviewModel = likeviewModel
        self.item = item
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack(alignment: .bottomLeading) {
                          if !item.coverPhoto.isEmpty {
                                WebImage(url: URL(string: item.coverPhoto))
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
                                Text(String(item.viewsNo ?? 0))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "photo.on.rectangle")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text(item.title ?? "Title")
                                        .font(.title2.bold())
                                        .padding(.horizontal, 8)
                                    Text((item.city.name ?? "City") + ", Egypt")
                                        .font(.title2)
                                        .padding(.horizontal, 8)
                                }
                                Spacer()
                                Button(action: {
                                    likeviewModel.postServerData(id: item.id ?? "")
                                    self.likePressed = true
                                }) {
                                    Image(systemName: self.likePressed ? "heart.fill" : "heart")
                                        .foregroundColor(Color(red: 241/255, green: 135/255, blue: 87/255))
                                }
                                Text(String(item.likesNo ?? 0))
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
                                Text(item.description ?? "Description")
                                    .foregroundStyle(Color(.systemGray))
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .preferredColorScheme(.light)
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
}

// MARK: - Preview
#Preview {
    SearchDetailView(
        likeviewModel: LikeExperienceViewModel(service: LikeExperienceService(), id:  "7351979e-7951-4aad-876f-49d5027438bf"), item: Datum3(id: "", title: "Test", coverPhoto: "https://picsum.photos/id/27/200/300", description: "Description ....", viewsNo: 67, likesNo: 335, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: JSONNull(), era: Era3(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation3(type: "", coordinates: []), openingHours: OpeningHours3(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours3(sunday: Day3(day: "", time: ""), monday: Day3(day: "", time: ""), tuesday: Day3(day: "", time: ""), wednesday: Day3(day: "", time: ""), thursday: Day3(day: "", time: ""), friday: Day3(day: "", time: ""), saturday: Day3(day: "", time: "")), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false)
    )
}
