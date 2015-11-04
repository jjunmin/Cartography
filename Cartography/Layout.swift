//
//  Layout.swift
//  Cartography
//
//  Created by Robert Böhnke on 30/09/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

import Foundation

/// Layouts a single view.
///
/// The views will have its layout updated after this call.
///
/// - parameter view:    The view to layout.
/// - parameter replace: The `ConstraintGroup` whose constraints should be replaced.
/// - parameter block:   A block that declares the layout for `view`.
///
public func layout(view: View, replace group: ConstraintGroup = ConstraintGroup(), block: LayoutProxy -> ()) -> ConstraintGroup {
    let context = Context()
    block(LayoutProxy(context, view))
    group.replaceConstraints(context.constraints)

    return group
}

/// Layouts two views.
///
/// The views will have their layout updated after this call.
///
/// - parameter view1:   A view to layout.
/// - parameter view2:   A view to layout.
/// - parameter replace: The `ConstraintGroup` whose constraints should be replaced.
/// - parameter block:   A block that declares the layout for the views.
///
public func layout(view1: View, view2: View, replace group: ConstraintGroup = ConstraintGroup(), block: (LayoutProxy, LayoutProxy) -> ()) -> ConstraintGroup {
    let context = Context()
    block(LayoutProxy(context, view1), LayoutProxy(context, view2))
    group.replaceConstraints(context.constraints)

    return group
}

/// Layouts three views.
///
/// The views will have their layout updated after this call.
///
/// - parameter view1:   A view to layout.
/// - parameter view2:   A view to layout.
/// - parameter view3:   A view to layout.
/// - parameter replace: The `ConstraintGroup` whose constraints should be replaced.
/// - parameter block:   A block that declares the layout for the views.
///
public func layout(view1: View, view2: View, view3: View, replace group: ConstraintGroup = ConstraintGroup(), block: (LayoutProxy, LayoutProxy, LayoutProxy) -> ()) -> ConstraintGroup {
    let context = Context()
    block(LayoutProxy(context, view1), LayoutProxy(context, view2), LayoutProxy(context, view3))
    group.replaceConstraints(context.constraints)

    return group
}

/// Layouts an array of views.
///
/// The views will have their layout updated after this call.
///
/// - parameter views:   The views to layout.
/// - parameter replace: The `ConstraintGroup` whose constraints should be replaced.
/// - parameter block:   A block that declares the layout for `views`.
///
public func layout(views: [View], replace group: ConstraintGroup = ConstraintGroup(), block: ([LayoutProxy]) -> ()) -> ConstraintGroup {
    let context = Context()
    block(views.map({ LayoutProxy(context, $0) }))
    group.replaceConstraints(context.constraints)

    return group
}

/// Layouts a dictioary of views.
///
/// The views will have their layout updated after this call.
///
/// - parameter views:   The views to layout.
/// - parameter replace: The `ConstraintGroup` whose constraints should be replaced.
/// - parameter block:   A block that declares the layout for `views`.
///
public func layout<T: Hashable>(views: [T: View], replace group: ConstraintGroup = ConstraintGroup(), block: ([T : LayoutProxy] -> ())) -> ConstraintGroup {
    let context = Context()
    let proxies = views.map { ($0, LayoutProxy(context, $1)) }
    block(Dictionary(proxies))
    group.replaceConstraints(context.constraints)

    return group
}

/// Removes all constraints for a group.
///
/// The affected views will have their layout updated after this call.
///
/// - parameter clear: The `ConstraintGroup` whose constraints should be removed.
///
public func layout(clear group: ConstraintGroup) {
    let context = Context()
    group.replaceConstraints(context.constraints)
}
