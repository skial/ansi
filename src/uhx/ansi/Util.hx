package uhx.ansi;

class Util {
	
	public static var ansicon:Process;
	
	public static function initialize():Void {
		if (!Sys.environment().exists('ANSICON')) ansicon = new Process( './ansicon/${is64Bit?"x64":"x86"}/ansicon.exe', ['-p'] );
	}
	
	public static function cleanup():Void {
		if (!Sys.environment().exists('ANSICON')) {
			ansicon.exitCode();
			ansicon.close();
			
		}
	}
	
}
