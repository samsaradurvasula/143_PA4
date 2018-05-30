(* The Game of Life
   Tendo Kayiira, Summer '95
   With code taken from /private/cool/class/examples/cells.cl
 This introduction was taken off the internet. It gives a brief
 description of the Game Of Life. It also gives the rules by which
 this particular game follows.
	Introduction
   John Conway's Game of Life is a mathematical amusement, but it
   is also much more: an insight into how a system of simple
   cellualar automata can create complex, odd, and often aesthetically
   pleasing patterns. It is played on a cartesian grid of cells
   which are either 'on' or 'off' The game gets it's name from the
   similarity between the behaviour of these cells and the behaviour
   of living organisms.
 The Rules
  The playfield is a cartesian grid of arbitrary size. Each cell in
  this grid can be in an 'on' state or an 'off' state. On each 'turn'
  (called a generation,) the state of each cell changes simultaneously
  depending on it's state and the state of all cells adjacent to it.
   For 'on' cells,
      If the cell has 0 or 1 neighbours which are 'on', the cell turns
        'off'. ('dies of loneliness')
      If the cell has 2 or 3 neighbours which are 'on', the cell stays
        'on'. (nothing happens to that cell)
      If the cell has 4, 5, 6, 7, 8, or 9 neighbours which are 'on',
        the cell turns 'off'. ('dies of overcrowding')
   For 'off' cells,
      If the cell has 0, 1, 2, 4, 5, 6, 7, 8, or 9 neighbours which
        are 'on', the cell stays 'off'. (nothing happens to that cell)
      If the cell has 3 neighbours which are 'on', the cell turns
        'on'. (3 neighbouring 'alive' cells 'give birth' to a fourth.)
   Repeat for as many generations as desired.
 *)


class Board inherits IO {

 rows : Int;
 columns : Int;
 board_size : Int;

 size_of_board(initial : String) : Int {
   initial.length()
 };

 board_init(start : String) : SELF_TYPE {
   (let size :Int  <- size_of_board(start) in
    {
	if size = 15 then
	 {
	  rows <- 3;
	  columns <- 5;
	  board_size <- size;
	 }
	else if size = 16 then
	  {
	  rows <- 4;
	  columns <- 4;
	  board_size <- size;
	 }
	else if size = 20 then
	 {
	  rows <- 4;
	  columns <- 5;
	  board_size <- size;
	 }
	else if size = 21 then
	 {
	  rows <- 3;
	  columns <- 7;
	  board_size <- size;
	 }
	else if size = 25 then
	 {
	  rows <- 5;
	  columns <- 5;
	  board_size <- size;
	 }
	else if size = 28 then
	 {
	  rows <- 7;
	  columns <- 4;
	  board_size <- size;
	 }
	else 	-- If none of the above fit, then just give
	 {  -- the configuration of the most common board
	  rows <- 5;
	  columns <- 5;
	  board_size <- size;
	 }
	fi fi fi fi fi fi;
	self;
    }
   )
 };

};



class CellularAutomaton inherits Board {
    population_map : String;

    init(map : String) : SELF_TYPE {
        {
            population_map <- map;
	    board_init(map);
            self;
        }
    };




    print() : SELF_TYPE {

	(let i : Int <- 0 in
	(let num : Int <- board_size in
	{
 	out_string("\n");
	 while i < num loop
           {
	    out_string(population_map.substr(i,columns));
	    out_string("\n");
	    i <- i + columns;
	   }
	 pool;
 	out_string("\n");
	self;
	}
	) )
    };

    num_cells() : Int {
        population_map.length()
    };

    cell(position : Int) : String {
	if board_size - 1 < position then
		" "
	else
        	population_map.substr(position, 1)
	fi
    };

 north(position : Int): String {
	if (position - columns) < 0 then
	      " "
	else
	   cell(position - columns)
	fi
 };

 south(position : Int): String {
	if board_size < (position + columns) then
	      " "
	else
	   cell(position + columns)
	fi
 };

