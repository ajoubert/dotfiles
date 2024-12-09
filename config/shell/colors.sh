############################### ANSI Colors ##############################

# foregrounds
 
_x=30; # black
_r=31; # red
_g=32; # green
_y=33; # yellow
_b=34; # blue
_m=35; # magenta
_c=36; # cyan
_w=37; # white

# backgrounds

_xb=40; # bgblack
_rb=41; # bgred
_gb=42; # bggreen
_yb=43; # bgyellow
_bb=44; # bgblue
_mb=45; # bgmagenta
_cb=46; # bgcyan
_wb=47; # bgwhite

# modern bright (not bold) foregrounds

_X=90; # brblack
_R=91; # brred
_G=92; # brgreen
_Y=93; # bryellow
_B=94; # brblue
_M=95; # brmagenta
_C=96; # brcyan
_W=97; # brwhite
 
# # modern bright (not bold) backgrounds

_Xb=100 # brblack
_Rb=101 # brred
_Gb=102 # brgreen
_Yb=103 # bryellow
_Bb=104 # brblue
_Mb=105 # brmagenta
_Cb=106 # brcyan
_Wb=107 # brwhite

reset=$'\033[0m'

############################ Solarized Colors ############################

# https://ethanschoonover.com/solarized/

soly=$'\033['$_y'm'; # export yellow=$soly
solo=$'\033['$_R'm'; # export orange=$solo
solr=$'\033['$_r'm'; # export red=$solr
solm=$'\033['$_m'm'; # export magen=$solm
solv=$'\033['$_M'm'; # export violet=$solv
solb=$'\033['$_b'm'; # export blue=$solb
solc=$'\033['$_c'm'; # export cyan=$solc
solg=$'\033['$_g'm'; # export green=$solg

solb03=$'\033['$_X'm'; # export base03=$solb03
solb02=$'\033['$_x'm'; # export base02=$solb02
solb01=$'\033['$_G'm'; # export base01=$solb01
solb00=$'\033['$_Y'm'; # export base00=$solb00
solb0=$'\033['$_B'm';  # export base0=$solb0
solb1=$'\033['$_C'm';  # export base1=$solb1
solb2=$'\033['$_w'm';  # export base2=$solb2
solb3=$'\033['$_W'm';  # export base3=$solb3

solY=$'\033['$_yb'm'; # export bgyellow=$solY
solO=$'\033['$_Rb'm'; # export bgorange=$solO
solR=$'\033['$_rb'm'; # export bgred=$solR
solM=$'\033['$_mb'm'; # export bgmagen=$solM
solV=$'\033['$_Mb'm'; # export bgviolet=$solV
solB=$'\033['$_bb'm'; # export bgblue=$solB
solC=$'\033['$_cb'm'; # export bgcyan=$solC
solG=$'\033['$_gb'm'; # export bggreen=$solG

solB03=$'\033['$_Xb'm'; # export bgbase03=$solB03
solB02=$'\033['$_xb'm'; # export bgbase02=$solB02
solB01=$'\033['$_Gb'm'; # export bgbase01=$solB01
solB00=$'\033['$_Yb'm'; # export bgbase00=$solB00
solB0=$'\033['$_Bb'm';  # export bgbase0=$solB0
solB1=$'\033['$_Cb'm';  # export bgbase1=$solB1
solB2=$'\033['$_wb'm';  # export bgbase2=$solB2
solB3=$'\033['$_Wb'm';  # export bgbase3=$solB3

########################### CSS Standard Colors ##########################

# Thanks to the wonderful work of Ethan Baker (github.com/ethanbaker).

