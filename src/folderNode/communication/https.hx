package hxTShopify.connection;
import haxe.Http;
import haxe.Json;
import js.html.XMLHttpRequest;
class Https<THolder> {
    public var onError:     String -> Void;
    public var onStatus:    Int -> Void;
    public var onLoad:      THolder -> Void;
    public var onDelete:    String -> Void;
    public function new(){}
    public function get( url: String, pass: String ) {
        var req: Http = new Http( url );
        req.addHeader( "Content-type", "application/json" );
        req.setHeader( 'Authorization', 'Basic $pass' );
        req.onError  = function( error: String ) if( onError != null  ) onError( error );
        req.onStatus = function( status: Int )   if( onStatus != null ) onStatus( status );
        req.onData   = function( data:   String ) {
            var holder: THolder = haxe.Json.parse( data );
            onLoad( holder );
        };
        req.request( false );
    }
    public function post( url: String, payload: Dynamic, pass: String ) {
        var req: Http = new Http( url );
        req.setPostData( Json.stringify( payload ) ); 
        req.addHeader( "Content-type", "application/json" );
        req.setHeader( 'Authorization', 'Basic $pass' );
        req.onError  = function( error:  String ) if( onError != null )  onError( error );
        req.onStatus = function( status: Int )    if( onStatus != null ) onStatus( status );
        req.onData   = function( data:   String ) {
            var holder: THolder = haxe.Json.parse( data );
            onLoad( holder );
        };
        req.request( true );
    }
    public function put( url: String, payload: Dynamic, pass: String ){
        var http = new XMLHttpRequest();
        http.onreadystatechange = function(){
            if( http.readyState == 4 ){
                if( http.status == 200 ){
                    var holder: THolder = haxe.Json.parse( http.responseText );
                    onLoad( holder );
                } else {
                    onError( Std.string( http.status ) );
                }
            }
        }
        http.open( "PUT", url, true );
        http.withCredentials = true;
        http.setRequestHeader( "Content-type", "application/json" );
        http.setRequestHeader( 'Authorization', 'Basic $pass' );
        http.send( Json.stringify( payload ) );
    }
    public function delete( url: String, id: String, pass: String ){
        var http = new XMLHttpRequest();
        http.onreadystatechange = function(){
            if( http.readyState == 4 ){
                if( http.status == 200 ){
                    onDelete( id );
                } else {                    
                    onError( Std.string( http.status ) );
                }
            }
        }
        http.open( "DELETE", url, true );
        http.withCredentials = true;
        http.setRequestHeader( "Content-type", "application/json" );
        http.setRequestHeader( 'Authorization', 'Basic $pass' );
        http.send();
    }
}