`define FIFO_WIDTH 3    // FIFO_SIZE = 8 -> FIFO_WIDTH = 3, no. of bits to be used in pointer
`define FIFO_SIZE ( 1<<`FIFO_WIDTH )

module fifo( clk, rst, fifo_in, fifo_out, push, pop, fifo_empty, fifo_full, fifo_counter );

input                 rst, clk, push, pop;   
// reset, system clock, write enable and read enable.
input [7:0]           fifo_in;                   
// data input to be pushed to fifo
output[7:0]           fifo_out;                  
// port to output the data using pop.
output                fifo_empty, fifo_full;      
// fifo empty and full indication 
output[`FIFO_WIDTH :0] fifo_counter;             
// number of data pushed in to fifo   

reg[7:0]              fifo_out;
reg                   fifo_empty, fifo_full;
reg[`FIFO_WIDTH :0]    fifo_counter;
reg[`FIFO_WIDTH -1:0]  rd_ptr, wr_ptr;           // pointer to read and write addresses  
reg[7:0]              fifo_mem[`FIFO_SIZE -1 : 0]; //  

always @(fifo_counter)
begin
   fifo_empty = (fifo_counter==0);
   fifo_full = (fifo_counter== `FIFO_SIZE);
end

always @(posedge clk or posedge rst)
begin
   if( rst )
       fifo_counter <= 0;

   else if( (!fifo_full && push) && ( !fifo_empty && pop ) )
       fifo_counter <= fifo_counter;

   else if( !fifo_full && push )
       fifo_counter <= fifo_counter + 1;

   else if( !fifo_empty && pop )
       fifo_counter <= fifo_counter - 1;
   else
      fifo_counter <= fifo_counter;
end

always @( posedge clk or posedge rst)
begin
   if( rst )
      fifo_out <= 0;
   else
   begin
      if( pop && !fifo_empty )
         fifo_out <= fifo_mem[rd_ptr];

      else
         fifo_out <= fifo_out;

   end
end

always @(posedge clk)
begin

   if( push && !fifo_full )
      fifo_mem[ wr_ptr ] <= fifo_in;

   else
      fifo_mem[ wr_ptr ] <= fifo_mem[ wr_ptr ];
end

always@(posedge clk or posedge rst)
begin
   if( rst )
   begin
      wr_ptr <= 0;
      rd_ptr <= 0;
   end
   else
   begin
      if( !fifo_full && push )    wr_ptr <= wr_ptr + 1;
          else  wr_ptr <= wr_ptr;

      if( !fifo_empty && pop )   rd_ptr <= rd_ptr + 1;
      else rd_ptr <= rd_ptr;
   end

end
endmodule