aliceblue=$'\033[38;2;240;248;255m'
antiquewhite=$'\033[38;2;250;235;215m'
aqua=$'\033[38;2;0;255;255m'
aquamarine=$'\033[38;2;127;255;212m'
azure=$'\033[38;2;1240;255;255m'
beige=$'\033[38;2;245;245;220m'
bisque=$'\033[38;2;255;228;196m'
black=$'\033[38;2;0;0;0m'
blanchedalmond=$'\033[38;2;255;235;205m'
blue=$'\033[38;2;0;0;255m'
blueviolet=$'\033[38;2;138;43;226m'
brown=$'\033[38;2;165;42;42m'
burlywood=$'\033[38;2;222;184;135m'
cadetblue=$'\033[38;2;95;158;160m'
chartreuse=$'\033[38;2;95;158;160m'
chocolate=$'\033[38;2;210;105;30m'
coral=$'\033[38;2;255;127;80m'
cornflowerblue=$'\033[38;2;100;149;237m'
cornsilk=$'\033[38;2;255;248;220m'
crimson=$'\033[38;2;220;20;60m'
cyan=$'\033[38;2;0;255;255m'
darkblue=$'\033[38;2;0;0;139m'
darkcyan=$'\033[38;2;0;139;139m'
darkgoldenrod=$'\033[38;2;184;134;11m'
darkgray=$'\033[38;2;169;169;169m'
darkgreen=$'\033[38;2;0;100;0m'
darkkhaki=$'\033[38;2;189;183;107m'
darkmagenta=$'\033[38;2;139;0;139m'
darkolivegreen=$'\033[38;2;85;107;47m'
darkorange=$'\033[38;2;255;140;0m'
darkorchid=$'\033[38;2;153;50;204m'
darkred=$'\033[38;2;139;0;0m'
darksalmon=$'\033[38;2;233;150;122m'
darkseagreen=$'\033[38;2;143;188;143m'
darkslateblue=$'\033[38;2;72;61;139m'
darkslategray=$'\033[38;2;47;79;79m'
darkturquoise=$'\033[38;2;0;206;209m'
darkviolet=$'\033[38;2;148;0;211m'
deeppink=$'\033[38;2;255;20;147m'
deepskyblue=$'\033[38;2;0;191;255m'
dimgray=$'\033[38;2;0;191;255m'
dodgerblue=$'\033[38;2;30;144;255m'
firebrick=$'\033[38;2;178;34;34m'
floralwhite=$'\033[38;2;255;250;240m'
forestgreen=$'\033[38;2;34;139;34m'
fuchsia=$'\033[38;2;255;0;255m'
gainsboro=$'\033[38;2;220;220;220m'
ghostwhite=$'\033[38;2;248;248;255m'
gold=$'\033[38;2;255;215;0m'
goldenrod=$'\033[38;2;218;165;32m'
gray=$'\033[38;2;127;127;127m'
green=$'\033[38;2;0;128;0m'
greenyellow=$'\033[38;2;173;255;47m'
honeydew=$'\033[38;2;240;255;240m'
hotpink=$'\033[38;2;255;105;180m'
indianred=$'\033[38;2;205;92;92m'
indigo=$'\033[38;2;75;0;130m'
ivory=$'\033[38;2;255;255;240m'
khaki=$'\033[38;2;240;230;140m'
lavender=$'\033[38;2;230;230;250m'
lavenderblush=$'\033[38;2;255;240;245m'
lawngreen=$'\033[38;2;124;252;0m'
lemonchiffon=$'\033[38;2;255;250;205m'
lightblue=$'\033[38;2;173;216;230m'
lightcoral=$'\033[38;2;240;128;128m'
lightcyan=$'\033[38;2;224;255;255m'
lightgoldenrodyellow=$'\033[38;2;250;250;210m'
lightgreen=$'\033[38;2;144;238;144m'
lightgrey=$'\033[38;2;211;211;211m'
lightpink=$'\033[38;2;255;182;193m'
lightsalmon=$'\033[38;2;255;160;122m'
lightseagreen=$'\033[38;2;32;178;170m'
lightskyblue=$'\033[38;2;135;206;250m'
lightslategray=$'\033[38;2;119;136;153m'
lightsteelblue=$'\033[38;2;176;196;222m'
lightyellow=$'\033[38;2;255;255;224m'
lime=$'\033[38;2;0;255;0m'
limegreen=$'\033[38;2;50;205;50m'
linen=$'\033[38;2;250;240;230m'
magenta=$'\033[38;2;255;0;255m'
maroon=$'\033[38;2;128;0;0m'
mediumaquamarine=$'\033[38;2;102;205;170m'
mediumblue=$'\033[38;2;0;0;205m'
mediumorchid=$'\033[38;2;186;85;211m'
mediumpurple=$'\033[38;2;147;112;219m'
mediumseagreen=$'\033[38;2;60;179;113m'
mediumslateblue=$'\033[38;2;123;104;238m'
mediumspringgreen=$'\033[38;2;0;250;154m'
mediumturquoise=$'\033[38;2;72;209;204m'
mediumvioletred=$'\033[38;2;199;21;133m'
midnightblue=$'\033[38;2;25;25;112m'
mintcream=$'\033[38;2;245;255;250m'
mistyrose=$'\033[38;2;255;228;225m'
moccasin=$'\033[38;2;255;228;181m'
navajowhite=$'\033[38;2;255;222;173m'
navy=$'\033[38;2;0;0;128m'
navyblue=$'\033[38;2;159;175;223m'
oldlace=$'\033[38;2;253;245;230m'
olive=$'\033[38;2;128;128;0m'
olivedrab=$'\033[38;2;107;142;35m'
orange=$'\033[38;2;255;165;0m'
orangered=$'\033[38;2;255;69;0m'
orchid=$'\033[38;2;218;112;214m'
palegoldenrod=$'\033[38;2;238;232;170m'
palegreen=$'\033[38;2;152;251;152m'
paleturquoise=$'\033[38;2;175;238;238m'
palevioletred=$'\033[38;2;219;112;147m'
papayawhip=$'\033[38;2;255;239;213m'
peachpuff=$'\033[38;2;255;218;185m'
peru=$'\033[38;2;205;133;63m'
pink=$'\033[38;2;255;192;203m'
plum=$'\033[38;2;221;160;221m'
powderblue=$'\033[38;2;176;224;230m'
purple=$'\033[38;2;128;0;128m'
red=$'\033[38;2;255;0;0m'
rosybrown=$'\033[38;2;188;143;143m'
royalblue=$'\033[38;2;65;105;225m'
saddlebrown=$'\033[38;2;139;69;19m'
salmon=$'\033[38;2;250;128;114m'
sandybrown=$'\033[38;2;244;164;96m'
seagreen=$'\033[38;2;46;139;87m'
seashell=$'\033[38;2;255;245;238m'
sienna=$'\033[38;2;160;82;45m'
silver=$'\033[38;2;192;192;192m'
skyblue=$'\033[38;2;135;206;235m'
slateblue=$'\033[38;2;106;90;205m'
slategray=$'\033[38;2;112;128;144m'
snow=$'\033[38;2;255;250;250m'
springgreen=$'\033[38;2;0;255;127m'
steelblue=$'\033[38;2;70;130;180m'
tan=$'\033[38;2;210;180;140m'
teal=$'\033[38;2;0;128;128m'
thistle=$'\033[38;2;216;191;216m'
tomato=$'\033[38;2;255;99;71m'
turquoise=$'\033[38;2;64;224;208m'
violet=$'\033[38;2;238;130;238m'
wheat=$'\033[38;2;245;222;179m'
white=$'\033[38;2;255;255;255m'
whitesmoke=$'\033[38;2;245;245;245m'
yellow=$'\033[38;2;255;255;0m'
yellowgreen=$'\033[38;2;139;205;50m'