 east(position : Int): String {
	if (((position + 1) /columns ) * columns) = (position + 1) then
	      " "
	else
	   cell(position + 1)
	fi
 };

 west(position : Int): String {
	if position = 0 then
	      " "
	else
	   if ((position / columns) * columns) = position then
	      " "
	   else
	      cell(position - 1)
	fi fi
 };

 northwest(position : Int): String {
	if (position - columns) < 0 then
	      " "
	else  if ((position / columns) * columns) = position then
	      " "
	      else
		north(position - 1)
	fi fi
 };

 northeast(position : Int): String {
	if (position - columns) < 0 then
	      " "
	else if (((position + 1) /columns ) * columns) = (position + 1) then
	      " "
	     else
	       north(position + 1)
	fi fi
 };

 southeast(position : Int): String {
	if board_size < (position + columns) then
	      " "
	else if (((position + 1) /columns ) * columns) = (position + 1) then
	       " "
	     else
	       south(position + 1)
	fi fi
 };

 southwest(position : Int): String {
	if board_size < (position + columns) then
	      " "
	else  if ((position / columns) * columns) = position then
	      " "
	      else
	       south(position - 1)
	fi fi
 };

 neighbors(position: Int): Int {
 	{
	     if north(position) = "X" then 1 else 0 fi
	     + if south(position) = "X" then 1 else 0 fi
 	     + if east(position) = "X" then 1 else 0 fi
 	     + if west(position) = "X" then 1 else 0 fi
	     + if northeast(position) = "X" then 1 else 0 fi
	     + if northwest(position) = "X" then 1 else 0 fi
 	     + if southeast(position) = "X" then 1 else 0 fi
	     + if southwest(position) = "X" then 1 else 0 fi;
	 }
 };


(* A cell will live if 2 or 3 of it's neighbors are alive. It dies
   otherwise. A cell is born if only 3 of it's neighbors are alive. *)

    cell_at_next_evolution(position : Int) : String {

	if neighbors(position) = 3 then
		"X"
	else
	   if neighbors(position) = 2 then
		if cell(position) = "X" then
			"X"
		else
			"-"
	        fi
	   else
		"-"
	fi fi
    };


    evolve() : SELF_TYPE {
        (let position : Int <- 0 in
        (let num : Int <- num_cells() in
        (let temp : String in
            {
                while position < num loop
                    {
                        temp <- temp.concat(cell_at_next_evolution(position));
                        position <- position + 1;
                    }
                pool;
                population_map <- temp;
                self;
            }
        ) ) )
    };

(* This is where the background pattern is detremined by the user. More
   patterns can be added as long as whoever adds keeps the board either
   3x5, 4x5, 5x5, 3x7, 7x4, 4x4 with the row first then column. *)
 option(): String {
 {
  (let num : Int in
   {
   out_string("\nPlease chose a number:\n");
   out_string("\t1: A cross\n");
   out_string("\t2: A slash from the upper left to lower right\n");
   out_string("\t3: A slash from the upper right to lower left\n");
   out_string("\t4: An X\n");
   out_string("\t5: A greater than sign \n");
   out_string("\t6: A less than sign\n");
   out_string("\t7: Two greater than signs\n");
   out_string("\t8: Two less than signs\n");
   out_string("\t9: A 'V'\n");
   out_string("\t10: An inverse 'V'\n");
   out_string("\t11: Numbers 9 and 10 combined\n");
   out_string("\t12: A full grid\n");
   out_string("\t13: A 'T'\n");
   out_string("\t14: A plus '+'\n");
   out_string("\t15: A 'W'\n");
   out_string("\t16: An 'M'\n");
   out_string("\t17: An 'E'\n");
   out_string("\t18: A '3'\n");
   out_string("\t19: An 'O'\n");
   out_string("\t20: An '8'\n");
   out_string("\t21: An 'S'\n");
   out_string("Your choice => ");
   num <- in_int();
   out_string("\n");
   if num = 1 then
    	" XX  XXXX XXXX  XX  "
   else if num = 2 then
    	"    X   X   X   X   X    "
   else if num = 3 then
    	"X     X     X     X     X"
   else if num = 4 then
	"X   X X X   X   X X X   X"
   else if num = 5 then
	"X     X     X   X   X    "
   else if num = 6 then
	"    X   X   X     X     X"
   else if num = 7 then
	"X  X  X  XX  X      "
   else if num = 8 then
	" X  XX  X  X  X     "
   else if num = 9 then
	"X   X X X   X  "
   else if num = 10 then
	"  X   X X X   X"
   else if num = 11 then
	"X X X X X X X X"
   else if num = 12 then
	"XXXXXXXXXXXXXXXXXXXXXXXXX"
   else if num = 13 then
    	"XXXXX  X    X    X    X  "
   else if num = 14 then
    	"  X    X  XXXXX  X    X  "
   else if num = 15 then
    	"X     X X X X   X X  "
   else if num = 16 then
    	"  X X   X X X X     X"
   else if num = 17 then
	"XXXXX   X   XXXXX   X   XXXX"
   else if num = 18 then
	"XXX    X   X  X    X   XXXX "
   else if num = 19 then
	" XX X  XX  X XX "
   else if num = 20 then
	" XX X  XX  X XX X  XX  X XX "
   else if num = 21 then
	" XXXX   X    XX    X   XXXX "
   else
	"                         "
  fi fi fi fi fi fi fi fi fi fi fi fi fi fi fi fi fi fi fi fi fi;
    }
   );
 }
 };




 prompt() : Bool {
 {
  (let ans : String in
   {
   out_string("Would you like to continue with the next generation? \n");
   out_string("Please use lowercase y or n for your answer [y]: ");
   ans <- in_string();
   out_string("\n");
   if ans = "n" then
	false
   else
	true
   fi;
   }
  );
 }
 };


 prompt2() : Bool {
  (let ans : String in
   {
   out_string("\n\n");
   out_string("Would you like to choose a background pattern? \n");
   out_string("Please use lowercase y or n for your answer [n]: ");
   ans <- in_string();
   if ans = "y" then
	true
   else
	false
   fi;
   }
  )
 };


};

class Complex inherits IO {
    x : Int;
    y : Int;

