#!/usr/bin/perl

use strict;
use warnings;

my $today=`/bin/date '+%F'`;

my ($t_year,$t_month,$t_day);

if ($today=~/^(.+?)-(0|)(.+?)-(0|)(.+)$/){

    $t_year=$1;
    $t_month=$3;
    $t_day=$5;
}

my $dow=`/bin/date -d $t_year-$t_month-1 '+%u'`;
chomp $dow;

my $day=2-$dow;
my $dom=&dom($t_year,$t_month);
my $weeks=($dom+$dow-1)/7;

my $zwy=&zwy($t_month);

my $ctjr;
my $gjjr=&gjjr($t_month);

# print "\${alignr}\${font WenQuanYi Zen Hei:bold:size=20}$t_year年 $zwy月\${font}\n";

printf "\${offset 20}\${font WenQuanYi Zen Hei:size=16}%7s%7s%7s%7s%7s%7s%7s\n\${offset 40}\${stippled_hr}\n","一","二","三","四","五","六","日";
for (my $i=0;$i<$weeks;$i++){
    my $j;
    print "\${offset 20}\${font FreeMono:bold:size=14}";
    for ($j=1;$j<=7 && $day<=$dom;$j++){
        if ($day>0){
            if ($day==$t_day){
                printf ("\${color #ff5d51}%4s\${color}",$day);
            }
            else{
                printf ("%4s",$day);
            }
        }
        else{
            printf ("%4s","");
        }
        $day++;
    }
    print "\${font}\n";

    $day=$day-$j+1;
    for ($j=1;$j<=7 && $day<=$dom;$j++){
        my $nl=&gl2nl($t_year,$t_month,$day);
        if ($day>0){
            if ($nl=~/(.+?月)初一/){
                printf ("\${offset 20}\${offset 12}\${font WenQuanYi Zen Hei:size=10}\${color #e9ff6f}%8s\${color}",$1);
            }
            elsif ($nl=~/.+?月(.+)/){
                printf ("\${offset 20}\${offset 12}\${font WenQuanYi Zen Hei:size=10}%8s",$1);
            }
            else{
                printf ("\${offset 20}\${offset 12}\${font WenQuanYi Zen Hei:size=10}\${color #d196bd}%8s\${color}",$nl);
            }
            $ctjr.=&ctjr($nl);
        }
        else{
            printf ("\${offset 12}%10s"," ");
        }
        $day++;
    }
    print "\n\n";
}

# print "\${color #e9ff5f}\${offset 150}传统节日\n";
# if (my @ctjr=$ctjr=~/(.+?\n)/g){
#     foreach (@ctjr){
#     print "\${offset 120}$_";
#     }
# }
# print "\n\${offset 150}国际节日\n";
# if (my @gjjr=$gjjr=~/(.+?\n)/g){
#     foreach (@gjjr){
#     print "\${offset 120}$_";
#     }
# }

#print "\${color}";

sub gl2nl{

    my ($year,$month,$day)=@_;

    open TXT,"../res/nongli.txt";

    while (<TXT>){

        if (/^$year-$month-$day (.+)/){

            close TXT;
            return $1;

        }

    }

    close TXT;
    return 0;
}

sub dom{

    my ($year,$month)=@_;

    if ($month==1||$month==3||$month==5||$month==7||$month==8||$month==10||$month==12){
    return 31;
    }
    elsif ($month==4||$month==6||$month==9||$month==11){
    return 30;
    }
    elsif (($year%100==0&&$year%400==0)||($year%4==0)){
    return 29;
    }
    else {
    return 28;
    }
}

sub zwy{

    my $month=$_[0];

    if ($month=~/^1$/){
    return "一";
    }
    elsif ($month=~/^2$/){
    return "二";
    }
    elsif ($month=~/^3$/){
    return "三";
    }
    elsif ($month=~/^4$/){
    return "四";
    }
    elsif ($month=~/^5$/){
    return "五";
    }
    elsif ($month=~/^6$/){
    return "六";
    }
    elsif ($month=~/^7$/){
    return "七";
    }
    elsif ($month=~/^8$/){
    return "八";
    }
    elsif ($month=~/^9$/){
    return "九";
    }
    elsif ($month=~/^10$/){
    return "十";
    }
    elsif ($month=~/^11$/){
    return "十一";
    }
    elsif ($month=~/^12$/){
    return "十二";
    }

}

