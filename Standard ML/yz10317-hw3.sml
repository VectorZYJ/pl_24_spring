(* ---------- 4. ML Function Signature ---------- *)


(* ----- 4.1 test1 ----- *)
fun test1 (x, []) = []
  | test1 (x, y) = [x];

(* ----- 4.2 test2 ----- *)
fun test2 f [] = []
  | test2 f (x :: xs) = f x;

(* ----- 4.3 test3 ----- *)
fun test3 f [] y = y
  | test3 f (x :: xs) y = f (x, y);

(* ----- 4.4 test4 ----- *)
fun test4 f [] y = y
  | test4 f (x :: xs) y = f (x, test4 f y y);

(* ----- 4.5 test5 ----- *)
datatype ('a, 'b) tree = Leaf of 'a
                       | Node of 'a * 'b;
fun test5 (Node (x, y)) f g = Node (x, g (g (f x) y) x)
  | test5 (Leaf x) f g = Leaf x;




(* ---------- 5. Getting Started with ML ---------- *)


(* ----- 5.1 scheme_intr ----- *)
exception InvalidCommand;
fun scheme_intr ([], str) = raise InvalidCommand
  | scheme_intr ((x :: xs), str) = 
    case str of 
        "car" => [x]
    |   "cdr" => xs
    |   _ => raise InvalidCommand;

scheme_intr ([1, 2, 3], "cdr");
scheme_intr ([1, 2, 3], "car");


(* ----- 5.2 half_sum ----- *)
fun half_sum lis n = 
    foldl (fn (a, b) => a + b) 0 (map (fn i => i div 2) lis) = n;

half_sum [1, 2, 3, 8, 6, 4] 11;


(* ----- 5.3 max_profit ----- *)
fun max_profit lis = 
    let fun max (a, b) = if a > b then a else b
        fun dp [] pre1 pre2 = max (pre1, pre2)
        |   dp (x :: xs) pre1 pre2 = dp xs (max (pre2+x, pre1)) pre1
    in
        dp lis 0 0
    end;

max_profit [1, 2, 3, 1];
max_profit [2, 7, 9, 3, 1];


(* ----- 5.4 skip_num ----- *)
fun skip_num (lis, n) =
    let fun skip_num_helper [] n cnt = []
        |   skip_num_helper (x :: xs) n cnt = 
                if cnt mod (n+1) = 0 then x :: skip_num_helper xs n (cnt+1)
                else skip_num_helper xs n (cnt+1)
    in
        skip_num_helper lis n 0
    end;

skip_num ([1, 2, 3, 4, 5], 2);
skip_num ([1], 4);


(* ----- 5.5 bind ----- *)
fun bind (SOME x) (SOME y) f = SOME (f x y)
  | bind NONE (SOME y) f = NONE
  | bind (SOME x) NONE f = NONE
  | bind NONE NONE f = NONE;

fun add x y = x + y;
bind (SOME 4) (SOME 3) add;
bind (SOME 4) NONE add;


(* ----- 5.6 getitem ----- *)
fun getitem n [] = NONE
  | getitem 1 (x :: xs) = SOME x
  | getitem n (x :: xs) = getitem (n-1) xs;

getitem 2 [1,2,3,4];
getitem 5 [1,2,3,4];


(* ----- 5.7 lookup ----- *)
fun lookup [] (str: string) = NONE
  | lookup ((s, i: int) :: xs) (str: string) = 
        if s = str then SOME i
        else lookup xs str;

lookup [("hello",1), ("world", 2)] "hello";
lookup [("hello",1), ("world", 2)] "world";
lookup [("hello",1), ("world", 2)] "he";


(* ----- 5.8 spiral_sort ----- *)
fun spiral_sort lis = 
    let fun quicksort op < [] = []
          | quicksort op < [x] = [x]
          | quicksort op < (a :: bs) =
                let fun partition (left, right, []) = (left, right)
                      | partition (left, right, x :: xs) =
                            if x < a
                            then partition (x :: left, right, xs)
                            else partition (left, x :: right, xs)
                    val (left, right) = partition ([], [], bs)
                in
                    quicksort op < left @ (a :: quicksort op < right)
                end

        fun length [] = 0
          | length (x :: xs) = 1 + length xs

        fun split (lis1, lis2, 0) = (lis1, lis2)
          | split ([], lis2, n) = ([], lis2)
          | split (x :: xs, lis2, n) = split (xs, lis2 @ [x], n-1)

        fun merge ([], lis2) = lis2
          | merge (lis1, []) = lis1
          | merge (x :: xs, y :: ys) = x :: (y :: merge (xs, ys))
    in
        merge (split (quicksort op < lis, [], (length lis + 1) div 2))
    end;