    init(a : Int, b : Int) : Complex {
	{
	    x = a;
	    y = b;
	    self;
	}
    };

    print() : Object {
	if y = 0
	then out_int(x)
	else out_int(x).out_string("+").out_int(y).out_string("I")
	fi
    };

    reflect_0() : Complex {
	{
	    x = ~x;
	    y = ~y;
	    self;
	}
    };

    reflect_X() : Complex {
	{
	    y = ~y;
	    self;
	}
    };

    reflect_Y() : Complex {
	{
	    x = ~x;
	    self;
	}
    };
};

(* models one-dimensional cellular automaton on a circle of finite radius
   arrays are faked as Strings,
   X's respresent live cells, dots represent dead cells,
   no error checking is done *)
class NewCellularAutomaton inherits IO {
    population_map : String;

    init(map : String) : SELF_TYPE {
        {
            population_map <- map;
            self;
        }
    };

    print() : SELF_TYPE {
        {
            out_string(population_map.concat("\n"));
            self;
        }
    };

    num_cells() : Int {
        population_map.length()
    };

    cell(position : Int) : String {
        population_map.substr(position, 1)
    };

    cell_left_neighbor(position : Int) : String {
        if position = 0 then
            cell(num_cells() - 1)
        else
            cell(position - 1)
        fi
    };

    cell_right_neighbor(position : Int) : String {
        if position = num_cells() - 1 then
            cell(0)
        else
            cell(position + 1)
        fi
    };

    (* a cell will live if exactly 1 of itself and it's immediate
       neighbors are alive *)
    cell_at_next_evolution(position : Int) : String {
        if (if cell(position) = "X" then 1 else 0 fi
            + if cell_left_neighbor(position) = "X" then 1 else 0 fi
            + if cell_right_neighbor(position) = "X" then 1 else 0 fi
            = 1)
        then
            "X"
        else
            "."
        fi
    };

