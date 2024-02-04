//
//  BishopTests.swift
//  ChessTests
//
//  Created by Marcus Ong on 14/3/22.
//

@testable import Chess
import XCTest

class RookTests: XCTest {
    func testBishopRules() {
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 2, row: 7, imageName: "", isWhite: true, rank: .bishop))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . . . .
        5 . . . x . . . .
        6 . . . . . . . .
        7 . . b . . . . .
         */
        XCTAssertFalse(game.canPieceMove(fromCol: 2, fromRow: 7, toCol: 3, toRow: 5, isWhite: true))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . . . .
        5 . . . . x . . .
        6 . . . p . . . .
        7 . . b . . . . .
         */
        game.pieces.insert(ChessPiece(col: 3, row: 6, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertFalse(game.canPieceMove(fromCol: 2, fromRow: 7, toCol: 4, toRow: 5, isWhite: true))
        
        game.pieces.insert(ChessPiece(col: 3, row: 3, imageName: "", isWhite: true, rank: .bishop))
        /*
         0 1 2 3 4 5 6 7
        0 x . . . . . x .
        1 . p . . . . . .
        2 . . . . p . . .
        3 . . . b . . . .
        4 . . . . . . . .
        5 . n . . . . . .
        6 x . . . . . n .
        7 . . . . . . . x
         */
        game.pieces.insert(ChessPiece(col: 1, row: 1, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 4, row: 2, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 6, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 1, row: 5, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 0, toRow: 0, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 6, toRow: 0, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 7, toRow: 7, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 0, toRow: 6, isWhite: true))
    }
}