spiral_sort [1, 2, 3, 4, 5, 6, 7];
spiral_sort [3, 6, 1, 7, 5, 2, 4];
spiral_sort [9, 2, 6, 5, 6];
spiral_sort [1, 2, 3, 4];






(* ---------- 6. Circular Stack in ML ---------- *)

(* ----- 6.2 Data Structure ----- *)

signature STACKS =
sig
  type stack
  exception Underflow
  val empty : int -> stack
  val push : int * stack -> stack
  val pop : stack -> int * stack
  val isEmpty : stack -> bool
end

structure Stacks: STACKS =
struct
  type stack = int * (int list) list
  exception Underflow
  fun empty size = (0, List.tabulate (size, fn _ => []))
  fun push (num, (pos, stacklist)) = 
    let 
      val left = List.take (stacklist, pos)
      val update = List.nth (stacklist, pos)
      val right = List.drop (stacklist, pos + 1)
    in
      if (pos = List.length stacklist - 1) then (0, left @ [num :: update] @ right)
      else (pos + 1, left @ [num :: update] @ right)
    end
  fun pop (pos, stacklist) = 
    case List.nth (stacklist, pos) of
      [] => raise Underflow
    | _ =>
        let
          val update = List.nth (stacklist, pos)
          val num = List.hd update
          val updated = List.tl update
          val left = List.take (stacklist, pos)
          val right = List.drop (stacklist, pos + 1)
        in
          if (pos = List.length stacklist - 1) then (num, (0, left @ [updated] @ right))
          else (num, (pos + 1, left @ [updated] @ right))
        end
  fun isEmpty (pos, stacklist) = 
    List.all (fn x => List.null x) stacklist
end


(* Test case for Data Structure part*)

val emptyStack = Stacks.empty 3;
Stacks.isEmpty emptyStack;
val stack1 = Stacks.push (1, emptyStack);
val stack2 = Stacks.push (2, stack1);
val stack3 = Stacks.push (3, stack2);
val stack4 = Stacks.push (4, stack3);
val (popped1, stack5) = Stacks.pop stack4;
val (popped2, stack6) = Stacks.pop stack5;
val (popped3, stack7) = Stacks.pop stack6;
Stacks.isEmpty stack7;




(* ----- 6.3 Functor ----- *)

signature STACKTYPE = 
sig
  type element
end

signature NEWSTACKS =
sig
  type stackElement
  type stack
  exception Underflow
  val empty : int -> stack
  val push : stackElement * stack -> stack
  val pop : stack -> stackElement * stack
  val isEmpty : stack -> bool
end

functor MakeCircularStack (Lt: STACKTYPE) : NEWSTACKS =
struct
  type stackElement = Lt.element
  type stack = int * (stackElement list) list
  exception Underflow

  fun empty size = (0, List.tabulate (size, fn _ => []))
  fun push (elem, (pos, stacklist)) = 
    let 
      val left = List.take (stacklist, pos)
      val update = List.nth (stacklist, pos)
      val right = List.drop (stacklist, pos + 1)
    in
      if (pos = List.length stacklist - 1) then (0, left @ [elem :: update] @ right)
      else (pos + 1, left @ [elem :: update] @ right)
    end
  fun pop (pos, stacklist) = 
    case List.nth (stacklist, pos) of
      [] => raise Underflow
    | _ =>
        let
          val update = List.nth (stacklist, pos)
          val elem = List.hd update
          val updated = List.tl update
          val left = List.take (stacklist, pos)
          val right = List.drop (stacklist, pos + 1)
        in
          if (pos = List.length stacklist - 1) then (elem, (0, left @ [updated] @ right))
          else (elem, (pos + 1, left @ [updated] @ right))
        end
  fun isEmpty (pos, stacklist) = 
    List.all (fn x => List.null x) stacklist
end


(* Test case for Functor part*)

structure String : STACKTYPE = 
struct
  type element = string
end

structure StringCircularStack = MakeCircularStack(String);

val emptyStack = StringCircularStack.empty 3;
StringCircularStack.isEmpty emptyStack;
val stack1 = StringCircularStack.push ("1", emptyStack);
val stack2 = StringCircularStack.push ("2", stack1);
val stack3 = StringCircularStack.push ("3", stack2);
val stack4 = StringCircularStack.push ("4", stack3);
val (popped1, stack5) = StringCircularStack.pop stack4;
val (popped2, stack6) = StringCircularStack.pop stack5;
val (popped3, stack7) = StringCircularStack.pop stack6;
StringCircularStack.isEmpty stack7;