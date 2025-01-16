| fontDefsCollection fontDefs fontDef fontDefsWriteStream fontDefsJson onInitCb onInitClosureBlock onTextChangedCb onTextChangedClosureBlock onComboChangedClosureBlock onComboChangedCb onNumericValueChangedClosureBlock onNumericValueChangedCb onBooleanValueChangedClosureBlock onBooleanValueChangedCb onMultipleNumericValuesChangedClosureBlock onMultipleNumericValuesChangedCb onClickCb onClickClosureBlock |

PackageLoader fileInPackage: 'JSON'.
PackageLoader fileInPackage: 'DLD'.

OnInitCb := [:callback | ].
OnTextChangedCb := [:index :text | ].
OnComboChangedCb := [:index :newValue | ].
OnNumericValueChangedCb := [:index :value | ].
OnBooleanValueChangedCb := [:index :value | ].
OnMultipleNumericValuesChangedCb := [:index :values :numValues | ].
OnClickCb := [:index | ].

fontDefsCollection := OrderedCollection new.

fontDef := Dictionary new.
fontDef at: 'name' put: 'roboto-regular'.
fontDef at: 'size' put: 16.

fontDefsCollection add: fontDef.

fontDefs := Dictionary new.
fontDefs at: 'defs' put: fontDefsCollection.

fontDefsWriteStream := WriteStream on: String new.
fontDefs jsonWriteOn: fontDefsWriteStream.
fontDefsJson := fontDefsWriteStream contents.

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
 

XFrames init: './assets' fontsDefs: fontDefsJson themeDef: '{}' onInit: onInitCb onTextChanged: onTextChangedCb onComboChanged: onComboChangedCbs onNumericValueChanged: onNumericValueChangedCb onBooleanValueChanged: onBooleanValueChangedCb onMultipleNumericValuesChanged: onInitCb onClick: onClickCb.

inputStringOne := stdin nextLine.
