#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
      METU CENG
      2017-2018 CENG140
      TAKE HOME EXAM - 2
      MUSTAFA OZAN ALPAY
      2309615
      Version: 1.1.1 (2018-06-02 18:44)
*/

struct node {
	int data;
	struct node *next;
};

struct message_node {
	int sender_id;
	int topic_id;
	int message_id;
	struct message_node *next;
};

struct topic_node {
	char *topic_name;
	int topic_id;
	struct node *follower_list;
	struct topic_node *next;
};

struct user_node {
	char *user_name;
	int user_id;
	struct node *followed_topics;
	struct message_node *inbox;
	struct node *myinbox;
	struct user_node *next;
};

typedef struct user_node user;
typedef struct topic_node topic;
typedef struct node node;
typedef struct message_node message;

void add_user(user **users, char *uname, int *ucount) {
	user *curr, *new;
	*ucount=*ucount+1;
	if(*users) {
		curr=*users;
		for(;(curr->next)!=NULL;curr=curr->next);
	}
	new=(user*)malloc(sizeof(user));
	new->user_name=uname;
	new->user_id=*ucount;
	new->next=NULL;
	new->followed_topics=NULL;
	new->inbox=NULL;
	new->myinbox=NULL;
	if(!(*users)) {
		*users=new;
	}
	else {
		curr->next=new;
	}
}

int getUserID(user **users,char *uname) {
	user *curr;
	int i, uid;
	curr=*users;
	for(i=1;;i++,curr=curr->next) {
		if(strcmp(uname,curr->user_name) == 0) {
			uid=curr->user_id;
			break;
		}
	}
	return uid;
}

int checkThread(topic **topicsp, char *topic_name) {
	topic *curr;
	if(*topicsp) {
		curr=*topicsp;
		while(curr) {
			if(strcmp(topic_name,curr->topic_name) == 0) {
				return curr->topic_id;
			}
			else {
				if(curr->next) {
					curr=curr->next;
				}
				else {
					return 0;
				}
			}
		}
	}
	return 0;
}

int lastThreadID(topic **topicsp) {
	topic *curr;
	if(*topicsp) {
		curr=*topicsp;
		while(curr->next) curr=curr->next;
		return curr->topic_id;
	}
	else {
		return 0;
	}
}

void createThread(topic **topicsp, char *topic_name) {
	topic *new, *curr;
	new=(topic*)malloc(sizeof(topic));
	new->topic_name=topic_name;
	new->next=NULL;
	new->follower_list=NULL;
	new->topic_id=lastThreadID(topicsp)+1;
	if(*topicsp) {
		curr=*topicsp;
		while(curr->next) curr=curr->next;
		curr->next=new;
	}
	else {
		*topicsp=new;
	}
}

void subscribeUser(user **users, int uid, int topic_id) {
	user *ucurr;
	node *topics, *new;
	ucurr=*users;
	for(;ucurr->user_id!=uid;ucurr=ucurr->next);
	topics=ucurr->followed_topics;
	new=(node*)malloc(sizeof(node));
	new->data=topic_id;
	new->next=NULL;
	if(topics) {
		while(topics->next) topics=topics->next;
		topics->next=new;
	}
	else {
		(ucurr->followed_topics)=new;
	}
}

void subscribersList(topic **topicsp, int topic_id, int uid) {
	node *new, *subscribers;
	topic *curr;
	curr=*topicsp;
	for(;curr->topic_id!=topic_id;curr=curr->next);
	subscribers=curr->follower_list;
	new=(node*)malloc(sizeof(node));
	new->data=uid;
	new->next=NULL;
	if(subscribers) {
		while(subscribers->next) subscribers=subscribers->next;
		subscribers->next=new;
	}
	else {
		(curr->follower_list)=new;
	}
}

void subscribe(user **users, int uid, topic **topicsp, char *topic_name) {
	int topic_id;
	if(!checkThread(topicsp,topic_name)) {
		createThread(topicsp,topic_name);
	}
	topic_id=checkThread(topicsp,topic_name);
	subscribeUser(users,uid,topic_id);
	subscribersList(topicsp,topic_id,uid);
}

