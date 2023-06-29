# DocxTemplate

DocxTemplate is a simple Pharo class that allows you to perform templating with DOCX files. It makes use of [Mustache](https://github.com/noha/mustache) for variable replacement.

## Installation

To install DocxTemplate in Pharo, execute the following code:

```Smalltalk
Metacello new
	baseline: 'DocxTemplater';
	repository: 'github.com//MatFluor/DocxTemplate:main';
	load
```

## Usage

With DocxTemplate, you can work directly on the `document.xml` file inside a DOCX archive by using mustache variables, such as `{{name}}`, in your template. Thanks to Noha's Mustache implementation, the usage is straightforward. 

Here are some examples:

```smalltalk
"Fill a template based on JSON data"
DocxTemplate new 
	zip: '<Location of my .docx>'
	json: '{ "name" : "mustache" }'
	out: '<Location of the new, filled .docx>'.
	
"Fill a template based on an Array"
DocxTemplate new 
	zip: '<Location of my .docx>'
	array: { 'name' -> 'mustache' }
	out: '<Location of the new, filled .docx>'.
```

Apart from these two convenient methods, you can directly access each part individually (see the "private" protocol) for more advanced usage.

## Caveats

Please note that DocxTemplate has not been tested with partial templates and larger or more formatted documents. Keep this in mind as DOCX/Word may sometimes split content in unexpected ways.