    evolve() : SELF_TYPE {
        (let position : Int in
        (let num : Int <- num_cells() in
        (let temp : String in
            {
                while position < num loop
                    {
                        temp <- temp.concat(cell_at_next_evolution(position));
                        position <- position + 1;
                    }
                pool;
                population_map <- temp;
                self;
            }
        ) ) )
    };
};


-- example of static and dynamic type differing for a dispatch

Class Book inherits IO {
    title : String;
    author : String;

    initBook(title_p : String, author_p : String) : Book {
        {
            title <- title_p;
            author <- author_p;
            self;
        }
    };

    print() : Book {
        {
            out_string("title:      ").out_string(title).out_string("\n");
            out_string("author:     ").out_string(author).out_string("\n");
            self;
        }
    };
};

Class Article inherits Book {
    per_title : String;

    initArticle(title_p : String, author_p : String,
		per_title_p : String) : Article {
        {
            initBook(title_p, author_p);
            per_title <- per_title_p;
            self;
        }
    };

    print() : Book {
        {
	    self@Book.print();
            out_string("periodical:  ").out_string(per_title).out_string("\n");
            self;
        }
    };
};

Class BookList inherits IO {
    (* Since abort "returns" type Object, we have to add
       an expression of type Bool here to satisfy the typechecker.
       This code is unreachable, since abort() halts the program.
    *)
    isNil() : Bool { { abort(); true; } };

    cons(hd : Book) : Cons {
        (let new_cell : Cons <- new Cons in
            new_cell.init(hd,self)
        )
    };

    (* Since abort "returns" type Object, we have to add
       an expression of type Book here to satisfy the typechecker.
       This code is unreachable, since abort() halts the program.
    *)
    car() : Book { { abort(); new Book; } };

    (* Since abort "returns" type Object, we have to add
       an expression of type BookList here to satisfy the typechecker.
       This code is unreachable, since abort() halts the program.
    *)
    cdr() : BookList { { abort(); new BookList; } };

    print_list() : Object { abort() };
};

Class Cons inherits BookList {
    xcar : Book;  -- We keep the car and cdr in attributes.
    xcdr : BookList; -- Because methods and features must have different names,
    -- we use xcar and xcdr for the attributes and reserve
    -- car and cdr for the features.

    isNil() : Bool { false };

    init(hd : Book, tl : BookList) : Cons {
        {
            xcar <- hd;
            xcdr <- tl;
            self;
        }
    };

    car() : Book { xcar };

    cdr() : BookList { xcdr };

    print_list() : Object {
        {
            case xcar.print() of
                dummy : Book => out_string("- dynamic type was Book -\n");
                dummy : Article => out_string("- dynamic type was Article -\n");
            esac;
            xcdr.print_list();
        }
    };
};

Class Nil inherits BookList {
    isNil() : Bool { true };

    print_list() : Object { true };
};


(*
 *  A contribution from Anne Sheets (sheets@cory)
 *
 *  Tests the arithmetic operations and various other things
 *)

class A {

   var : Int <- 0;

   value() : Int { var };

   set_var(num : Int) : SELF_TYPE {
      {
         var <- num;
         self;
      }
   };

   method1(num : Int) : SELF_TYPE {  -- same
      self
   };

   method2(num1 : Int, num2 : Int) : B {  -- plus
      (let x : Int in
	 {
            x <- num1 + num2;
	    (new B).set_var(x);
	 }
      )
   };

   method3(num : Int) : C {  -- negate
      (let x : Int in
	 {
            x <- ~num;
	    (new C).set_var(x);
	 }
      )
   };

   method4(num1 : Int, num2 : Int) : D {  -- diff
            if num2 < num1 then
               (let x : Int in
		  {
                     x <- num1 - num2;
	             (new D).set_var(x);
	          }
               )
            else
               (let x : Int in
		  {
	             x <- num2 - num1;
	             (new D).set_var(x);
		  }
               )
            fi
   };

