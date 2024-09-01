import SwiftUI

struct LeaderboardView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Player.points, ascending: false)], // Sort by points in descending order
        animation: .default)
    private var players: FetchedResults<Player>
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .padding()

            List {
                ForEach(Array(players.enumerated()), id: \.element) { index, player in
                    HStack {
                        // Rank number with crown icon for #1
                        HStack(spacing: 5) {
                            if index == 0 {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.yellow)
                                    .rotationEffect(.degrees(-15))
                            }
                            Text("#\(index + 1)")
                                .font(.headline)
                                .foregroundColor(rankColor(for: index))
                        }
                        .frame(width: 50, alignment: .leading)

                        // Player name
                        Text(player.name ?? "Unknown Player")
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Player points
                        Text("\(player.points) pts")
                            .font(.body)
                            .frame(width: 70, alignment: .trailing)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding()
    }
    
    // Determine the color based on rank
    private func rankColor(for index: Int) -> Color {
        switch index {
        case 0:
            return .yellow // Gold for 1st place
        case 1:
            return .gray // Silver for 2nd place
        case 2:
            return .orange // Bronze for 3rd place
        default:
            return .primary // Default color for other ranks
        }
    }
}

#Preview {
    LeaderboardView()
}
