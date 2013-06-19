

// var player = ""




var game_board = [[0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0]];

var player_turn = 100;


function checkWinner(){

  var i = 0;
  var sum = 0;
  var row = 0;
  var column = 0;

  var offset;
  var cur_col;
  var cur_row;

  for (offset = 0; offset<4; offset++ ){
    for (cur_row = 0; cur_row<6; cur_row++ ){
      curVal = 0;
      for (cur_col = 0; cur_col<4; cur_col++ ){
        curVal += game_board[cur_row][offset + cur_col];
        if (curVal== 400){alert('1 wins'); return true;}
        if (curVal== -400){alert('2 wins'); return true;}
      }
    }
  }

  for (offset = 0; offset<3; offset++ ){
    for (cur_col = 0; cur_col<7; cur_col++ ){
      curVal = 0;
      for (cur_row = 0; cur_row<4; cur_row++ ){
        curVal += game_board[cur_row+offset][cur_col];
        if (curVal== 400){alert('1 wins'); return true;}
        if (curVal== -400){alert('2 wins'); return true;}
      }
    }
  }

  var cur_idx;
  var row_offset;

  for (row_offset = 0; row_offset<3; row_offset++ ){
    for (col_offset = 0; col_offset<4; col_offset++ ){
        curVal = 0;
      for (cur_idx = 0; cur_idx<4; cur_idx++ ){
        curVal += game_board[row_offset+cur_idx][col_offset + cur_idx];
        if (curVal== 400){alert('1 wins'); return true;}
        if (curVal== -400){alert('2 wins'); return true;}
      }
    }
  }

  for (row_offset = 0; row_offset<3; row_offset++ ){
    for (col_offset = 0; col_offset<4; col_offset++ ){
        curVal = 0;
      for (cur_idx = 0; cur_idx<4; cur_idx++ ){
        curVal += game_board[row_offset+Math.abs((cur_idx-3))][col_offset + cur_idx];
        if (curVal== 400){alert('1 wins'); return true;}
        if (curVal== -400){alert('2 wins'); return true;}
      }
    }
  }

  return false;
}


function played_box(context){
  var boxName = context.id;
  var row = boxName.slice(4, 5);
  var col = boxName.slice(5, 6);
  var curVal;
  for (var i = 5; i >=0; i-- ){
    curVal = game_board[i][col];
     if (curVal === 0){
      game_board[i][col] = player_turn;
      player_turn*=(-1);
      break;
     }
  }

  update_board();
}


function update_board(){
  var row = 0;
  var col = 0;

  for(row=0; row<6; row++){
    for(col=0; col<7; col++){
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
    game_board = [[0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0]];

    player_turn = 100;
    update_board();
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