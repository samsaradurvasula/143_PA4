class A inherits IO {
        a : Int;
        b : SELF_TYPE;
        c : Int;
   main(): SELF_TYPE {
      {
              a <- 10;
              b <- self;

	out_string("Hello, World.\n");
      }
   };
};

class Main inherits A {
        d : SELF_TYPE;
        main (): SELF_TYPE {
                {
                        d <- b;
                        out_string ("hello");
                }
        };
};
