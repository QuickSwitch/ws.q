\d .ws

w:([h:`int$()] hostname:`$();callback:`$())                             //table for recording open websockets

.z.ws:{value[w[.z.w]`callback]x}                                        //pass messages to relevant handler

hd:()!()                                                                //default headers for request
hd[`Upgrade]:"websocket";
hd[`Connection]:"Upgrade";
hd[`$"Sec-WebSocket-Version"]:"13";

open0:{
  u:.Q.hap[hsym$[10=type x;`$;]x];                                      //parse URL
  d:hd;                                                                 //get headers
  d[`Host]:u 2;                                                         //insert host
  d[`Origin]:u 2;                                                       //insert origin
  d:("\r\n" sv ": " sv/:flip ({string key x};value)@\:d),"\r\n\r\n";    //convert dictionary to HTTP headers
  h:first r:(hsym`$raze u 0 2)"GET ",u[3]," HTTP/1.1\r\n",d;            //send request, get list of handle & response
  w,:(h;`$u 2;y);                                                       //record handle & callback in table
  :r;
 }

open:{neg first open0[x;y]}                                             //return neg handle for messaging

\d .
