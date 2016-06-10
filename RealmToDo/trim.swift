//
//  trim.swift
//  RealmToDo
//
//  Created by Soto Yanis on 08/06/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit

extension String
{
    func trim() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}