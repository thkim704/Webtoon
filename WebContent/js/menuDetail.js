const menu=document.querySelector(".menu");
const
subBar=document.querySelector(".menu>.sub");

let subToggle=true,i=0;
let _up,_down;
const framerate=120/1000;
function up(){
	subBar.style.height='${i++}px';
	if(i>120){
		clearInerval(_up);
	}
}

function down(){
	subBar.style.height='${i--}px';
	if(i<0){
		clearInterval(_down);
	}
}

function slide_menu(){
	if(subToggle){
		clearInterval(_down);
		_up=setInterval(up,framerate);
		subToggle=!subToggle;
	}else{
		clearInterval(_up);
		_down=setInterval(down,framerate);
		subToggle=!subToggle;
	}
}

menu.addEventListener("click",slide_menu);