   method5(num : Int) : E {  -- factorial
      (let x : Int <- 1 in
	 {
	    (let y : Int <- 1 in
	       while y <= num loop
	          {
                     x <- x * y;
	             y <- y + 1;
	          }
	       pool
	    );
	    (new E).set_var(x);
	 }
      )
   };

};

class B inherits A {  -- B is a number squared

   method5(num : Int) : E { -- square
      (let x : Int in
	 {
            x <- num * num;
	    (new E).set_var(x);
	 }
      )
   };

};

class C inherits B {

   method6(num : Int) : A { -- negate
      (let x : Int in
         {
            x <- ~num;
	    (new A).set_var(x);
         }
      )
   };

   method5(num : Int) : E {  -- cube
      (let x : Int in
	 {
            x <- num * num * num;
	    (new E).set_var(x);
	 }
      )
   };

};

class D inherits B {

   method7(num : Int) : Bool {  -- divisible by 3
      (let x : Int <- num in
            if x < 0 then method7(~x) else
            if 0 = x then true else
            if 1 = x then false else
	    if 2 = x then false else
	       method7(x - 3)
	    fi fi fi fi
      )
   };

};

class E inherits D {

   method6(num : Int) : A {  -- division
      (let x : Int in
         {
            x <- num / 8;
	    (new A).set_var(x);
         }
      )
   };

};

(* The following code is from atoi.cl in ~cs164/examples *)

(*
   The class A2I provides integer-to-string and string-to-integer
conversion routines.  To use these routines, either inherit them
in the class where needed, have a dummy variable bound to
something of type A2I, or simpl write (new A2I).method(argument).
*)


(*
   c2i   Converts a 1-character string to an integer.  Aborts
         if the string is not "0" through "9"
*)
class A2I {

     c2i(char : String) : Int {
	if char = "0" then 0 else
	if char = "1" then 1 else
	if char = "2" then 2 else
        if char = "3" then 3 else
        if char = "4" then 4 else
        if char = "5" then 5 else
        if char = "6" then 6 else
        if char = "7" then 7 else
        if char = "8" then 8 else
        if char = "9" then 9 else
        { abort(); 0; }  (* the 0 is needed to satisfy the
				  typchecker *)
        fi fi fi fi fi fi fi fi fi fi
     };

(*
   i2c is the inverse of c2i.
*)
     i2c(i : Int) : String {
	if i = 0 then "0" else
	if i = 1 then "1" else
	if i = 2 then "2" else
	if i = 3 then "3" else
	if i = 4 then "4" else
	if i = 5 then "5" else
	if i = 6 then "6" else
	if i = 7 then "7" else
	if i = 8 then "8" else
	if i = 9 then "9" else
	{ abort(); ""; }  -- the "" is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

(*
   a2i converts an ASCII string into an integer.  The empty string
is converted to 0.  Signed and unsigned strings are handled.  The
method aborts if the string does not represent an integer.  Very
long strings of digits produce strange answers because of arithmetic
overflow.
*)
     a2i(s : String) : Int {
        if s.length() = 0 then 0 else
	if s.substr(0,1) = "-" then ~a2i_aux(s.substr(1,s.length()-1)) else
        if s.substr(0,1) = "+" then a2i_aux(s.substr(1,s.length()-1)) else
           a2i_aux(s)
        fi fi fi
     };

(* a2i_aux converts the usigned portion of the string.  As a
   programming example, this method is written iteratively.  *)


     a2i_aux(s : String) : Int {
	(let int : Int <- 0 in
           {
               (let j : Int <- s.length() in
	          (let i : Int <- 0 in
		    while i < j loop
			{
			    int <- int * 10 + c2i(s.substr(i,1));
			    i <- i + 1;
			}
		    pool
		  )
	       );
              int;
	    }
        )
     };

(* i2a converts an integer to a string.  Positive and negative
   numbers are handled correctly.  *)

    i2a(i : Int) : String {
	if i = 0 then "0" else
        if 0 < i then i2a_aux(i) else
          "-".concat(i2a_aux(i * ~1))
        fi fi
    };

(* i2a_aux is an example using recursion.  *)

    i2a_aux(i : Int) : String {
        if i = 0 then "" else
	    (let next : Int <- i / 10 in
		i2a_aux(next).concat(i2c(i - next * 10))
	    )
        fi
    };

};

class Main inherits IO {

