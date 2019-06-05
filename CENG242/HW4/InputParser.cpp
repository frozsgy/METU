#include"InputParser.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

Game* InputParser::parseGame() {
  int size=0;
  int chx,chy;
  int maxTurn;
  int playersCount;
  std::cin >> size;
  std::cin >> chx >> chy;
  std::cin >> maxTurn;
  std::cin >> playersCount;
  Game* myGame = new Game(maxTurn,size,Coordinate(chx,chy));
  for(int i=0;i<playersCount;i++) {
    int pid;
    std::string pro;
    std::string pte;
    Team ptei;
    int px, py;
    std::cin >> pid >> pro >> pte >> px >> py;
    if(pte == "BARBARIAN") ptei=BARBARIANS;
    else ptei=KNIGHTS;
    myGame->addPlayer(pid,px,py,ptei,pro);
  }
  return myGame;
}
