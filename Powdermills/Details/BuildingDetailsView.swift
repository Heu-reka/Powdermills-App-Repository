//
//  BuildingDetailsView.swift
//  Powdermills
//
//  Created by James Sadlier on 14/09/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct BuildingDetailsView: View {
	var viewModel: BuildingDetailsViewModel
	@State var imageIndex: Int = 0
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		ZStack {
			ScrollView {
				Section(header:
									carousel
									.frame(height: 209, alignment: .center),
								content: {
									Group {
										history
										function
										if viewModel.building.funFacts.count > 0 {
											trivia
										}
									}.padding(.top, -12)
								})
				
			}
			.edgesIgnoringSafeArea(.top)
			.navigationBarTitle("\(viewModel.building.name)")
			.navigationBarHidden(true)
			
			VStack {
				titleView
					.frame(height: 64, alignment: .top)
					.padding(.top, -40)
				Spacer()
			}
		}
	}
	
	var titleView: some View {
		ZStack {
			VStack {
				Text(viewModel.building.name)
					.font(Font.buildingDetailsTitleFont)
					.foregroundColor(.listTextColor)
					.padding()
					.padding(.top, 22)
				Spacer()
			}
			VStack {
				HStack {
					backButton
						.font(Font.backButtonFont)
						.padding()
						.padding(.top, 26)
					Spacer()
				}
				Spacer()
			}
		}
	}
	
	var carousel: some View {
		TabView(selection: $imageIndex,
						content:  {
							ForEach (viewModel.building.imagePaths, id: \.self) { path in
								ZStack {
									WebImage(url: URL(string: path))
										.resizable()
										.scaledToFill()
										.frame(height: 209)
										.clipped()
									gradient
								}
                .tag(viewModel.building.imagePaths.firstIndex(of: path) ?? 0)
							}
						})
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
	}
	
	var gradient: some View {
		LinearGradient(gradient: Gradient(colors: [.gradiant3, .gradiant2, .gradiant1, .gradiant0]), startPoint: .top, endPoint: .center)
			.opacity(0.95)
	}
	
	func carouselImage(at index: Int) -> AnyView {
		return AnyView (
			Text("")
				.tabItem {
					Image("")
				}.tag(index)
		)
	}
	
	var history: some View {
		VStack {
			BuildingSubtitleView(text: "History", color: Color.historyColor, textColor: Color.white)
			Text(viewModel.building.history)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding()
		}
	}
	
	var backButton: some View {
		Button {
			self.presentationMode.wrappedValue.dismiss()
		} label: {
			Image(systemName: "arrow.backward")
				.foregroundColor(.listTextColor)
		}
	}
	
	var function: some View {
		VStack {
			BuildingSubtitleView(text: "Function", color: Color.functionColor, textColor: Color.white)
			Text("\(viewModel.building.function)")
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding()
		}
	}
	
	var trivia: some View {
		VStack {
			BuildingSubtitleView(text: "Trivia", color: Color.triviaColor, textColor: Color.white)
			ForEach(viewModel.building.funFacts, id: \.self) { fact in
				Text(fact)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
			}
		}
	}
}
