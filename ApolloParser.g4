parser grammar ApolloParser;

// $antlr-format alignTrailingComments true, columnLimit 80, minEmptyLines 1, maxEmptyLinesToKeep 1, reflowComments false, useTab false
// $antlr-format allowShortRulesOnASingleLine false, allowShortBlocksOnASingleLine true, alignSemicolons hanging, alignColons hanging

options {
    tokenVocab = ApolloLexer;
}

start_
    : compilationUnit EOF
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

compilationUnit
    : unsignedIntegralType*
    ;