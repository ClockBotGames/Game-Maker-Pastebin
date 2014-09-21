#define pastebin_init
///pastebin_init(devkey)
//Initializes the pastebin scripts

/*
Arguments:
devkey - Your Pastebin API Developer Key. You can find this on http://pastebin.com/api
*/
globalvar pastebin_developer_key;
pastebin_developer_key = string(argument0);
#define pastebin_login
///pastebin_login(username,password)
//Generates a pastebin userkey which can be used to do things specific to a user
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

/*
Arguments:
username - The username of the account you wish to use
password - The password of the account you wish to use
*/

var user, pass, str, request;
user = argument0;
pass = argument1;

str = "api_dev_key="+pastebin_developer_key+"&api_user_name="+user+"&api_user_password="+pass;

return (http_post_string("http://pastebin.com/api/api_login.php",str));
#define pastebin_post
///pastebin_post(code)
//Creates a new paste and uploads it to pastebin
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

/*
Arguments:
code - The text you wish to upload
*/


var code, str;
code = string(argument0);
str = "api_option=paste"+"&api_dev_key="+pastebin_developer_key+"&api_paste_code="+code;

return (http_post_string("http://pastebin.com/api/api_post.php",str));
#define pastebin_post_ext
///pastebin_post_ext(code,name,format,privacy,expire,[userkey])
//Creates a new paste and uploads it to pastebin with additional options
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

/*
Arguments:
code - The text you wish to upload
name - The name of your paste
[format] - The syntax highlighting for this paste - More detail: http://pastebin.com/api#5 - *Optional*
[privacy] - The privacy of the paste - 0 for Public, 1 for Unlisted, 2 for Private (requires login) - *Optional*
[expire] - When this paste will expire - More detail: http://pastebin.com/api#6 - *Optional*
[userkey] - A userkey for the account you wish to tie the paste to - *Optional*
*/


var code, name, str;
code = string(argument[0]);
name = string(argument[1]);

str = "api_option=paste"
+"&api_dev_key="+pastebin_developer_key
+"&api_paste_code="+code
+"&api_paste_name="+name;

if (argument_count > 2)
    {
    format = string(argument[2]);
    str += "&api_paste_format="+format;
    }
if (argument_count > 3)
    {
    privacy = string(argument[3]);
    str += "&api_paste_private="+privacy;
    }
if (argument_count > 4)
    {
    expire = string(argument[4]);
    str += "&api_paste_expire_date="+expire;
    }
if (argument_count > 5)
    {
    var userkey;
    userkey = string(argument[5]);
    str += "&api_user_key="+userkey;
    }

return (http_post_string("http://pastebin.com/api/api_post.php",str));

#define pastebin_delete_paste
///pastebin_delete_paste(userkey,pasteid)
//Deletes a given paste - Requires login
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

/*
Arguments:
userkey - A userkey for the account of the paste owner
pasteid - The eight character ID of the paste you wish to delete
*/

var userkey, pasteid, str;
userkey = string(argument0);
pasteid = string(argument1);

str = "api_dev_key="+pastebin_developer_key
+"&api_option=delete"
+"&api_user_key="+userkey
+"&api_paste_key="+pasteid;

return (http_post_string("http://pastebin.com/api/api_post.php",str));
#define pastebin_get_userpastes
///pastebin_get_userpastes(userkey,[limit])
//Fetches a list of the given user's pastes
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

/*
userkey - A userkey for the account whose pastes you wish to fetch
[limit] - How many pastes to show - *Optional*
*/

var userkey, limit, str;
userkey = string(argument[0]);
limit = "";
if (argument_count > 1)
    {
    limit = string(argument[1]);
    }

str = "api_option=list"
+"&api_dev_key="+pastebin_developer_key
+"&api_user_key="+userkey
+"&api_results_limit="+limit;

return (http_post_string("http://pastebin.com/api/api_post.php",str));
#define pastebin_get_trending
///pastebin_get_trending()
//Fetches a list of the eighteen trending pastes
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

return (http_post_string("http://pastebin.com/api/api_post.php","api_option=trends&api_dev_key="+pastebin_developer_key));
#define pastebin_get_userdetails
///pastebin_get_userdetails(userkey)
//Fetches a list of information about the given user
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

/*
Arguments:
userkey - A userkey for the account whose details you wish to fetch
*/

var userkey, str;

userkey = string(argument0);

str = "api_dev_key="+pastebin_developer_key
+"&api_option=userdetails"
+"&api_user_key="+userkey;

return (http_post_string("http://pastebin.com/api/api_post.php",str));
#define pastebin_get_paste
///pastebin_get_paste(pasteid)
//Fetches a given paste
//This script will trigger an Asynchronous HTTP event. The API response will be stored in the temporary DS Map async_load.

/*
Arguments:
pasteid - The eight character ID for the paste you wish to fetch
*/

var pasteid;
pasteid = string(argument0);
return (http_get("http://pastebin.com/raw.php?i="+pasteid));
