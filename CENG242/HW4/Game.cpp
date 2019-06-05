#include"Game.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

#include <algorithm>

Game::Game(uint maxTurnNumber, uint boardSize, Coordinate chest) : board(boardSize,&players,chest), turnNumber(0), maxTurnNumber(maxTurnNumber){

}

Game::~Game() {
  for(auto i: players) {
    delete i;
  }
}

void Game::addPlayer(int id, int x, int y, Team team, std::string cls) {
  Player* adding=nullptr;
  if(cls == "ARCHER") {
    adding = new Archer(id,x,y,team);
  }
  else if(cls == "FIGHTER") {
    adding = new Fighter(id,x,y,team);
  }
  else if(cls == "SCOUT") {
    adding = new Scout(id,x,y,team);
  }
  else if(cls == "PRIEST") {
    adding = new Priest(id,x,y,team);
  }
  else {
    adding = new Tank(id,x,y,team);
  }
  this->players.push_back(adding);
  std::sort(this->players.begin(),this->players.end(),Game::playerSort);
}

bool Game::isGameEnded() {
  int barbarianCount=this->getBoard()->getBarbarianCount();
  int knightCount=this->getBoard()->getKnightCount();
  if(!barbarianCount) {
    std::cout << "Game ended at turn " << this->turnNumber << ". All barbarians dead. Knight victory." << std::endl;
    return true;
  }
  else if(!knightCount) {
    std::cout << "Game ended at turn " << this->turnNumber << ". All knights dead. Barbarian victory." << std::endl;
    return true;
  }
  else if(this->getBoard()->barbarianOnChest()) {
    std::cout << "Game ended at turn " << this->turnNumber << ". Chest captured. Barbarian victory." << std::endl;
    return true;
  }
  else if(this->turnNumber == this->maxTurnNumber) {
    std::cout << "Game ended at turn " << this->turnNumber << ". Maximum turn number reached. Knight victory." << std::endl;
    return true;
  }
  return false;
}

void Game::playTurn() {
    std::cout << "Turn " << turnNumber+1 << " has started." << std::endl;
    int i=0;
    int psize=this->players.size();
    while(i<psize) {
      psize=this->players.size();
      playTurnForPlayer(this->players[i]);
      if(this->players.size() == psize) {
        i++;
      }
      else if(this->players.size() == psize-1 && i == psize-1) {
        i++;
      }
    }
    turnNumber++;
}

