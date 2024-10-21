parser grammar ApolloParser;

// $antlr-format alignTrailingComments true, columnLimit 80, minEmptyLines 1, maxEmptyLinesToKeep 1, reflowComments false, useTab false
// $antlr-format allowShortRulesOnASingleLine false, allowShortBlocksOnASingleLine true, alignSemicolons hanging, alignColons hanging

options {
    tokenVocab = ApolloLexer;
}

start_
    : statement* EOF
    ;

identifier
    : IDENTIFIER
    ;

typeIdentifier
    : IDENTIFIER
    ;

literal
    : INTEGER_LITERAL
    | REAL_LITERAL
    | BOOLEAN_LITERAL
    | CHARACTER_LITERAL
    | STRING_LITERAL
    | NULL_LITERAL
    ;

primitiveType
    : numericType
    | BOOL
    ;

numericType
    : integralType
    | floatingPointType
    ;

integralType
    : signedIntegralType
    | unsignedIntegralType
    ;

signedIntegralType
    : SBYTE
    | SHORT
    | INT
    | LONG
    ;

unsignedIntegralType
    : BYTE
    | USHORT
    | UINT
    | ULONG
    ;

floatingPointType
    : FLOAT
    | DOUBLE
    ;

referenceType
    : typeIdentifier
    | typeVariable
    | arrayType
    | ANY
    ;

arrayType
    : primitiveType dims
    | classType dims
    | typeVariable dims
    ;

unannType
    : unannPrimitiveType
    | unannReferenceType
    ;

unannPrimitiveType
    : numericType
    | BOOL
    ;

unannReferenceType
    : unannTypeVariable
    | unannArrayType
    | ANY
    ;

unannTypeVariable
    : typeVariable
    ;

unannArrayType
    : (unannPrimitiveType | unannTypeVariable | ANY) dims
    ;

result
    : unannType
    | VOID
    ;

classType
    : typeIdentifier typeArguments?
    ;

dims
    : (OPEN_BRACKET CLOSE_BRACKET)+
    ;

typeVariable
    : typeIdentifier
    ;

typeArguments
    : LT typeArgumentList GT
    ;

typeArgumentList
    : typeArgument (COMMA typeArgument)*
    ;

typeArgument
    : referenceType
    ;

typeParameter
    : identifier
    ;

typeParameters
    : LT typeParameterList GT
    ;

typeParameterList
    : typeParameter (COMMA typeParameter)*
    ;

statement
    : block
    ;

block
    : OPEN_BRACE blockStatements? CLOSE_BRACE
    ;

blockStatements
    : blockStatement blockStatement*
    ;

blockStatement
    : localVariableDeclarationStatement
    | statement
    ;

localVariableDeclarationStatement
    : localVariableDeclaration SEMICOLON
    ;

localVariableDeclaration
    : variableDeclarator variableInitializer?
    ;

variableDeclarator
    : NEW variableType variableDeclaratorId
    ;

variableType
    : type
    ;

variableDeclaratorID
    : identifier dims?
    ;

variableInitializer
    : expresion
    | arrayInitializer
    ;

functionDeclaration
    : functionHeader functionBody
    ;

functionHeader
    : annotation? functionDeclarator
    ;

functionDeclarator
    : NEW functionType functionName formalParameterList
    ;

functionType
    : FUNCTION LT result GT
    ;

functionName
    : identifier
    ;

formalParameterList
    : OPEN_PARENS paramType paramName (
        COMMA paramType paramName
    )* CLOSE_PARENS
    ;

paramType
    : typeIdentifier
    ;

paramName
    : identifier
    ;

annotation
    : ANNOTATION_START ANNOTATION_CONTENT ANNOTATION_END
    ;

functionBody
    : block
    | SEMICOLON
    ;

arrayInitializer
    : OPEN_BRACE variableInitializerList CLOSE_BRACE
    ;

variableInitializerList
    : variableInitializer variableInitializer*
    ;