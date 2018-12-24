#ifndef TWOPHASEBST_H
#define TWOPHASEBST_H

#include <iostream>
#include <string>
#include <stack>
#include <list>
// do not add any other library.
// modify parts as directed by assignment text and comments here.

template <class T>
class TwoPhaseBST {
private: //do not change
    struct SecondaryNode {
        std::string key;
        T data;
        SecondaryNode *left;
        SecondaryNode *right;

        SecondaryNode(const std::string &k, const T &d, SecondaryNode *l, SecondaryNode *r);
    };

    struct PrimaryNode {
        std::string key;
        PrimaryNode *left;
        PrimaryNode *right;
        SecondaryNode *rootSecondaryNode;

        PrimaryNode(const std::string &k, PrimaryNode *l, PrimaryNode *r, SecondaryNode *rsn);
    };

public: // do not change.
    TwoPhaseBST();
    ~TwoPhaseBST();

    TwoPhaseBST &insert(const std::string &primaryKey, const std::string &secondaryKey, const T &data);
    TwoPhaseBST &remove(const std::string &primaryKey, const std::string &secondaryKey);
    TwoPhaseBST &print(const std::string &primaryKey = "", const std::string &secondaryKey = "");
    T *find(const std::string &primaryKey, const std::string &secondaryKey);

private: // you may add your own utility member functions here.
    void destructNode(PrimaryNode * &root);
    void destructNode(SecondaryNode * &root);
    void insertNode(const std::string &primaryKey, const std::string &secondaryKey, const T &data, PrimaryNode* &pn);
    void insertSecondaryNode(SecondaryNode* &sn, const std::string &secondaryKey, const T &data);
    void PrimaryPrinter(PrimaryNode *pn, const std::string &primaryKey, const std::string &secondaryKey) const;
    void SecondaryPrinter(SecondaryNode *sn, const std::string &secondaryKey) const;
    int SecondaryCounter(SecondaryNode *sn, const std::string &secondaryKey) const;
    struct TwoPhaseBST<T>::PrimaryNode *findPrimary(const std::string &primaryKey, const std::string &secondaryKey, PrimaryNode *pn);
    struct TwoPhaseBST<T>::SecondaryNode *findSecondary(const std::string &secondaryKey, SecondaryNode *sn);
    void deleteSecondaryNode(const std::string &secondaryKey, SecondaryNode * &sn);
    struct TwoPhaseBST<T>::SecondaryNode *findMin(SecondaryNode *sn) const;

private: // do not change.
    PrimaryNode *root; //designated root.

    // do not provide an implementation. TwoPhaseBST's are not copiable.
    TwoPhaseBST(const TwoPhaseBST &);
    const TwoPhaseBST &operator=(const TwoPhaseBST &);
};

template <class T>
TwoPhaseBST<T>::SecondaryNode::SecondaryNode(const std::string &k, const T &d, SecondaryNode *l, SecondaryNode *r)
        : key(k), data(d), left(l), right(r) {}

template <class T>
TwoPhaseBST<T>::PrimaryNode::PrimaryNode(const std::string &k, PrimaryNode *l, PrimaryNode *r, SecondaryNode *rsn)
        : key(k), left(l), right(r), rootSecondaryNode(rsn) {}

template <class T>
TwoPhaseBST<T>::TwoPhaseBST() : root(NULL) {}

template <class T>
TwoPhaseBST<T>::~TwoPhaseBST() {
    destructNode(root);
}

template <class T>
TwoPhaseBST<T> &
TwoPhaseBST<T>::insert(const std::string &primaryKey, const std::string &secondaryKey, const T &data) {
    /* IMPLEMENT THIS */
    insertNode(primaryKey,secondaryKey,data,root);
    return *this;
}

template <class T>
void TwoPhaseBST<T>::insertNode(const std::string &primaryKey, const std::string &secondaryKey, const T &data, PrimaryNode* &pn) {
  if(!pn) {
    SecondaryNode* sn=NULL;
    sn=new SecondaryNode(secondaryKey, data, NULL, NULL);
    pn=new PrimaryNode(primaryKey, NULL, NULL, sn);
  }
  else if(primaryKey < pn->key) {
    insertNode(primaryKey,secondaryKey,data,pn->left);
  }
  else if(pn->key < primaryKey) {
    insertNode(primaryKey,secondaryKey,data,pn->right);
  }
  else {
    insertSecondaryNode(pn->rootSecondaryNode, secondaryKey, data);
  }
}

template <class T>
void TwoPhaseBST<T>::insertSecondaryNode(SecondaryNode* &sn, const std::string &secondaryKey, const T &data) {
  if(!sn) {
    sn=new SecondaryNode(secondaryKey, data, NULL, NULL);
  }
  else if(secondaryKey < sn->key) {
    insertSecondaryNode(sn->left,secondaryKey,data);
  }
  else if(sn->key < secondaryKey) {
    insertSecondaryNode(sn->right,secondaryKey,data);
  }
  else {
    //not supposed to happen according to the hw text
    //std::cout << "secondary tree -- we have a duplicate here" << std::endl;
  }
}

template <class T>
TwoPhaseBST<T> &
TwoPhaseBST<T>::remove(const std::string &primaryKey, const std::string &secondaryKey) {
    /* IMPLEMENT THIS */
    PrimaryNode* fpn=findPrimary(primaryKey,secondaryKey,root);
    if(fpn) {
      deleteSecondaryNode(secondaryKey,fpn->rootSecondaryNode);
    }
    return *this;
}