Goal Game::playTurnForPlayer(Player* player) {
  if(player->isDead()) {
    /* player died, print message, free sources. */
    std::cout << "Player " << player->getBoardID() << " has died." << std::endl;
    int i;
    for(i=0;i<this->players.size();i++) {
      if(this->players[i] == player) break;
    }
    this->players.erase(this->players.begin()+i);
    delete player;
    return NO_GOAL;
  }
  else {
    /* player is alive, play for them. */
    std::vector<Goal> priorities=player->getGoalPriorityList();
    for(auto i:priorities) {
      if (i == ATTACK) {
        /* do attacking stuff, if succesfull return ATTACK */
        std::vector<Coordinate> attackables=player->getAttackableCoordinates();
        Coordinate cmin(player->getCoord());
        uint minID=2147483647;
        Player* enemy=nullptr;
        for(auto j:attackables) {
          if(!this->getBoard()->isCoordinateInBoard(j)) continue;
          Player *ch=(*(this->getBoard()))[j];
          if(ch && ch->getTeam() == player->getTeam()) continue;
          if(ch && ch->getID() < minID) {
            minID=ch->getID();
            cmin=ch->getCoord();
            enemy=ch;
          }
        }

        if(cmin != player->getCoord()) {
          player->attack(enemy);
          return ATTACK;
        }
      }
      else if (i == CHEST) {
        /* go to chest, if succesfull return CHEST */
        std::vector<Coordinate> moveables=player->getMoveableCoordinates();
        Coordinate chest=this->getBoard()->getChestCoordinates();
        if(player->getCoord() == chest) continue;
        if(moveables.size()) {
          Coordinate pref(999999999,99999999);
          std::vector<Coordinate> prefs;
          for(auto j:moveables) {
            if(!this->getBoard()->isCoordinateInBoard(j) || this->getBoard()->isPlayerOnCoordinate(j)) continue;
            if((this->getBoard()->getChestCoordinates() - j) < (this->getBoard()->getChestCoordinates() - pref)) {
              pref=j;
            }
          }
          for(auto j:moveables) {
            if(!this->getBoard()->isCoordinateInBoard(j) || this->getBoard()->isPlayerOnCoordinate(j)) continue;
            if((this->getBoard()->getChestCoordinates() - j) == (this->getBoard()->getChestCoordinates() - pref)) {
              prefs.push_back(j);
            }
          }
          if(prefs.size() > 1) {
            /* multiple, pick the best*/
            // if cannot reduce, do not move at all.
            for(auto j:prefs) {
              if(abs(j.x-player->getCoord().x)) {
                if(player->getCoord()-this->getBoard()->getChestCoordinates() != j-this->getBoard()->getChestCoordinates()){
                  player->movePlayerToCoordinate(j);
                  return CHEST;
                }
              }
            }
          }
          else {
            if(player->getCoord()-this->getBoard()->getChestCoordinates() != pref-this->getBoard()->getChestCoordinates()){
              player->movePlayerToCoordinate(pref);
              return CHEST;
            }
          }
        }
        /* chest ended*/
      }
      else if (i == TO_ENEMY) {
        /* go to enemy, if succesfull return TO_ENEMY */
        std::vector<Coordinate> moveables=player->getMoveableCoordinates();
        Team myTeam = player->getTeam();
        bool neigh=false;
        for(auto e:moveables) {
          Player *ch=(*(this->getBoard()))[e];
          if(ch && ch->getTeam() != myTeam) neigh=true;
        }
        if(neigh) continue;
        std::vector<Player*> enemies;
        for(auto j:this->players) {
          if(j->getTeam() != myTeam) {
            enemies.push_back(j);
          }
        }
        if(enemies.size()) {
          /* we have enemies, let's move to them*/
          Coordinate pref(999999999,99999999);
          std::vector<Coordinate> prefs;
          std::vector<uint> prefsIDs;
          for(auto j:enemies) {
            if((player->getCoord() - j->getCoord()) < (player->getCoord() - pref)) {
              pref=j->getCoord();
            }
          }
          for(auto j:enemies) {
          if((player->getCoord() - j->getCoord()) == (player->getCoord() - pref)) {
              prefs.push_back(j->getCoord());
              prefsIDs.push_back(j->getID());
            }
          }
          int smallest=9999999;
          for(auto p:prefsIDs) {
            if(smallest > p) smallest=p;
          }
          //pick the one with the smallest id, then pick the horizontal one if multiple existing.
          if(prefs.size() > 1) {
            // multiple, pick the best
            for(int jj=0;jj<prefs.size();jj++) {
              Coordinate j=prefs[jj];
              if(prefsIDs[jj] == smallest) {
                if(abs(j.y-player->getCoord().y)) {
                  int prefe=99999999;
                  Coordinate prefc(999999999,99999999);
                  for(auto k:moveables) {
                    if(!(this->getBoard()->isCoordinateInBoard(k)) || this->getBoard()->isPlayerOnCoordinate(k)) continue;
                    if((j - k) < prefe) {
                      prefc=k;
                      prefe=j - k;
                    }
                  }
                  if(player->getCoord() - j > prefc - j) {
                    player->movePlayerToCoordinate(prefc);
                    return TO_ENEMY;
                  }
                }
              }
            }
          }
          else {
            int prefe=99999999;
            Coordinate prefc(999999999,99999999);
            for(auto k:moveables) {
              if(!(this->getBoard()->isCoordinateInBoard(k)) || this->getBoard()->isPlayerOnCoordinate(k)) continue;
              if((pref - k) < prefe) {
                prefc=k;
                prefe=pref - k;
              }
            }
            if(player->getCoord() - pref > prefc - pref) {
              player->movePlayerToCoordinate(prefc);
              return TO_ENEMY;
            }
          }
        /* done with enemies*/
        }
      }
      else if (i == TO_ALLY) {
        /* go to ally, if succesfull return TO_ALLY */
        std::vector<Coordinate> moveables=player->getMoveableCoordinates();
        Team myTeam = player->getTeam();
        std::vector<Player*> allies;
        for(auto j:this->players) {
          if(j->getTeam() == myTeam && j != player) {
            allies.push_back(j);
          }
        }
        //std::sort(allies.begin(),allies.end(),Game::playerSort);
        if(allies.size()) {
          /* we have allies, let's move to them*/
          Coordinate pref(999999999,99999999);
          std::vector<Coordinate> prefs;
          std::vector<uint> prefsIDs;
          for(auto j:allies) {
            if((player->getCoord() - j->getCoord()) < (player->getCoord() - pref)) {
              pref=j->getCoord();
            }
          }
          for(auto j:allies) {
          if((player->getCoord() - j->getCoord()) == (player->getCoord() - pref)) {
              prefs.push_back(j->getCoord());
              prefsIDs.push_back(j->getID());
            }
          }
          int smallest=9999999;
          for(auto p:prefsIDs) {
            if(smallest > p) smallest=p;
          }
          //pick the one with the smallest id, then pick the horizontal one if multiple existing.
          if(prefs.size() > 1) {
            // multiple, pick the best
            for(int jj=0;jj<prefs.size();jj++) {
              Coordinate j=prefs[jj];
              if(prefsIDs[jj] == smallest) {
                if(abs(j.y-player->getCoord().y)) {
                  int prefe=99999999;
                  Coordinate prefc(999999999,99999999);
                  for(auto k:moveables) {
                    if(!(this->getBoard()->isCoordinateInBoard(k)) || this->getBoard()->isPlayerOnCoordinate(k)) continue;
                    if((j - k) < prefe) {
                      prefc=k;
                      prefe=j - k;
                    }
                  }
                  if(player->getCoord() - j > prefc - j) {
                    player->movePlayerToCoordinate(prefc);
                    return TO_ALLY;
                  }
                }
              }
            }
          }
          else {
            int prefe=99999999;
            Coordinate prefc(999999999,99999999);
            for(auto k:moveables) {
              if(!(this->getBoard()->isCoordinateInBoard(k)) || this->getBoard()->isPlayerOnCoordinate(k)) continue;
              if((pref - k) < prefe) {
                prefc=k;
                prefe=pref - k;
              }
            }
            if(player->getCoord() - pref > prefc - pref) {
              player->movePlayerToCoordinate(prefc);
              return TO_ALLY;
            }
          }
        }
        /* done with enemies*/

      }
      else if (i == HEAL) {
        /* heal stuff, if succesfull return HEAL */
        std::vector<Coordinate> healables=player->getHealableCoordinates();
        bool healed=false;
        for(auto j:healables) {
          if(!(this->getBoard()->isCoordinateInBoard(j))) continue;
          Player *ch=(*(this->getBoard()))[j];
          if(ch && ch->getTeam() == player->getTeam()) {
            player->heal(ch);
            healed=true;
          }
        }
        if(healed) {
          return HEAL;
        }
      }
    }
    return NO_GOAL;
  }
}

bool Game::playerSort(Player* f, Player* s) {
  return f->getID() < s->getID();
}
