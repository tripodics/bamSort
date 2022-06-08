/// Qiksort "bamSort"
// partition (with minimal moving, using empty slot)..

// Hello World



String title=  "bamSort"
  , subtitle=  "qiksort partitioning w/o swaps  (use empty slot)."
  , news="..."
  , helpmsg=   "t: test, q: quit, ? for help"
  , author=    "ProfessorBAM.com"
  , version=   "bamSort-2603a";
// ++++++   TO DO:
// +++ Add timing checks!
// +++ logging, if (bug ....
// +++ ? select int/float/double
// 2602k:  Prepare for other sorting algortimss:  i, s, b
// 2529g:  variable array size,  variable data range.




char type='e';
int many=10, min=1, max=100;
//--  int[] e = new int[many];
int[] a = new int[many];
int tx=10, ty=50, tl=0, th=15, top=70, tymax=height-60;

int countdown=5, step=0, move=0;
int bug=7;
int partition, p1=-1;
int pvalue;
//
void setup() {
  size(800, 600);
  preset(a, 0, many-1);
}
void draw() {
  background(255);
  fill(0);
  head();
  fill(0, 0, 255);
  show( a, 0, many-1 );        // Display the array.
  //--??  noLoop();
}

void ranset( int[] a, int lo, int hi ) {    // Fill with random values. //
  for (int j=lo; j<=hi; ++j) {
    a[j] = int( random(min, max) );
    loop();
  }
}
void preset( int[] a, int lo, int hi ) {
  // Fill with preset values. //
  int aa[] = { 5, 10, 4, 9, 3, 8, 2, 7, 1, 6 };
  for (int i=lo; i<=hi; ++i) {
    a[i] = aa[i%10];            // Repeated pattern.
    loop();
  }
}
void worst( int[] a, int first, int last ) {
}

void test( int[]  e, int first, int last ) {
  step=0;
  println( "test( e,", first, last, ")" );
  log( e, first, last );
  println( "BEGIN:" );
  if (type == 'e') emptySort( e, first, last );
  else if (type == 'b') bubbleSort( e, first, last );
  else if (type == 'i') insertionSort( e, first, last );
  else if (type == 's') selectionSort( e, first, last );
  else emptySort( e, first, last );
  //
  text( "pivot:  " +pvalue+ "["+p1+"]", 220, 40 );
  text( min+ ".." +max, 220, 40 );
  println( "emptySort( e", first, last, ")  ", step+" steps" );
  //--??  noLoop();
  check(a, first, last);
}
void check( int[]  e, int first, int last ) {
  // check:
  String s, ss, tab="    ";
  int errors=0;
  s=  "check( e, " +first+ ".." +last+ ")";
  news=  s;
  println( s );
  for (int i=first; i<last; ++i) {    // n-1 pairs.
    if (e[i] > e[i+1]) {
      background(255, 0, 0);
      ss=  "a[" +i+ ".." +(i+1)+ "]";
      s = e[i]+ " > " +e[i+1];
      news += "\n  "+ss+tab+s;
      println( ss + tab + s  );
      ++errors;
    }
  }
  if (errors==0) s="OK";
  else s = "\n"+errors+" errors";
  println( s );
  news += s;
}


/*
    DOWN                      UP
   a[lo] is empty            a[hi] is empty
   check a[hi]               check a[lo]
   if >= pivot               if <= pivot
     hi--                      lo++
   else move a[hi] DOWN      else move a[hi] UP
     empty a[lo] = a[hi]       empty a[hi] = a[lo]
             lo++    hi--              hi--    lo++
     down = false              down = true
    //UP is next!              // DOWN is next!
*/
void emptySort( int[] a, int first, int last ) {
  // Sort the (sub) array between a[first] & a[last]. //
  // Avoid multiple swapping; always move into "empty" slot.
  int lo=first, hi=last;
  int pivot=  a[lo];
  boolean down=true;  // Find a smaller value to move DOWN to lo.
  //--  partition=lo;
  step++;
  //--  show( a, first, last );
  println( "\n==== bamSort( a, ", first, last );

  while (lo<hi) {
    if (down) {
      //--  if ((bug&2)>0) print( "*** DOWN ***", lo, hi );
      if (a[hi]>=pivot) {
        if ((bug&1)>0) println( " a[" +hi+ "] = " +a[hi]+ " > "+pivot+ "  OK" );
        hi--;  // a[hi] is OK.
      } else {
        if ((bug&2)>0) println( "  Move a["+hi+"] "+a[hi]+
          " DOWN into a["+lo+"];  a["+hi+"] now empty." );
        a[lo] = a[hi];     // Move a[hi] down into a[lo].
        a[hi] = 0;         // a[hi] is now empty,    (UNNECESSARY).
        lo++;              // Check for next a[lo] to move UP.
        down=false;
      }
    } else {
      //--  if ((bug&2)>0) print( "***  UP  ***", lo, hi );
      if (a[lo]<=pivot) {
        if ((bug&1)>0) println( "a[" +lo+ "] = " +a[lo]+ " < "+pivot+ "  OK" );
        lo++;  // a[lo] is OK.
      } else {
        //        a[hi--] = a[lo];     // Move a[lo] UP into a[hi].
        if ((bug&2)>0) println( "  Move a["+lo+"] "+a[lo]+
          " UP into a["+hi+"]", a[lo] );
        a[hi] = a[lo];     // Move a[lo] up into a[hi].
        a[lo] = 0;         // a[lo] is now empty
        hi--;              // Check next a[hi] to move DOWN.
        down=true;
      }
    }
  }
  //--  if ((bug&4)>0)
  //--  if (--countdown<0) exit();
  partition = lo;    // ?? also == hi
  a[partition] = pivot;
  if ((bug&1)>0) println( "----> Insert ", pivot, " at a[" +partition+ "], after:  ",
    step+" steps" );
  //
  if (partition-first > 1) log( a, first, partition-1 );
  if (last - partition>  1) log( a, partition+1, last );

  if (partition-first > 1) emptySort( a, first, partition-1);
  if (last - partition>  1) emptySort( a, partition+1, last);
  //--  println( "Array:  ", a[0], "...", a[many-1] );
  //--  println( a );
  log( a, first, partition-1 );
}


