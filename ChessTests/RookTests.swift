//
//  RookTests.swift
//  ChessTests
//
//  Created by Marcus Ong on 14/3/22.
//

@testable import Chess
import XCTest

class Rooktests: XCTest {
    func testRookRules() {
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . . . .
        5 o . . . . . . .
        6 . x . . . . . .
        7 r . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 0, row: 7, imageName: "", isWhite: true, rank: .rook))
        XCTAssertFalse(game.canPieceMove(fromCol: 0, fromRow: 7, toCol: 1, toRow: 6, isWhite: true))
        XCTAssertTrue(game.canPieceMove(fromCol: 0, fromRow: 7, toCol: 0, toRow: 5, isWhite: true))
    }
}
