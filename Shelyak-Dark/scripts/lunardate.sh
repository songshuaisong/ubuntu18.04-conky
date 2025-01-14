#!/bin/bash
DOM=(0xd4a8 0xd4a0 0xda50 0x5aa8 0x56a0 0xaad8 0x25d0 0x92d0 0xc958 0xa950 
	 0xb4a0 0xb550 0xb550 0x55a8 0x4ba0 0xa5b0 0x52b8 0x52b0 0xa930 0x74a8
	 0x6aa0 0xad50 0x4da8 0x4b60 0x9570 0xa4e0 0xd260 0xe930 0xd530 0x5aa0
	 0x6b50 0x96d0 0x4ae8 0x4ad0 0xa4d0 0xd258 0xd250 0xd520 0xdaa0 0xb5a0
	 0x56d0 0x4ad8 0x49b0 0xa4b8 0xa4b0 0xaa50 0xb528 0x6d20 0xada0 0x55b0)
LMOY=(0x40 0x02 0x07 0x00 0x50
	  0x04 0x09 0x00 0x60 0x04
	  0x00 0x20 0x60 0x05 0x00
	  0x30 0xb0 0x06 0x00 0x50
	  0x02 0x07 0x00 0x50 0x03)
START=2001; END=2050
# $1: 2001-2050
get_leap_month()
{
	sft=$(( $1 - $START )); dom=${LMOY[$(( $sft >> 1 ))]}
	echo $(( $(( sft & 1 ))?$(( $dom & 0x0f )):$(( $dom >> 4 )) ))
}
# $1: 2001-2050, $2: 1-12
get_days_of_month()
{
	y=$1; m=$2; high=0; low=29; sft=$(( 16 - $m ))
	dom=${DOM[$(( $y - $START ))]}; lmoy=$(get_leap_month $y)
	[ $m -gt $lmoy -a $lmoy -gt 0 ] && let "sft--"
	[ $(( $dom & $(( 1 << $sft )) )) -gt 0 ] && let "low++"
	if [ $m -eq $lmoy ]; then
		let "sft--"
		high=$(( $(( $dom & ( 1 << $sft ) ))?30:29 ))
	fi
	echo $(( low + ( high << 16) ))
}
# $1: 2001-2050
get_days_of_year()
{
	y=$1; d=0
	for i in {1..12}; do
		tmp=$(get_days_of_month $y $i)
		let "d+=$(( $(( $tmp >> 16)) & 0xffff ))"
		let "d+=$(( $tmp & 0xffff ))"
	done
	echo $d
}
#
parse_year()
{
	HS="甲乙丙丁戊己庚辛壬癸"; EB="子丑寅卯辰巳午未申酉戌亥"
	echo "${HS:$(( ($1 - 4) % 10 )):1}${EB:$(( ($1 - 4) % 12 )):1}"
}	
#
parse_month()
{
	LM=('' '正' '二' '三' '四' '五' '六' '七' '八' '九' '十' '十一' '十二')
	echo "${LM[$1]}"
}
#
parse_day()
{
	PREFIX="初十廿"; DAY="一二三四五六七八九十"
	d=$1
	if [ $d -eq 20 ]; then
		echo "二十"
	elif [ $d -eq 30 ]; then
		echo "三十"
	else
		echo "${PREFIX:$(( ($d - 1) / 10 )):1}${DAY:$(( ($d - 1) % 10 )):1}"
	fi
}
parse_date()
{
	d=${*:-$(date)}; leap=
	sft=$(( ( $(date -d "$d" +%s) - $(date -d "${START}/01/01" +%s) ) / 60 / 60 / 24 ))
	if [ $sft -lt 23 ]; then
		ly=2000
		lm=12
		ld=$(( $sft + 7 ))
	else
		let "sft-=23"; ly=2001; lm=1; ld=1
		tmp=$(get_days_of_year $ly)
		while [ $sft -ge $tmp ]; do
			let "sft-=$tmp"
			let "ly++"
			tmp=$(get_days_of_year $ly)
		done
		tmp=$(( $(get_days_of_month $ly $lm) & 0xffff ))
		while [ $sft -ge $tmp ]; do
			let "sft-=$tmp"
			if [ $lm -eq $(get_leap_month $ly) ]; then
				tmp=$(( $(get_days_of_month $ly $lm) >> 16 ))
				if [ $sft -lt $tmp ]; then
					test $tmp -gt 0 && leap="闰"
					break
				fi
				let "sft-=$tmp"
			fi
			let "lm++"
			tmp=$(( $(get_days_of_month $ly $lm) & 0xffff ))
		done
		let "ld+=$sft"
	fi
	echo "$(parse_year $ly)年${leap}$(parse_month $lm)月$(parse_day $ld)"
}
parse_date "$*"