void attachInbox(node *messages, user *curr, node *temp, int *ch, int msgid) {
	node *new;
	new=(node*)malloc(sizeof(node));
	new->data=msgid;
	new->next=NULL;
	if(!messages) {
		curr->myinbox=new;
	}
	else {
		while(messages->next) {
			if(messages->next->data > msgid) {
				temp=messages->next;
				new->next=temp;
				messages->next=new;
				break;
			}
			messages=messages->next;
		}
		if(!(messages->next)) {
				messages->next=new;
		}
		*ch=1;
	}
}

void updateInbox(user **usersp, message **msgp, message *sent) {
	int uid, thid, msgid, ch;
	user *curr;
	node *topics, *messages, *temp;
	uid=sent->sender_id;
	thid=sent->topic_id;
	msgid=sent->message_id;
	curr=*usersp;
	temp=NULL;
	while(curr) {
		ch=0;
		topics=curr->followed_topics;
		messages=curr->myinbox;
		while(topics) {
			if(topics->data == thid) {
				attachInbox(messages,curr,temp,&ch,msgid);
				break;
			}
			topics=topics->next;
		}
		if(!ch && curr->user_id == uid) {
			attachInbox(messages,curr,temp,&ch,msgid);
		}
		curr=curr->next;
	}
}

void sendMessage(user **usersp, message **msgp, int uid, int thid, int *mcount) {
	int ms;
	message *new, *curr;
	ms=*mcount;
	new=(message*)malloc(sizeof(message));
	new->sender_id=uid;
	new->topic_id=thid;
	new->next=NULL;
	new->message_id=(ms+1);
	if(!ms) {
		*msgp=new;
	}
	else {
		curr=*msgp;
		while(curr->next) curr=curr->next;
		curr->next=new;
	}
	ms++;
	*mcount=ms;
	updateInbox(usersp,msgp,new);
}

int getSenderID(message **msgp, int mid) {
	message *messages;
	messages=*msgp;
	while(messages->message_id!=mid) {
		messages=messages->next;
	}
	return messages->sender_id;
}

int getThreadID(message **msgp, int mid) {
	message *messages;
	messages=*msgp;
	while(messages->message_id!=mid) {
		messages=messages->next;
	}
	return messages->topic_id;
}

void cleanInbox(message **msgp, user *user, int thid) {
	node *messages, *prev;
	int fmi, ch;
	messages=user->myinbox;
	if(messages) {
		fmi=messages->data;
		ch=getThreadID(msgp,fmi);
		if(ch==thid) {
			user->myinbox=messages->next;
			cleanInbox(msgp,user,thid);
		}
		else {
			prev=messages;
			messages=messages->next;
			while(messages) {
				ch=getThreadID(msgp,messages->data);
				if(ch==thid) {
					prev->next=messages->next;
					messages=messages->next;
				}
				else {
					prev=messages;
					messages=messages->next;
				}
			}
		}
	}
}

void unsubscribeUser(user **usersp, topic **topicsp, message **msgp, int uid, int thid) {
	topic *curr;
	node *followers, *ftemp, *fprev;
	user *users;
	/*remove user id from topic followers*/
	curr=*topicsp;
	while(curr->topic_id!=thid) {
		curr=curr->next;
	}
	followers=curr->follower_list;
	if(followers->data==uid) {
		ftemp=followers->next;
		free(followers);
		curr->follower_list=ftemp;
	}
	else {
		ftemp=followers;
		fprev=followers;
		while(ftemp->data!=uid) {
			fprev=ftemp;
			ftemp=ftemp->next;
		}
		fprev->next=ftemp->next;
		free(ftemp);
	}
	/*end of removal of user id from topic followers*/
	/*remove topic from the followed topics list*/
	users=*usersp;
	while(users->user_id!=uid) {
		users=users->next;
	}
	followers=users->followed_topics;
	if(followers->data==thid) {
		ftemp=followers->next;
		free(followers);
		users->followed_topics=ftemp;
	}
	else {
		ftemp=followers;
		while(ftemp->data!=thid) {
			fprev=ftemp;
			ftemp=ftemp->next;
		}
		fprev->next=ftemp->next;
		free(ftemp);
	}
	/*end of removal of topic from the followed topics list*/
	/*remove all messages of that topic from users inbox*/
	cleanInbox(msgp,users,thid);
	/*end of removal of all messages of that topic from users inbox*/
}

