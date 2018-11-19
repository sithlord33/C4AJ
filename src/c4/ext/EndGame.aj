package c4.ext;

import c4.base.C4Dialog;
import c4.model.Board;
import c4.model.Player;

public privileged aspect EndGame {
	
	pointcut gameOver(C4Dialog d):
		execution(void C4Dialog.makeMove(int)) && this(d);
	
	after(C4Dialog d): gameOver(d) {
		if (d.board.isWonBy(d.player)) {
			d.showMessage(d.player.name() + " wins!");
		}
		else if (d.board.isFull()) {
			d.showMessage("Draw");
		}
	}

}