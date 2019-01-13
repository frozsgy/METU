#include "hw3.h"

AccessControl::AccessControl(int table1Size, int table2Size) {
	regUsers.resize(table1Size);
	activeUsers.resize(table2Size);
	for(int i=0;i<table1Size;i++) {
		regUsers[i].first="EMPTY";
		regUsers[i].second="EMPTY";
	}
	for(int i=0;i<table2Size;i++) {
		activeUsers[i]="EMPTY";
	}
	this->regCount=0;
	this->activeCount=0;
	this->tableSize=table1Size;
	this->activeSize=table2Size;
}

AccessControl::~AccessControl() {

}

int AccessControl::findUser(const std::string username, int cycle) {
	if(cycle==tableSize) {
		return -1;
	}
	else {
		int temp=hashFunction(username, tableSize, cycle);
		if(regUsers[temp].first==username) {
			return temp;
		}
		else {
			return findUser(username,cycle+1);
		}
	}
}

int AccessControl::countPasswords(const std::vector<std::pair<std::string, std::string> >& myTable, int mySize, const std::string username, int cycle) {
	if(cycle==mySize) {
		return 0;
	}
	else {
		int temp=hashFunction(username, mySize, cycle);
		if(myTable[temp].first==username) {
			return 1+countPasswords(myTable, mySize, username, cycle+1);
		}
		else {
			return countPasswords(myTable, mySize, username, cycle+1);
		}
	}
}

double AccessControl::getLoadFactor() const {
	return (double)regCount/tableSize;
}

double AccessControl::getLoadFactorActive() const {
	return (double)activeCount/activeSize;
}

bool AccessControl::isPrime(int n) const {
	if(n==2) {
		return true;
	}
	if(!(n%2)) {
		return false;
	}
	int i=3;
	while(i*i<=n) {
		if(!(n%i)) {
			return false;
		}
		i+=2;
	}
	return true;
}

int AccessControl::nextPrime(int n) const {
	int i=n+1;
	while(!isPrime(i)) {
		i++;
	}
	return i;
}

int AccessControl::addUser(std::string username, std::string pass) {
	return addUserHelper(username,pass,0);
}

int AccessControl::addUserHelper(std::string username, std::string pass, int recursive) {
	if(findUser(username,0) != -1 && recursive != 2) {
		//exists
		return 0;
	}
	else {
		int temp=hashFunction(username, tableSize, 0);
		if(regUsers[temp].first=="EMPTY" || regUsers[temp].first=="DELETED") {
			//first hash is empty, insert here
			regUsers[temp].first=username;
			regUsers[temp].second=pass;
			if(!recursive)  {
				++regCount;
				resizeTable();
			}
			return 1;
		}
		else {
			// probe
			for(int walk=1;walk<tableSize;walk++) {
				temp=hashFunction(username, tableSize, walk);
				if(regUsers[temp].first=="EMPTY" || regUsers[temp].first=="DELETED") {
					//found
					break;
				}
			}
			if(regUsers[temp].first!="EMPTY" && regUsers[temp].first!="DELETED") {
				return 0;
			}
			regUsers[temp].first=username;
			regUsers[temp].second=pass;
			if(!recursive)  {
				++regCount;
				resizeTable();
			}
			return 1;
		}
	}
}

