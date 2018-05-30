class A inherits IO {
   a : Int;
   main(): SELF_TYPE {
      {
        a <- 10;
	out_string("Hello, World.\n");
      }
   };

   old_method (x : Int, y: String) : SELF_TYPE {
        out_string ("Hello\n")
   };
 };

class SecondMain inherits A {
   a : Int;


   method(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
   method(): SELF_TYPE {
	out_string("Hello, World.\n")
   };

};

class B inherits A {

   old_method (x : Int, y: String) : SELF_TYPE {
        out_string ("Hello\n")
   };

};

class C inherits A {

        old_method (x : String, y: String) : SELF_TYPE {
                out_string ("Hello\n")
   };
};

class D inherits A {

        old_method (y: String) : SELF_TYPE {
                out_string ("Hello\n")
   };
};


class E inherits A {

        old_method (y: String) : Int {
                {
                        out_string ("Hello\n");
                        3;
                }
   };
};

class F inherits A {
(* switch name of var, but types stay the same *)
        old_method (y : Int, x: String) : SELF_TYPE {
                out_string ("Hello\n")
   };
};

class G inherits A {
        (* wrong type in attr init *)
        a : Object <- 8; (*should be OK *)
        b : Int <- "Hello\n"; (*not descendant *)

        old_method (y : Int, x: String) : SELF_TYPE {
                out_string ("Hello\n")
   };
};

(*Test bad return type, when supposed to return SELF_TYPE *)
class H inherits A {
        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        out_string ("Hello\n");
                        true;
                }
   };
};
(*Test bad return type, when not returning SELF_TYE*)
class I inherits A {
        old_method (x : Int, y: String) : Int {
                {
                        out_string ("Hello\n");
                        true;
                }
   };
};

(* Bad assign *)
class J inherits A {
        m : Int;
        n : Object;

        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        m <- n;
                        n <- m;
                        n <- undefined_var;

                        out_string ("Hello\n");
                }
   };
};


(* wrong num of arguments for dispatch AND bad types *)
class K inherits A {
        old_method (x : Int, y: String) : SELF_TYPE {
                {

                        out_string (2, 3);
                }
   };
};



(* bad type on dispatch *)
class L inherits A {
        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        out_string (2);
                }
   };
};


(* cannot find method *)
class M inherits A {
        io : IO;
        old_method (x : Int, y: String) : SELF_TYPE {
                {


                        out_string_2 ("Hello\n");
                        (*
                        io <- new IO;

                        io.out_string_2 ("Hello\n");

                        io <- new A;
                        io.out_string_2 ("Hello\n");
                        io.out_string ("Hello\n");
                        *)



                }
   };
};

class N inherits IO {
        out_string (x : String) : SELF_TYPE {
                self
        };
};

(*Test arith errors and loop*)
class O inherits A {
        old_method (x : Int, y: String) : SELF_TYPE {
                {
                x <- 2 + 3;
                x <- 2 * 3;
                x <- 2 / 3;
                x <- 2 - 3;

                x <- 2 + false;
                x <- false + 2;

                x <- "hello" - 2;
                x <- false - 2;

                x <- 2 * "hello";
                x <- false * 2;

                x <- 2 / false;
                x <- true / 2;

                while
                   2
                loop
                  x <- 2
                pool;

                out_string ("Hello\n");
                }
   };

};

(*if, neg, eq *)
class P inherits A {
        s : SELF_TYPE;
        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        if 2 then 5 else "hello" fi;
                        x <- ~x;
                        x <- ~bool;
                        x <- ~"hello";

                        if 2 = 3
                        then true
                        else false fi;

                        if "abc" = 3
                        then true
                        else false fi;


                        if false = 3
                        then true
                        else false fi;


                        if "abc" = false
                        then true
                        else false fi;

                        if "abc" = false
                        then s
                        else false fi;


                        self;
                }
        };
};

(* Test bad leq eq *)
class Q inherits A {

        self : Int;
        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        self <- 2;
                        self <- new Q;
                        if 2 < 3
                        then true
                        else false fi;

                        if "this" < 2
                        then true
                        else false fi;

                        if 2 <= "that"
                        then true
                        else false fi;

                        out_string ("Hello\n");

                }
   };
};

class R inherits A {

        old_method (x : Int, y: String) : SELF_TYPE {

                {
                        (let self : Int <- 0 in
                                {
                                        (let j : Int <- s.length() in
                                                (let  r : SELF_TYPE <- self, i : Int <- "hello\n"  in
                                                        while i < j loop
                                                        {
                                                                int <- int * 10;
                                                                i <- i + 1;
                                                                undef <- 2;
                                                        }
                                                        pool
                                                )
                                        );
                                        int;
                                }
                        );


                        out_string ("Hello\n");
                }

        };

};

(* Test on isvoid new and comp Not and case*)
class S inherits A {

        j : Int;
        r : Bool;
        z : SELF_TYPE;
        k : Bool;
        var : Int;
        my_assign : Int;
        my_assign_self : SELF_TYPE;
        my_assign_string : String;
        one_string :String;


        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        if isvoid 2
                        then true
                        else false fi;
                        isvoid self;
                        isvoid blah;
                        isvoid j;

                        new Bad_thing;
                        new S;
                        z <- new SELF_TYPE;
                        r <- new SELF_TYPE;
                        j <- ~false;

                        k <- Not 2;
                        k <- Not self;

                        var <- 1;

                        case var of
                                one : Int => 11;
                                two : String => 22;
                                self : IO => my_assign_self <- self;
                        esac;

                        my_assign <- case var of
                                one : Int => 11;
                                two : String => "hello";
                                five : BadUndeclared => 23 + five;
                        esac;

                        my_assign_self <- case var of
                                one : Int => self;
                        esac;



                        my_assign_string  <- case var of
                                one : Int => 11;
                                two : Int => 22;
                        esac;


                        my_assign  <- case var of
                                one_string : String => 11;
                                two : Int => 22;

                        esac;

                        my_assign  <- case var of
                                one_string : String => "hello";
                                two : Int => 22;
                                three : SELF_TYPE => three + 22;

                        esac;


                        j <- one;

                        out_string ("Hello\n");

                }
   };
};

(*test self *)
class T inherits A {
        z : Int;
        n : BadClassAttr;
        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        out_string ("Hello\n");


                        z <- self;
                }
        };
        new_method (x : BadClass, y : String) : SELF_TYPE {
                {
                        z = x + 2;
                        y = "hello\n";
                        self;
                }
        };

        new_method_2 (x : BadClass, y : String, self: Int) : SELF_TYPE {
                {
                        self = 2;
                        self;
                }
        };

        new_method_3 (x : SELF_TYPE, y : String, self: Int) : SELF_TYPE {
                {
                        self = 2;
                        self;
                }
        };


};

(*test self *)
class U inherits Object {
        z : Int;
        n : BadClassAttr;
        old_method (x : Int, y: String) : SELF_TYPE {
                {
                        self@IO.out_string ("Hello\n");


                        z <- self;
                }
        };

};


(*test self *)
class V inherits IO {
        z : Int;
        n : BadClassAttr;
        old_method (x : Int, y: String) : BadClassUndef {
                {
                        out_string ("Hello\n");
                }
        };
};

class W inherits IO {
        z : Int;
        n : BadClassAttr;
        old_method (x : Int, y: BADtype) : SELF_TYPE {
                {
                        out_string ("Hello\n");

                }
        };
};