alicebluebg=$'\033[48;2;240;248;255m'
antiquewhitebg=$'\033[48;2;250;235;215m'
aquabg=$'\033[48;2;0;255;255m'
aquamarinebg=$'\033[48;2;127;255;212m'
azurebg=$'\033[48;2;1240;255;255m'
beigebg=$'\033[48;2;245;245;220m'
bisquebg=$'\033[48;2;255;228;196m'
blackbg=$'\033[48;2;0;0;0m'
blanchedalmondbg=$'\033[48;2;255;235;205m'
bluebg=$'\033[48;2;0;0;255m'
bluevioletbg=$'\033[48;2;138;43;226m'
brownbg=$'\033[48;2;165;42;42m'
burlywoodbg=$'\033[48;2;222;184;135m'
cadetbluebg=$'\033[48;2;95;158;160m'
chartreusebg=$'\033[48;2;95;158;160m'
chocolatebg=$'\033[48;2;210;105;30m'
coralbg=$'\033[48;2;255;127;80m'
cornflowerbluebg=$'\033[48;2;100;149;237m'
cornsilkbg=$'\033[48;2;255;248;220m'
crimsonbg=$'\033[48;2;220;20;60m'
cyanbg=$'\033[48;2;0;255;255m'
darkbluebg=$'\033[48;2;0;0;139m'
darkcyanbg=$'\033[48;2;0;139;139m'
darkgoldenrodbg=$'\033[48;2;184;134;11m'
darkgraybg=$'\033[48;2;169;169;169m'
darkgreenbg=$'\033[48;2;0;100;0m'
darkkhakibg=$'\033[48;2;189;183;107m'
darkmagentabg=$'\033[48;2;139;0;139m'
darkolivegreenbg=$'\033[48;2;85;107;47m'
darkorangebg=$'\033[48;2;255;140;0m'
darkorchidbg=$'\033[48;2;153;50;204m'
darkredbg=$'\033[48;2;139;0;0m'
darksalmonbg=$'\033[48;2;233;150;122m'
darkseagreenbg=$'\033[48;2;143;188;143m'
darkslatebluebg=$'\033[48;2;72;61;139m'
darkslategraybg=$'\033[48;2;47;79;79m'
darkturquoisebg=$'\033[48;2;0;206;209m'
darkvioletbg=$'\033[48;2;148;0;211m'
deeppinkbg=$'\033[48;2;255;20;147m'
deepskybluebg=$'\033[48;2;0;191;255m'
dimgraybg=$'\033[48;2;0;191;255m'
dodgerbluebg=$'\033[48;2;30;144;255m'
firebrickbg=$'\033[48;2;178;34;34m'
floralwhitebg=$'\033[48;2;255;250;240m'
forestgreenbg=$'\033[48;2;34;139;34m'
fuchsiabg=$'\033[48;2;255;0;255m'
gainsborobg=$'\033[48;2;220;220;220m'
ghostwhitebg=$'\033[48;2;248;248;255m'
goldbg=$'\033[48;2;255;215;0m'
goldenrodbg=$'\033[48;2;218;165;32m'
graybg=$'\033[48;2;127;127;127m'
greenbg=$'\033[48;2;0;128;0m'
greenyellowbg=$'\033[48;2;173;255;47m'
honeydewbg=$'\033[48;2;240;255;240m'
hotpinkbg=$'\033[48;2;255;105;180m'
indianredbg=$'\033[48;2;205;92;92m'
indigobg=$'\033[48;2;75;0;130m'
ivorybg=$'\033[48;2;255;255;240m'
khakibg=$'\033[48;2;240;230;140m'
lavenderbg=$'\033[48;2;230;230;250m'
lavenderblushbg=$'\033[48;2;255;240;245m'
lawngreenbg=$'\033[48;2;124;252;0m'
lemonchiffonbg=$'\033[48;2;255;250;205m'
lightbluebg=$'\033[48;2;173;216;230m'
lightcoralbg=$'\033[48;2;240;128;128m'
lightcyanbg=$'\033[48;2;224;255;255m'
lightgoldenrodyellowbg=$'\033[48;2;250;250;210m'
lightgreenbg=$'\033[48;2;144;238;144m'
lightgreybg=$'\033[48;2;211;211;211m'
lightpinkbg=$'\033[48;2;255;182;193m'
lightsalmonbg=$'\033[48;2;255;160;122m'
lightseagreenbg=$'\033[48;2;32;178;170m'
lightskybluebg=$'\033[48;2;135;206;250m'
lightslategraybg=$'\033[48;2;119;136;153m'
lightsteelbluebg=$'\033[48;2;176;196;222m'
lightyellowbg=$'\033[48;2;255;255;224m'
limebg=$'\033[48;2;0;255;0m'
limegreenbg=$'\033[48;2;50;205;50m'
linenbg=$'\033[48;2;250;240;230m'
magentabg=$'\033[48;2;255;0;255m'
maroonbg=$'\033[48;2;128;0;0m'
mediumaquamarinebg=$'\033[48;2;102;205;170m'
mediumbluebg=$'\033[48;2;0;0;205m'
mediumorchidbg=$'\033[48;2;186;85;211m'
mediumpurplebg=$'\033[48;2;147;112;219m'
mediumseagreenbg=$'\033[48;2;60;179;113m'
mediumslatebluebg=$'\033[48;2;123;104;238m'
mediumspringgreenbg=$'\033[48;2;0;250;154m'
mediumturquoisebg=$'\033[48;2;72;209;204m'
mediumvioletredbg=$'\033[48;2;199;21;133m'
midnightbluebg=$'\033[48;2;25;25;112m'
mintcreambg=$'\033[48;2;245;255;250m'
mistyrosebg=$'\033[48;2;255;228;225m'
moccasinbg=$'\033[48;2;255;228;181m'
navajowhitebg=$'\033[48;2;255;222;173m'
navybg=$'\033[48;2;0;0;128m'
navybluebg=$'\033[48;2;159;175;223m'
oldlacebg=$'\033[48;2;253;245;230m'
olivebg=$'\033[48;2;128;128;0m'
olivedrabbg=$'\033[48;2;107;142;35m'
orangebg=$'\033[48;2;255;165;0m'
orangeredbg=$'\033[48;2;255;69;0m'
orchidbg=$'\033[48;2;218;112;214m'
palegoldenrodbg=$'\033[48;2;238;232;170m'
palegreenbg=$'\033[48;2;152;251;152m'
paleturquoisebg=$'\033[48;2;175;238;238m'
palevioletredbg=$'\033[48;2;219;112;147m'
papayawhipbg=$'\033[48;2;255;239;213m'
peachpuffbg=$'\033[48;2;255;218;185m'
perubg=$'\033[48;2;205;133;63m'
pinkbg=$'\033[48;2;255;192;203m'
plumbg=$'\033[48;2;221;160;221m'
powderbluebg=$'\033[48;2;176;224;230m'
purplebg=$'\033[48;2;128;0;128m'
redbg=$'\033[48;2;255;0;0m'
rosybrownbg=$'\033[48;2;188;143;143m'
royalbluebg=$'\033[48;2;65;105;225m'
saddlebrownbg=$'\033[48;2;139;69;19m'
salmonbg=$'\033[48;2;250;128;114m'
sandybrownbg=$'\033[48;2;244;164;96m'
seagreenbg=$'\033[48;2;46;139;87m'
seashellbg=$'\033[48;2;255;245;238m'
siennabg=$'\033[48;2;160;82;45m'
silverbg=$'\033[48;2;192;192;192m'
skybluebg=$'\033[48;2;135;206;235m'
slatebluebg=$'\033[48;2;106;90;205m'
slategraybg=$'\033[48;2;112;128;144m'
snowbg=$'\033[48;2;255;250;250m'
springgreenbg=$'\033[48;2;0;255;127m'
steelbluebg=$'\033[48;2;70;130;180m'
tanbg=$'\033[48;2;210;180;140m'
tealbg=$'\033[48;2;0;128;128m'
thistlebg=$'\033[48;2;216;191;216m'
tomatobg=$'\033[48;2;255;99;71m'
turquoisebg=$'\033[48;2;64;224;208m'
violetbg=$'\033[48;2;238;130;238m'
wheatbg=$'\033[48;2;245;222;179m'
whitebg=$'\033[48;2;255;255;255m'
whitesmokebg=$'\033[48;2;245;245;245m'
yellowbg=$'\033[48;2;255;255;0m'
yellowgreenbg=$'\033[48;2;139;205;50m'