   char : String;
   avar : A;
   a_var : A;
   flag : Bool <- true;


   menu() : String {
      {
         out_string("\n\tTo add a number to ");
         print(avar);
         out_string("...enter a:\n");
         out_string("\tTo negate ");
         print(avar);
         out_string("...enter b:\n");
         out_string("\tTo find the difference between ");
         print(avar);
         out_string("and another number...enter c:\n");
         out_string("\tTo find the factorial of ");
         print(avar);
         out_string("...enter d:\n");
         out_string("\tTo square ");
         print(avar);
         out_string("...enter e:\n");
         out_string("\tTo cube ");
         print(avar);
         out_string("...enter f:\n");
         out_string("\tTo find out if ");
         print(avar);
         out_string("is a multiple of 3...enter g:\n");
         out_string("\tTo divide ");
         print(avar);
         out_string("by 8...enter h:\n");
	 out_string("\tTo get a new number...enter j:\n");
	 out_string("\tTo quit...enter q:\n\n");
         in_string();
      }
   };

   prompt() : String {
      {
         out_string("\n");
         out_string("Please enter a number...  ");
         in_string();
      }
   };

   get_int() : Int {
      {
	 (let z : A2I <- new A2I in
	    (let s : String <- prompt() in
	       z.a2i(s)
	    )
         );
      }
   };

   is_even(num : Int) : Bool {
      (let x : Int <- num in
            if x < 0 then is_even(~x) else
            if 0 = x then true else
	    if 1 = x then false else
	          is_even(x - 2)
	    fi fi fi
      )
   };

    class_type(var : A) : SELF_TYPE {
      case var of
	 a : A => out_string("Class type is now A\n");
	 b : B => out_string("Class type is now B\n");
	 c : C => out_string("Class type is now C\n");
	 d : D => out_string("Class type is now D\n");
	 e : E => out_string("Class type is now E\n");
	 o : Object => out_string("Oooops\n");
      esac
   };

   print(var : A) : SELF_TYPE {
     (let z : A2I <- new A2I in
	{
	   out_string(z.i2a(var.value()));
	   out_string(" ");
	}
     )
   };

   main() : Object {
      {
         avar <- (new A);
         while flag loop
            {
	       -- avar <- (new A).set_var(get_int());
	       out_string("number ");
	       print(avar);
	       if is_even(avar.value()) then
	          out_string("is even!\n")
	       else
	          out_string("is odd!\n")
	       fi;
	       -- print(avar); -- prints out answer
	       class_type(avar);
	       char <- menu();
                  if char = "a" then -- add
                     {
                        a_var <- (new A).set_var(get_int());
	                avar <- (new B).method2(avar.value(), a_var.value());
	             } else
                  if char = "b" then -- negate
                     case avar of
	                   c : C => avar <- c.method6(c.value());
	                   a : A => avar <- a.method3(a.value());
	                   o : Object => {
		                  out_string("Oooops\n");
		                  abort(); 0;
		               };
                     esac else
                  if char = "c" then -- diff
                     {
                        a_var <- (new A).set_var(get_int());
	                avar <- (new D).method4(avar.value(), a_var.value());
	             } else
                  if char = "d" then avar <- (new C)@A.method5(avar.value()) else
		          -- factorial
                  if char = "e" then avar <- (new C)@B.method5(avar.value()) else
			  -- square
                  if char = "f" then avar <- (new C)@C.method5(avar.value()) else
			  -- cube
                  if char = "g" then -- multiple of 3?
		      if ((new D).method7(avar.value()))
		                       then -- avar <- (new A).method1(avar.value())
			 {
	                    out_string("number ");
	                    print(avar);
	                    out_string("is divisible by 3.\n");
			 }
			 else  -- avar <- (new A).set_var(0)
			 {
	                    out_string("number ");
	                    print(avar);
	                    out_string("is not divisible by 3.\n");
			 }
		      fi else
                  if char = "h" then
		      (let x : A in
			 {
		            x <- (new E).method6(avar.value());
			    (let r : Int <- (avar.value() - (x.value() * 8)) in
			       {
			          out_string("number ");
			          print(avar);
			          out_string("is equal to ");
			          print(x);
			          out_string("times 8 with a remainder of ");
				  (let a : A2I <- new A2I in
				     {
			                out_string(a.i2a(r));
			                out_string("\n");
				     }
				  ); -- end let a:
			       }
                            ); -- end let r:
			    avar <- x;
		         }
		      )  -- end let x:
		      else
                  if char = "j" then avar <- (new A)
		      else
                  if char = "q" then flag <- false
		      else
                      avar <- (new A).method1(avar.value()) -- divide/8
                  fi fi fi fi fi fi fi fi fi fi;
            }
         pool;
       }
   };

};



class Graph {