void AccessControl::resizeTable() {
	if(getLoadFactor() > MAX_LOAD_FACTOR) {
		//resize
		int nextSize=nextPrime(2*tableSize);
		std::vector<std::pair<std::string, std::string> > tempTable=regUsers;
		regUsers.clear();
		int oldSize=tableSize;
		tableSize=nextSize;
		regUsers.resize(nextSize);
		std::vector<std::string> importedQ;
		for(int i=0;i<nextSize;i++) {
			regUsers[i].first="EMPTY";
			regUsers[i].second="EMPTY";
		}
		for(int i=0;i<oldSize;i++) {
			if(tempTable[i].first != "DELETED" && tempTable[i].first != "EMPTY") {
				int pwCount=countPasswords(tempTable,oldSize,tempTable[i].first,0);
				if(pwCount == 1) {
					//only one copy, import it right away
					addUserHelper(tempTable[i].first,tempTable[i].second,1);
				}
				else {
					//multiple copies, protect the order.
					//check if imported before.
					bool before=false;
					for(unsigned int j=0;j<importedQ.size();j++) {
						if(importedQ[j]==tempTable[i].first) {
							before=true;
							break;
						}
					}
					if(before) {
						continue;
					}
					//if we're here it means it was not imported before.
					std::vector<std::string> oldPasswordsQ;
					for(int m=0;m<oldSize;m++) {
						int hashCheck=hashFunction(tempTable[i].first, oldSize, m);
						if(tempTable[hashCheck].first==tempTable[i].first) {
							oldPasswordsQ.push_back(tempTable[hashCheck].second);
							if((int)oldPasswordsQ.size() == pwCount) break;
						}
					}
					for(int m=0;m<pwCount;m++) {
						addUserHelper(tempTable[i].first,oldPasswordsQ[m],2);
						importedQ.push_back(tempTable[i].first);
					}
				}
			}
		}
		tempTable.clear();
	}
}

int AccessControl::addUsers(std::string filePath) {
  std::string temp;
  std::string temp2[2];
	int imported=0;
	int stat;
  std::ifstream usersFile(filePath.c_str());
  while(getline(usersFile,temp)) {
    for(int i=0;i<2;i++) {
      int wh=temp.find(' ');
      if(!i && !wh) {
        temp2[0]=temp2[1]="";
        break;
      }
      temp2[i]=temp.substr(0, wh);
      temp.erase(0, wh+1);
    }
    if(temp2[0] != "") {
      stat=addUser(temp2[0],temp2[1]);
			if(stat) {
				imported++;
			}
    }
    temp2[0]=temp2[1]="";
  }
  usersFile.close();
	return imported;
}

int AccessControl::delUser(std::string username, std::vector<std::string>& oldPasswords) {
	if(findUser(username,0) != -1) {
		//exists
		int it=countPasswords(regUsers,tableSize,username,0);
		std::vector<std::string> passwordsQ;
		int total=0;
		int temp, i;
		for(i=0;i<tableSize;++i) {
			temp=hashFunction(username, tableSize, i);
			if(regUsers[temp].first==username) {
				passwordsQ.push_back(regUsers[temp].second);
				regUsers[temp].first="DELETED";
				regUsers[temp].second="DELETED";
				--regCount;
				++total;
			}
			if(total == it) break;
		}
		oldPasswords=passwordsQ;
		return 1;
	}
	else {
		return 0;
	}
}

int AccessControl::changePass(std::string username, std::string oldpass, std::string newpass) {
	if(findUser(username,0) != -1) {
		if(canLogin(username,oldpass,false)) {
			//change the password
			int it=countPasswords(regUsers,tableSize,username,0);
			int total=0;
			int temp, i;
			for(i=0;i<tableSize;++i) {
				temp=hashFunction(username, tableSize, i);
				if(regUsers[temp].first==username) ++total;
				if(total == it) break;
			}
			for(;i<tableSize;++i) {
				temp=hashFunction(username, tableSize, i);
				if(regUsers[temp].first == "DELETED" || regUsers[temp].first == "EMPTY") {
					regUsers[temp].first=username;
					regUsers[temp].second=newpass;
					regCount++;
					resizeTable();
					return 1;
				}
			}
			return 0;
		}
		return 0;
	}
	return 0;
}

