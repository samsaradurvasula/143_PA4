class Main inherits IO {
        a : Int;
        b : SELF_TYPE;
        c : Int;
   main(): SELF_TYPE {
      {
              a <- 10;
              b <- self;
              c <- b;

	out_string("Hello, World.\n");
      }
   };
}; 
