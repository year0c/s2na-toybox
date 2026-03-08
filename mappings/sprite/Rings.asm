Map_Ring_internal:
		dc.w .frame1-Map_Ring_internal
		dc.w .frame2-Map_Ring_internal
		dc.w .frame3-Map_Ring_internal
		dc.w .frame4-Map_Ring_internal
		dc.w .frame5-Map_Ring_internal
		dc.w .frame6-Map_Ring_internal
		dc.w .frame7-Map_Ring_internal
		dc.w .frame8-Map_Ring_internal
.frame1:	dc.w $F805, 0, 0, $FFF8
.frame2:	dc.w $F805, 4, 2, $FFF8
.frame3:	dc.w $F801, 8, 4, $FFFC
.frame4:	dc.w $F805, $804, $802, $FFF8
.frame5:	dc.w $F805, $A, 5, $FFF8
.frame6:	dc.w $F805, $180A, $1805, $FFF8
.frame7:	dc.w $F805, $80A, $805, $FFF8
.frame8:	dc.w $F805, $100A, $1005, $FFF8