void delete_user(user **usersp, message **msgp, int uid) {
	user *users, *uprev;
	message *messages;
	node *inbox, *previ;
	int sender, mid;
	users=*usersp;
	/*delete the user from users list*/
	if(uid == users->user_id) {
		uprev=users;
		users=users->next;
		*usersp=users;
		free(uprev);
	}
	else {
		while(users->user_id!=uid) {
			uprev=users;
			users=users->next;
		}
		uprev->next=users->next;
		free(users);
	}
	/*end of deleting the user from users list*/
	/*delete all messages from from that user from other users inboxes*/
	messages=*msgp;
	while(messages) {
		users=*usersp;
		mid=messages->message_id;
		sender=getSenderID(msgp,mid);
		if(sender == uid) {
			/*lets delete from everywhere*/
			while(users) {
				inbox=users->myinbox;
				if(inbox) {
					if(inbox->data==mid) {
						users->myinbox=inbox->next;
						free(inbox);
					}
					else {
						while(inbox) {
							if(inbox->data==mid) {
								previ->next=inbox->next;
							}
							previ=inbox;
							inbox=inbox->next;
						}
					}
				}
				users=users->next;
			}
		}
		messages=messages->next;
	}
	/*end of deleting all messages from from that user from other users inboxes*/
}

void decipher(char *line, user **usersp, topic **topicsp, message **msgp, int *ucount, int *mcount) {
	int i, p, uid, thid;
	char *comm, *uname, *thread;
	i=p=0;
	comm=(char*)malloc(sizeof(char)*28);
	while(line[i] != ' ') {
		comm[p]=line[i];
		p++, i++;
	}
	comm=(char*)realloc(comm,sizeof(char)*(p+1));
	comm[p]='\0';
	i++;
	p=0;
	uname=(char*)malloc(sizeof(char)*21);
	if(!strcmp(comm,"ADD") || !strcmp(comm,"DELETEUSER")) {
		/*adding or deleting a user*/
		while(line[i] != '\n') {
			uname[p]=line[i];
			p++, i++;
		}
		uname=(char*)realloc(uname,sizeof(char)*(p+1));
		uname[p]='\0';
		if(!strcmp(comm,"ADD")) {
			add_user(usersp,uname,ucount);
		}
		else {
			/*deleteuser*/
			uid=getUserID(usersp,uname);
			delete_user(usersp,msgp,uid);
		}
	}
	else {
		/*other commands*/
		while(line[i] != ' ') {
			uname[p]=line[i];
			p++, i++;
		}
		uname=(char*)realloc(uname,sizeof(char)*(p+1));
		uname[p]='\0';
		i++;
		p=0;
		thread=(char*)malloc(sizeof(char)*21);
		while(line[i] != '\n') {
			thread[p]=line[i];
			p++, i++;
		}
		thread=(char*)realloc(thread,sizeof(char)*(p+1));
		thread[p]='\0';
		uid=getUserID(usersp,uname);
		if(!strcmp(comm,"SUBSCRIBE")) {
			subscribe(usersp,uid,topicsp,thread);
		}
		else if(!strcmp(comm,"UNSUBSCRIBE")) {
			thid=checkThread(topicsp,thread);
			unsubscribeUser(usersp,topicsp,msgp,uid,thid);
		}
		else if(!strcmp(comm,"SEND")) {
			thid=checkThread(topicsp,thread);
			sendMessage(usersp,msgp,uid,thid,mcount);
		}
	}
}

int main() {
	char line[70];
	user *users, **usersp, *ucurr;
	topic *topics, **topicsp;
	message *messages, **msgp;
	node *mid;
	int uid, ucount, *ucp, mcount, *mcp;
	ucount=0;
	mcount=0;
	users=NULL;
	topics=NULL;
	messages=NULL;
	ucp=&ucount;
	mcp=&mcount;
	usersp=&users;
	topicsp=&topics;
	msgp=&messages;
	while(fgets(line,70,stdin)) {
		decipher(line,usersp,topicsp,msgp,ucp,mcp);
	}
	ucurr=users;
	while(ucurr) {
		uid=ucurr->user_id;
		mid=ucurr->myinbox;
		printf("%d:",uid);
		while(mid) {
			printf(" %d",mid->data);
			mid=mid->next;
		}
		printf("\n");
		ucurr=ucurr->next;
	}
	return 0;
}
