//
//  PawnTests.swift
//  ChessTests
//
//  Created by Marcus Ong on 14/3/22.
//

import XCTest
@testable import Chess

class PawnTests: XCTest {
    
    func testWhitePawnRules() {
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . o . .
        5 . . . . x o x .
        6 . . . . x p x .
        7 . . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 6, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 6, toCol: 6, toRow: 5, isWhite: true))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 6, toCol: 5, toRow: 5, isWhite: true))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4, isWhite: true))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . x . .
        5 . . . . . N . .
        6 . . . . . p . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 5, row: 5, imageName: "", isWhite: false, rank: .knight))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 6, toCol: 5, toRow: 5, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4, isWhite: true))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . N . .
        5 . . . . . x . .
        6 . . . . . p . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: false, rank: .knight))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 6, toCol: 5, toRow: 5, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4, isWhite: true))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . x o x .
        4 . . . . x p x .
        5 . . . . x x x .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 5, toRow: 3, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 5, toRow: 5, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 4, toRow: 3, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 4, toRow: 4, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 4, toRow: 5, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 5, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 4, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 3, isWhite: true))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . N . .
        4 . . . . . p . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 5, row: 3, imageName: "", isWhite: false, rank: .knight))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 5, toRow: 3, isWhite: true))
        
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . x . .
        3 . . . . . . . .
        4 . . . . . p . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 5, toRow: 2, isWhite: true))
        
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . N . N .
        4 . . . . . p . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 4, row: 3, imageName: "", isWhite: false, rank: .knight))
        game.pieces.insert(ChessPiece(col: 6, row: 3, imageName: "", isWhite: false, rank: .knight))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 4, toRow: 3, isWhite: true))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 3, isWhite: true))
    }
    func testBlackPawnRules() {
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . P . .
        2 . . . . . o x .
        3 . . . . . o . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        var game = ChessEngine()
        game.whitesTurn = false
        game.pieces.insert(ChessPiece(col: 5, row: 1, imageName: "", isWhite: false, rank: .pawn))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 1, toCol: 5, toRow: 2, isWhite: false))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 1, toCol: 5, toRow: 3, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 1, toCol: 6, toRow: 2, isWhite: false))
        
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . P . .
        2 . . . . . n . .
        3 . . . . . x . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.whitesTurn = false
        game.pieces.insert(ChessPiece(col: 5, row: 1, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 5, row: 2, imageName: "", isWhite: true, rank: .knight))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 1, toCol: 5, toRow: 2, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 1, toCol: 5, toRow: 3, isWhite: false))
        
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . P . .
        2 . . . . . o . .
        3 . . . . . n . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.whitesTurn = false
        game.pieces.insert(ChessPiece(col: 5, row: 1, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 5, row: 3, imageName: "", isWhite: true, rank: .knight))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 1, toCol: 5, toRow: 2, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 1, toCol: 5, toRow: 3, isWhite: false))
        
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . x x x .
        4 . . . . x P x .
        5 . . . . x o x .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.whitesTurn = false
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: false, rank: .pawn))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 5, toRow: 5, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 4, toRow: 3, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 4, toRow: 4, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 4, toRow: 5, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 5, toRow: 3, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 5, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 4, isWhite: false))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 3, isWhite: false))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . P . .
        4 . . . . . n . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.whitesTurn = false
        game.pieces.insert(ChessPiece(col: 5, row: 3, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: true, rank: .knight))
        XCTAssertFalse(game.canPieceMove(fromCol: 5, fromRow: 3, toCol: 5, toRow: 4, isWhite: false))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . P . .
        3 . . . . n . n .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.whitesTurn = false
        game.pieces.insert(ChessPiece(col: 5, row: 2, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 6, row: 3, imageName: "", isWhite: true, rank: .knight))
        game.pieces.insert(ChessPiece(col: 4, row: 3, imageName: "", isWhite: true, rank: .knight))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 2, toCol: 4, toRow: 3, isWhite: false))
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 2, toCol: 6, toRow: 3, isWhite: false))
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . P . . . . .
        2 . p . p . . . .
        3 . . . . . . . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        game = ChessEngine()
        game.whitesTurn = false
        game.pieces.insert(ChessPiece(col: 2, row: 1, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 3, row: 2, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 1, row: 2, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertTrue(game.canPieceMove(fromCol: 2, fromRow: 1, toCol: 3, toRow: 2, isWhite: false))
        XCTAssertTrue(game.canPieceMove(fromCol: 2, fromRow: 1, toCol: 1, toRow: 2, isWhite: false))
    }
    
    func testWhitePawnEnPassant() {
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . o . . .
        3 . . . . P p . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 3, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 4, row: 3, imageName: "", isWhite: false, rank: .pawn))
        game.lastMove = ChessMove(fromCol: 4, fromRow: 1, toCol: 4, toRow: 3)
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 3, toCol: 4, toRow: 2, isWhite: true))
        
        XCTAssertNotNil(game.pieceAt(col: 4, row: 3))
        game.movePiece(fromCol: 5, fromRow: 3, toCol: 4, toRow: 2)
        XCTAssertNil(game.pieceAt(col: 4, row: 3))
        XCTAssertNotNil(game.pieceAt(col: 4, row: 2))
        
        //bug testing
        game = ChessEngine()
        game.initializeGame()
        game.movePiece(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4)
        game.movePiece(fromCol: 1, fromRow: 0, toCol: 0, toRow: 2)
        game.movePiece(fromCol: 5, fromRow: 4, toCol: 5, toRow: 3)
        game.movePiece(fromCol: 4, fromRow: 1, toCol: 4, toRow: 3)
        
        XCTAssertNotNil(game.pieceAt(col: 0, row: 2))
        XCTAssertNotNil(game.pieceAt(col: 5, row: 3))
        
    }
    
    func testBlackPawnEnPassant() {
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . P p .
        5 . . . . . . o .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 4, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 6, row: 4, imageName: "", isWhite: true, rank: .pawn))
        game.lastMove = ChessMove(fromCol: 6, fromRow: 6, toCol: 6, toRow: 4)
        game.whitesTurn = false
        XCTAssertTrue(game.canPieceMove(fromCol: 5, fromRow: 4, toCol: 6, toRow: 5, isWhite: false))
        
        XCTAssertNotNil(game.pieceAt(col: 6, row: 4))
        game.movePiece(fromCol: 5, fromRow: 4, toCol: 6, toRow: 5)
        XCTAssertNil(game.pieceAt(col: 6, row: 4))
        XCTAssertNotNil(game.pieceAt(col: 6, row: 5))
        
    }

}
