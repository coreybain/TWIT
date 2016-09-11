var request = require('request');

function twitConnect(url, showID, pageNum, callback) {
    var jsonBody = ""
    var baseURL = "https://twit.tv/api/v1.0/" + url
    console.log(baseURL);
    if (!(pageNum == undefined) && !(showID == undefined)) {
        baseURL += "?page=" + pageNum + "&filter%5Bshows%5D=" + showID;
    } else if (!(pageNum == undefined)) {
        baseURL += "?page=" + pageNum;
    } else if (!(pageNum == undefined)) {
        baseURL += "?filter%5Bshows%5D=" + showID;
    }
    console.log(baseURL);
    request({
        url: baseURL,
        method: "GET",
        headers: {
        'Accept': 'application/json',
        'app-id': '3e742ac7',
        'app-key': '2a6557daace8c6524cc82af2e718fbcc'
        }
    },function(error, response, body){
    if(!error && response.statusCode == 200){
        console.log('YES');
        jsonBody = JSON.parse(body);
        callback(JSON.parse(body));

    }else{
        console.log('error' + response.statusCode);
    } 
    });
}
module.exports.twitConnect = twitConnect;