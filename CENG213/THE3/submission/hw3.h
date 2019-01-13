#ifndef _HW3_H
#define _HW3_H
#include <iostream>
#include <string>
#include <vector>
#include <utility>  // use just for std::pair< >
#include <fstream>

#define MAX_LOAD_FACTOR 0.65
#define EMPTY "EMPTY"
#define DELETED "DELETED"

class AccessControl
{
public:
	AccessControl(int table1Size, int table2Size);
	~AccessControl();

	int addUser(std::string username, std::string pass);
	int addUsers(std::string filePath);
	int delUser(std::string username, std::vector<std::string>& oldPasswords);
	int changePass(std::string username, std::string oldpass, std::string newpass);

	int login(std::string username, std::string pass);
	int logout(std::string username);

	float printActiveUsers();
	float printPasswords();
	
private:
	std::vector<std::pair<std::string, std::string> > regUsers;
	std::vector<std::string> activeUsers;
	int tableSize;
	int activeSize;
	int regCount;
	int activeCount;
	int hashFunction(std::string key, int tableSize, int i) {
		int length = key.length();
		int newK = 0;
		for (int j = 0; j < length; j++)
			newK += (int) key[j];
			// hash function 1 -> (newK % tableSize)
			// hash function 2 -> (newK * tableSize - 1) % tableSize)
		return ((newK % tableSize) + i * ((newK * tableSize - 1) % tableSize)) % tableSize;
	}
	int addUserHelper(std::string username, std::string pass, int recursive);
	int findUser(const std::string username, int cycle);
	int countPasswords(const std::vector<std::pair<std::string, std::string> >& myTable, int mySize, const std::string username, int cycle);
	double getLoadFactor() const;
	bool isPrime(int n) const;
	int nextPrime(int n) const;
	void resizeTable();
	void resizeLoginTable();
	bool canLogin(std::string username, std::string pass, bool forLogin=true);
	int loginHelper(std::string username, int recursive);
	double getLoadFactorActive() const;
};

#endif
