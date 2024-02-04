//
//  ChessPiece.swift
//  Chess
//
//  Created by Marcus Ong on 9/2/22.
//

import Foundation

//create set(hashed) data structure
struct ChessPiece: Hashable {
    let col: Int
    let row: Int
    let imageName: String
    let isWhite: Bool
    let rank: ChessRank
    
}
