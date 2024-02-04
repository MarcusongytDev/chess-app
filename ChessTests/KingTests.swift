//
//  KingTests.swift
//  ChessTests
//
//  Created by Marcus Ong on 14/3/22.
//

import XCTest
@testable import Chess

class KingTests: XCTest {
    
    func testKingRules() {
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . x . .
        2 . . . . . . . .
        3 . . . k o x . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 3, row: 3, imageName: "", isWhite: true, rank: .king))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 3, toRow: 3, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 5, toRow: 3, isWhite: true))
        XCTAssertTrue(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 4, toRow: 3, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 4, toRow: 1, isWhite: true))
        
    }
    
    func testWhiteKingSideCanCastle() {
        /*  0 1 2 3 4 5 6 7
         0 R N B Q K B N R
         1 . . P P P P P P
         2 P P . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . p . . n
         6 p p p p b p p p
         7 r n b q k . . r
         */
        var game = ChessEngine()
        game.initializeGame()
        game.movePiece(fromCol: 4, fromRow: 6, toCol: 4, toRow: 5)
        game.movePiece(fromCol: 0, fromRow: 1, toCol: 0, toRow: 2)
        game.movePiece(fromCol: 5, fromRow: 7, toCol: 4, toRow: 6)
        game.movePiece(fromCol: 1, fromRow: 1, toCol: 1, toRow: 2)
        game.movePiece(fromCol: 6, fromRow: 7, toCol: 7, toRow: 5)
        game.movePiece(fromCol: 2, fromRow: 1, toCol: 2, toRow: 2)
        XCTAssertNotNil(game.pieceAt(col: 7, row: 7))
        XCTAssertNil(game.pieceAt(col: 6, row: 7))
        XCTAssertNil(game.pieceAt(col: 5, row: 7))
        
        XCTAssertTrue(game.canCastle(toCol: 6, toRow: 7))
        
        /*  0 1 2 3 4 5 6 7
         0 R N B Q K B N R
         1 . . P P P P P P
         2 P P . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . p . . n
         6 p p p p b p p p
         7 r n b q . r k .
         */
        game.movePiece(fromCol: 4, fromRow: 7, toCol: 6, toRow: 7)
//        XCTAssertNil(game.pieceAt(col: 7, row: 7))
//        XCTAssertNotNil(game.pieceAt(col: 6, row: 7))
//        XCTAssertNotNil(game.pieceAt(col: 5, row: 7))
    }
    
    func testwhiteQueenSideCastling() {
        /*  0 1 2 3 4 5 6 7
         0 R N B Q K B N R
         1 P P P P P P P P
         2 . . . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . . . . .
         6 p p p p p p p p
         7 r n b q k b n r
         */
        var game = ChessEngine()
        game.initializeGame()
        game.movePiece(fromCol: 2, fromRow: 6, toCol: 2, toRow: 4)
        game.movePiece(fromCol: 0, fromRow: 1, toCol: 0, toRow: 2)
        game.movePiece(fromCol: 3, fromRow: 7, toCol: 1, toRow: 5)
        game.movePiece(fromCol: 1, fromRow: 1, toCol: 1, toRow: 2)
        game.movePiece(fromCol: 1, fromRow: 7, toCol: 0, toRow: 5)
        game.movePiece(fromCol: 2, fromRow: 1, toCol: 2, toRow: 2)
        game.movePiece(fromCol: 3, fromRow: 6, toCol: 3, toRow: 5)
        game.movePiece(fromCol: 3, fromRow: 1, toCol: 3, toRow: 2)
        game.movePiece(fromCol: 2, fromRow: 7, toCol: 3, toRow: 6)
        game.movePiece(fromCol: 4, fromRow: 1, toCol: 4, toRow: 2)
        XCTAssertTrue(game.canCastle(toCol: 2, toRow: 7))
        
        XCTAssertNil(game.pieceAt(col: 1, row: 7))
        XCTAssertNil(game.pieceAt(col: 2, row: 7))
        XCTAssertNil(game.pieceAt(col: 3, row: 7))
        XCTAssertNotNil(game.pieceAt(col: 0, row: 7))
        XCTAssertNotNil(game.pieceAt(col: 4, row: 7))
        game.movePiece(fromCol: 4, fromRow: 7, toCol: 2, toRow: 7)
        XCTAssertNil(game.pieceAt(col: 1, row: 7))
        XCTAssertNotNil(game.pieceAt(col: 2, row: 7))
        XCTAssertNotNil(game.pieceAt(col: 3, row: 7))
        XCTAssertNil(game.pieceAt(col: 0, row: 7))
        XCTAssertNil(game.pieceAt(col: 4, row: 7))
    }
    
    func testWhiteKingSideCastling() {
        /*  0 1 2 3 4 5 6 7
         0 R N B Q K B N R
         1 . . P P P P P P
         2 P P . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . p . . n
         6 p p p p b p p p
         7 r n b q k . . r
         */
        var game = ChessEngine()
        game.initializeGame()
        game.movePiece(fromCol: 4, fromRow: 6, toCol: 4, toRow: 5)
        game.movePiece(fromCol: 0, fromRow: 1, toCol: 0, toRow: 2)
        game.movePiece(fromCol: 5, fromRow: 7, toCol: 4, toRow: 6)
        game.movePiece(fromCol: 1, fromRow: 1, toCol: 1, toRow: 2)
        game.movePiece(fromCol: 6, fromRow: 7, toCol: 7, toRow: 5)
        game.movePiece(fromCol: 2, fromRow: 1, toCol: 2, toRow: 2)
        XCTAssertNotNil(game.pieceAt(col: 7, row: 7))
        XCTAssertNil(game.pieceAt(col: 6, row: 7))
        XCTAssertNil(game.pieceAt(col: 5, row: 7))
        
        XCTAssertTrue(game.canCastle(toCol: 6, toRow: 7))
        
        /*  0 1 2 3 4 5 6 7
         0 R N B Q K B N R
         1 . . P P P P P P
         2 P P . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . p . . n
         6 p p p p b p p p
         7 r n b q . r k .
         */
        game.movePiece(fromCol: 4, fromRow: 7, toCol: 6, toRow: 7)
        XCTAssertNil(game.pieceAt(col: 7, row: 7))
        XCTAssertNotNil(game.pieceAt(col: 6, row: 7))
        XCTAssertNotNil(game.pieceAt(col: 5, row: 7))
    }
    
    func testBlackKingSideCastling() {
        /*  0 1 2 3 4 5 6 7
         0 R N B Q K . . R
         1 P P P P B P P P
         2 . . . . P . . N
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . p p p p
         6 p p p p b p p p
         7 r n b q k b n r
         */
        var game = ChessEngine()
        game.initializeGame()
        game.movePiece(fromCol: 4, fromRow: 6, toCol: 4, toRow: 5)
        game.movePiece(fromCol: 4, fromRow: 1, toCol: 4, toRow: 2)
        game.movePiece(fromCol: 5, fromRow: 6, toCol: 5, toRow: 5)
        game.movePiece(fromCol: 5, fromRow: 0, toCol: 4, toRow: 1)
        game.movePiece(fromCol: 6, fromRow: 6, toCol: 6, toRow: 5)
        game.movePiece(fromCol: 6, fromRow: 0, toCol: 7, toRow: 2)
        game.movePiece(fromCol: 7, fromRow: 6, toCol: 7, toRow: 5)

        XCTAssertTrue(game.canCastle(toCol: 6, toRow: 0))
        
        /*  0 1 2 3 4 5 6 7
         0 R N B Q K B N R
         1 . . P P P P P P
         2 P P . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . p . . n
         6 p p p p b p p p
         7 r n b q . r k .
         */
        game.movePiece(fromCol: 4, fromRow: 0, toCol: 6, toRow: 0)
        XCTAssertNil(game.pieceAt(col: 7, row: 0))
        XCTAssertNotNil(game.pieceAt(col: 6, row: 0))
        XCTAssertNotNil(game.pieceAt(col: 5, row: 0))
    }
    func testKingThreatenedByPawn() {
    /*  0 1 2 3 4 5 6 7
     0 R . B Q K B N R
     1 P P P P P P P P
     2 . . . . . . . .
     3 . . . . . . . .
     4 . . . . p P . .
     5 . . . . . . . .
     6 p p p p k p p p
     7 r n b q . b n r
     */
    }
}
