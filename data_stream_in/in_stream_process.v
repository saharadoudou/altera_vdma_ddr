/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.0 : 2015/12/11 9:35:00
creaded: 2015/6/4 9:40:09
madified:2015/6/9 10:13:48
***********************************************/
`timescale 1ns/1ps
module in_stream_process #(
	parameter		MEM_DATA_BITS 	= 64,
	parameter		ADDR_BITS		= 25,
	parameter		DSIZE			= 24,
	parameter		FIFO_DEPTH		= 256
)(
	input						stream_clk,
	input						stream_rst_n,
	input						stream_in_sof,
	input						stream_in_vld,
	output						stream_out_wait_for_data,
	input [DSIZE-1:0]			stream_in_data,
	input [ADDR_BITS-1:0]		stream_in_baseaddr,
	input [23:0]				stream_in_length,
	//-- mem interface
	input						mem_clk,
	input						mem_rst_n,
	output 						wr_burst_req,
	output[9:0] 				wr_burst_len,
	output[ADDR_BITS-1:0] 		wr_burst_addr,
	input 						wr_burst_data_req,
	output[MEM_DATA_BITS - 1:0]	wr_burst_data,
	input 						wr_burst_finish

);



wire					wr_fifo_en	;
wire[63:0]				wr_data     ;
wire					sync_fifo_empty  ;
wire					arst_fifo   ;
wire					loadbase    ;
wire[ADDR_BITS-1:0]		ddr_baseaddr;
wire[23:0]				ddr_line_length;
wire[11:0]				ddr_col_length;

generate
if(DSIZE == 24)
video24bit_in_discontinuous #(
	.ADDR_BITS					(ADDR_BITS		),
	.BROADEN_LOAD				("TRUE"			)
)video_in_line_by_line_inst(
	.pclk						(stream_clk 				),
	.prst_n						(stream_rst_n				),
	.vsync						(stream_in_sof				),
	.de             			(stream_in_vld				),
	.fifo_empty					(stream_out_wait_for_data	),
	.indata         			(stream_in_data				),
	.baseaddr       			(stream_in_baseaddr			),
	.video_width				(stream_in_length			),
	.video_height				(12'd1						),

	.wr_fifo_en					(wr_fifo_en		),
	.wr_data        			(wr_data        ),
	.sync_fifo_empty			(sync_fifo_empty),
	.arst_fifo      			(arst_fifo      ),
	.loadbase       			(loadbase       ),
	.ddr_baseaddr   			(ddr_baseaddr   ),
	.ddr_line_length  			(ddr_line_length),
	.ddr_col_length				(ddr_col_length	)
);
else if (DSIZE == 8)
video8bit_in_discontinuous #(
	.ADDR_BITS					(ADDR_BITS		),
	.BROADEN_LOAD				("TRUE"			)
)video_in_line_by_line_inst(
	.pclk						(stream_clk 				),
	.prst_n						(stream_rst_n				),
	.vsync						(stream_in_sof				),
	.de             			(stream_in_vld				),
	.fifo_empty					(stream_out_wait_for_data	),
	.indata         			(stream_in_data				),
	.baseaddr       			(stream_in_baseaddr			),
	.video_width				(stream_in_length			),
	.video_height				(12'd1						),

	.wr_fifo_en					(wr_fifo_en		),
	.wr_data        			(wr_data        ),
	.sync_fifo_empty			(sync_fifo_empty),
	.arst_fifo      			(arst_fifo      ),
	.loadbase       			(loadbase       ),
	.ddr_baseaddr   			(ddr_baseaddr   ),
	.ddr_line_length  			(ddr_line_length),
	.ddr_col_length				(ddr_col_length	)
);
else if (DSIZE == 16)
video16bit_in_discontinuous #(
	.ADDR_BITS					(ADDR_BITS		),
	.BROADEN_LOAD				("TRUE"			)
)video_in_line_by_line_inst(
	.pclk						(stream_clk 				),
	.prst_n						(stream_rst_n				),
	.vsync						(stream_in_sof				),
	.de             			(stream_in_vld				),
	.fifo_empty					(stream_out_wait_for_data	),
	.indata         			(stream_in_data				),
	.baseaddr       			(stream_in_baseaddr			),
	.video_width				(stream_in_length			),
	.video_height				(12'd1						),

	.wr_fifo_en					(wr_fifo_en		),
	.wr_data        			(wr_data        ),
	.sync_fifo_empty			(sync_fifo_empty),
	.arst_fifo      			(arst_fifo      ),
	.loadbase       			(loadbase       ),
	.ddr_baseaddr   			(ddr_baseaddr   ),
	.ddr_line_length  			(ddr_line_length),
	.ddr_col_length				(ddr_col_length	)
);
else if(DSIZE == 32)
video32bit_in_discontinuous #(
	.ADDR_BITS					(ADDR_BITS		),
	.BROADEN_LOAD				("TRUE"			)
)video_in_line_by_line_inst(
	.pclk						(stream_clk 				),
	.prst_n						(stream_rst_n				),
	.vsync						(stream_in_sof				),
	.de             			(stream_in_vld				),
	.fifo_empty					(stream_out_wait_for_data	),
	.indata         			(stream_in_data				),
	.baseaddr       			(stream_in_baseaddr			),
	.video_width				(stream_in_length			),
	.video_height				(12'd1						),

	.wr_fifo_en					(wr_fifo_en		),
	.wr_data        			(wr_data        ),
	.sync_fifo_empty			(sync_fifo_empty),
	.arst_fifo      			(arst_fifo      ),
	.loadbase       			(loadbase       ),
	.ddr_baseaddr   			(ddr_baseaddr   ),
	.ddr_line_length  			(ddr_line_length),
	.ddr_col_length				(ddr_col_length	)
);
endgenerate


in_fifo_line_by_line #(
	.BURST_LEN					(128				),
	.MEM_DATA_BITS				(64					),
	.ADDR_BITS					(ADDR_BITS			),
	.FIFO_DEPTH					(FIFO_DEPTH			),
	.DETAL						(16					),
	.FLIPPING					("FALSE"			)
)in_fifo_line_by_line_inst(
	.inclk						(stream_clk			),
	.baseaddr					(ddr_baseaddr		),
	.loadbase					(loadbase			),
	.fifo_empty					(sync_fifo_empty	),
 	.arst_fifo					(arst_fifo			),
	.indata						(wr_data			),
	.wr_en						(wr_fifo_en			),
	.ddr_line_length			(ddr_line_length	),
	.ddr_col_length				(ddr_col_length		),
	//-- mem interface
	.mem_clk					(mem_clk			),
	.mem_rst_n					(mem_rst_n			),
	.wr_burst_req				(wr_burst_req		),
	.wr_burst_len				(wr_burst_len		),
	.wr_burst_addr				(wr_burst_addr		),
	.wr_burst_data_req			(wr_burst_data_req	),
	.wr_burst_data				(wr_burst_data		),
	.wr_burst_finish			(wr_burst_finish	)
);


endmodule
