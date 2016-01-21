{
{-# OPTIONS_GHC -w #-}
module Parser.Lex
  ( alexScanTokens
  ) where

import Common
import Parser.Tokens

}

%wrapper "posn"

@idUpper  = [A-Z] [a-zA-Z0-9_]*
@idLower  = [a-z] [a-zA-Z0-9_]*
@operator = [\!\#\$\%\&\*\+\.\/\<\=\>\?\@\\\^\|\-\~]+

tokens :-

  "class"    { tok KW_class    }
  "instance" { tok KW_instance }
  "datatype" { tok KW_datatype }
  "value"    { tok KW_value    }
  "case"     { tok KW_case     }
  "if"       { tok KW_if       }
  "else"     { tok KW_else     }
  "do"       { tok KW_do       }
  "of"       { tok KW_of       }
  "where"    { tok KW_where    }
  "()"       { tok Unit        }
  "("        { tok ParenL      }
  ")"        { tok ParenR      }
  "="        { tok Equal       }
  "::"       { tok ColonColon  }
  ";"        { tok Semi        }
  "`"        { tok Tic         }
  "|"        { tok Pipe        }

  @idUpper       { tok IdUpper  }
  @idLower       { tok IdLower  }
  @operator      { tok Operator }

  $white         ;
  .              { tok Unknown }

{
tok :: TokenName -> AlexPosn -> String -> Token
tok t (AlexPn _ l c) s = Token t s $ Location "" l c
}

