package folderNode.folder;
import js.node.Fs;
import js.node.Readline;
class ReadFile{
    var onLine: Int->String->Void;
    var finished: Void->Void;
    var lineNo: Int;
    public function new(  file_: String
                        , onLine_: Int->String->Void
                        , finished_: Void->Void ){
        onLine = onLine_;
        finished = finished_;
        var file = file_;
        lineNo = 0;
        var readLine = Readline.createInterface({
          input: Fs.createReadStream( file )
        });
        readLine.on('line',     onReadLine );
        readLine.on('close', onFinished );
    }
    function onReadLine( str ){
        onLine( lineNo, str );
        lineNo++;
    }
    function onFinished( ){
        finished();
    }
}