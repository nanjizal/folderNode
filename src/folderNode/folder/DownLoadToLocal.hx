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
        DownLoaderToLocal.log('DownLoad.load');
        var file = js.node.Fs.createWriteStream( fileName );
        var request = js.node.Http.get( url_, function( response ) {
            //this.setHeader ("Content-type", "application/json"); 
            DownLoaderToLocal.log( 'requesting ' + url_ );
            var len = Std.parseInt(response.headers['content-length']);
            var ratio = 100/len;
            DownLoaderToLocal.log(' load ' );
            response.pipe( file ).on('finish'
                                    , function() { 
                                        DownLoaderToLocal.log(' finish ' );
                                        file.end();
                                        loada_();
                                      });
            response.on( 'data', function( chunk ) {
                len -= chunk.length;
                progress_( Math.ceil( len*ratio ) );
                DownLoaderToLocal.log(' loading...' );
              });
        });
        DownLoaderToLocal.log('DownLoad.request');
        request.on( 'error', function( err){
            DownLoaderToLocal.log( 'error ' + err );
            error_( err );
        });
    }
}
