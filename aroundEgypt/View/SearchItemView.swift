//
//  SearchItemView.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchItemView: View {
    @State private var imageSaved: Bool = false
    let item: Datum3

    var body: some View {
        HStack {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    if let url = URL(string: item.coverPhoto) {
                        WebImage(url: url)
                            .cancelOnDisappear(true)
                            .resizable()
                            .onSuccess { (image, _, _) in
                                saveImage(image: image)
                            }
                            .frame(height: 154)
                            .frame(width: 339)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10.0)
                    }

                    // Views and likes overlay
                    HStack(alignment: .bottom) {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.white)
                        Text(String(item.viewsNo))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "photo.on.rectangle")
                            .foregroundColor(.white)
                    }
                }

                // Title and likes row
                HStack {
                    Text(item.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    Text(String(item.likesNo))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(red: 241/255, green: 135/255, blue: 87/255))
                }
            }
            .frame(height: 200)
            .frame(maxWidth: 339)
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

#Preview {
    SearchItemView(item: Datum3(id: "", title: "Test", coverPhoto: "https://picsum.photos/id/27/200/300", description: "Description ....", viewsNo: 67, likesNo: 335, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: JSONNull(), era: Era3(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation3(type: "", coordinates: []), openingHours: OpeningHours3(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours3(sunday: Day3(day: "", time: ""), monday: Day3(day: "", time: ""), tuesday: Day3(day: "", time: ""), wednesday: Day3(day: "", time: ""), thursday: Day3(day: "", time: ""), friday: Day3(day: "", time: ""), saturday: Day3(day: "", time: "")), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false))
}
