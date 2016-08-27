package ;

using StringTools;

@:forward abstract ANSI(String) {
	private inline function new(v) this = v;
	@:to private function toString():String return this + '\u001b[0m';
	@:op(A+B) private function addPairing(v:ANSIPair):ANSI return v + this;
	@:from private static function fromString(v:String):ANSI return new ANSI(v);
}

@:structInit class Pair { 
	public var open:Any;
	public var close:Any;
}

@:forward abstract ANSIPair(Pair) from Pair {
	@:commutative @:op(A+B) public static function addString(a:ANSIPair, b:String):ANSI return addANSI(a, b);
	@:op(A+B) public static function addANSI(a:ANSIPair, b:ANSI):ANSI {
		//trace( 'ansi', a );
		return '\u001b[' + a.open + 'm' + b.replace('\u001b[' + a.close + 'm', '\u001b[' + a.open + 'm') + '\u001b[' + a.close + 'm';
	}
}

typedef Attr = Attributes;
typedef Attributes = TextAttributes;
@:forward @:enum abstract TextAttributes(Int) {
	public var Reset = 0;
	public var Bold = 1;
	public var Dim = 2;
	public var Italic = 3;
	public var Underline = 4;
	public var Inverse = 7;
	public var Hidden = 8;
	public var StrikeThrough = 9;
	
	@:op(A+B) public function addANSI(v:ANSI) return toPair() + v;
	@:op(A+B) public function addString(v:String) return toPair() + (v:ANSI);
	@:to public static function toPair(v:Int):ANSIPair return {open:v, close:switch v {
		case Bold, Dim: 22;
		case Italic: 23;
		case Underline: 24;
		case Inverse: 27;
		case Hidden: 28;
		case StrikeThrough: 29;
		case _: 0;
	}};
}

typedef Colors = Colours;
typedef Colours = Foreground;
@:enum abstract Foreground(Int) {
	public var Black = 30;
	public var Red = 31;
	public var Green = 32;
	public var Yellow = 33;
	public var Blue = 34;
	public var Magenta = 35;
	public var Cyan = 36;
	public var White = 37;
	
	@:to public function toPair():ANSIPair return {open:this, close:39};
	@:commutative @:op(A+B) public function addANSI(v:ANSI) return toPair() + v;
}

typedef Bg = Background;
@:enum abstract Background(Int) {
	public var Black = 40;
	public var Red = 41;
	public var Green = 42;
	public var Yellow = 43;
	public var Blue = 44;
	public var Magenta = 45;
	public var Cyan = 46;
	public var White = 47;
	
	@:to public function toPair():ANSIPair return {open:this, close:49};
	@:commutative @:op(A+B) public function addANSI(v:ANSI) return toPair() + v;
}