bool AccessControl::canLogin(std::string username, std::string pass, bool forLogin) {
	if(activeCount && forLogin) {
		for(int i=0;i<activeSize;i++) {
			int actHash=hashFunction(username,activeSize,i);
			if(activeUsers[actHash] == username) return false;
		}
	}
	if(findUser(username,0) != -1) {
		//exists
		int pwCount=countPasswords(regUsers, tableSize, username, 0);
		if(pwCount == 1) {
			//1 password only
			for(int i=0;i<tableSize;i++) {
				int hashCheck=hashFunction(username,tableSize,i);
				if(regUsers[hashCheck].first == username && regUsers[hashCheck].second == pass) {
					return true;
				}
				else {
					//probe
					int lastHash=hashCheck;
					for(int walk=1;walk<tableSize;walk++) {
						int temp=hashFunction(username, tableSize, walk);
						if(regUsers[temp].first==username) {
							//found
							lastHash=temp;
							break;
						}
					}
					if(username == regUsers[lastHash].first && pass == regUsers[lastHash].second) {
						return true;
					}
					return false;
				}
			}
		}
		else {
			//multiple passwords history
			for(int i=0;i<tableSize;i++) {
				int hashCheck=hashFunction(username,tableSize,i);
				int lastHash=hashCheck;
				int many=0;
				for(int walk=0;walk<tableSize;walk++) {
					int temp=hashFunction(username, tableSize, walk);
					if(regUsers[temp].first==username) {
						//found
						lastHash=temp;
						++many;
					}
					if(many == pwCount) break;
				}
				if(username == regUsers[lastHash].first && pass == regUsers[lastHash].second) {
					return true;
				}
				return false;
			}
		}
	}
	return false;
}

int AccessControl::login(std::string username, std::string pass) {
	if(canLogin(username,pass)) return loginHelper(username,0);
	return 0;
}

int AccessControl::loginHelper(std::string username, int recursive) {
	int temp=hashFunction(username, activeSize, 0);
	if(activeUsers[temp]=="EMPTY" || activeUsers[temp]=="DELETED") {
		//first hash is empty, insert here
		activeUsers[temp]=username;
		if(!recursive)  {
			++activeCount;
			resizeLoginTable();
		}
		return 1;
	}
	else {
		// probe
		for(int walk=1;walk<activeSize;walk++) {
			temp=hashFunction(username, activeSize, walk);
			if(activeUsers[temp]=="EMPTY" || activeUsers[temp]=="DELETED") {
				//found
				break;
			}
		}
		if(activeUsers[temp]!="EMPTY" && activeUsers[temp]!="DELETED") {
			return 0;
		}
		activeUsers[temp]=username;
		if(!recursive)  {
			++activeCount;
			resizeLoginTable();
		}
		return 1;
	}
}

void AccessControl::resizeLoginTable() {
	if(getLoadFactorActive() > MAX_LOAD_FACTOR) {
		//resize
		int nextSize=nextPrime(2*activeSize);
		std::vector<std::string> tempTable=activeUsers;
		activeUsers.clear();
		int oldSize=activeSize;
		activeSize=nextSize;
		activeUsers.resize(nextSize);
		for(int i=0;i<nextSize;i++) {
			activeUsers[i]="EMPTY";
		}
		for(int i=0;i<oldSize;i++) {
			if(tempTable[i] != "DELETED" && tempTable[i] != "EMPTY") {
					loginHelper(tempTable[i],1);
				}
			}
		tempTable.clear();
	}
}

int AccessControl::logout(std::string username) {
	if(findUser(username,0) != -1) {
		bool found=false;
		int temp;
		for(int walk=0;walk<activeSize;walk++) {
			temp=hashFunction(username, activeSize, walk);
			if(activeUsers[temp]==username) {
				//found
				found=true;
				break;
			}
		}
		if(found) {
			activeUsers[temp]="DELETED";
			--activeCount;
			return 1;
		}
		return 0;
	}
	return 0;
}

float AccessControl::printActiveUsers() {
	for(int i=0; i<activeSize; ++i) {
		std::cout << activeUsers[i] << std::endl;
	}
	return getLoadFactorActive();
}

float AccessControl::printPasswords() {
	for(int i=0; i<tableSize; ++i) {
		std::cout << regUsers[i].first << " " << regUsers[i].second << std::endl;
	}
	return getLoadFactor();
}
