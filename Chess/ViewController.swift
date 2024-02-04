//
//  ViewController.swift
//  Chess
//
//  Created by Marcus Ong on 9/2/22.
//

import UIKit
import AVFoundation
import MultipeerConnectivity
//all MC methods and variables are used for mc connectivity

//provide ChessDelegate service
class ViewController: UIViewController {
    
    
    var chessEngine: ChessEngine = ChessEngine()
    
    @IBOutlet weak var boardView: BoardView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    
    var audioPlayer: AVAudioPlayer!
    
    var peerID: MCPeerID!
    var session: MCSession!
    var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    
    var rankPromotedTo: String = "queen"
    var isWhiteDevice: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        let url = Bundle.main.url(forResource: "move", withExtension: "wav")!
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        
        //instance of viewcontroller class created in chessdelegate protocol
        boardView.ChessDelegate = self
        
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        
    }
    
    @IBAction func advertise(_ sender: Any) {
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "gt-chess")
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceAdvertiser.startAdvertisingPeer()
        
        boardView.blackAtTop = false
        isWhiteDevice = false
        boardView.setNeedsDisplay()
    }
    

    @IBAction func join(_ sender: Any) {
        let browser = MCBrowserViewController(serviceType: "gt-chess", session: session)
        browser.delegate = self
        present(browser, animated: true)
    }
    
    @IBAction func reset(_ sender: Any) {
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.blackAtTop = true
        boardView.setNeedsDisplay()
        infoLabel.text = "White"
    }
    
    func updateMove(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        guard chessEngine.canPieceMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow, isWhite: chessEngine.whitesTurn) else {
            return
        }
        chessEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPieces = chessEngine.pieces
        //setNeedsDisplay redraws board
        boardView.setNeedsDisplay()
        
        audioPlayer.play()
        
        if chessEngine.whitesTurn {
            infoLabel.text = "White"
        } else {
            infoLabel.text = "Black"
        }
    }
    
    func sendLastMove() {
        let promotionPostFix = chessEngine.needsPromotion() ? ":\(rankPromotedTo)" : ""
        if let lastMove = chessEngine.lastMove {
            let move = "\(lastMove.fromCol):\(lastMove.fromRow):\(lastMove.toCol):\(lastMove.toRow):\(promotionPostFix)"
            if let data = move.data(using: .utf8) {
                try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
            }
        }
    }
    
    func promptPromotionOptions() {
        if chessEngine.needsPromotion() {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let queenAction = UIAlertAction(title: "Queen", style: .default) { _ in
                self.chessEngine.promoteTo(rank: .queen)
                self.boardView.shadowPieces = self.chessEngine.pieces
                self.boardView.setNeedsDisplay()
                self.rankPromotedTo = "q"
                
                self.sendLastMove()
            }
            alertController.addAction(queenAction)
            
            let knightAction = UIAlertAction(title: "Knight", style: .default) { _ in
                self.chessEngine.promoteTo(rank: .knight)
                self.boardView.shadowPieces = self.chessEngine.pieces
                self.boardView.setNeedsDisplay()
                self.rankPromotedTo = "n"
                
                self.sendLastMove()
            }
            alertController.addAction(knightAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

//handles event of recieving invitation from peer
extension ViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
    
    
}

//acknowledge and dismiss interaction
extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    
}

extension ViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("connected: \(peerID.displayName)")
        case .connecting:
            print("connecting: \(peerID.displayName)")
        case .notConnected:
            print("not connected: \(peerID.displayName)")
        @unknown default:
            fatalError()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("recieved data: \(data)")
        if let move = String(data: data, encoding: .utf8) {
            let moveArr = move.components(separatedBy: ":")
            if let fromCol = Int(moveArr[0]), let fromRow = Int(moveArr[1]), let toCol = Int(moveArr[2]), let toRow = Int(moveArr[3]) {
                DispatchQueue.main.async {
                    self.updateMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
                    if moveArr.count == 5 {
                        let rankPromotedTo = moveArr[4]
                        switch rankPromotedTo {
                        case "q":
                            self.chessEngine.promoteTo(rank: .queen)
                        case "n":
                            self.chessEngine.promoteTo(rank: .knight)
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}

extension ViewController: ChessDelegate {
    
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        
        if let movingPiece = chessEngine.pieceAt(col: fromCol, row: fromRow) {
            if movingPiece.isWhite != chessEngine.whitesTurn {
                return
            }
        }
        
        if session.connectedPeers.count > 0 && isWhiteDevice != chessEngine.whitesTurn {
            return
        }
        
        updateMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        
        if chessEngine.needsPromotion() {
            promptPromotionOptions()
        }
        else {
            sendLastMove()
        }
    
    }

    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(col: col, row: row)
    }
}
