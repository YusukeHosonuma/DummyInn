//
//  GenerateSize.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import Defaults

struct GenerateSize: Hashable, Identifiable, Codable, Defaults.Serializable {
    var id: GenerateSize { self }

    var width: Int
    var height: Int
}