void selectionSort( int[] a, int first, int last ) {
  // Sort the (sub) array between a[first] & a[last]. //
  if (first != 0) return;
  int n=last+1;    // ASSUME first=0;
  int m=n, big;       // first with complete array.
  while (m>1) {              // Shrink the array!
    big = findBig( a, m );   // Index of biggest.
    swap( a, big, m-1 );     // Move it to end.
    m=m-1;                   // Shrink the array!
  }
  loop();
}
int findBig( int[] a, int n ) {  // Return index of biggest. //
  int j, k=0;
  for (j=0; j<n; ++j) {
    if (a[j] > a[k]) k=j;
  }
  return k;      // Index of biggest.
}
void swap( int[] a, int p, int q ) {  // Swap a[p] with a[q] //
  int tmp=a[p];
  a[p]=a[q];
  a[q]=tmp;
}

void insertionSort( int[] a, int first, int last ) {  // Sort the array. //
}

void bubbleSort( int[] a, int first, int last ) {  // Sort the array. //
}

void log( int[] a, int first, int last ) {    // Display values in (subarray). //
  print( "a[" +first+ ".." +last+ "]  " );
  for (int j=first; j<=last; ++j) {
    if (j>=0) print( " ", a[j] );
  }
  println();
}

void show( int[] a, int first, int last ) {
  // Display all values. //
  tx=10;
  ty=top;
  tl=0;
  th=16;
  tymax=  height-20 -10*th;
  textSize(14);
  fill(127);
  for (int j=first; j<-10; ++j) {
    text( "a["+j+"]", tx, ty+th*tl++);
  }
  tx=50;
  ty=top;
  tl=0;
  fill(0);
  for (int j=first; j<=last; ++j) {
    if (j>1 && a[j] < a[j-1]) fill(127);    // sort error:  grey
    text( ""+a[j], tx, ty);
    ty +=  th;
    tl++;
    fill(0);
    if (j%10 == 9) {
      ty += th/2;
      if (ty > tymax) {
        tx += 60;
        ty=  top;
        tl=0;
      }
    }
  }
}

void head() {
  tx=10;
  ty=20;
  th=16;
  tl=1;
  textSize(20);
  text( title, tx, ty);
  textSize(14);
  text( version, tx, height-th*2);
  text( author, tx, height-th);
  text( subtitle, tx+10, ty+th*tl++ );
  //--  text( subsub, tx+10, ty+th*tl++);
  fill(255, 0, 255);
  text( helpmsg, tx+10, ty+th*tl++);
  //--  text( helpmsg, 300, 20);
  tx=320;
  ty=20;
  if (key=='?') {
    help();
    return;
  }
  fill(0,0,255);
  text( news, tx, ty);
  fill(0);
  tx=width-200;
  ty=20;
  tl=1;
  text( "type:    " +type, tx, ty+th*tl++ );
  text( "[" +0+ ".." +(many-1)+ "]  range:  "+min+ ".." +max, tx, ty+th*tl++ );
  text( "steps:  " +step+ ", moves: " +move, tx, ty+th*tl++ );
  text( "bug:    " +bug, tx, ty+th*tl++ );
  text( "tymax:    " +tymax, tx, ty+th*tl++ );
}
void help() {
  int tx=300, ty=20, th=15, tl=1;
  fill(255, 0, 255);
  text( "r:  randomize the array, p: preset, q: quit", tx, ty+th*tl++ );
  text( "t: test the sorting algorithm.", tx, ty+th*tl++ );
  text( "e: emptySort (default), i: insertion sort, s: selection sort, b: bubble-sort", tx, ty+th*tl++ );
  text( "(toggle debugging with 'd' & 't')", tx, ty+th*tl++);
}
//+++++ vertical list.
// Add a method to display one pair, e.g.  q:  quit
//++++ make tx, ty, etc. GLOBAL

void keyPressed() {
  if (key == 'q')  exit();
  if (key == 'r')  ranset( a, 0, many-1 );
  if (key == 'p')  preset( a, 0, many-1 );
  if (key == 'w')  worst( a, 0, many-1 );
  //
  if (key == 'e')  type='e';    // Empty-sort
  if (key == 's')  type='s';    // Selection-sort
  if (key == 'i')  type='i';    // Insertion-sort
  if (key == 'b')  type='b';    // Bubble-sort
  //
  if (key == 'c')  check( a, 0, many-1 );
  if (key == 't')  test( a, 0, many-1 );
  if (key == ' ') {
    ranset( a, 0, many-1 );
    test( a, 0, many-1 );
  }
  //
  if (key == '1') bug = bug ^ 1;
  if (key == '2') bug = bug ^ 2;
  if (key == '-') many = many>1 ? many/2 : 1;
  if (key == '+') {
    many += 10;
    a = new int[many];
  }
  if (key == '*') {
    many *= 2;
    a = new int[many];
  }
}
