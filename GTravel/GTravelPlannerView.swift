//
//  GTravelPlannerView.swift
//  GTravel
//
//  Created by Lono on 2024/8/5.
//

import LinkPreview
import SwiftUI

let TextOutputTokenLen = 30
struct GTravelPlannerView: View {
    @EnvironmentObject var appState: AppState
    @State private var partialInteractions: [Interaction] = []
    @State private var currentInteractionIndex = 0
    @State private var currentTextIndex = 0
    @State private var displayTimer: Timer?
    @State private var lastInteractionId = 0

    var body: some View {
        ZStack {
            // Color.black.edgesIgnoringSafeArea(.all)
            mainView
        }
        .navigationBarHidden(true)
        .background(Color.black)
        .onAppear {
            // print("full interactions", appState.interactions)
            startDisplayingResponse()
        }
    }

    var mainView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(partialInteractions.indices, id: \.self) { index in
                        let nextInteraction: Interaction? = index + 1 < partialInteractions.count ? partialInteractions[index + 1] : nil
                        if case let .input(inputType) = nextInteraction {
                            InteractionView(interaction: partialInteractions[index], inputType: inputType)
                                .id(index)
                        } else {
                            InteractionView(interaction: partialInteractions[index], inputType: nil)
                                .id(index)
                        }
                    }
                }
                .padding()
            }
            .onChange(of: lastInteractionId) { _ in
                withAnimation {
                    proxy.scrollTo(partialInteractions.count - 1, anchor: .bottom)
                }
            }
        }
    }

    private func startDisplayingResponse() {
        displayTimer = Timer.scheduledTimer(withTimeInterval: appState.userInputSpeed, repeats: true) { timer in
            if currentInteractionIndex < appState.interactions.count {
                let currentInteraction = appState.interactions[currentInteractionIndex]

                switch currentInteraction {
                case let .input(inputType):
                    switch inputType {
                    case let .userInput(userInput):
                        updatePartialInteraction(userInput: userInput)
                    case let .userInteraction(userInteraction):
                        updatePartialInteraction(userInteraction: userInteraction)
                    }
                case let .output(outputType):
                    updatePartialInteraction(outputType: outputType)
                }

                // Check if the current interaction is complete
                if currentTextIndex == 0 {
                    // Delay the next interaction by 0.5 seconds
                    timer.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.startDisplayingResponse()
                    }
                }
            } else {
                timer.invalidate()
            }
        }
    }

    private func updatePartialInteraction(userInput: UserInput) {
        let fullText = userInput.userInput

        // the first user input always displays immediately
        if currentInteractionIndex == 0 {
            partialInteractions.append(.input(.userInput(userInput)))

            currentInteractionIndex += 1
            return
        }
        if currentTextIndex < fullText.count {
            let partialText = String(fullText.prefix(currentTextIndex + 1))
            if partialInteractions.isEmpty || !(partialInteractions.last?.isUserInput ?? false) {
                partialInteractions.append(.input(.userInput(UserInput(userInput: partialText))))
            } else {
                partialInteractions[partialInteractions.count - 1] = .input(.userInput(UserInput(userInput: partialText)))
            }
            currentTextIndex += 1
        } else {
            currentInteractionIndex += 1
            currentTextIndex = 0
            lastInteractionId = partialInteractions.count - 1
        }
    }

    private func updatePartialInteraction(userInteraction: UserInteraction) {
        let fullSelected = userInteraction.selected

        if currentTextIndex < fullSelected.count {
            let partialSelected = Array(fullSelected.prefix(currentTextIndex + 1))
            let partialUserInteraction = UserInteraction(userInteraction: userInteraction.userInteraction, selected: partialSelected)

            if partialInteractions.isEmpty || !partialInteractions[partialInteractions.count - 1].isUserInteraction {
                partialInteractions.append(.input(.userInteraction(partialUserInteraction)))
            } else {
                partialInteractions[partialInteractions.count - 1] = .input(.userInteraction(partialUserInteraction))
            }
            currentTextIndex += 1
        } else {
            currentInteractionIndex += 1
            currentTextIndex = 0
            lastInteractionId = partialInteractions.count - 1
        }
    }

    private func updatePartialInteraction(outputType: OutputType) {
        switch outputType {
        case let .textOutput(llmOutput):
            updatePartialLLMOutput(llmOutput)
        case let .systemOutput(systemOutput):
            updatePartialSystemOutput(systemOutput)
        case let .trafficOutput(traffics):
            updatePartialTrafficOutput(traffics)
        case let .tripData(tripData):
            updatePartialTripData(tripData)
        }
    }

    private func updatePartialLLMOutput(_ llmOutput: LLMOutput) {
        let fullText = llmOutput.llmOutput
        if currentTextIndex < fullText.count {
            let partialText = String(fullText.prefix(currentTextIndex + TextOutputTokenLen))
            let partialLLMOutput = LLMOutput(llmOutput: partialText)
            if partialInteractions.isEmpty || !(partialInteractions.last?.isTextOutput ?? false) {
                partialInteractions.append(.output(.textOutput(partialLLMOutput)))
            } else {
                partialInteractions[partialInteractions.count - 1] = .output(.textOutput(partialLLMOutput))
            }
            currentTextIndex += TextOutputTokenLen
        } else {
            currentInteractionIndex += 1
            currentTextIndex = 0
            lastInteractionId = partialInteractions.count - 1
        }
    }

    private func updatePartialSystemOutput(_ systemOutput: SystemOutput) {
        // For simplicity, we'll just add the entire SystemOutput at once
        // You can implement gradual reveal for system message if needed
        partialInteractions.append(.output(.systemOutput(systemOutput)))
        currentInteractionIndex += 1
        currentTextIndex = 0
        lastInteractionId = partialInteractions.count - 1
    }

    private func updatePartialTrafficOutput(_ traffics: [DailyItinerary]) {
        // For simplicity, we'll add the entire traffic output at once
        // You can implement gradual reveal for traffic data if needed
        partialInteractions.append(.output(.trafficOutput(traffics)))
        currentInteractionIndex += 1
        currentTextIndex = 0
        lastInteractionId = partialInteractions.count - 1
    }

    private func updatePartialTripData(_ tripData: TripData) {
        // For simplicity, we'll add the entire trip data at once
        // You can implement gradual reveal for trip data if needed
        partialInteractions.append(.output(.tripData(tripData)))
        currentInteractionIndex += 1
        currentTextIndex = 0
        lastInteractionId = partialInteractions.count - 1
    }
}

