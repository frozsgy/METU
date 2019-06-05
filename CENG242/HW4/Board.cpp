#include"Board.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

Board::Board(uint _size, std::vector<Player*>* _players, Coordinate chest) :size(_size), chest(chest) {
  this->players=_players;
}
Board::~Board() { }

bool Board::isCoordinateInBoard(const Coordinate& c) {
  if(c.x < this->size && c.y < this->size) {
    return true;
  }
  return false;
}

bool Board::isPlayerOnCoordinate(const Coordinate& c) {
  for(auto i: *players) {
    if(i->getCoord() == c) {
      return true;
    }
  }
  return false;
}

Player* Board::operator [](const Coordinate& c) {
  for(auto i: *players) {
    if(i->getCoord() == c) {
      return i;
    }
  }
  return NULL;
}

Coordinate Board::getChestCoordinates() {
  return this->chest;
}

void Board::printBoardwithID() {
  std::string board[this->size][this->size];
  std::string temp={"__"};
  for(int i=0;i<this->size;i++)
  for(int j=0;j<this->size;j++) board[i][j]=temp;
  board[this->chest.x][this->chest.y]="Ch";
  for(auto i: *players) {
    Coordinate t=i->getCoord();
    std::string myID=i->getBoardID();
    board[t.x][t.y]=myID;
  }
  for(int i=0;i<this->size;i++) {
  for(int j=0;j<this->size;j++)
  std::cout << board[j][i] << " ";
  std::cout << std::endl;
  }
}

void Board::printBoardwithClass() {
  std::string board[this->size][this->size];
  std::string temp={"__"};
  for(int i=0;i<this->size;i++)
  for(int j=0;j<this->size;j++) board[i][j]=temp;
  board[this->chest.x][this->chest.y]="Ch";
  for(auto i: *players) {
    Coordinate t=i->getCoord();
    std::string myID=i->getClassAbbreviation();
    board[t.x][t.y]=myID;
  }
  for(int i=0;i<this->size;i++) {
  for(int j=0;j<this->size;j++)
  std::cout << board[j][i] << " ";
  std::cout << std::endl;
  }
}

int Board::getBarbarianCount() const {
  int res=0;
  for(auto i:*players) {
    if (i->getTeam() == BARBARIANS) {
      res++;
    }
  }
  return res;
}

int Board::getKnightCount() const {
  int res=0;
  for(auto i:*players) {
    if (i->getTeam() == KNIGHTS) {
      res++;
    }
  }
  return res;
}

bool Board::barbarianOnChest() const {
  for(auto i:*players) {
    if (i->getTeam() == BARBARIANS && i->getCoord() == this->chest) {
      return true;
    }
  }
  return false;
}