# Here's your colored man pages right here.

export LESS_TERMCAP_mb=$magen
export LESS_TERMCAP_md=$yellow
export LESS_TERMCAP_me=$reset
export LESS_TERMCAP_se=$reset
export LESS_TERMCAP_so=$blue
export LESS_TERMCAP_ue=$reset
export LESS_TERMCAP_us=$violet


LS_COLORS='';
LS_COLORS=$LS_COLORS:'no=00:';        # no = (NORMAL, NORM) Normal (non-filename) text. Global default, although everything should be something
LS_COLORS=$LS_COLORS:'fi=00:';        # fi = (FILE) Normal file
LS_COLORS=$LS_COLORS:'di=34:';        # di = (DIR)  Directory
LS_COLORS=$LS_COLORS:'ow=34;40:';     # ow = (OTHER_WRITABLE)   Directory that is other-writable (o+w) and not sticky
LS_COLORS=$LS_COLORS:'ln=35:';        # ln = (SYMLINK, LINK, LNK)   Symbolic link. If you set this to ‘target’ instead of a numerical value, the color is as for the file pointed to.
LS_COLORS=$LS_COLORS:'pi=30;44:';     # pi = (FIFO, PIPE)   Named pipe (fifo file)
LS_COLORS=$LS_COLORS:'so=35;44:';     # so = (SOCK) Socket file
LS_COLORS=$LS_COLORS:'do=35;44:';     # do = (DOOR) [Door][1]
LS_COLORS=$LS_COLORS:'bd=33;44:';     # bd = (BLOCK, BLK)   Block device (buffered) special file
LS_COLORS=$LS_COLORS:'cd=37;44:';     # cd = (CHAR, CHR)    Character device (unbuffered) special file
LS_COLORS=$LS_COLORS:'or=05;37;41:';  # or = (ORPHAN)   Symbolic link pointing to an orphaned non-existent file
LS_COLORS=$LS_COLORS:'mi=05;37;41:';  # mi = (MISSING)  Non-existent file pointed to by a symbolic link (visible when you type ls -l)
LS_COLORS=$LS_COLORS:'ex=01;31:';     # ex = (EXEC) Executable file (ie. has 'x' set in permissions)

