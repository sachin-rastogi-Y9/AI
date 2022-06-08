// Finds a way to represent each square on th tic-tac-toe board: X, O, or empty (E)
enum Piece: String {
    case X = "X"
    case O = "O"
    case E = " "
    // Flips from one player’s turn to the other player’s turn after a tic-tac-toe move
    var opposite: Piece {
        switch self {
        case .X:
            return .O
        case .O:
            return .X
        case .E:
            return .E
        }
    }
}
// A move is an integer 0-8 indicating a place to put a piece
typealias Move = Int
struct Board {
    let position: [Piece]
    let turn: Piece
    let lastMove: Move
}
// By default the board is empty and X goes first
// LastMove being -1 is a marker of a start position
init(position: [Piece] = [.E, .E, .E, .E, .E, .E, .E, .E, .E], turn: Piece = .X, lastMove: Int = -1) {
    self.position = position
    self.turn = turn
    self.lastMove = lastMove
}
// Location can be 0-8, indicating where to move, starting with 0 in the top-left and 8 in the bottom-right
// Return a new board with the move played
func move(_ location: Move) -> Board {
    var tempPosition = position
    tempPosition[location] = turn
    return Board(position: tempPosition, turn: turn.opposite, lastMove: location)
}
// The legal moves in a position are all of the empty squares
var legalMoves: [Move] {
    return position.indices.filter { position[$0] == .E }
}
// Highlights a win when one of the following patterns in completed
var isWin: Bool {
    return
        position[0] == position[1] && position[0] == position[2] && position[0] != .E || // row 0
        position[3] == position[4] && position[3] == position[5] && position[3] != .E || // row 1
        position[6] == position[7] && position[6] == position[8] && position[6] != .E || // row 2
        position[0] == position[3] && position[0] == position[6] && position[0] != .E || // col 0
        position[1] == position[4] && position[1] == position[7] && position[1] != .E || // col 1
        position[2] == position[5] && position[2] == position[8] && position[2] != .E || // col 2
        position[0] == position[4] && position[0] == position[8] && position[0] != .E || // diag 0
        position[2] == position[4] && position[2] == position[6] && position[2] != .E // diag 1
}
// Highlights a draw when there are 0 available spaces left on the board and there hasn't been a completed row, col, or diag
var isDraw: Bool {
    return !isWin && legalMoves.count == 0
}
// Find the best possible outcome for originalPlayer
 func minimax(_ board: Board, maximizing: Bool, originalPlayer: Piece) -> Int {
    // Base case - evaluate the position if it is a win or a draw
    if board.isWin && originalPlayer == board.turn.opposite { return 1 } // win
    else if board.isWin && originalPlayer != board.turn.opposite { return -1 } // loss
    else if board.isDraw { return 0 } // draw
    // Recursive case - maximize your gains or minimize the opponent's gains
    if maximizing {
        var bestEval = Int.min
        for move in board.legalMoves { // find the move with the highest evaluation
            let result = minimax(board.move(move), maximizing: false, originalPlayer: originalPlayer)
         bestEval = max(result, bestEval)
        }
        return bestEval
    } else { // minimizing
        var worstEval = Int.max
    f   or move in board.legalMoves {
            let result = minimax(board.move(move), maximizing: true, originalPlayer: originalPlayer)
            worstEval = min(result, worstEval)
        }
        return worstEval
    }
}
// Run minimax on every possible move to find the best one
func findBestMove(_ board: Board) -> Move {
    var bestEval = Int.min
    var bestMove = -1
    for move in board.legalMoves {
        let result = minimax(board.move(move), maximizing: false, originalPlayer: board.turn)
        if result > bestEval {
            bestEval = result
            bestMove = move
        }
    }
    return bestMove
}
// win in 1 move
let toWinEasyPosition: [Piece] = [.X, .O, .X,
                                   .X, .E, .O,
                                   .E, .E, .O]
let testBoard1: Board = Board(position: toWinEasyPosition, turn: .X, lastMove: 8)
let answer1 = findBestMove(testBoard1)
print(answer1)

// must block O's win
let toBlockPosition: [Piece] = [.X, .E, .E,
                                 .E, .E, .O,
                                 .E, .X, .O]
let testBoard2: Board = Board(position: toBlockPosition, turn: .X, lastMove: 8)
let answer2 = findBestMove(testBoard2)
print(answer2)

// find the best move to win in 2 moves
let toWinHardPosition: [Piece] = [.X, .E, .E,
                                   .E, .E, .O,
                                   .O, .X, .E]
let testBoard3: Board = Board(position: toWinHardPosition, turn: .X, lastMove: 6)
let answer3 = findBestMove(testBoard3)
print(answer3)
  
  
  
  
  
  

  

  
