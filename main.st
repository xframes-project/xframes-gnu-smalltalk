| myDict jsonStr callback2 callback2 callbackDescriptor1 callbackDescriptor2 |

PackageLoader fileInPackage: 'JSON'.
PackageLoader fileInPackage: 'DLD'.
" PackageLoader fileInPackage: 'CObject'. "

OnInitCb := [:callback | "Callback logic"].
OnTextChangedCb := [:index :text | "Handle text changed"].
OnComboChangedCb := [:index :newValue | "Handle combo changed"].
OnNumericValueChangedCb := [:index :value | "Handle numeric value changed"].
OnBooleanValueChangedCb := [:index :value | "Handle boolean value changed"].
OnMultipleNumericValuesChangedCb := [:index :values :numValues | "Handle multiple numeric values changed"].
OnClickCb := [:index | "Handle click"].

myDict := Dictionary new.
myDict at: 'name' put: 'Alice'.
myDict at: 'age' put: 30.

jsonStr := WriteStream on: String new.
myDict jsonWriteOn: jsonStr.

x := Dictionary new.
x at: 'One' put: 1.
x at: 'Two' put: 2.
x at: 1 put: 'One'.
x at: 2 put: 'Two'.





"Define the callback block"
callback2 := [ :arg1 :arg2 |
    Transcript show: 'Callback called with args: ', arg1 printString, ' and ', arg2 printString; nl.
].

callback1 := [ 
    Transcript show: 'Callback called with no arguments'; nl.
].

"Create the callback descriptor"
callbackDescriptor2 := CCallbackDescriptor for: callback2
    returning: #void
    withArgs: #(#string #string).

callbackDescriptor1 := CCallbackDescriptor for: callback1
    returning: #void
    withArgs: #().









DLD addLibrary: 'libxframesshared.so'.
(CFunctionDescriptor isFunction: 'init') displayNl.
 
CObject subclass: XFrames [
    XFrames class >> init: a b: bb c: cc onInit: onInitCb onTextChanged: onTextChangedCb onComboChanged: onComboChangedCb onNumericValueChanged: onNumericValueChangedCb onBooleanValueChanged: onBooleanValueChangedCb onMultipleNumericValuesChanged: onMultipleNumericValuesChangedCb onClick: onClickCb [
        <cCall: 'init' returning: #void args: #(#string #string #string #unknown #unknown #unknown #unknown #unknown #unknown #unknown)>
    ]

    XFrames class >> test [
        Transcript show: 'Callback called with no arguments'; nl.
    ]
]

callback3 := [ XFrames test ].

callbackDescriptor3 := CCallbackDescriptor for: callback3
    returning: #void
    withArgs: #().

XFrames init: './assets' b: '{}' c: '{}' onInit: callbackDescriptor3 onTextChanged: callbackDescriptor3 onComboChanged: callbackDescriptor3 onNumericValueChanged: callbackDescriptor3 onBooleanValueChanged: callbackDescriptor3 onMultipleNumericValuesChanged: callbackDescriptor3 onClick: callbackDescriptor3.

inputStringOne := stdin nextLine.


" x displayNl. "