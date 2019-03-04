package folderNode.folder;
import sys.FileSystem;

class HomeFiles{
    public var log: String->Void;
    public var homeDir: String;
    public var appName: String;
    public function new( appName_: String ){
        appName = appName_;
        createHome();
    }
    public function createHome(){
        homeDir = untyped js.node.Os.homedir() +'/' + appName + '_appdata/'; // <- use $ instead to test.
        //log( homeDir );
        if( !FileSystem.exists( homeDir ) ) FileSystem.createDirectory( homeDir  );
    }
    public function createFolder( str: String ): Bool{
        var f = pathTo( str );
        if( !FileSystem.exists( f ) ) {
            FileSystem.createDirectory( f );
            if( log != null ) log( "created folder '" + str + "'");
            return false;
        } else {
            return true;
        }
    }
    public function createFileIfNeeded( fileName: String, content: String ){
        var p = pathTo( fileName );
        if( !FileSystem.exists( p ) ){
            sys.io.File.saveContent( p, content );
        }
    }
    public function pathTo( str: String ){
        return homeDir + '/' + str;
    }
    
    public static inline function getBytes( path : String ) : Null<haxe.io.Bytes> {
        var f = pathTo( str );
        if( FileSystem.exists( f ) ){
            return sys.io.File.getBytes( f );
        }
        return null;
    }
    
    public static inline function saveBytes( path : String, bytes : haxe.io.Bytes ) : Void {
        var f = pathTo( fileName );
        sys.io.File.saveBytes( f, b );
    }
    
    public function saveToFile( fileName: String, content: String ){
        var f = pathTo( fileName );
        sys.io.File.saveContent( f, content );
    }
    public function readFile( str: String ){
        var f = pathTo( str );
        if( FileSystem.exists( f ) ){
            return sys.io.File.getContent( f );
        }
        return null;
    }
    public static inline function getLocalPath(){
        return 'file://' + js.Node.__dirname;
    }
}