class Main inherits IO {
  a : Int;
   main(): SELF_TYPE {
      {
        a <- 10;
        out_string("Hello, World.\n");
      }
   };  


a2i_aux(s : String) : Int {
        (let int : Int <- 0 in
           {
               (let j : Bad  <- s.length() in
                  (let i : Int <- 0 in
                    while i < j loop
                        {
                            int <- int * 10; 
                            i <- i + 1;
                        }
                    pool
                  )
               );
              int;
            }
        )
     };

b2i_aux(s : String) : Int {
        (let self : Int in
           {
               (let j : Int <- s.length() in
                  (let i : Int <- 0 in
                    while i < j loop
                        {
                            int <- int * 10; 
                            i <- 1;
                        }
                    pool
                  )
               );
              int;
            }
        )
     }; 
}; 