sub ctjr{

    my $date=$_[0];

    if ($date=~/正月初一/){
    return "正月初一 春节\n";
    }
    elsif ($date=~/正月初五/){
    return "正月初五 路神生日\n";
    }
    elsif ($date=~/正月十五/){
    return "正月十五 元宵节\n";
    }
    elsif ($date=~/二月初二/){
    return "二月初二 龙抬头\n";
    }
    elsif ($date=~/四月初四/){
    return "四月初四 寒食节\n";
    }
    elsif ($date=~/五月初五/){
    return "五月初五 端午节\n";
    }
    elsif ($date=~/六月初六/){
    return "六月初六 天贶节\n六月初六 姑姑节\n";
    }
    elsif ($date=~/六月廿四/){
    return "六月廿四 彝族火把节\n";
    }
    elsif ($date=~/七月初七/){
    return "七月初七 七夕节\n";
    }
    elsif ($date=~/七月十五/){
    return "七月十五 盂兰盆节\n";
    }
    elsif ($date=~/七月三十/){
    return "七月三十 地藏节\n";
    }
    elsif ($date=~/八月十五/){
    return "八月十五 中秋节\n";
    }
    elsif ($date=~/九月初九/){
    return "九月初九 重阳节\n";
    }
    elsif ($date=~/十月初一/){
    return "十月初一 祭祖节\n";
    }
    elsif ($date=~/冬至/){
    return "冬月冬至 冬至节\n";
    }
    elsif ($date=~/腊月初八/){
    return "腊月初八 腊八节\n";
    }
    elsif ($date=~/腊月廿三/){
    return "腊月廿三 过小年\n";
    }
    elsif ($date=~/腊月三十/){
    return "腊月三十 除夕\n";
    }
}

sub gjjr{

    my $month=$_[0];

    if ($month==1){
    return "新年元旦[01.01]\n黑人节[1月第一个星期天]\n中国13亿人口日[01.06]\n日本成人节[1月第二个星期一]\n中国110宣传日[01.10]\n国际麻风节[1月最后一个星期日]\n";
    }
    elsif ($month==2){
    return "世界湿地日[02.02]\n世界抗癌症日[02.04]\n世界气象日[02.10]\n情人节[02.14]\n国际母语日[02.21]\n国际声援南非日[02.07]\n";
    }
    elsif ($month==3){
    return "全国爱耳日[03/03]\n妇女节[03/08]\n植树节[03/12]\n国际消费日[03/15]\n世界森林日 [03/21]\n世界水日[03/22]\n世界气象日[03.23]\n世界防治结核病日[03.24]\n";
    }
    elsif ($month==4){
    return "愚人节[04.01]\n清明节[04.05]\n世界卫生日 [04.07]\n世界地球日[04.22]\n";
    }
    elsif ($month==5){
    return "国际劳动节[05.01]\n中国青年节[05.04]\n全国碘缺乏病日 [05.05]\n世界红十字日[05.08]\n国际护士节[05.12]\n国际家庭日[05.15]\n世界电信日[05.17]\n国际博物馆日[05.18]\n全国助残日[每年五月第三个星期日]\n中国汶川地震哀挨哀悼日[05.19]\n全国学生营养日[05.20]\n国际生物多样性日[05.22]\n国际牛奶日[每年5月的第三个星期二]\n世界无烟日[05.31]\n母亲节[5月第二个星期日]\n`";
    }
    elsif ($month==6){
    return "国际儿童节 [06.01]\n世界环境日[06.05]\n全国爱眼日[06.06]\n父亲节[6月第三个星期日]\n防治荒漠化和干旱日[06.17]\n国际奥林匹克日[06.23]\n全国土地日[06.25]\n国际反毒品日[06.26]\n";
    }
    elsif ($month==7){
    return "香港回归日[07.01]\n建党节[07.01]\n抗日战争纪念日[07.07]\n世界人口日[07/11]\n";
    }
    elsif ($month==8){
    return "八一建军节[08.01]\n";
    }
    elsif ($month==9){
    return "劳动节[09.01]\n国际扫盲日[09.08]\n教师节[09.10]\n国际臭氧层保护日[09.16]\n国际和平日[09.17]\n国际爱牙日[09.20]\n国际聋人节[9月第四个星期日]\n世界旅游日[09.27]\n";
    }
    elsif ($month==10){
    return "国庆节[10.01]\n国际音乐节[10.01]\n国际减轻自然灾害日[10.02]\n世界动物日[10.04]\n国际住房日[10.07]\n全国高血压日[10.08]\n世界视觉日[10.08]\n世界邮政日[10.09]\n世界精神卫生日[10.10]\n国际盲人节[10.15]\n世界粮食节[10.16]世界消除贫困日[10.17]\n中国（揭阳）国际玉器节[10.21]\n世界传统医药日[10.22]\n联合国日[10.24]\n人类天花绝迹日[10.25]\n足球诞生日[10.26]\n万圣节[10.31]\n";
    }
    elsif ($month==11){
    return "中国记者日[11.08]\n消防宣传日[11.09]\n世界糖尿病日[11.14]\n国际大学生节[11.17]\n感恩节[11月第四个星期四]\n";
    }
    elsif ($month==12){
    return "世界艾滋病日[12.01]\n世界残疾人日[12.03]\n世界足球日[12.09]\n澳门回归纪念日[12.20]\n国际篮球日[12.21]\n平安夜[12.24]\n圣诞节[12.25]\n世界强化免疫日[12.25]\n";
    }
}