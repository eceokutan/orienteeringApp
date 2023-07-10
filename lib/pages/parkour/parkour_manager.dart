import 'package:check_point/models/leaderboard_item.dart';
import 'package:check_point/pages/parkour/parkour_service.dart';

class ParkourManager {
  ParkourManager._private();

  static final ParkourManager _instance = ParkourManager._private();

  factory ParkourManager() {
    return _instance;
  }

  Future<void> getAndSetParkourLeaderBoard(
      String parkourId, LeaderboardItem newItem) async {

    var myParkour = await ParkourService().getParkour(parkourId);

    var myLeaderBoard = myParkour.leaderBoard;
    //yukarısı get leaderboard
    myLeaderBoard.add(newItem);

    myParkour.leaderBoard = sortLeaderBoardListByTimeTaken(myLeaderBoard);
    
    await ParkourService().updateParkour(parkourId, myParkour);
  }

  List<LeaderboardItem> sortLeaderBoardListByTimeTaken(
      List<LeaderboardItem> leaderBoard) {
    leaderBoard.sort((a, b) => a.timeTaken.compareTo(b.timeTaken));
    return leaderBoard;
  }
}
