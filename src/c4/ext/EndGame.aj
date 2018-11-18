package c4.ext;

import java.awt.Color;
import java.awt.Graphics;

import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;
import c4.model.*;
import c4.model.Board.Place;

public privileged aspect EndGame {
	
	Boolean finished = false;
	Iterable<Place> winningRow;
	
    private void BoardPanel.drawWinRow(Graphics g){
    	
    }
	
	pointcut gameOver(C4Dialog d):	
		this(d) && (execution(void C4Dialog.makeMove(int)) || execution(int Board.dropInSlot(int, Player)));
	
	after(C4Dialog d): gameOver(d){
		if(d.board.isWonBy(d.player)) {
			d.showMessage(d.player.name() + " wins");
		}
	}		

}