   vertices : VList <- new VList;
   edges    : EList <- new EList;

   add_vertice(v : Vertice) : Object { {
      edges <- v.outgoing().append(edges);
      vertices <- vertices.cons(v);
   } };

   print_E() : Object { edges.print() };
   print_V() : Object { vertices.print() };

};

class Vertice inherits IO {

   num  : Int;
   out  : EList <- new EList;

   outgoing() : EList { out };

   number() : Int { num };

   init(n : Int) : SELF_TYPE {
      {
         num <- n;
         self;
      }
   };


   add_out(s : Edge) : SELF_TYPE {
      {
	 out <- out.cons(s);
         self;
      }
   };

   print() : Object {
      {
         out_int(num);
	 out.print();
      }
   };

};

class Edge inherits IO {

   from   : Int;
   to     : Int;
   weight : Int;

   init(f : Int, t : Int, w : Int) : SELF_TYPE {
      {
         from <- f;
	 to <- t;
	 weight <- w;
	 self;
      }
   };

   print() : Object {
      {
         out_string(" (");
	 out_int(from);
	 out_string(",");
	 out_int(to);
	 out_string(")");
	 out_int(weight);
      }
   };

};



class EList inherits IO {
   -- Define operations on empty lists of Edges.

   car : Edge;

   isNil() : Bool { true };

   head()  : Edge { { abort(); car; } };

   tail()  : EList { { abort(); self; } };

   -- When we cons and element onto the empty list we get a non-empty
   -- list. The (new Cons) expression creates a new list cell of class
   -- Cons, which is initialized by a dispatch to init().
   -- The result of init() is an element of class Cons, but it
   -- conforms to the return type List, because Cons is a subclass of
   -- List.

   cons(e : Edge) : EList {
      (new ECons).init(e, self)
   };

   append(l : EList) : EList {
     if self.isNil() then l
     else tail().append(l).cons(head())
     fi
   };

   print() : Object {
     out_string("\n")
   };

};


(*
 *  Cons inherits all operations from List. We can reuse only the cons
 *  method though, because adding an element to the front of an emtpy
 *  list is the same as adding it to the front of a non empty
 *  list. All other methods have to be redefined, since the behaviour
 *  for them is different from the empty list.
 *
 *  Cons needs an extra attribute to hold the rest of the list.
 *
 *  The init() method is used by the cons() method to initialize the
 *  cell.
 *)

class ECons inherits EList {

   cdr : EList;	-- The rest of the list

   isNil() : Bool { false };

   head()  : Edge { car };

   tail()  : EList { cdr };

   init(e : Edge, rest : EList) : EList {
      {
	 car <- e;
	 cdr <- rest;
	 self;
      }
   };

   print() : Object {
     {
       car.print();
       cdr.print();
     }
   };

};




class VList inherits IO {
   -- Define operations on empty lists of vertices.

