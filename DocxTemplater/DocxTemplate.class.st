"
I am a Template-Filler for Word documents.

The intention is that your clients can style and adjust a Word-DOCX file with mustache variables and have it rendered with their data via Pharo. It operates by simply replacing the tags in the underlying XML. You can use either an Array (which will be automatically taken as a Dictionary), or a JSON-String (whcih will be converted to a Dictionary using STONJSON).

## Public API and Key Messages

- readZipNamed: aFilename
- replaceDocumentTextWith: anArray
- replaceDocumentTextWithJSON: aString
- createNewZipAt: aFilename

```smalltalk
FlTemplate new readZipNamed: 'my_template.docx';
	replaceDocumentTextWith: {'nachname'->'Mike'. 'vorname'->'Hansen'};
	createNewZipAt: 'filled_template.docx'
	```

## Instance Variables
	currentDoc:		This is the original XML-File contents as String
	tempStorage:		a MemoryFileSystem to unpack-replece-pack the zips


"
Class {
	#name : #DocxTemplate,
	#superclass : #Object,
	#instVars : [
		'tempStorage',
		'currentDoc'
	],
	#category : #DocxTemplater
}

{ #category : #private }
DocxTemplate >> createMemoryFS [
	tempStorage := FileSystem memory.
tempStorage createDirectory: 'workingDocx'.
]

{ #category : #private }
DocxTemplate >> createNewZipAt: aDestinationFile [
  | z2 |
  z2 := ZipArchive new addTree: tempStorage / 'workingDocx' relativeTo: tempStorage / 'workingDocx' match: [:entry |  entry exists ].
  aDestinationFile asFileReference ensureDelete.
  z2 writeToFile: aDestinationFile asFileReference.
  z2 close.

tempStorage close.
]

{ #category : #accessing }
DocxTemplate >> currentDoc [

	^ currentDoc
]

{ #category : #accessing }
DocxTemplate >> currentDoc: anObject [

	currentDoc := anObject
]

{ #category : #private }
DocxTemplate >> readZipNamed: aFilename [

	| z |
	self tempStorage ifNil: [ self createMemoryFS].
	z := ZipArchive new readFrom:
		     'C:\Users\matfl\Desktop\Begleitbrief Vermietung.docx'.
	z extractAllTo: tempStorage / 'workingDocx'.
	z close.
	currentDoc := (tempStorage / 'workingDocx/word/document.xml')
		              contents asString
]

{ #category : #private }
DocxTemplate >> replaceDocumentTextWith: aDictionary [
	"This uses Mustache to replace the specified tokens."
  | renderedTemplate |
  renderedTemplate := (MustacheTemplate on: currentDoc) value: aDictionary asDictionary.
  tempStorage / 'workingDocx/word/document.xml' writeStreamDo: [:stream |  stream nextPutAll: renderedTemplate ]
]

{ #category : #private }
DocxTemplate >> replaceDocumentTextWithJSON: aJSONString [
	"This uses Mustache to replace the specified tokens."

	| renderedTemplate |
	renderedTemplate := (MustacheTemplate on: currentDoc) value:
		                    (STONJSON fromString: aJSONString).
	tempStorage / 'workingDocx/word/document.xml' writeStreamDo: [
		:stream | stream nextPutAll: renderedTemplate ]
]

{ #category : #accessing }
DocxTemplate >> tempStorage [

	^ tempStorage
]

{ #category : #accessing }
DocxTemplate >> tempStorage: anObject [

	tempStorage := anObject
]

{ #category : #public }
DocxTemplate >> zip: aZipFilename array: anArray out: aFilename [
	"Convenience method to save some typing"

	self readZipNamed: aZipFilename.
	self replaceDocumentTextWith: anArray.
	self createNewZipAt: aFilename
]

{ #category : #public }
DocxTemplate >> zip: aZipFilename json: aString out: aFilename [
	"Convenience method to save some typing"
	self readZipNamed: aZipFilename.
	self replaceDocumentTextWithJSON: aString.
	self createNewZipAt: aFilename
]
