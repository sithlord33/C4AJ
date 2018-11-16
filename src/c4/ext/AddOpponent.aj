package c4.ext;

import java.util.List;

import c4.model.Player;

public privileged aspect AddOpponent {

    private List<Player> players;

    private void C4Dialog.changeTurn(Player opponent){
        player = opponent;
        showMessage(player.name() + "s turn.");
        repaint();
    }

    //Write your pointcuts, advices, fields, and methods...
}
