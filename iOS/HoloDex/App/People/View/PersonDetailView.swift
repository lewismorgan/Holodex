//
//  PeopleDetailView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/11/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation
import People
import UIKit

class PersonDetailView: UIView {
  var person: Person
  var root = UIView()

  var name = UILabel()
  var height = UILabel()
  var mass = UILabel()
  var hairColor = UILabel()
  var skinColor = UILabel()
  var eyeColor = UILabel()
  var birthYear = UILabel()
  var gender = UILabel()
  var homeworld = UILabel()

  init(person: Person) {
    self.person = person
    super.init(frame: .zero)
    setup()
    style()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) not implemented")
  }

  func setup() {
    layoutFlexContent(root)
    addSubview(root)
  }

  func style() {
    backgroundColor = .white
  }

  func layoutFlexContent(_ flexContainer: UIView) {
    let padding: CGFloat = 5.0

    debugPrint("Laying out flex content")

    flexContainer.flex.alignContent(.center).justifyContent(.center).padding(padding).define { (flex) in
      flex.addItem().direction(.row).backgroundColor(.green).paddingBottom(padding).define { (flex) in
        flex.addItem(name)
      }
      flex.addItem(gender).direction(.row).paddingBottom(padding).backgroundColor(.brown)
      flex.addItem(birthYear).direction(.row).paddingBottom(padding).backgroundColor(.yellow)
      flex.addItem(skinColor).direction(.row).paddingBottom(padding).backgroundColor(.magenta)

      flex.addItem().direction(.row).backgroundColor(.gray).padding(padding).define { (flex) in
        flex.addItem(height)
        flex.addItem(mass)
      }

      flex.addItem().direction(.row).backgroundColor(.orange).padding(padding).define { (flex) in
        flex.addItem(hairColor)
        flex.addItem(eyeColor)
      }

      flex.addItem(homeworld).direction(.row).backgroundColor(UIColor.cyan)
    }

  }

  override func layoutSubviews() {
    root.pin.all(pin.safeArea)
    root.flex.layout()
  }

}

extension PersonDetailView {
  func updatePerson(person: Person) {
    if let pName = person.name {
      name.text = "Name: \(pName)"
      name.flex.markDirty()
    }
    if let pHeight = person.height {
      height.text = "Height: \(pHeight)"
      height.flex.markDirty()
    }
    if let pMass = person.mass {
      mass.text = "Mass: \(pMass)"
      mass.flex.markDirty()
    }
    if let pHairColor = person.hairColor {
      hairColor.text = "Hair Color: \(pHairColor)"
      hairColor.flex.markDirty()
    }
    if let pSkinColor = person.skinColor {
      skinColor.text = "Skin Color: \(pSkinColor)"
      skinColor.flex.markDirty()
    }
    if let pEyeColor = person.eyeColor {
      eyeColor.text = "Eye Color: \(pEyeColor)"
      eyeColor.flex.markDirty()
    }
    if let pBirthYear = person.birthYear {
      birthYear.text = "Birth Year: \(pBirthYear)"
      birthYear.flex.markDirty()
    }
    if let pGender = person.gender {
      gender.text = "Gender: \(pGender)"
      gender.flex.markDirty()
    }
    if let pHomeworld = person.homeworld {
      homeworld.text = "Homeworld: \(pHomeworld)"
      homeworld.flex.markDirty()
    }
    // refresh the view since text was changed
    layoutSubviews()
  }
}
