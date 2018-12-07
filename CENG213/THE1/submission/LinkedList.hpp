#ifndef LINKEDLIST_HPP
#define	LINKEDLIST_HPP

#include <iostream>
#include "Node.hpp"

using namespace std;

/*....DO NOT EDIT BELOW....*/
template <class T>
class LinkedList {
private:
    Node<T>* head;
    int length;
public:

    LinkedList();
    LinkedList(const LinkedList<T>& ll);
    LinkedList<T>& operator=(const LinkedList<T>& ll);
    ~LinkedList();


    Node<T>* getHead() const;
    Node<T>* first() const;
    Node<T>* findPrev(const T& data) const;
    Node<T>* findNode(const T& data) const;
    void insertNode(Node<T>* prev, const T& data);
    void deleteNode(Node<T>* prevNode);
    void clear();
    size_t getLength() const;
    void print() const;
    void swap(int index1, int index2);
};

template <class T>
void LinkedList<T>::print() const {
    const Node<T>* node = first();
    while (node) {
        std::cout << node->getData();
        node = node->getNext();
    }
    cout << std::endl;
}

/*....DO NOT EDIT ABOVE....*/

/* TO-DO: method implementations below */

template <class T>
LinkedList<T>::LinkedList() {
  head=new Node<T>;
  length=0;
}

template <class T>
LinkedList<T>::LinkedList(const LinkedList<T>& ll) {
  head=new Node<T>;
  *this=ll;
  length=ll.getLength();
}

template <class T>
LinkedList<T>& LinkedList<T>::operator=(const LinkedList<T>& ll) {
  if(this != &ll) {
    clear();
    const Node<T>* r=ll.first();
    Node<T>* p=getHead();
    while(r) {
      insertNode(p, r->getData());
      r=r->getNext();
      p=p->getNext();
    }
  }
  length=ll.getLength();
  return *this;
}

template <class T>
LinkedList<T>::~LinkedList() {
  clear();
  delete head;
}

template <class T>
Node<T>* LinkedList<T>::getHead() const {
  return head;
}

template <class T>
Node<T>* LinkedList<T>::first() const {
  return head->getNext();
}

template <class T>
Node<T>* LinkedList<T>::findPrev(const T& data) const {
  Node<T>* p=first();
  if(!p) return NULL;
  if(p->getData() == data) {
    return head;
  }
  while(p->getNext()) {
    if(p->getNext()->getData() == data) {
      return p;
    }
    p=p->getNext();
  }
  return NULL;
}

template <class T>
Node<T>* LinkedList<T>::findNode(const T& data) const {
  Node<T>* p=first();
  while(p) {
    if(p->getData() == data) {
      return p;
    }
    p=p->getNext();
  }
  return NULL;
}

template <class T>
void LinkedList<T>::insertNode(Node<T>* prev, const T& data) {
  Node<T>* newNode=new Node<T>(data);
  if(prev->getNext()) {
    Node<T>* nextNode=prev->getNext();
    newNode->setNext(nextNode);
  }
  prev->setNext(newNode);
  length++;
}

template <class T>
void LinkedList<T>::deleteNode(Node<T>* prevNode) {
  if(prevNode) {
    if(prevNode == getHead()) {
      head=prevNode->getNext();
      delete prevNode;
    }
    else {
      Node<T>* tmp=prevNode->getNext();
      Node<T>* tmp2=NULL;
      if(tmp->getNext()) {
        tmp2=tmp->getNext();
      }
      prevNode->setNext(tmp2);
      delete tmp;
    }
    length--;
  }
}

template <class T>
void LinkedList<T>::clear() {
  Node<T>* dummy=getHead();
  while(dummy->getNext()) {
    Node<T>* tmp=dummy->getNext();
    dummy->setNext(tmp->getNext());
    delete tmp;
  }
  this->length=0;
}

template <class T>
size_t LinkedList<T>::getLength() const {
  return length;
}

template <class T>
void LinkedList<T>::swap(int index1, int index2) {
  if(index1 > length || index2 > length) return;
  if(index1 != index2) {
    Node<T> *walk, *walk2, *prev1, *prev2, *next1, *next2;
    int wai=0;
    walk=first();
    int early=min(index1, index2);
    int late=max(index1, index2);
    if(!early) {
      prev1=getHead();
    }
    else {
      prev1=walk;
      while(wai != early) {
        prev1=walk;
        walk=walk->getNext();
        wai++;
      }
    }
    if(late-early == 1) {
      //adjoint case
      walk2=walk->getNext();
      next2=walk2->getNext();
      prev1->setNext(walk2);
      walk2->setNext(walk);
      walk->setNext(next2);
    }
    else {
      walk2=walk;
      prev2=walk2;
      while(wai != late) {
        prev2=walk2;
        walk2=walk2->getNext();
        wai++;
      }
      next1=walk->getNext();
      next2=walk2->getNext();
      prev1->setNext(walk2);
      walk2->setNext(next1);
      prev2->setNext(walk);
      walk->setNext(next2);
    }
  }
}

/* end of your implementations*/
#endif
