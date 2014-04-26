import java.util.Map;
import java.util.Collections;
import java.awt.Color;

class Tile{
  Color col;
  color c_p = #000000;
  String name;
  float xpos;
  float ypos;
  int row_pos;
  
  Tile(String n, Color c){
    name = n;
    col = c;
    c_p = col.getRGB();
  }
  
  void setRow(int r){
    row_pos = r;
  }
  
  void setX(float x){
    xpos = x;
  }
  
  void setY(float y){
    ypos = y;
  }
  
  void display(){
    rectMode(CENTER);
    fill(c_p);
    //x,y coords, width height
    noStroke();
    ellipse(xpos, ypos, 50, 50);
  }
}


class CatanBoard{
  HashMap<String, Color> tileColors = new HashMap<String, Color>();
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  CatanBoard(){
    //fill hash map
    tileColors.put("ore", Color.BLACK);
    tileColors.put("wood", Color.GREEN.darker());
    tileColors.put("sheep", Color.GREEN);
    tileColors.put("brick", new Color(88,60,50)); //brown
    tileColors.put("wheat", Color.YELLOW);
    tileColors.put("desert", new Color(236, 222, 201)); //tan
     
    //create a vector of pieces, randomly put them in some order
    //standard catan map for now
    //3 ore, brick
    //4 wood, sheep, wheat
    //1 desert
    //this is kinda dumb, refactor this
    tiles.add(new Tile("desert", tileColors.get("desert")));
    for(int i = 0; i < 3; i++) {
      tiles.add(new Tile("ore", tileColors.get("ore")));
      tiles.add(new Tile("brick", tileColors.get("brick")));
    }
    for(int i = 0; i < 4; i++) {
      tiles.add(new Tile("wood", tileColors.get("wood")));
      tiles.add(new Tile("sheep", tileColors.get("sheep")));
      tiles.add(new Tile("wheat", tileColors.get("wheat")));
    }
    
    //huzzah no wheel reinvention
    Collections.shuffle(tiles);
    
    //set rows in original catan setup
    //generate x, y pos based on location in the queue and row on board
    int rowSep = 0;
    for(int i = 0, row = 0; i < tiles.size(); i++){
      if((i == 3) || (i == 7) || (i == 12) || (i == 16) ) {
       row++;
       rowSep = 0; 
      }
      tiles.get(i).setRow(row);
      switch (row){
        case 0:
        tiles.get(i).setX(120 + (55 * (rowSep+1)) );
        break;
        case 1:
        tiles.get(i).setX(80 + (55 * (rowSep+1)) );
        break;
        case 2:
        tiles.get(i).setX(50 + (55 * (rowSep+1)) );
        break;
        case 3:
        tiles.get(i).setX(80 + (55 * (rowSep+1)) );
        break;
        case 4:
        tiles.get(i).setX(120 + (55 * (rowSep+1)) );
        break;
        default:
        break;
      }
      rowSep++;
      tiles.get(i).setY(100 + 55 * (row+1));
    }
  }
  
  //only need to draw this once
  void display(){
    fill(255,0,0);
    textSize(42);
    text("Random Catan Map", 50, 50);
    for(int i = 0; i < tiles.size(); i++) tiles.get(i).display();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

//main
CatanBoard board;

void setup(){
  size(500,500);
  background(0,0,255);
  board = new CatanBoard();
}

void draw(){
  board.display();
}
