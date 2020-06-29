package folderNode.folder;
import js.node.Http;
import js.node.ChildProcess;
import js.node.Fs;
import js.node.fs.WriteStream;
class DownLoadToLocal{
    public static var log: String -> Void;
    public function new(){}
    public static inline function load( fileName: String
                        , url_: String
                        , loada_: Void->Void
                        , progress_: Int->Void
                        , error_: String->Void ){
        DownLoadToLocal.log('DownLoad.load');
        var file = js.node.Fs.createWriteStream( fileName );
        var request = js.node.Http.get( url_, function( response ) {
            //this.setHeader ("Content-type", "application/json"); 
            DownLoadToLocal.log( 'requesting ' + url_ );
            var str: String = response.headers['content-length'];
            var len: Int = Std.parseInt( str );
            var ratio = 100/len;
            DownLoadToLocal.log(' load ' );
            response.pipe( file ).on('finish'
                                    , function() { 
                                        DownLoadToLocal.log(' finish ' );
                                        file.end();
                                        loada_();
                                      });
            response.on( 'data', function( chunk ) {
                len -= chunk.length;
                progress_( Math.ceil( len*ratio ) );
                DownLoadToLocal.log(' loading...' );
              });
        });
        DownLoadToLocal.log('DownLoad.request');
        request.on( 'error', function( err){
            DownLoadToLocal.log( 'error ' + err );
            error_( err );
        });
    }
}
