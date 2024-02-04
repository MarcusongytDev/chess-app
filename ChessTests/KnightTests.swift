//
//  KnightTests.swift
//  ChessTests
//
//  Created by Marcus Ong on 14/3/22.
//

import Foundation
@testable import Chess
import XCTest

class KnightTests: XCTest {
    func testKnightRules() {
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . . . .
        5 . x . . . . . .
        6 . . . . . . . .
        7 . k . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 1, row: 7, imageName: "", isWhite: true, rank: .knight))
        XCTAssertFalse(game.canPieceMove(fromCol: 1, fromRow: 7, toCol: 1, toRow: 5, isWhite: true))
    }
}
