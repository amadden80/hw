

// var player = ""




var game_board = [[0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]];

var player_turn = 1;



function checkWinner(){

  var i = 0;
  var sum = 0;
  var row = 0;
  var column = 0;

  for (i = 0; i<3; i++ ){
    row = game_board[i][0] + game_board[i][1] + game_board[i][2];
    column = game_board[0][i] + game_board[1][i] + game_board[2][i];
    if (row==3 || column==3){alert('1 wins'); return true;}
    if (row==-3 || column==-3){alert('2 wins'); return true;}
  }

  diag1 = game_board[0][0] + game_board[1][1] + game_board[2][2];
  diag2 = game_board[2][0] + game_board[1][1] + game_board[0][2];
  if (diag1==3 || diag2==3){alert('1 wins'); return true;}
  if (diag1==-3 || diag2==-3){alert('2 wins'); return true;}

  return false;
}


function played_box(context){
  var boxName = context.id;
  var row = boxName.slice(4, 5);
  var col = boxName.slice(5, 6);

  var currentVal = game_board[row][col];
  if (currentVal == 0){
    game_board[row][col] = player_turn;
    player_turn*=(-1);
  }
  update_board();
}


function update_board(){
  var row = 0;
  var col = 0;

  for(row=0; row<3; row++){
    for(col=0; col<3; col++){
      id = '#box_' + (row+'') + (col+'');
      if (game_board[row][col]>0){
        $(id).addClass('player_1_owned');
      }
      if(game_board[row][col]<0){
        $(id).addClass('player_2_owned');
      }
      if(game_board[row][col]==0){
        $(id).removeClass('player_1_owned');
        $(id).removeClass('player_2_owned');
      }
    }
  }


  if (check_game_complete()){
    game_board = [[0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]];

    player_turn = 1;
    update_board()
  }
}


function check_game_complete(){
  var row = 0;
  var col = 0;
  var position = 0;

  if (checkWinner()){return true;}

  for(row=0; row<3; row++){
    for(col=0; col<3; col++){
      position = game_board[row][col];
      if (position === 0){
        return false;
      }
    }
  }
  return true;
}