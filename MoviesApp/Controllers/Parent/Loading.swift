//  Loading.swift
//  MoviesApp
//  Created by Doston Rustamov on 06/03/22.

import Foundation
import UIKit

protocol LoadingDelegate: AnyObject {
    var loadingIcon: UIActivityIndicatorView! { get set }
}