template <class T>
void TwoPhaseBST<T>::deleteSecondaryNode(const std::string &secondaryKey, SecondaryNode * &sn) {
  if(!sn) {
    return;
  }
  else if(secondaryKey < sn->key) {
    deleteSecondaryNode(secondaryKey,sn->left);
  }
  else if(sn->key < secondaryKey) {
    deleteSecondaryNode(secondaryKey,sn->right);
  }
  else if(sn->left && sn->right) {
    SecondaryNode *temp=findMin(sn->right);
    sn->key=temp->key;
    sn->data=temp->data;
    deleteSecondaryNode(sn->key,sn->right);
  }
  else {
    SecondaryNode *old=sn;
    sn=(sn->left != NULL) ? sn->left : sn->right;
    delete old;
  }
}

template <class T>
struct TwoPhaseBST<T>::SecondaryNode *TwoPhaseBST<T>::findMin(SecondaryNode *sn) const {
  if(!sn) {
    return NULL;
  }
  else if(!(sn->left)) {
    return sn;
  }
  return findMin(sn->left);
}

template <class T>
TwoPhaseBST<T> &TwoPhaseBST<T>::print(const std::string &primaryKey, const std::string &secondaryKey) {
    /* IMPLEMENT THIS */
    if(primaryKey.empty() && !secondaryKey.empty()) {
      return *this;
    }
    else {
      std::cout << "{";
      PrimaryPrinter(root,primaryKey,secondaryKey);
      std::cout  << "}" << std::endl;
      return *this;
    }
}

template <class T>
void TwoPhaseBST<T>::PrimaryPrinter(PrimaryNode *pn,const std::string &primaryKey, const std::string &secondaryKey) const {
  if(pn) {
    PrimaryPrinter(pn->left,primaryKey,secondaryKey);
    if(!primaryKey.empty() && !secondaryKey.empty()) {
      if(pn->key == primaryKey) {
        if(SecondaryCounter(pn->rootSecondaryNode, secondaryKey)) {
          if(primaryKey.empty() && pn->left) {
            std::cout << ", ";
          }
          std::cout << "\"" << pn->key << "\" : {";
          SecondaryPrinter(pn->rootSecondaryNode, secondaryKey);
          std::cout << "}";
          if(primaryKey.empty() && pn->right) {
            std::cout << ", ";
          }
        }
      }
    }
    else {
      if(primaryKey.empty() || (!primaryKey.empty() && pn->key == primaryKey)) {
        if(primaryKey.empty() && pn->left) {
          std::cout << ", ";
        }
        std::cout << "\"" << pn->key << "\" : {";
        SecondaryPrinter(pn->rootSecondaryNode, secondaryKey);
        std::cout << "}";
        if(primaryKey.empty() && pn->right) {
          std::cout << ", ";
        }
      }
    }
    PrimaryPrinter(pn->right,primaryKey,secondaryKey);
  }
}

template <class T>
int TwoPhaseBST<T>::SecondaryCounter(SecondaryNode *sn, const std::string &secondaryKey) const {
  int res=0;
  if(sn) {
    res+=SecondaryCounter(sn->left, secondaryKey);
    if(sn->key == secondaryKey) {
      res++;
    }
    res+=SecondaryCounter(sn->right, secondaryKey);
  }
  return res;
}

template <class T>
void TwoPhaseBST<T>::SecondaryPrinter(SecondaryNode *sn, const std::string &secondaryKey) const {
  if(sn) {
    SecondaryPrinter(sn->left, secondaryKey);
    if(secondaryKey.empty() && sn->left) {
      std::cout << ", ";
    }
    if(secondaryKey.empty() || (!secondaryKey.empty() && sn->key == secondaryKey)) {
      std::cout << "\"" << sn->key << "\" : \"" << sn->data << "\"";
    }
    if(sn->right && secondaryKey.empty()) {
      std::cout << ", ";
    }
    SecondaryPrinter(sn->right, secondaryKey);
  }
}

template <class T>
T *TwoPhaseBST<T>::find(const std::string &primaryKey, const std::string &secondaryKey) {
    /* IMPLEMENT THIS */
    PrimaryNode* fpn=findPrimary(primaryKey,secondaryKey,root);
    if(fpn) {
      SecondaryNode* fsn=findSecondary(secondaryKey,fpn->rootSecondaryNode);
      if(fsn) {
        return &(fsn->data);
      }
      else {
        return NULL;
      }
    }
    return NULL;
}

template <class T>
struct TwoPhaseBST<T>::PrimaryNode *TwoPhaseBST<T>::findPrimary(const std::string &primaryKey, const std::string &secondaryKey, PrimaryNode *pn) {
  if(!pn) {
    return NULL;
  }
  else if(primaryKey < pn->key) {
    return findPrimary(primaryKey,secondaryKey,pn->left);
  }
  else if(pn->key < primaryKey) {
    return findPrimary(primaryKey,secondaryKey,pn->right);
  }
  else {
    return pn;
  }
}

template <class T>
struct TwoPhaseBST<T>::SecondaryNode *TwoPhaseBST<T>::findSecondary(const std::string &secondaryKey, SecondaryNode *sn) {
  if(!sn) {
    return NULL;
  }
  else if(secondaryKey < sn->key) {
    return findSecondary(secondaryKey,sn->left);
  }
  else if(sn->key < secondaryKey) {
    return findSecondary(secondaryKey,sn->right);
  }
  else {
    return sn;
  }
}

template <class T>
void TwoPhaseBST<T>::destructNode(TwoPhaseBST::PrimaryNode * &root)
{
    if (root == NULL)
        return;

    destructNode(root->left);
    destructNode(root->right);

    destructNode(root->rootSecondaryNode);

    delete root;

    root = NULL;
}

template <class T>
void TwoPhaseBST<T>::destructNode(TwoPhaseBST::SecondaryNode * &root)
{
    if (root == NULL)
        return;

    destructNode(root->left);
    destructNode(root->right);

    delete root;

    root = NULL;
}

#endif //TWOPHASEBST_H
