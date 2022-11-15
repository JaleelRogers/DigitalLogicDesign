module sevenSegmentDecoder(bcd, led_a, led_b, led_c, led_d, led_e, _led_f, led_g);

	input [3:0] bcd; //Intilizing bcd as an 4=bit input signal
	output led_a, led_b, led_c, led_d, led_e, _led_f, led_g;
	

		
		/*
		
		assign led_a = (B&~C&~D | ~A&~B&~C&D);
		assign led_b = (B&~C&D | B&C&~D);
		assign led_c = (B&~C&~D);
		assign led_d = (B&~C&~D | ~B&~C&D | B&C&D);
		assign led_e = (D | B&~C);
		assign led_f = (C&D | ~A&~B&D | ~B&C);
		assign led_g = (B&C&D | ~A&~B&~C);
		
		a= BC'D'+A'B'C'D -> A' & C' & (B^D)
		b= BC'D+BCD' ->  B & (C^D) 
		c= B'CD' -> ~B & C & ~D
		d= BC'D'+B'C'D+BCD ->  (B^D) & BCD
		e=D+ BC' -> B&~C + D
		f=CD+ A'B'D+ B'C -> ~A&D + C 
		g= BCD+A'B'C' -> ~A&~B&~C + B&C&D
		*/
		assign led_a = ~bcd[0] & ~bcd[2] & (bcd[1]^bcd[3]);
		assign led_b = bcd[1] & (bcd[2]^bcd[3];
		assign led_c = ~bcd[1] & bcd[2] & ~bcd[3];
		assign led_d =  ~bcd[0] & ~bcd[2] & (bcd[1]^bcd[3]) | bcd[0]& ~bcd[1] & bcd[2];
		assign led_e = bcd[1] & ~bcd[2] | bcd[3]
		assign led_f =  ~bcd[0] & ~bcd[1] & ~bcd[2] & bcd[3] | bcd[1] & bcd[2] & bcd[3] | ~bcd[0] & ~bcd[1] & bcd[2];
		assign led_g = ~bcd[0] & ~bcd[1] & ~bcd[2] | bcd[1] & bcd[2] & bcd[2];
endmodule
