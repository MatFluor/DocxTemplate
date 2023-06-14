# DocxTemplate
A Simple Docx-Templating Class for Pharo. Leverages [Mustache](https://github.com/noha/mustache) for the Variable replacement.

## Installation

Evaluate in Pharo:

```Smalltalk

Metacello new
	baseline: 'DocxTemplater';
	repository: 'github.com//MatFluor/DocxTemplate:main';
	load

```

## Usage
Using a DOCX-File, sprinkled with mustache-variables like `{{name}}`, the DocxTemplater simply work directly on the underlying `document.xml` file insode the docx-archive. Thanks to Nohas Mustache implementation, usage is straightforward:

```smalltalk
"Fill a template based on JSON-Data"
DocxTemplate new zip: '<Location of my .docx>'
	json: '{ "name" : "mustache"}'
	out: '<Location of new, filled .docx>'.
	
"Fill a template based on an Array"
DocxTemplate new zip: '<Location of my .docx>'
	array: { 'name' -> 'mustache' }
	out: '<Location of the new, filled .docx>'.
```
Apart from these two convenient messages, each part can be directly accessed (see the "private" protocol).

## Caveats
It is not (yet) tested with partial templates, and has not been tested with larger or more formatted documents, please keep that in mind. Sometimes DOCX/Word decides to split up things in unreasonable places.
