$(function () {
    let audioPlayer = null;
    window.addEventListener('message', function (event) {
        const data = event.data;
        if (data !== undefined) {
            if (data.display && !data.IsPauseMenuActive) {
                $('#titleText').html(data.titleText);
                $('#subText').html(data.subText);
                $('#txtMin').html(data.txtMin);
                $('#txtSec').html(data.txtSec);
                $('.container').fadeIn();
            } else {
                $('.container').fadeOut();
            }

            if (data.transactionType === "playSound") {
                if (audioPlayer != null) {
                    audioPlayer.pause();
                    audioPlayer.currentTime = 0;
                }
                audioPlayer = new Audio("./sounds/" + data.transactionFile + ".mp3");
                audioPlayer.volume = data.transactionVolume;
                audioPlayer.play();
            } else if (data.transactionType === "stopSound") {
                audioPlayer.pause();
                audioPlayer.currentTime = 0;
            }
        }
    }, false);
});
