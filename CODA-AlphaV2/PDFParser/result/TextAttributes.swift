//
//  TextAttributes.swift
//  PDFParser
//
//  Created by Benjamin Garrigues on 24/07/2018.
//  Copyright © 2018 SimpleApp. All rights reserved.
//

import Foundation
import UIKit

struct TextAtttributes {
    var fontTraits: UIFontDescriptor.SymbolicTraits
    var attributes: [NSAttributedString.Key: Any]

    init(rendering: PDFRenderingState) {
        fontTraits = TextAtttributes.traits(forFont: rendering.font)
        attributes = TextAtttributes.attributes(forRendering: rendering)
    }

    static func traits(forFont font: PDFFont) -> UIFontDescriptor.SymbolicTraits {
        return traits(fromFontName: font.descriptor.fontName)
            .union(traits(fromFontName: font.baseFontName))
        .union(traits(fromFontName: font.descriptor.fontFile?.fontInfos()?.subfamily))
    }

    static func traits(fromFontName name: String? ) -> UIFontDescriptor.SymbolicTraits {
        var res = UIFontDescriptor.SymbolicTraits()
        guard let lowercased = name?.lowercased() else { return res }
        if lowercased.contains("bold") {
            res.insert(.traitBold)
        }
        if lowercased.contains("italic") {
            res.insert(.traitItalic)
        }
        if lowercased.contains("condensed") {
            res.insert(.traitCondensed)
        }
        return res
    }

    static func attributes(forRendering: PDFRenderingState) -> [NSAttributedString.Key:Any] {
        //TODO
        return [:]
    }
}


