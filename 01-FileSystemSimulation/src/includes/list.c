/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 8 mars 2017
=========================================================*/

#include "list.h"

// NODE ---------------------------------------------------
Node newNode( void * val ){
    Node n = (Node)malloc(sizeof(struct node));
    if( !n ) return NULL;
    
    n->val = val;
    n->prev = NULL;
    n->next = NULL;
    
    // Default methods
    n->copy = NULL;
    n->equal = NULL;
    n->toString = NULL;
    n->del = NULL;
    
    return n;
}

Node copy( Node n ){
    void * v = n->val;
    if( n->copy != NULL )
        v = (*n->copy)( n->val );
    
    Node c = newNode( v );
    
    // copy methods
    c->copy = n->copy;
    c->equal = n->equal;
    c->toString = n->toString;
    c->del = n->del;
    
    return c;
}

int equal( Node a, Node b ){
    if( !a->equal || !b->equal ){
        return (a->val == b->val);
    }

    return (*a->equal)( a->val, b->val );
}

char * toString( Node n ){
    if( !n->toString ) return "";
    
    return (*n->toString)( n->val );
}

void del( Node n ){
    if( !n->del ) return ;

    (*n->del)( n->val );
    free(n);
}



// LIST ---------------------------------------------------
List newList(){    
    List ns = (List)malloc(sizeof(struct list));
    if( !ns ) return NULL;
    
    ns->card = 0;
    ns->head = NULL;
    ns->tail = NULL;
    return ns;
}

int enlist( List ns, Node n ){
    if( !ns ||!n ) 
        return 0;

    if( !(ns->head) )    // first elem
        ns->head = n;
    n->prev = ns->tail;
    if( ns->tail )
        ns->tail->next = n;
    ns->tail = n;
    ns->card++;
    return 1;
}

int delist( List ns, Node n ){
    Node d = find( ns, n );
    if( !d ) return 0;
    
    if( !d->prev )                  // del head
        ns->head = d->next;
    else
        d->prev->next = d->next;
    if( !d->next )
        ns->tail = d->prev;
    else
        d->next->prev = d->prev;
    
    ns->card--;
    del(d);
    
    return 1;
}

List copyList( List ns ){
    List as = newList();
    if( !ns  || !ns->card )
        return as;
    Node c = ns->head;
    while( c ){
        enlist( as, copy(c) );
        c = c->next;
    }
    return as;
}

List joinList( List as, List bs ){
    List cs = newList();
    if( !as || !bs )
        return cs;
    cs = copyList(as);
    Node c = bs->head;
    while( c ){
        enlist( cs, copy(c) );
        c = c->next;
    }
    return cs;
}

Node pop( List ns ){
    Node a = ns->head;
    Node b = copy(a);
    delist( ns, a );
    return b;
}

Node cut( List ns ){
    Node a = ns->tail;
    Node b = copy(a);
    delist( ns, a );
    return b;
}

int equalList( List as, List bs ){
    if( !as || !bs || (as->card != bs->card ) )
        return 0;

    Node a = as->head;
    Node b = bs->head;
    while( a && b ){
        if( !equal( a,b ) )
            return 0;
        a = a->next;
        b = b->next;
    }
    return 1;
}

Node find( List ns, Node n ){
    Node c = ns->head;
    while( c ){
        if( equal( n, c ) ){
            return c;
        }
        c = c->next;
    }
    return NULL;
}

char * toStringList( List ns ){
    char * s = "[";
    Node c = ns->head;
    while( c ){
        s = concat( s, toString( c ) );
        c = c->next;
        if( c ) s = concat( s, ", " );
    }
    s = concat( s, "]" );
    return s;
}
