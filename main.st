| myDict jsonStr |

PackageLoader fileInPackage: 'JSON'.
PackageLoader fileInPackage: 'CObject'.

OnInitCb := [:callback | "Callback logic here"].
OnTextChangedCb := [:index :text | "Handle text changed"].
OnComboChangedCb := [:index :newValue | "Handle combo changed"].
OnNumericValueChangedCb := [:index :value | "Handle numeric value changed"].
OnBooleanValueChangedCb := [:index :value | "Handle boolean value changed"].
OnMultipleNumericValuesChangedCb := [:index :values :numValues | "Handle multiple numeric values changed"].
OnClickCb := [:index | "Handle click"].

initFunction := ExternalFunction
    fromHandle: 'init'
    module: 'yourlibrary'
    argumentTypes: #( #string #string #string 
                      #callback #callback #callback #callback 
                      #callback #callback #callback )
    returnType: #void.

myDict := Dictionary new.
myDict at: 'name' put: 'Alice'.
myDict at: 'age' put: 30.

jsonStr := WriteStream on: String new.
myDict jsonWriteOn: jsonStr.


Transcript show: jsonStr contents; nl.



'Hello, World!' displayNl.

x := Dictionary new.
x at: 'One' put: 1.
x at: 'Two' put: 2.
x at: 1 put: 'One'.
x at: 2 put: 'Two'.

x displayNl.