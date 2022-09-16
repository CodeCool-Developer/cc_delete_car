$(function () {
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
        }
    }, false);
});