# Missing:
# ow = (OTHER_WRITABLE)   Directory that is other-writable (o+w) and not sticky
# sg = (SETGID)   File that is setgid (g+s)
# st = (STICKY)   Directory with the sticky bit set (+t) and not other-writable
# su = (SETUID)   File that is setuid (u+s)
# tw = (STICKY_OTHER_WRITABLE)    Directory that is sticky and other-writable (+t,o+w)

# *.extension =   Every file using this extension e.g. *.rpm = files with the ending .rpm
LS_COLORS=$LS_COLORS:'*.cmd=01;31:';
LS_COLORS=$LS_COLORS:'*.exe=01;31:';
LS_COLORS=$LS_COLORS:'*.com=01;31:';
LS_COLORS=$LS_COLORS:'*.bat=01;31:';
LS_COLORS=$LS_COLORS:'*.reg=01;31:';
LS_COLORS=$LS_COLORS:'*.app=01;31:';
LS_COLORS=$LS_COLORS:'*.txt=32:';
LS_COLORS=$LS_COLORS:'*.org=32:';
LS_COLORS=$LS_COLORS:'*.md=32:';
LS_COLORS=$LS_COLORS:'*.mkd=32:';
LS_COLORS=$LS_COLORS:'*.h=32:';
LS_COLORS=$LS_COLORS:'*.c=32:';
LS_COLORS=$LS_COLORS:'*.C=32:';
LS_COLORS=$LS_COLORS:'*.cc=32:';
LS_COLORS=$LS_COLORS:'*.cpp=32:';
LS_COLORS=$LS_COLORS:'*.cxx=32:';
LS_COLORS=$LS_COLORS:'*.objc=32:';
LS_COLORS=$LS_COLORS:'*.sh=32:';
LS_COLORS=$LS_COLORS:'*.csh=32:';
LS_COLORS=$LS_COLORS:'*.zsh=32:';
LS_COLORS=$LS_COLORS:'*.el=32:';
LS_COLORS=$LS_COLORS:'*.vim=32:';
LS_COLORS=$LS_COLORS:'*.java=32:';
LS_COLORS=$LS_COLORS:'*.pl=32:';
LS_COLORS=$LS_COLORS:'*.pm=32:';
LS_COLORS=$LS_COLORS:'*.py=32:';
LS_COLORS=$LS_COLORS:'*.rb=32:';
LS_COLORS=$LS_COLORS:'*.hs=32:';
LS_COLORS=$LS_COLORS:'*.php=32:';
LS_COLORS=$LS_COLORS:'*.htm=32:';
LS_COLORS=$LS_COLORS:'*.html=32:';
LS_COLORS=$LS_COLORS:'*.shtml=32:';
LS_COLORS=$LS_COLORS:'*.erb=32:';
LS_COLORS=$LS_COLORS:'*.haml=32:';
LS_COLORS=$LS_COLORS:'*.xml=32:';
LS_COLORS=$LS_COLORS:'*.rdf=32:';
LS_COLORS=$LS_COLORS:'*.css=32:';
LS_COLORS=$LS_COLORS:'*.sass=32:';
LS_COLORS=$LS_COLORS:'*.scss=32:';
LS_COLORS=$LS_COLORS:'*.less=32:';
LS_COLORS=$LS_COLORS:'*.js=32:';
LS_COLORS=$LS_COLORS:'*.coffee=32:';
LS_COLORS=$LS_COLORS:'*.man=32:';
LS_COLORS=$LS_COLORS:'*.0=32:';
LS_COLORS=$LS_COLORS:'*.1=32:';
LS_COLORS=$LS_COLORS:'*.2=32:';
LS_COLORS=$LS_COLORS:'*.3=32:';
LS_COLORS=$LS_COLORS:'*.4=32:';
LS_COLORS=$LS_COLORS:'*.5=32:';
LS_COLORS=$LS_COLORS:'*.6=32:';
LS_COLORS=$LS_COLORS:'*.7=32:';
LS_COLORS=$LS_COLORS:'*.8=32:';
LS_COLORS=$LS_COLORS:'*.9=32:';
LS_COLORS=$LS_COLORS:'*.l=32:';
LS_COLORS=$LS_COLORS:'*.n=32:';
LS_COLORS=$LS_COLORS:'*.p=32:';
LS_COLORS=$LS_COLORS:'*.pod=32:';
LS_COLORS=$LS_COLORS:'*.tex=32:';
LS_COLORS=$LS_COLORS:'*.go=32:';
LS_COLORS=$LS_COLORS:'*.bmp=33:';
LS_COLORS=$LS_COLORS:'*.cgm=33:';
LS_COLORS=$LS_COLORS:'*.dl=33:';
LS_COLORS=$LS_COLORS:'*.dvi=33:';
LS_COLORS=$LS_COLORS:'*.emf=33:';
LS_COLORS=$LS_COLORS:'*.eps=33:';
LS_COLORS=$LS_COLORS:'*.gif=33:';
LS_COLORS=$LS_COLORS:'*.jpeg=33:';
LS_COLORS=$LS_COLORS:'*.jpg=33:';
LS_COLORS=$LS_COLORS:'*.JPG=33:';
LS_COLORS=$LS_COLORS:'*.mng=33:';
LS_COLORS=$LS_COLORS:'*.pbm=33:';
LS_COLORS=$LS_COLORS:'*.pcx=33:';
LS_COLORS=$LS_COLORS:'*.pdf=33:';
LS_COLORS=$LS_COLORS:'*.pgm=33:';
LS_COLORS=$LS_COLORS:'*.png=33:';
LS_COLORS=$LS_COLORS:'*.PNG=33:';
LS_COLORS=$LS_COLORS:'*.ppm=33:';
LS_COLORS=$LS_COLORS:'*.pps=33:';
LS_COLORS=$LS_COLORS:'*.ppsx=33:';
LS_COLORS=$LS_COLORS:'*.ps=33:';
LS_COLORS=$LS_COLORS:'*.svg=33:';
LS_COLORS=$LS_COLORS:'*.svgz=33:';
LS_COLORS=$LS_COLORS:'*.tga=33:';
LS_COLORS=$LS_COLORS:'*.tif=33:';
LS_COLORS=$LS_COLORS:'*.tiff=33:';
LS_COLORS=$LS_COLORS:'*.xbm=33:';
LS_COLORS=$LS_COLORS:'*.xcf=33:';
LS_COLORS=$LS_COLORS:'*.xpm=33:';
LS_COLORS=$LS_COLORS:'*.xwd=33:';
LS_COLORS=$LS_COLORS:'*.xwd=33:';
LS_COLORS=$LS_COLORS:'*.yuv=33:';
LS_COLORS=$LS_COLORS:'*.aac=33:';
LS_COLORS=$LS_COLORS:'*.au=33:';
LS_COLORS=$LS_COLORS:'*.flac=33:';
LS_COLORS=$LS_COLORS:'*.m4a=33:';
LS_COLORS=$LS_COLORS:'*.mid=33:';
LS_COLORS=$LS_COLORS:'*.midi=33:';
LS_COLORS=$LS_COLORS:'*.mka=33:';
LS_COLORS=$LS_COLORS:'*.mp3=33:';
LS_COLORS=$LS_COLORS:'*.mpa=33:';
LS_COLORS=$LS_COLORS:'*.mpeg=33:';
LS_COLORS=$LS_COLORS:'*.mpg=33:';
LS_COLORS=$LS_COLORS:'*.ogg=33:';
LS_COLORS=$LS_COLORS:'*.ra=33:';
LS_COLORS=$LS_COLORS:'*.wav=33:';
LS_COLORS=$LS_COLORS:'*.anx=33:';
LS_COLORS=$LS_COLORS:'*.asf=33:';
LS_COLORS=$LS_COLORS:'*.avi=33:';
LS_COLORS=$LS_COLORS:'*.axv=33:';
LS_COLORS=$LS_COLORS:'*.flc=33:';
LS_COLORS=$LS_COLORS:'*.fli=33:';
LS_COLORS=$LS_COLORS:'*.flv=33:';
LS_COLORS=$LS_COLORS:'*.gl=33:';
LS_COLORS=$LS_COLORS:'*.m2v=33:';
LS_COLORS=$LS_COLORS:'*.m4v=33:';
LS_COLORS=$LS_COLORS:'*.mkv=33:';
LS_COLORS=$LS_COLORS:'*.mov=33:';
LS_COLORS=$LS_COLORS:'*.MOV=33:';
LS_COLORS=$LS_COLORS:'*.mp4=33:';
LS_COLORS=$LS_COLORS:'*.mp4v=33:';
LS_COLORS=$LS_COLORS:'*.mpeg=33:';
LS_COLORS=$LS_COLORS:'*.mpg=33:';
LS_COLORS=$LS_COLORS:'*.nuv=33:';
LS_COLORS=$LS_COLORS:'*.ogm=33:';
LS_COLORS=$LS_COLORS:'*.ogv=33:';
LS_COLORS=$LS_COLORS:'*.ogx=33:';
LS_COLORS=$LS_COLORS:'*.qt=33:';
LS_COLORS=$LS_COLORS:'*.rm=33:';
LS_COLORS=$LS_COLORS:'*.rmvb=33:';
LS_COLORS=$LS_COLORS:'*.swf=33:';
LS_COLORS=$LS_COLORS:'*.vob=33:';
LS_COLORS=$LS_COLORS:'*.webm=33:';
LS_COLORS=$LS_COLORS:'*.wmv=33:';
LS_COLORS=$LS_COLORS:'*.doc=31:';
LS_COLORS=$LS_COLORS:'*.docx=31:';
LS_COLORS=$LS_COLORS:'*.rtf=31:';
LS_COLORS=$LS_COLORS:'*.dot=31:';
LS_COLORS=$LS_COLORS:'*.dotx=31:';
LS_COLORS=$LS_COLORS:'*.xls=31:';
LS_COLORS=$LS_COLORS:'*.xlsx=31:';
LS_COLORS=$LS_COLORS:'*.ppt=31:';
LS_COLORS=$LS_COLORS:'*.pptx=31:';
LS_COLORS=$LS_COLORS:'*.fla=31:';
LS_COLORS=$LS_COLORS:'*.psd=31:';
LS_COLORS=$LS_COLORS:'*.7z=1;35:';
LS_COLORS=$LS_COLORS:'*.apk=1;35:';
LS_COLORS=$LS_COLORS:'*.arj=1;35:';
LS_COLORS=$LS_COLORS:'*.bin=1;35:';
LS_COLORS=$LS_COLORS:'*.bz=1;35:';
LS_COLORS=$LS_COLORS:'*.bz2=1;35:';
LS_COLORS=$LS_COLORS:'*.cab=1;35:';
LS_COLORS=$LS_COLORS:'*.deb=1;35:';
LS_COLORS=$LS_COLORS:'*.dmg=1;35:';
LS_COLORS=$LS_COLORS:'*.gem=1;35:';
LS_COLORS=$LS_COLORS:'*.gz=1;35:';
LS_COLORS=$LS_COLORS:'*.iso=1;35:';
LS_COLORS=$LS_COLORS:'*.jar=1;35:';
LS_COLORS=$LS_COLORS:'*.msi=1;35:';
LS_COLORS=$LS_COLORS:'*.rar=1;35:';
LS_COLORS=$LS_COLORS:'*.rpm=1;35:';
LS_COLORS=$LS_COLORS:'*.tar=1;35:';
LS_COLORS=$LS_COLORS:'*.tbz=1;35:';
LS_COLORS=$LS_COLORS:'*.tbz2=1;35:';
LS_COLORS=$LS_COLORS:'*.tgz=1;35:';
LS_COLORS=$LS_COLORS:'*.tx=1;35:';
LS_COLORS=$LS_COLORS:'*.war=1;35:';
LS_COLORS=$LS_COLORS:'*.xpi=1;35:';
LS_COLORS=$LS_COLORS:'*.xz=1;35:';
LS_COLORS=$LS_COLORS:'*.z=1;35:';
LS_COLORS=$LS_COLORS:'*.Z=1;35:';
LS_COLORS=$LS_COLORS:'*.zip=1;35:';
LS_COLORS=$LS_COLORS:'*.ANSI-30-black=30:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;30-brblack=01;30:';
LS_COLORS=$LS_COLORS:'*.ANSI-31-red=31:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;31-brred=01;31:';
LS_COLORS=$LS_COLORS:'*.ANSI-32-green=32:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;32-brgreen=01;32:';
LS_COLORS=$LS_COLORS:'*.ANSI-33-yellow=33:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;33-bryellow=01;33:';
LS_COLORS=$LS_COLORS:'*.ANSI-34-blue=34:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;34-brblue=01;34:';
LS_COLORS=$LS_COLORS:'*.ANSI-35-magenta=35:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;35-brmagenta=01;35:';
LS_COLORS=$LS_COLORS:'*.ANSI-36-cyan=36:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;36-brcyan=01;36:';
LS_COLORS=$LS_COLORS:'*.ANSI-37-white=37:';
LS_COLORS=$LS_COLORS:'*.ANSI-01;37-brwhite=01;37:';
LS_COLORS=$LS_COLORS:'*.log=01;32:';
LS_COLORS=$LS_COLORS:'*~=01;32:';
LS_COLORS=$LS_COLORS:'*#=01;32:';
LS_COLORS=$LS_COLORS:'*.bak=01;33:';
LS_COLORS=$LS_COLORS:'*.BAK=01;33:';
LS_COLORS=$LS_COLORS:'*.old=01;33:';
LS_COLORS=$LS_COLORS:'*.OLD=01;33:';
LS_COLORS=$LS_COLORS:'*.org_archive=01;33:';
LS_COLORS=$LS_COLORS:'*.off=01;33:';
LS_COLORS=$LS_COLORS:'*.OFF=01;33:';
LS_COLORS=$LS_COLORS:'*.dist=01;33:';
LS_COLORS=$LS_COLORS:'*.DIST=01;33:';
LS_COLORS=$LS_COLORS:'*.orig=01;33:';
LS_COLORS=$LS_COLORS:'*.ORIG=01;33:';
LS_COLORS=$LS_COLORS:'*.swp=01;33:';
LS_COLORS=$LS_COLORS:'*.swo=01;33:';
LS_COLORS=$LS_COLORS:'*,v=01;33:';
LS_COLORS=$LS_COLORS:'*.gpg=34:';
LS_COLORS=$LS_COLORS:'*.gpg=34:';
LS_COLORS=$LS_COLORS:'*.pgp=34:';
LS_COLORS=$LS_COLORS:'*.asc=34:';
LS_COLORS=$LS_COLORS:'*.3des=34:';
LS_COLORS=$LS_COLORS:'*.aes=34:';
LS_COLORS=$LS_COLORS:'*.enc=34:';
LS_COLORS=$LS_COLORS:'*.sqlite=34:';
export LS_COLORS;
# converted using https://github.com/lucas-flowers/gnu2bsd.git
export LSCOLORS='exfxfeaeBxdehexxxxxxea'

export COLOR_NONE="\[\e[0m\]"

## TODO: add theme support
export COLOR_PRIMARY=$solb2
export COLOR_BACKGROUND=$solb02
export COLOR_ACCENT=$solc
