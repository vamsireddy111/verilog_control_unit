module mealy_control_unit(
    input clk,
    input reset,
    input [2:0] opcode,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg [2:0] alu_op
);

// State encoding
reg [1:0] state, next_state;

// State definitions
parameter FETCH = 2'b00,
          DECODE = 2'b01,
          EXECUTE = 2'b10,
          WRITEBACK = 2'b11;


//  State Register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= FETCH;
    else
        state <= next_state;
end


//  Next State Logic
always @(*) begin
    case(state)
        FETCH:     next_state = DECODE;
        DECODE:    next_state = EXECUTE;
        EXECUTE:   next_state = WRITEBACK;
        WRITEBACK: next_state = FETCH;
        default:   next_state = FETCH;
    endcase
end


//  Mealy Output Logic 
always @(*) begin
    // Default values
    reg_write = 0;
    mem_read  = 0;
    mem_write = 0;
    alu_op    = 3'b000;

    case(state)

        //  FETCH
        FETCH: begin
            mem_read = 1;
        end

        // EXECUTE
        EXECUTE: begin
            case(opcode)
                3'b000: alu_op = 3'b000; // ADD
                3'b001: alu_op = 3'b001; // SUB
                3'b010: alu_op = 3'b010; // AND
                3'b011: alu_op = 3'b011; // OR
                3'b100: alu_op = 3'b000; // LOAD (use ADD for address calc)
                3'b101: alu_op = 3'b000; // STORE
                default: alu_op = 3'b000;
            endcase
        end

        //  WRITEBACK
        WRITEBACK: begin
            case(opcode)
                3'b100: begin // LOAD
                    reg_write = 1;
                end

                3'b101: begin // STORE
                    mem_write = 1;
                end

                default: begin // ALU ops
                    reg_write = 1;
                end
            endcase
        end

    endcase
end

endmodule
