//  Created by Dominik Hauser on 08.04.22.
//  
//

import SwiftUI

@main
struct XcodeTipsApp: App {
    var body: some Scene {
        WindowGroup {
          TipsOverView(tips: tips())
            .frame(minWidth: 600)
        }
    }

  func tips() -> [Tip] {
    do {
      let url = Bundle.main.url(forResource: "tips", withExtension: "json")!
      let data = try Data(contentsOf: url)
      return try JSONDecoder().decode([Tip].self, from: data)
    } catch {
      print("error: \(error)")
      return []
    }
  }
}
