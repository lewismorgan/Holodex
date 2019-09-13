//
//  PersonCellView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 9/13/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import SwiftUI

struct PersonCellView: View {
  let model: PersonCellModel
  var body: some View {
    Text(model.name)
      .foregroundColor(.yellow)
  }
}

struct PersonCellView_Previews: PreviewProvider {
  static var previews: some View {
    PersonCellView(model: PersonCellModel(name: "Luke Skywalker"))
      .colorScheme(.dark)
      .previewLayout(.sizeThatFits)
  }
}
