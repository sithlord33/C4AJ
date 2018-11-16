package c4.ext;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import c4.base.BoardPanel;

public aspect PressDisc {

	pointcut press(BoardPanel board, Graphics g):
		execution(void BoardPanel.drawPlacedCheckers(Graphics)) && this(board) && args(g);
	
	void around(BoardPanel board, Graphics g) : press(board,g){
		board.addMouseListener(new MouseAdapter());
		public void mouseClicked(MouseEvent arg0){
			g.setColor(Color.GREEN);
			g.fillOval(2, 2, 30-2*2, 30-2*2);
		}
		
		proceed(board,g);
	}
}