   car : Vertice;

   isNil() : Bool { true };

   head()  : Vertice { { abort(); car; } };

   tail()  : VList { { abort(); self; } };

   -- When we cons and element onto the empty list we get a non-empty
   -- list. The (new Cons) expression creates a new list cell of class
   -- ECons, which is initialized by a dispatch to init().
   -- The result of init() is an element of class Cons, but it
   -- conforms to the return type List, because Cons is a subclass of
   -- List.

        cons(v : Vertice) : VList {
                (new VCons).init(v, self)

        };


   print() : Object { out_string("\n") };

};


class VCons inherits VList {

   cdr : VList;	-- The rest of the list

   isNil() : Bool { false };

   head()  : Vertice { car };

   tail()  : VList { cdr };

   init(v : Vertice, rest : VList) : VList {
      {
	 car <- v;
	 cdr <- rest;
	 self;
      }
   };

   print() : Object {
     {
       car.print();
       cdr.print();
     }
   };

};


class Parse inherits IO {


   boolop : BoolOp <- new BoolOp;

   -- Reads the input and parses the fields

   read_input() : Graph {

      (let g : Graph <- new Graph in {
         (let line : String <- in_string() in
            while (boolop.and(not line="\n", not line="")) loop {
		-- out_string(line);
		-- out_string("\n");
		g.add_vertice(parse_line(line));
		line <- in_string();
	    } pool
         );
	 g;
      } )
   };


   parse_line(s : String) : Vertice {
      (let v : Vertice <- (new Vertice).init(a2i(s)) in {
	 while (not rest.length() = 0) loop {
	       -- out_string(rest);
	       -- out_string("\n");
	       (let succ : Int <- a2i(rest) in (let
	           weight : Int <- a2i(rest)
               in
	          v.add_out(new Edge.init(v.number(),
                                          succ,
					  weight))
	       ) );
	 } pool;
	 v;
         }
      )
   };

     c2i(char : String) : Int {
	if char = "0" then 0 else
	if char = "1" then 1 else
	if char = "2" then 2 else
        if char = "3" then 3 else
        if char = "4" then 4 else
        if char = "5" then 5 else
        if char = "6" then 6 else
        if char = "7" then 7 else
        if char = "8" then 8 else
        if char = "9" then 9 else
        { abort(); 0; }  -- the 0 is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

     rest : String;

     a2i(s : String) : Int {
        if s.length() = 0 then 0 else
	if s.substr(0,1) = "-" then ~a2i_aux(s.substr(1,s.length()-1)) else
        if s.substr(0,1) = " " then a2i(s.substr(1,s.length()-1)) else
           a2i_aux(s)
        fi fi fi
     };

(*
  a2i_aux converts the usigned portion of the string.  As a programming
example, this method is written iteratively.
  The conversion stops at a space or comma.
  As a side effect, r is set to the remaining string (without the comma).
*)
     a2i_aux(s : String) : Int {
	(let int : Int <- 0 in
           {
               (let j : Int <- s.length() in
	          (let i : Int <- 0 in
		    while i < j loop
			(let c : String <- s.substr(i,1) in
			    if (c = " ") then
			       {
				  rest <- s.substr(i+1,s.length()-i-1);
				  i <- j;
			       }
			    else if (c = ",") then
		               {
				  rest <- s.substr(i+1, s.length()-i-1);
				  i <- j;
		               }
			    else
			       {
				 int <- int * 10 + c2i(s.substr(i,1));
				 i <- i + 1;
				 if i=j then rest <- "" else "" fi;
			       }
			    fi fi
			)
		    pool
		  )
	       );
              int;
	    }
        )
     };

};



class BoolOp {

        and(b1 : Bool, b2 : Bool) : Bool {
                {
                        isvoid self;
                        new BoolOp;
         if b1 then b2 else false fi;
         }
  };


  or(b1 : Bool, b2 : Bool) : Bool {
     if b1 then true else b2 fi
  };

};
