pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- flappy bird
-- by thomas nguyen
#include globals.p8.lua
#include extras.p8.lua

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
__label__
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111117777777777777777777711111111111111111111117777777777777711111111177777771111111111111111111111111111
11111111111111111111111111117000000000000000000777777777777777777777717000000000000777777777170000071111111111111111111111111111
111111111111111111111111111170aaaaaa0aaa0aaaaa00000000000000000000007170aaaaaaa0aa0000000007770aaa071111111111111111111111111111
111111111111111111111111111170aaaaaa0aaa0aaaaa0aaaaaa0aaaaa0aaa0aaa07170aaaaaaa0aa0aaaaaaa00000aaa071111111111111111111111111111
111111111111111111111111111170aa00000aa0000aaa0aaaaaa0aaaaa0aaa0aaa07170aaa0aaa0000aaaaaaa0aaaaaaa071111111111111111111111111111
111111111111111111111111111170aaaaaa0aa0aaaaaa0aa0aaa0aa0aa0aaa0aaa07170aaaaaaa0aa0aaaaaaa0aaaaaaa071111111111111111111111111111
111111111111111111111111111170aaaaaa0aa0aaaaaa0aa0aaa0aa0aa0aaa0aaa07170aaaaaa00aa0aaa0aaa0aaaaaaa071111111111111111111111111111
11111111111111111111111111117099777709909979990990999099099099999990717099999990990999000009990999071111111111111111111111111111
11111111111111111111111111117099000009909909990999999099999099999990717099979990990999077709990999071111111111111111111111111111
11111111111111111111111111117099077709909999990999999099999077799990717099909990990999071709990999071111111111111111111111111111
11111111111111111111111111117099071709909999990999999099999000099990717099999990990999071709999999071111111111111111111111111111
11111111111111111111111111117077071707707777770999777099977709999990717077777770770777071707777777071111111111111111111111111111
11111111111111111111111111117000071700000000000999000099900009999990717000000000000000071700000000071111111111111111111111111111
11111111111111111111111111117777771777777777770777077077707707777770717777777777777777771777777777771111111111111111111111111111
11111111111111111111111111111111111111111111170000077000007700000000711111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111177777777777777777777777711111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111110000001111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111007770770111111111111111111111111111111111111111111111111111111111111
1111111111111111111111111111111111111111111111111111111111077bb07777011111111111111111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111111111111110000bbb06770701111111111111111111111111111111111111111111111111111111111
1111111111111111111111111111111111111111111111111111111077770bb06770701111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111110777770bb0677701111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111110b777b0bbb000000111111111111111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111111111111110bbb0bbb0888888011111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111100033308000000111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111103333330888880111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111110033333000001111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111100000111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111110000000000000000000000000000000000000111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111110777777777777777777777777777777777770111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbbb77b777b777b777b777bbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbb7bbbb7bb7b7b7b7bb7bbbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbb777bb7bb777b77bbb7bbbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbbbb7bb7bb7b7b7b7bb7bbbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbb77bbb7bb7b7b7b7bb7bbbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb70111111111111111111111111111111111111111111111
111111111111111111111111111111111111111111111107bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb70111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111110777777777777777777777777777777777770111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111110000000000000000000000000000000000000111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111110000000000000000000000000000000000000111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
ffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfff
fbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffb
bbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbbbfffbb
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777

