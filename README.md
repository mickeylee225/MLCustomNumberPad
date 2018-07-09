# MLCustomNumberPad

<b> iOS 11 Circular Style NumberPad </b> 

## Installation
Copy `CustomNumberPad.swift` and `CustomNumberPad.xib` to your project.

## Usage

1. Initialize numberPad, set textField inputView to an empty view to avoid gray background, set numberPad as textField inputAccessoryView and set its delegate to the ViewController.
	<pre><code>override func viewDidLoad() {
		let numberPad = ViewController.initNumberPad()
		numberPad.delegate = self
		textField.inputView = UIView()
		textField.inputAccessoryView = numberPad
		textField.inputView = numberPad
	}
	</code></pre>


2. Set numberPad's frame, buttons titles colors, background colors, and font in initNumberPad function. And you could customize anything in public functions of `CustomNumberPad.swift`.
	<pre><code>func initNumberPad() -> CustomNumberPad {
		let numberPad = CustomNumberPad(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150))
		numberPad.setViewBgColor(.clear)
		numberPad.setButtonsTitleColor(.black, selectedColor: .lightGray)
		numberPad.setButtonsBgColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6), selectedColor: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8))
		numberPad.setButtonsFont(UIFont(name: ".SFUIText-Semibold", size: 28)!)
		numberPad.setTouchIDButtonImage(UIImage(named: "touchId")!)
		return numberPad
	}
</code></pre>

## Screenshots
![image](https://github.com/michilin/MLCustomNumberPad/blob/master/screenshot.png)

###Inspired by KBNumberPad