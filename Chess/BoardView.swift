//
//  BoardView.swift
//  Chess
//
//  Created by Marcus Ong on 9/2/22.
//

import UIKit

class BoardView: UIView {
    
    //CGFloat=computergraphicsfloat CGRect=computergraphicsrectangle
    let ratio: CGFloat = 1.0
    //variables to be determined later
    var originX: CGFloat = -10
    var originY: CGFloat = -10
    var cellSide: CGFloat = -10
    
    var shadowPieces: Set<ChessPiece> = Set<ChessPiece>()
    
    var ChessDelegate: ChessDelegate? = nil
    
    //brings touchesBegan func output out to global to bypass override func touchesEnded
    var fromCol:Int? = nil
    var fromRow:Int? = nil
    
    var movingImage: UIImage? = nil
    var movingPieceX: CGFloat = -1
    var movingPieceY: CGFloat = -1
    
    var blackAtTop = true


    override func draw(_ rect: CGRect) {
        //set board dimensions then draw board
        cellSide = bounds.width * ratio / 8
        originX = bounds.width * (1-ratio)/2
        originY = bounds.height * (1-ratio)/2
        
        drawBoard()
        drawPieces()
    }
    
    //locate finger touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerlocation = first.location(in: self)
        
        fromCol = p2p(Int((fingerlocation.x - originX) / cellSide))
        fromRow = p2p(Int((fingerlocation.y - originY) / cellSide))
        
        //if let block code occurs if movingPiece var is not nil
        //if let ensures optional variable to pass in code is not nil
        if let fromCol = fromCol, let fromRow = fromRow, let movingPiece = ChessDelegate?.pieceAt(col: fromCol, row: fromRow) {
            movingImage = UIImage(named: movingPiece.imageName)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerlocation = first.location(in: self)
        movingPieceX = fingerlocation.x
        movingPieceY = fingerlocation.y
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerlocation = first.location(in: self)
        
        let toCol: Int = p2p(Int((fingerlocation.x - originX) / cellSide))
        let toRow: Int = p2p(Int((fingerlocation.y - originY) / cellSide))
        
        if let fromCol = fromCol, let fromRow = fromRow, fromCol != toCol || fromRow != toRow {
            ChessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
            
        }
        movingImage = nil
        fromCol = nil
        fromRow = nil
        setNeedsDisplay() 

    }
    
    func drawPieces() {
        for piece in shadowPieces where fromCol != piece.col || fromRow != piece.row {
            //renders original image only if image at origin(ie. not being moved)
            let pieceImage = UIImage(named: piece.imageName)

            pieceImage?.draw(in: CGRect(x: originX + CGFloat(p2p(piece.col)) * cellSide, y: originY + CGFloat(p2p(piece.row)) * cellSide, width: cellSide, height: cellSide))
            
        }
        movingImage?.draw(in: CGRect(x: movingPieceX - cellSide/2, y: movingPieceY - cellSide/2, width: cellSide, height: cellSide))
    }
    
    
    func drawBoard() {
        //loops to draw the squares on the board
        for row in 0..<4 {
            for col in 0..<4 {
                drawSquare(col: col*2, row: row*2, color: UIColor.white)
                drawSquare(col: 1+col*2, row: row*2, color: UIColor.lightGray)
                drawSquare(col: 1+col*2, row: 1+row*2, color: UIColor.white)
                drawSquare(col: col*2, row: 1+row*2, color: UIColor.lightGray)
            }
        }
    }
    
    func drawSquare(col: Int, row: Int, color: UIColor) {
        //UIBezierPath to draw rectangles
        let path = UIBezierPath(rect: CGRect(x: originX + CGFloat(col) * cellSide, y: originY + CGFloat(row) * cellSide , width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
        
        
    }

    func p2p(_ coordinate: Int) -> Int {
        //peer2peer swithing off board side
        // if blackAtTop is true, return coordinate, if not, return 7 - coordinate
        return blackAtTop ? coordinate:  7 - coordinate
        
    }
    
}
