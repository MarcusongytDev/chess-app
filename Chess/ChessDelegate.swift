//
//  ChessDelegate.swift
//  Chess
//
//  Created by Marcus Ong on 16/2/22.
//

import Foundation

protocol ChessDelegate {
    func movePiece(fromCol:Int, fromRow:Int, toCol:Int, toRow:Int)
    
    //returns chesspiece at location
    func pieceAt(col: Int, row: Int) -> ChessPiece?
}
    
