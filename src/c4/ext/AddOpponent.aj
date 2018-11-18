package c4.ext;

import java.util.ArrayList;
import java.util.List;
import java.awt.Color;
import java.awt.Graphics;

import c4.model.Player;
import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;

public privileged aspect AddOpponent {

    private List<ColorPlayer> players;
    private int count = 0;
    private BoardPanel C4Dialog.panel;
 
    public void C4Dialog.changeTurn(ColorPlayer opponent){
        player = opponent;
        showMessage(player.name() + "'s turn.");
        repaint();
    }
    
    after(C4Dialog d) returning(BoardPanel b):
    	call(BoardPanel.new(..)) && this(d){
    	d.panel = b;
    }

    pointcut addOpponent(C4Dialog d):
    	call(void C4Dialog.configureUI()) && this(d);
    
    before(C4Dialog d): addOpponent(d){
    	ColorPlayer player2 = new ColorPlayer("Red", Color.RED);
    	players = new ArrayList<ColorPlayer>();
    	players.add(0, d.player);
    	players.add(1, player2);
    }
    
    pointcut makeMove(C4Dialog d):
    	execution(void C4Dialog.makeMove(int)) && this(d);
    
    after(C4Dialog d): makeMove(d){
    	if (count == 0){
    		d.changeTurn(players.get(1));
    		count = 1;
    	}
    	else {
    		d.changeTurn(players.get(0));
    		count = 0;
    		//BoardPanel.drawDroppableCheckers(g);
    	}
    	d.panel.setDropColor(d.player.color());
    }

    pointcut newGame(C4Dialog d):
    	call(void C4Dialog.startNewGame()) && this(d);
    
    after(C4Dialog d): newGame(d){
    	d.changeTurn(players.get(0));
    	count = 0;
    }
}
