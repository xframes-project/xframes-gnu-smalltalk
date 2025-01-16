| myDict jsonStr onInitCb onInitClosureBlock onTextChangedCb onTextChangedClosureBlock onComboChangedClosureBlock onComboChangedCb onNumericValueChangedClosureBlock onNumericValueChangedCb onBooleanValueChangedClosureBlock onBooleanValueChangedCb onMultipleNumericValuesChangedClosureBlock onMultipleNumericValuesChangedCb onClickCb onClickClosureBlock |

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

" @see https://www.gnu.org/software/smalltalk/manual/html_node/C-data-types.html "
CObject subclass: XFrames [
    XFrames class >> init: a fontsDefs: fd themeDef: td onInit: onInitCb onTextChanged: onTextChangedCb onComboChanged: onComboChangedCb onNumericValueChanged: onNumericValueChangedCb onBooleanValueChanged: onBooleanValueChangedCb onMultipleNumericValuesChanged: onMultipleNumericValuesChangedCb onClick: onClickCb [
        <cCall: 'init' returning: #void args: #(#string #string #string #unknown #unknown #unknown #unknown #unknown #unknown #unknown)>
    ]

    XFrames class >> setElement: elementJson [
        <cCall: 'setElement' returning: #void args: #(#string)>
    ]

    XFrames class >> setChildren: parentId childrenIds: childrenIdsJson [
        <cCall: 'setChildren' returning: #void args: #(#int #string)>
    ]

    " XFrames class >> test [
        Transcript show: 'Callback called with no arguments'; nl.
    ] "
]


onInitClosureBlock := [
    | rootNode rootNodeWriteStream rootNodeJson unformattedText unformattedTextWriteStream unformattedTextJson |
    Transcript show: 'Initialized'; nl.

    rootNode := Dictionary new.
    rootNode at: 'id' put: 0.
    rootNode at: 'type' put: 'node'.
    rootNode at: 'root' put: true.

    unformattedText := Dictionary new.
    unformattedText at: 'id' put: 1.
    unformattedText at: 'type' put: 'unformatted-text'.
    unformattedText at: 'text' put: 'Hello, world'.

    rootNodeWriteStream := WriteStream on: String new.
    rootNode jsonWriteOn: rootNodeWriteStream.
    rootNodeJson := rootNodeWriteStream contents.

    unformattedTextWriteStream := WriteStream on: String new.
    unformattedText jsonWriteOn: unformattedTextWriteStream.
    unformattedTextJson := unformattedTextWriteStream contents.

    XFrames setElement: rootNodeJson.
    XFrames setElement: unformattedTextJson.

    XFrames setChildren: 0 childrenIds: '[1]'
].

onInitCb := CCallbackDescriptor for: onInitClosureBlock
    returning: #void
    withArgs: #().

onTextChangedClosureBlock := [ :arg1 :arg2 |
    Transcript show: 'Text value changed: ', arg1 printString, ' : ', arg2 printString; nl.
].

onTextChangedCb := CCallbackDescriptor for: onTextChangedClosureBlock
    returning: #void
    withArgs: #(#int #string).

onComboChangedClosureBlock := [ :arg1 :arg2 |
    Transcript show: 'Combo value changed: ', arg1 printString, ' : ', arg2 printString; nl.
].

onComboChangedCb := CCallbackDescriptor for: onComboChangedClosureBlock
    returning: #void
    withArgs: #(#int #int).

onNumericValueChangedClosureBlock := [ :arg1 :arg2 |
    Transcript show: 'Numeric value changed: ', arg1 printString, ' : ', arg2 printString; nl.
].

onNumericValueChangedCb := CCallbackDescriptor for: onNumericValueChangedClosureBlock
    returning: #void
    withArgs: #(#int #float).

onBooleanValueChangedClosureBlock := [ :arg1 :arg2 |
    Transcript show: 'Boolean value changed: ', arg1 printString, ' : ', arg2 printString; nl.
].

"I cannot see 'bool' anywhere in the docs"
onBooleanValueChangedCb := CCallbackDescriptor for: onBooleanValueChangedClosureBlock
    returning: #void
    withArgs: #(#int #int).

onMultipleNumericValuesChangedClosureBlock := [ :arg1 :arg2 :arg3 |
    Transcript show: 'Multiple numeric values changed: ', arg1 printString, ' : ', arg2 printString; nl.
].

"I cannot see 'bool' anywhere in the docs"
onMultipleNumericValuesChangedCb := CCallbackDescriptor for: onMultipleNumericValuesChangedClosureBlock
    returning: #void
    withArgs: #(#int #cObject #int).

onClickClosureBlock := [ :arg1 |
    Transcript show: 'Clicked : ', arg1 printString; nl.
].

onClickCb := CCallbackDescriptor for: onClickClosureBlock
    returning: #void
    withArgs: #(#int).

DLD addLibrary: 'libxframesshared.so'.
(CFunctionDescriptor isFunction: 'init') displayNl.
 


" callback3 := [ XFrames test ]. "


XFrames init: './assets' fontsDefs: '{}' themeDef: '{}' onInit: onInitCb onTextChanged: onTextChangedCb onComboChanged: onComboChangedCbs onNumericValueChanged: onNumericValueChangedCb onBooleanValueChanged: onBooleanValueChangedCb onMultipleNumericValuesChanged: onInitCb onClick: onClickCb.

inputStringOne := stdin nextLine.


" x displayNl. "