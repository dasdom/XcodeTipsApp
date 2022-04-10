//  Created by Dominik Hauser on 08.04.22.
//  
//

import Foundation

struct Tip: Codable, Identifiable {
  let title: String
  let steps: [Step]

  var id: String {
    return title
  }
}
