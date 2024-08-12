import Foundation

enum Interaction {
    case input(InputType)
    case output(OutputType)
}

enum InputType {
    case userInput(UserInput)
    case userInteraction(UserInteraction)
}

extension InputType {
    var userInteraction: UserInteraction? {
        guard case let .userInteraction(user) = self else {
            return nil
        }
        return user
    }

    var userInput: UserInput? {
        guard case let .userInput(userInput) = self else {
            return nil
        }

        return userInput
    }
}

enum OutputType {
    case textOutput(LLMOutput)
    case systemOutput(SystemOutput)
    case trafficOutput([DailyItinerary])
    case tripData(TripData)
}

// MARK: - Root Models

struct UserInput: Codable {
    let userInput: String

    enum CodingKeys: String, CodingKey {
        case userInput = "user_input"
    }

    static let sample = UserInput(userInput: "黃仁勳上個月來台，都造訪了哪些美食？")
}

struct LLMOutput: Codable {
    let llmOutput: String

    enum CodingKeys: String, CodingKey {
        case llmOutput = "llm_output"
    }

    static let sample1 = LLMOutput(llmOutput: "1. LLM use Searching tool. 2. LLM generate based on the search results to provide an answer.")
    static let sample2 = LLMOutput(llmOutput: "黃仁勳夜市行程 + 饒河夜市推薦美食.....")
}

struct SystemOutput: Codable {
    init(youtubeAPIOutput: [YoutubeVideo], recommendation: [Place], systemMessage: String) {
        self.youtubeAPIOutput = youtubeAPIOutput
        self.recommendation = recommendation
        self.systemMessage = systemMessage
    }

    init(finalPlan: String) {
        youtubeAPIOutput = []
        recommendation = []
        systemMessage = finalPlan
    }

    let youtubeAPIOutput: [YoutubeVideo]
    let recommendation: [Place]
    let systemMessage: String

    enum CodingKeys: String, CodingKey {
        case youtubeAPIOutput = "Youtube_api_output"
        case recommendation = "Recommendation"
        case systemMessage = "system_message"
    }

    static let empty: SystemOutput = .init(finalPlan: "")
}

struct UserInteraction: Codable {
    let userInteraction: String
    let selected: [String]
    enum CodingKeys: String, CodingKey {
        case userInteraction = "user_interaction"
        case selected
    }

    static func selectCard(selected: [String]) -> Self {
        UserInteraction(userInteraction: "", selected: selected)
    }

    static let savePlan = UserInteraction(userInteraction: "Save to Itinerary", selected: ["Save to Itinerary"])
    static let finishPlan = UserInteraction(userInteraction: "Complete Planning", selected: ["Complete Planning"])
    static let transportPlan = UserInteraction(userInteraction: "Show Transport Options", selected: ["Show Transport Options"])
}

extension UserInteraction {
    var text: String {
        if !selected.isEmpty {
            return selected.joined(separator: ", ")
        }

        return userInteraction
    }
}

struct UserSystemInput: Codable {
    let interestedLocations: [Place]

    enum CodingKeys: String, CodingKey {
        case interestedLocations = "interested_locations"
    }

    static let sample = UserSystemInput(
        interestedLocations: [
            Place(placeID: "3", name: "Taroko Gorge", url: URL(string: "https://picsum.photos/400/300")!),
            Place(placeID: "4", name: "Sun Moon Lake", url: URL(string: "https://picsum.photos/200/400")!),
        ]
    )
}

struct InterestedLocations: Codable {
    let day1: [Place]
    let day2: [Place]

    enum CodingKeys: String, CodingKey {
        case day1 = "day_1"
        case day2 = "day_2"
    }
}

struct PlanData: Codable {
    let finalPlan: String
    let summary: String
    let trafficInfo: String

    enum CodingKeys: String, CodingKey {
        case finalPlan = "final_plan"
        case summary
        case trafficInfo = "交通資訊"
    }

    static let sample = PlanData(finalPlan: "最終規劃", summary: ".........................", trafficInfo: "Google Map API 回傳的路徑json格式")
}

// MARK: - Supporting Models

struct YoutubeVideo: Codable {
    init(videoID: String, videoTitle: String, summary: String, locations: [String]) {
        self.videoID = videoID
        self.videoTitle = videoTitle
        self.summary = summary
        self.locations = locations
    }

    init(videoID: String, videoTitle: String) {
        self.videoID = videoID
        self.videoTitle = videoTitle
        summary = ""
        locations = []
    }

    let videoID: String
    let videoTitle: String
    let summary: String
    let locations: [String]

    enum CodingKeys: String, CodingKey {
        case videoID = "video_id"
        case videoTitle = "video_title"
        case summary
        case locations
    }

    static let sample1 = YoutubeVideo(videoID: "ep_LWTwK3G8", videoTitle: "台灣夜市美食", summary: "介紹台灣夜市的影片", locations: ["台北", "台灣"])
    static let sample2 = YoutubeVideo(videoID: "C3SNF5UCXPo", videoTitle: "台灣夜市美食1", summary: "介紹台灣夜市的影片", locations: ["台北", "台灣"])
    static let sample3 = YoutubeVideo(videoID: "3OzipAmNG2s", videoTitle: "台灣夜市美食2", summary: "介紹台灣夜市的影片", locations: ["台北", "台灣"])
    static let sample4 = YoutubeVideo(videoID: "-VJK0KXewM0", videoTitle: "台灣夜市美食3", summary: "介紹台灣夜市的影片", locations: ["台北", "台灣"])
}

extension YoutubeVideo: Identifiable {
    var id: URL {
        return url
    }

    var url: URL {
        URL(string: "https://www.youtube.com/watch?v=\(videoID)")!
    }
}

struct Place: Hashable, Codable {
    let placeID: String
    let name: String
    let url: URL

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case name
        case url
    }
}
