pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- flappy bird
-- by thomas nguyen
#include globals.p8.lua
#include extras.p8.lua
#include timer.p8.lua

#include pipe.p8.lua
#include bird.p8.lua
#include scoreboard.p8.lua

#include main.p8.lua

__gfx__
bbbbb000000bbbbbb0000bbbbbbbbbbbbbbbbbbb00000000000000000000000000000000c0f7fffbfbbbbbbbbbbbbbbbbb3b330c000000000000000000000000
bbb007770770bbbb077770bbbbbbbbbbbbbbbbbb03f777777777777777f7fffffffffb30c0f7fffbfbbbbbbbbbbbbbbbbb3b330c777777777777777777777777
bb077aa077770bbb0777770bb00000bbbbbbbbbb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330c0f7fffbfbbbbbbbbbbbbbbbbb3b330cbbfffbbbfffbbbfffbbbfffb
b07aaaa0677070bb0a777a0b0777770bb00000bb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330c0f7fffbfbbbbbbbbbbbbbbbbb3b330cbfffbbbfffbbbfffbbbfffbb
0aaaaaa0677070bbb0aaa0bb0a777a0b0a777a0b0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330c0f7fffbfbbbbbbbbbbbbbbbbb3b330cfffbbbfffbbbfffbbbfffbbb
0aaaaaaa067770bbbb000bbbb00000bb077770bb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330c0f7fffbfbbbbbbbbbbbbbbbbb3b330cffbbbfffbbbfffbbbfffbbbf
0aaaaaaaa000000bbbbbbbbbbbbbbbbb077a0bbb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330c0f7fffbfbbbbbbbbbbbbbbbbb3b330cfbbbfffbbbfffbbbfffbbbff
0aaaaaaa08888880bbbbbbbbbbbbbbbbb0000bbb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330c0f7fffbfbbbbbbbbbbbbbbbbb3b330c333333333333333333333333
b09999908000000bb0000bbbbbbbbbbbbbbbbbbb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330bbb77777777777777bbbbbbbbb0bbbbbb0000bbbbbbbbbbbbbbbbbbb
b09999990888880b077770bbbbbbbbbbbbbbbbbb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330bb788888888888887bbbbbbbb000bbbb077770bbbbbbbbbbbbbbbbbb
bb009999900000bb0777770bb00000bbbbbbbbbb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330b7887778878877787bbbbbbb00000bbb0777770bb00000bbbbbbbbbb
bbbb00000bbbbbbb0877780b0777770bb00000bb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b33078888788787878787bbbbbbbb000bbbb0c777c0b0777770bb00000bb
bbbbbbbbbbbbbbbbb08880bb0877780b0877780b0f7ffbfbbbbbbbbbbbbbbbbbbbb3b33078888788777877787bbbbbbbb000bbbbb0ccc0bb0c777c0b0c777c0b
bbbbbbbbbbbbbbbbbb000bbbb00000bb077770bb0f7ffbfbbbbbbbbbbbbbbbbbbbb3b330b7888788787878887bbbbbbbb000bbbbbb000bbbb00000bb077770bb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb07780bbb03333333333333333333333333333330bb788888888888887bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb077c0bbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000bbb00000000000000000000000000000000bbb77777777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000bbb
bbbbb000000bbbbbbbbbb000000bbbbbbbbbb000000bbbbbccccc000000cccccb0000bbbbbbbbbbbbbbbbbbbbbbbbbbb000000bbbbbbbbbbbb00000bbbbbbbbb
bbb007770770bbbbbbb007770770bbbbbbb007770770bbbbccc007770770cccc077770bbbbbbbbbbbbbbbbbbbbbbbb007770770bbbbbbbbbb0777770bbbbbbbb
bb07788077770bbbbb077cc077770bbbbb077ee077770bbbcc077bb077770ccc0777770bb00000bbbbbbbbbbbbbbb07766077770bbbbbbbb076060670bbbbbbb
b0788880677070bbb07cccc0677070bbb07eeee0677070bbc07bbbb0677070cc0e777e0b0777770bb00000bbbbbb0766660677070bbbbbbb066606660bbbbbbb
08888880677070bb0cccccc0677070bb0eeeeee0677070bb0bbbbbb0677070ccb0eee0bb0e777e0b0e777e0bbbb06666660677070bbbbbbb066060660bbbbbbb
08888888067770bb0ccccccc067770bb0eeeeeee067770bb0bbbbbbb067770ccbb000bbbb00000bb077770bbbbb06666666067770bbbbbbb506666605bbbbbbb
088888888000000b0cccccccc000000b0eeeeeeee000000b0bbbbbbbb000000cbbbbbbbbbbbbbbbb077e0bbbbbb000006666000000bbbbbbb5000005bbbbbbbb
08888888088888800ccccccc088888800eeeeeee088888800bbbbbbb08888880bbbbbbbbbbbbbbbbb0000bbbbb06777606606666660bbbbbbb55555bbbbbbbbb
b04444408000000bb01111108000000bb0ddddd08000000bc03333308000000cc0000cccccccccccccccccccbb0777706606000000bbbbbb8888888888888888
b04444440888880bb01111110888880bb0dddddd0888880bc03333330888880c077770cccccccccccccccccc0b0776066660666660bbbbbb8788787778788878
bb004444400000bbbb001111100000bbbb00ddddd00000bbcc003333300000cc0777770cc00000cccccccccc0bb00006666600000bbbbbbb8778787888787878
bbbb00000bbbbbbbbbbb00000bbbbbbbbbbb00000bbbbbbbcccc00000ccccccc0b777b0c0777770cc00000ccb0bbbbb00000bbbbbbbbbbbb8787787778787878
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbccccccccccccccccc0bbb0cc0b777b0c0b777b0cbb00bbbbbbbbbbbbbbbbbbbb8788787888787878
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccc000cccc00000cc077770cc0bbbbbbbbbbbbbbbbbbbbbbb8788787778878788
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc077b0cccb00bbbbbbbbbbbbbbbbbbbbb8888888888888888
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbccccccccccccccccccccccccccccccccc0000cccbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
0000000bb000000b0000000b0000000b0000000b0000000b0000000b0000000b0000000b0000000bbb000000bbbbb000bb000000bb000000bb000000bb000000
07777700b07777000777770007777700077077000777770007777700077777000777770007777700bb077770bbbbb070bb077770bb077770bb070070bb077770
07777700b07777000777770007777700077077000777770007777700077777000777770007777700bb070070bbbbb070bb000070bb000070bb070070bb070000
07777700b07777000777770007777700077077000777770007777700077777000777770007777700bb070070bbbbb070bb077770bb077770bb077770bb077770
07777700b07777000000770000007700077077000770000007700000077077000770770007707700bb070070bbbbb070bb070000bb000070bb000070bb000070
07707700b00777000777770007777700077077000777770007777700077077000777770007777700bb077770bbbbb070bb077770bb077770bbbbb070bb077770
07707700bb0777000777770007777700077777000777770007777700077077000777770007777700bb000000bbbbb000bb000000bb000000bbbbb000bb000000
07707700bb0777000777770007777700077777000777770007777700000077000777770007777700bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
07707700bb0777000777770007777700077777000777770007777700b00077000777770007777700bb000000bb000000bb000000bb0000000000000000000000
07777700bb0777000770000000007700000077000000770007707700bbb077000770770000007700bb077770bb077770bb077770bb0777700000000000000000
07777700bb0777000777770007777700b00077000777770007777700bbb077000777770007777700bb070000bb000070bb070070bb0700700000000000000000
07777700bb0777000777770007777700bbb077000777770007777700bbb077000777770007777700bb077770bbbbb070bb077770bb0777700000000000000000
07777700bb0777000777770007777700bbb077000777770007777700bbb077000777770007777700bb070070bbbbb070bb070070bb0000700000000000000000
00000000bb0000000000000000000000bbb000000000000000000000bbb000000000000000000000bb077770bbbbb070bb077770bb0777700000000000000000
b0000000bbb00000b0000000b0000000bbbb0000b0000000b0000000bbbb0000b0000000b0000000bb000000bbbbb000bb000000bb0000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000
77777777777777777777bbbbbbbbbbbbbbbbbbbbbb77777777777777bbbbbbbbb77777777777777777777777777bbbb7777777777777777777777777777bbbbb
70000000000000000007777777777777777777777b7000000000000777777777b70000077000000000000000007777b7000000000000000000007700007bbbbb
70aaaaaa0aaa0aaaaa00000000000000000000007b70aaaaaaa0aa0000000007770aaa077099999909999909900007b709999990999990999990770990777777
70aaaaaa0aaa0aaaaa0aaaaaa0aaaaa0aaa0aaa07b70aaaaaaa0aa0aaaaaaa00000aaa077099999909999909999907b709999990999990777990000900000007
70aa00000aa0000aaa0aaaaaa0aaaaa0aaa0aaa07b70aaa0aaa0000aaaaaaa0aaaaaaa077099777709979909999907b709979990997900000990999909909907
70aaaaaa0aa0aaaaaa0aa0aaa0aa0aa0aaa0aaa07b70aaaaaaa0aa0aaaaaaa0aaaaaaa077099000009909909977707b709909990990909999990999909909907
70aaaaaa0aa0aaaaaa0aa0aaa0aa0aa0aaa0aaa07b70aaaaaa00aa0aaa0aaa0aaaaaaa077099099909999909900007b709909990999909999990999909909907
70997777099099799909909990990990999999907b7099999990990999000009990999077099099909999909909907b709999990999909999990997909999907
70990000099099099909999990999990999999907b7099979990990999077709990999077099099909977709909907b709999970997709997990990909999907
70990777099099999909999990999990777999907b709990999099099907b709990999077099099909900009999907b709999900990009990990990907779907
709907b7099099999909999990999990000999907b709999999099099907b709999999077099999909999909999907b709979990999909999990999900009907
707707b7077077777709997770999777099999907b707777777077077707b707777777077077777707777707777707b707707770777707777770777770999907
700007b7000000000009990000999000099999907b700000000000000007b700000000077000000000000000000007b700000000000000000000000000999907
777777b7777777777707770770777077077777707b777777777777777777b777777777777777777777777777777777b777777777777777777777777770777707
bbbbbbbbbbbbbbbbb700000770000077000000007bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb70000007
bbbbbbbbbbbbbbbbb777777777777777777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb77777777
7777777777777777bbbbbb777777777b7777777777bbbbb7777777777bbbbbbbeeeee777777dddddfefd77777777777777000000000000000000000000000000
7000000000000007777777700000007b70000000077777770000000777777777eeeee777777dfffffffd777777777777ee000000000000000000000000000000
7099999909999900000000009999907b70999999000000000999990000000007eeeddddddd7dfefefefdddd77777777eee000000000000000000000000000000
7099999909999909999999909999907b70999999099909990999990999999907eeedffffed7dfefefefdefd7777777eeee000000000000000000000000000000
7099777707779909999999909979907b70999799099909990997990999999907eeedfeffed7dfffffffdddddddd777eeee000000000000000000000000000000
7099000000009909979979909909907b70999099099909990990990999799907dddddddddd7dfefefefdefffffdee7eeee000000000000000000000000000000
7099099099999909909909909999907b70999099099909990999990999077707dffffffeed7dfefefefdefffffdee7eeee00000000000000dddd777777777777
7099099099999909909909909999907b70999099099909990999990999000007defefefeed7dfffffffdefefefdee7eeee00000000000000fffd777777777777
7099099099979909909909909977707b70999999099909990997770999077777defefefeed7dfffffffdefefefdee7eeee000000000000000000000000000000
7099099099909909909909909900007b7099999909999999099000099907bbbbdfffffddddddfefefefdefffffdee7eeee000000000000000000000000000000
7099999099999909909909909999907b7099999907999997099999099907bbbbdefefedfffedfefefefdefefefdee7eeee000000000000000000000000000000
7077777077777707707707707777707b7077777700777770077777077707bbbbdefefedfefedfffffffdefefefdeeeeeee000000000000000000000000000000
7000000000000000000000000000007b7000000007000007000000000007bbbbdfffffdfefedfefefefdefffffdeeeeeee000000000000000000000000000000
7777777777777777777777777777777b7777777777777777777777777777bbbbdefefedfffedfefefefdefefefdeeeeeee000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdefefedfffedfffffffdefefefdeeeeeee00000000000000777777777777eeed
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdfffffdfffedfffffffdefffffdeeeeeee00000000000000777777777777e66d
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777700000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777777000000000000000000000000
00000077777700000000000000000000000000000000000000000000000000000000000000077777700000000000777777777777770000000000000000000000
00007777777777000000000000000000000000000000000000000000000000000000000007777777777700000007777777777777777000000000000000000000
00777777777777770000000000000000000000000007777770000000000000000000000777777777777777000077777777777777777000000000000000000000
07777777777777777000000000000000000000000777777777700000000000777777007777777777777777770777777777777777777700000000000000000000
77777777777777777700000000000000000000077777777777777000000077777777777777777777777777777777777777777777777700000000000000000000
77777777777777777770000000000000000000777777777777777700007777777777777777777777777777777777777777777777777700000000000000000000
77777777777777777770000000000000000007777777777777777770077777777777777777777777777777777777777777777777777700000000000000000000
77777777777777777777000007777770000077777777777777777777777777777777777777777777777777777777777777777777777700000000000000000000
77777777777777777777007777777777770077777777777777777777777777777777777777777777777777777777777777777777777700000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033330000000000033330000003333000000000003333000033330000000000000000000000000000000000000000000000000000000000000000000
000000033bbbb33000000033bbbb330033bbbb33000000033bbbb3333bbbb3300000000000000000000000000000000000000000000000000000000000000000
0000033bbbbbbbb33003333bbbbbbb33bbbbbbbb33003333bbbbbbb33bbbbbb33003300000000000000000000000000000000000000000000000000000000000
33303bbbbbbbbbb3333bbbb33bbbbbbb3bbb3333bb33bbbb33bbbbbbb3bbbb33333bb00000000000000000000000000000000000000000000000000000000000
bbb33bbbbbbbbbb33bbbbbbbb33bbbbb3b33bbbb33bbbbbbbb33bbbbb3bb33bbbbbbb00000000000000000000000000000000000000000000000000000000000
bbbbb33bb3333b3bbbbbbbbbbbb3bbb3333bbbb3bbbbbbbbbbbb3bbbb3333bbbbbbbb00000000000000000000000000000000000000000000000000000000000
bbbbbbb33bbbb33bbbbbbbbbbbb3b33bbbb33bb3bbbbbbbbbbbb3bb33bbbb33bbbbbb00000000000000000000000000000000000000000000000000000000000
bbbbb33bbbbbbbb33bbbbbbbbbb33bbbbbbbb33bbbbbbbbbbbbbb33bbbbbbbb33bbbb00000000000000000000000000000000000000000000000000000000000
bbbb3bbbbbbbbbbbb3bbbbbbbb3bbbbbbbbbbb3bbbbbbbbbbbbbb3bbbbbbbbbbb3bbb00000000000000000000000000000000000000000000000000000000000
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccc77777777777777ccccccccc7777777cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70000000000000000007777777777777777777777c7000000000000777777777c7000007cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70aaaaaa0aaa0aaaaa00000000000000000000007c70aaaaaaa0aa0000000007770aaa07cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70aaaaaa0aaa0aaaaa0aaaaaa0aaaaa0aaa0aaa07c70aaaaaaa0aa0aaaaaaa00000aaa07cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70aa00000aa0000aaa0aaaaaa0aaaaa0aaa0aaa07c70aaa0aaa0000aaaaaaa0aaaaaaa07cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70aaaaaa0aa0aaaaaa0aa0aaa0aa0aa0aaa0aaa07c70aaaaaaa0aa0aaaaaaa0aaaaaaa07cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70aaaaaa0aa0aaaaaa0aa0aaa0aa0aa0aaa0aaa07c70aaaaaa00aa0aaa0aaa0aaaaaaa07cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70997777099099799909909990990990999999907c709999999099099900000999099907cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70990000099099099909999990999990999999907c709997999099099907770999099907cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc70990777099099999909999990999990777999907c709990999099099907c70999099907cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc709907c7099099999909999990999990000999907c709999999099099907c70999999907cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc707707c7077077777709997770999777099999907c707777777077077707c70777777707cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc700007c7000000000009990000999000099999907c700000000000000007c70000000007cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc777777c7777777777707770770777077077777707c777777777777777777c77777777777cccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccc700000770000077000000007ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccc777777777777777777777777ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc007770770cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc077aa077770ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000aaa0677070cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc077770aa0677070cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc0777770aa067770cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc0a777a0aaa000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc0aaa0aaa08888880cccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00099908000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc09999990888880ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc009999900000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777cccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc7777777777cccccccccccccccccccccccc
cccccc777777ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777ccccccccccc77777777777777cccccccc777777cccccccc
cccc7777777777ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777ccccccc7777777777777777ccccc7777777777cccccc
cc77777777777777ccccccccccccccccccccccccccc777777cccccccccccccccccccccc777777777777777cccc77777777777777777ccc77777777777777cccc
c7777777777777777cccccccccccccccccccccccc7777777777ccccccccccc777777cc777777777777777777c7777777777777777777c7777777777777777ccc
777777777777777777ccccccccccccccccccccc77777777777777ccccccc777777777777777777777777777777777777777777777777777777777777777777cc
7777777777777777777ccccccccccccccccccc7777777777777777cccc777777777777777777777777777777777777777777777777777777777777777777777c
7777777777777777777cccccccccccccccccc777777777777777777cc7777777777777777777777777777777777777777777777777777777777777777777777c
77777777777777777777ccccc777777ccccc77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777cc777777777777cc77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777eeeddddd77777777777777777777777777eeeddddd77777777777777777777777777eeeddddd77777777777777777777777777
77777777777777777777777777e66dfffd77777777777777777777777777e66dfffd77777777777777777777777777e66dfffd77777777777777777777777777
77777777777777eeeee777777dddddfefd77777777777777eeeee777777dddddfefd77777777777777eeeee777777dddddfefd77777777777777eeeee777777d
777777777777eeeeeee777777dfffffffd777777777777eeeeeee777777dfffffffd777777777777eeeeeee777777dfffffffd777777777777eeeeeee777777d
ddd77777777eeeeeeddddddd7dfefefefdddd77777777eeeeeeddddddd7dfefefefdddd77777777eeeeeeddddddd7dfefefefdddd77777777eeeeeeddddddd7d
efd7777777eeeeeeedffffed7dfefefefdefd7777777eeeeeeedffffed7dfefefefdefd7777777eeeeeeedffffed7dfefefefdefd7777777eeeeeeedffffed7d
ddddddd777eeeeeeedfeffed7dfffffffdddddddd777eeeeeeedfeffed7dfffffffdddddddd777eeeeeeedfeffed7dfffffffdddddddd777eeeeeeedfeffed7d
efffffdee7eeeedddddddddd7dfefefefdefffffdee7eeeedddddddddd7dfefefefdefffffdee7eeeedddddddddd7dfefefefdefffffdee7eeeedddddddddd7d
efffffdee7eeeedffffffeed7dfefefefdefffffdee7eeeedffffffeed7dfefefefdefffffdee7eeeedffffffeed7dfefefefdefffffdee7eeeedffffffeed7d
efefefdee7eeeedefefefeed7dfffffffdefefefdee7eeeedefefefeed7dfffffffdefefefdee7eeeedefefefeed7dfffffffdefefefdee7eeeedefefefeed7d
efefefdee7eeeedefefefeed7dfffffffdefefefdee7eeeedefefefeed7dfffffffdefefefdee7eeeedefefefeed7dfffffffdefefefdee7eeeedefefefeed7d
efffffdee7eeeedfffffddddddfefefefdefffffdee7eeeedfffffddddddfefefefdefffffdee7eeeedfffffddddddfefefefdefffffdee7eeeedfffffdddddd
efefefdee7eeeedefefedfffedfefefefdefefefdee7eeeedefefedfffedfefefefdefefefdee7eeeedefefedfffedfefefefdefefefdee7eeeedefefedfffed
efefefdeeeeeeedefefedfefedfffffffdefefefdeeeeeeedefefedfefedfffffffdefefefdeeeeeeedefefedfefedfffffffdefefefdeeeeeeedefefedfefed
efffffdeeeeeeedfffffdfefedfefefefdefffffdeeeeeeedfffffdfefedfefefefdefffffdeeeeeeedfffffdfefedfefefefdefffffdeeeeeeedfffffdfefed
efefefdee3333edefefedfff3333fefefd3333efdeeeeeeed3333edff3333efefefdefefefdeee3333defefedfffe3333efefde3333fdeeeeeeede3333dfff33
efefefd33bbbb33efefedf33bbbb33ff33bbbb33deeeeee33bbbb3333bbbb33ffffdefefefde33bbbb33fefedff33bbbb33ff33bbbb33eeeeeee33bbbb3333bb
effff33bbbbbbbb33ff3333bbbbbbb33bbbbbbbb33ee3333bbbbbbb33bbbbbb33ff33fffff33bbbbbbbb33ff3333bbbbbbb33bbbbbbbb33ee3333bbbbbbb33bb
333c3bbbbbbbbbb3333bbbb33bbbbbbb3bbb3333bb33bbbb33bbbbbbb3bbbb33333bb333c3bbbbbbbbbb3333bbbb33bbbbbbb3bbb3333bb33bbbb33bbbbbbb3b
bbb33bbbbbbbbbb33bbbbbbbb33bbbbb3b33bbbb33bbbbbbbb33bbbbb3bb33bbbbbbbbbb33bbbbbbbbbb33bbbbbbbb33bbbbb3b33bbbb33bbbbbbbb33bbbbb3b
bbbbb33bb3333b3bbbbbbbbbbbb3bbb3333bbbb3bbbbbbbbbbbb3bbbb3333bbbbbbbbbbbbb33bb3333b3bbbbbbbbbbbb3bbb3333bbbb3bbbbbbbbbbbb3bbbb33
bbbbbbb33bbbb33bbbbbbbbbbbb3b33bbbb33bb3bbbbbbbbbbbb3bb33bbbb33bbbbbbbbbbbbb33bbbb33bbbbbbbbbbbb3b33bbbb33bb3bbbbbbbbbbbb3bb33bb
bbbbb33bbbbbbbb33bbbbbbbbbb33bbbbbbbb33bbbbbbbbbbbbbb33bbbbbbbb33bbbbbbbbb33bbbbbbbb33bbbbbbbbbb33bbbbbbbb33bbbbbbbbbbbbbb33bbbb
bbbb3bbbbbbbbbbbb3bbbbbbbb3bbbbbbbbbbb3bbbbbbbbbbbbbb3bbbbbbbbbbb3bbbbbbb3bbbbbbbbbbbb3bbbbbbbb3bbbbbbbbbbb3bbbbbbbbbbbbbb3bbbbb
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
fffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbff
ffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfff
fbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffb
bbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbb
bbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbb
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

