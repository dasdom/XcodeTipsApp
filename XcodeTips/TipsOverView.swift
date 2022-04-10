//  Created by Dominik Hauser on 09.04.22.
//  
//

import SwiftUI

struct TipsOverView: View {

  let tips: [Tip]

  var body: some View {

    NavigationView {
      List(tips) { tip in
        NavigationLink(destination: {
          TipView(tip: tip)
        }) {
          Text(tip.title)
        }
      }
    }
  }
}

struct TipsOverView_Previews: PreviewProvider {
    static var previews: some View {
        TipsOverView(tips: [
          Tip(title: "Move Focus", steps: [
            Step(image: "move_focus_01", keys: [])
          ]),
          Tip(title: "Move Line Up/Down", steps: [])
        ])
    }
}
