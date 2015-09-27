//
//  Utilities.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 27-09-15.
//  Copyright © 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation

/* Meaning of the keywords
Attributions (author, authors, copyright, date) create a documentation trail for authorship.
Availability (since, version) specifies when material was added to the code or updated, enabling you to lock down both release conformance and real-world time.
Admonitions (attention, important, note, remark, warning) caution about use. These establish design rationales and point out limitations and hazards.
Development State (bug, TODO, experiment) express progress of ongoing development, marking out areas needing future inspection and refinement.
Implementation qualities (complexity) express a code’s time and space complexity.
Functional Semantics (precondition, postcondition, requires, invariant) detail predicates about argument values before and after calls. Preconditions and requirements limit the values and conditions under which the code should be accessed. Postconditions specify observable results that are true after execution.
Cross Reference (see) enables you to point out related material to add background to the documented implementation.
*/

/// This is a quick guide to how to document a function/class in Swift 2 with Xcode7
/// # Markdown is supported
/// Use **common** *markdown* `elements`
/// 
/// See [here](http://ericasadun.com/2015/06/14/swift-header-documentation-in-xcode-7/) for more details.
///
/// - Use the "-" symbol for this
///
/// Xcode recognices a lot of keywords:
/// - Attention: an attention
/// - Author: an author
/// - Authors: more than one author
/// - Bug: a bug
/// - Complexity: 0(1)
/// - Copyright: © 2015 Nicolás Gebauer
/// - Date: 27/09/2015
/// - Experiment: an experiment
/// - Important: important stuff
/// - Invariant: invariant stuff
/// - Note: a note
/// - Postcondition: a postcondition
/// - Precondition: a precondition
/// - Remark: a remark
/// - Requires: something required
/// - See: related material
/// - SeeAlso: more related material
/// - Since: 27/09/2015
/// - TODO: something to be donde
/// - Version: 1.0
/// - Warning: carefull!
///
/// You can display an image from a local file, with an absolute path (doesn't work)
/// ![sub](/Users/Nico/Documents/Xcode/EjemploCoreData/EjemploCoreData/Images.xcassets/MecolabImage.imageset/MecolabImage.png "sub")
///
/// And from an external URL
/// ![foo](http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_3000,q_90,w_1200/v1/209620/5MP-Gumstix-camera-with-PALO_px4md6.png "foo")
///
///
///  There are also more important ones
/// - Returns: Specify return type
/// - Parameter declareParameter: and give a definition
/// - Parameter term2: definition2
/// - Throws: Error.failure: Explain error
/// - Throws: Error.cranky: You can't put more than one error as of now
///
///
///     writingCode() {
///         use 4 spaces, leaving an empty (or 2 in this case) line(s) before
///     }
///
/// ```swift
/// writingCode() {
///     or use ```swift, only at the end of the comments
/// }
/// or this shows up
func howToDocumentFunctions() {
    
}

/**
Also, this is supported, so writing is more fluid
    
    writingCode() {
        something()
    }
*/
func howToDocumentFunctions2() {
    
}