struct InteractionView: View {
    let interaction: Interaction
    let inputType: InputType?

    var body: some View {
        switch interaction {
        case let .input(inputType):
            switch inputType {
            case let .userInput(userInput):
                UserInputView(userInput: userInput)
            case let .userInteraction(userInteraction):
                UserInteractionView(userInteraction: userInteraction)
            }
        case let .output(outputType):
            switch outputType {
            case let .textOutput(textOutput):
                TextOutputView(textOutput: textOutput)
            case let .systemOutput(systemOutput):
                SystemOutputView(systemOutput: systemOutput, inputType: inputType)
            case let .trafficOutput(traffics):
                GoogleTrafficView(googleTraffic: traffics)
                    .frame(height: 330)
            case let .tripData(tripData):
                TripDataView()
            }
        }
    }
}

// Add the necessary view structs (UserInputView, UserInteractionView, OutputView) here...

extension Interaction {
    var isUserInput: Bool {
        if case .input(.userInput(_)) = self { return true }
        return false
    }

    var isUserInteraction: Bool {
        if case .input(.userInteraction(_)) = self { return true }
        return false
    }

    var isTextOutput: Bool {
        if case .output(.textOutput(_)) = self { return true }
        return false
    }

    var isSystemOutput: Bool {
        if case .output(.systemOutput(_)) = self { return true }
        return false
    }
}

struct UserInputView: View {
    let userInput: UserInput
    var body: some View {
        Text(userInput.userInput)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(10)
    }
}

struct UserInteractionView: View {
    let userInteraction: UserInteraction

    var body: some View {
        Text(userInteraction.text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(10)
    }
}

struct SystemOutputView: View {
    let systemOutput: SystemOutput
    let inputType: InputType?
    @State private var userCommand: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            if !systemOutput.youtubeAPIOutput.isEmpty {
                // YouTube Videos Section
                VStack(alignment: .leading, spacing: 20) {
                    Text("Recommended Videos")
                        .font(.title)
                        .foregroundColor(.white)

                    YouTubeVideoView(videos: systemOutput.youtubeAPIOutput)
                }
            }

            if !systemOutput.recommendation.isEmpty {
                // Places Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recommended Places")
                        .font(.title)
                        .foregroundColor(.white)

                    SelectableImageGallery(places: systemOutput.recommendation, selected: inputType?.userInteraction?.selected ?? [], onConfirm: { _ in })
                }
            }

            if let inputType = inputType {
                SelectableTextOptions(
                    options: ["Complete Planning", "Show Transport Options", "Save to Itinerary"],
                    selected: inputType.userInteraction?.selected ?? [],
                    onConfirm: { selected in
                        // Handle the selected options here
                        print("Selected options: \(selected)")
                    }
                )

                // New TextField for user commands
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.gray)
                    TextField("", text: .constant(inputType.userInteraction?.text ?? inputType.userInput?.userInput ?? ""), prompt: Text("Enter instruction...").foregroundColor(Color(white: 0.7)))
                        .foregroundColor(Color.white)
                        .minimumScaleFactor(0.4)

                    Button(action: {
                        // Add your send action here
                        print("Send button tapped")
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            }
        }
    }
}

struct TextOutputView: View {
    let textOutput: LLMOutput

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(LocalizedStringKey(textOutput.llmOutput))
                .foregroundColor(Color.white)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
    }
}

struct YouTubeVideoView: View {
    let videos: [YoutubeVideo]

    var body: some View {
        VStack(spacing: 10) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(videos) { video in

                    LinkPreview(url: video.url)
                        .backgroundColor(.blue)
                        .primaryFontColor(.white)
                        .secondaryFontColor(.white.opacity(0.6))
                        .titleLineLimit(3)
                        .frame(width: 140, height: 140)
                        .cornerRadius(10)
                }
            }

            // Uncomment if you want to add a "View More" button
            /*
             Button(action: {
                 // Action for View More
             }) {
                 Text("View More")
                     .foregroundColor(.blue)
             }
             */
        }
    }
}

// Preview
struct GTravelPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GTravelPlannerView()
            .environmentObject(AppState())
    }
}