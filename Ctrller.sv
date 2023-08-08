module Ctrller (
                    input clk, rst, valid, complete,
                    output reg eni, eno, seli, selr, crst
                    ); 

	parameter RESET=2'b000, INIT=2'b001,  INITR=2'b010, ROUNDS=2'b011, FINISH=2'b100;

	reg [2:0] cs,ns;

	// state transition
	always @ (posedge clk or negedge rst)
		begin
			
			if (!rst) cs<=RESET;
			else cs<=ns;

		end

	// output logic
	always @ (*)
		begin

			case(cs)
			RESET: 
                begin
                    if (valid) 
                    begin
                        eni = 1'b1;
                        eno = 1'b0;
                        seli = 1'b1;
                        selr = 1'b0;
                        crst = 1'b0;
                    end
                    else 
                    begin
                        eni = 1'b0;
                        eno = 1'b0;
                        seli = 1'b0;
                        selr = 1'b0;
                        crst = 1'b0;
                    end
				end

			INIT:
                begin
                    eni = 1'b0;
                    eno = 1'b0;
                    seli = 1'b1;
                    selr = 1'b0;
                    crst = 1'b0;
				end
            
            INITR:
                begin
                    eni = 1'b0;
                    eno = 1'b0;
                    seli = 1'b0;
                    selr = 1'b0;
                    crst = 1'b1;
				end

			ROUNDS: 
                begin
                    if (complete) 
                    begin
                        eni = 1'b0;
                        eno = 1'b1;
                        seli = 1'b0;
                        selr = 1'b1;
                        crst = 1'b1;
                    end
                    else 
                    begin
                        eni = 1'b0;
                        eno = 1'b0;
                        seli = 1'b0;
                        selr = 1'b0;
                        crst = 1'b1;
                    end
				end

            FINISH: 
                begin
                    eni = 1'b0;
                    eno = 1'b0;
                    seli = 1'b0;
                    selr = 1'b0;
                    crst = 1'b0;
				end

            default: 
                begin
                    eni = 1'b0;
                    eno = 1'b0;
                    seli = 1'b0;
                    selr = 1'b0;
                    crst = 1'b0;
				end
				
			endcase

		end


	// state logic
	always @ (*)
		begin 
			case(cs)
			RESET: 
                begin
                    if (valid) 
                    begin
                        ns = INIT;
                    end
                    else 
                    begin
                        ns = RESET;
                    end
				end

			INIT:
                begin
                    ns = INITR;
				end
            
			INITR:
                begin
                    ns = ROUNDS;
				end

			ROUNDS: 
                begin
                    if (complete) 
                    begin
                        ns = FINISH;
                    end
                    else 
                    begin
                        ns = ROUNDS;
                    end
				end

            FINISH: 
                begin
                    ns = RESET;
				end

			default: 
                begin
                    ns = RESET;
				end

			endcase
		end
	


endmodule