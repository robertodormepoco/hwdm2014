#!/bin/sh

awk -F'\t' '{
	if($5 != "") print $1"\t"$5
}' $1 | sort |
awk -F'\t' '
BEGIN{
	count = 0;
	lastUser = $1;
	lastSong = $2;
	songIndex = 0;
}
{
	curUser = $1;
	curSong = $2;
	if(curSong != "") {
		if(lastUser == curUser){
			if(lastSong == curSong){
				count += 1;
			}else{
				count = 1;
				lastSong = curSong;
			}
		}else{	
			for(i = 0; i < songIndex; i++) {
				res = res " " songs[i];
			}
			if( songIndex > 0 )
				print lastUser "\t" res;
			lastUser = curUser;
			res = "";
	                songIndex = 0;
			delete songs;
			lastSong = curSong;
			count = 1;
		}
		if(count == 20){
			songs[songIndex] = lastSong;
	                songIndex += 1;
		}
	}
}
END{
    for(i = 0; i < songIndex; i++) {
        res = res " " songs[i];
    }
    if( songIndex > 0 )
        print lastUser "\t" res;
}'

