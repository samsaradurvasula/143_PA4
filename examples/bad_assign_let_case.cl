class Main inherits IO {
        main(): SELF_TYPE {
                {
	                out_string("Hello, World.\n");
                        var <- 2;
                        var2  <- 1;
                        one  <- 1;
                        two   <- 2;

                        case var of
                                one : Int => var2 <- 3;
                                two : Int => var2 <- 4;
                        esac;
                        let x : Int <-1, y : Int <- 2 in
                                out_string("Hello, World.\n");

                }

        };
};
