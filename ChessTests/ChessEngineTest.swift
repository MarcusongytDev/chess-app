//
//  ChessEngineTest.swift
//  ChessTests
//
//  Created by Marcus Ong on 1/3/22.
//

import XCTest
@testable import Chess

class ChessEngineTest: XCTestCase {
    
    func testPrintingEmptyGameBoard() {
        var game = ChessEngine()
        game.initializeGame()
        print(game)
    }
    
    func testPieceNotAllowedToGoOutOfBoard() {
        var game = ChessEngine()
        game.initializeGame()
        print(game)
        XCTAssertFalse(game.canPieceMove(fromCol: 0, fromRow: 7, toCol: -1, toRow: 7, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 0, fromRow: 7, toCol: 8, toRow: 7, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 0, fromRow: 7, toCol: 0, toRow: 8, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 0, fromRow: 7, toCol: 0, toRow: -1, isWhite: true))
    }
    
    func testAvoidCapturingOwnPieces() {
        var game = ChessEngine()
        game.initializeGame()
        XCTAssertFalse(game.canPieceMove(fromCol: 0, fromRow: 7, toCol: 0, toRow: 6, isWhite: true))
    }
    
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
    
    func testQueenRules() {
        var game = ChessEngine()
        
        /*
         0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . . . .
        5 . . . . x . . .
        6 . . . . . . . .
        7 . . . q . . . .
         */
        game.pieces.insert(ChessPiece(col: 3, row: 7, imageName: "", isWhite: true, rank: .queen))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 7, toCol: 4, toRow: 5, isWhite: true))
        
        /*
         0 1 2 3 4 5 6 7
        0 x . . . . . x .
        1 . p . . . . . .
        2 . . . . p . . .
        3 . . . q . . . .
        4 . . . . . . . .
        5 . n . . . . . .
        6 x . . . . . n .
        7 . . . . . . . x
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 3, row: 3, imageName: "", isWhite: true, rank: .queen))
        game.pieces.insert(ChessPiece(col: 1, row: 1, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 4, row: 2, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 6, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 1, row: 5, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 0, toRow: 0, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 6, toRow: 0, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 7, toRow: 7, isWhite: true))
        XCTAssertFalse(game.canPieceMove(fromCol: 3, fromRow: 3, toCol: 0, toRow: 6, isWhite: true))
    }
    
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
    /* 0 1 2 3 4 5 6 7
     0 R N B Q K B N R
     1 P P P P P P P P
     2 . . . . . . . .
     3 . . . . . . . .
     4 . . . . p P . .
     5 . . . . . . . .
     6 p p p p k p p p
     7 r n b q . b n r
     */
        var game = ChessEngine()
        game.initializeGame()
        game.movePiece(fromCol: 4, fromRow: 6, toCol: 4, toRow: 4)
        game.movePiece(fromCol: 5, fromRow: 1, toCol: 5, toRow: 3)
        game.movePiece(fromCol: 4, fromRow: 7, toCol: 4, toRow: 6)
        game.movePiece(fromCol: 5, fromRow: 3, toCol: 5, toRow: 4)
        XCTAssertFalse(game.canPieceMove(fromCol: 4, fromRow: 6, toCol: 4, toRow: 5, isWhite: true))
        XCTAssertTrue(game.canPieceMove(fromCol: 4, fromRow: 6, toCol: 5, toRow: 5, isWhite: true))
    }
    
    
    
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
    
    func testThreat() {
      /*  0 1 2 3 4 5 6 7
       0 R N B Q K B N R
       1 P P P . P P P P
       2 . . . P . . . .
       3 . . . . . p . .
       4 . . . . . . . .
       5 . . . . . . . .
       6 p p p p p . p p
       7 r n b q k b n r
       */
        var game = ChessEngine()
        game.initializeGame()
        game.movePiece(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4)
        game.movePiece(fromCol: 3, fromRow: 1, toCol: 3, toRow: 2)
        game.movePiece(fromCol: 5, fromRow: 4, toCol: 5, toRow: 3)
        
        XCTAssertTrue(game.underThreatAt(col: 5, row: 3, whiteEnemy: false))
        
        /*  0 1 2 3 4 5 6 7
         0 R . B Q K B N R
         1 P P P P P P P P
         2 N . . . . . . .
         3 . . . . . p . .
         4 . . . . . . . .
         5 . . . . . . . .
         6 p p p p p . p p
         7 r n b q k b n r
         */
          game = ChessEngine()
          game.initializeGame()
          game.movePiece(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4)
          game.movePiece(fromCol: 1, fromRow: 0, toCol: 0, toRow: 2)
          game.movePiece(fromCol: 5, fromRow: 4, toCol: 5, toRow: 3)
          
        XCTAssertFalse(game.underThreatAt(col: 5, row: 3, whiteEnemy: false))
    }
    
}
