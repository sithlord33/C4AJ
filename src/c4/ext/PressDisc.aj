package c4.ext;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.event.MouseListener;

import c4.base.BoardPanel;

public privileged aspect PressDisc {
	
	private int BoardPanel.mouseSlot = -1;
	
	pointcut pressDisc(BoardPanel b):
		execution(BoardPanel.new(..)) && this(b);
	
	void around(BoardPanel b): pressDisc(b){
		b.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				if (!b.board.isGameOver()) {
					b.mouseSlot = b.locateSlot(e.getX(), e.getY());
					b.repaint();
				}
			}
		});
		proceed(b);
	}
	
	pointcut drawDisc(BoardPanel b, Graphics g):
		execution(void BoardPanel.drawDroppableCheckers(Graphics)) && this(b) && args(g);
	
	after(BoardPanel b, Graphics g): drawDisc(b, g){
		if(b.mouseSlot >= 0 && !b.board.isSlotFull(b.mouseSlot)) {
			b.drawChecker(g, b.dropColor, b.mouseSlot, -1, 5);
		}
	}
	
}
