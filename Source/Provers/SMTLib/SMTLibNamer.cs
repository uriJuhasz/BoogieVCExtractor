﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie.VCExprAST;

namespace Microsoft.Boogie.SMTLib
{
  public class SMTLibNamer : UniqueNamer
  {
    // The following Boogie ID characters are not SMT ID characters: `'\#
    // Accomodate Z3 SMT2 lexer bug - it doesn't like @ and such in identifiers    
    const string idCharacters = "_"; // "~!@$%^&*_-+=<>.?/";    


    static string[] reservedSmtWordsList = 
    { // Basic symbols:
      "", "!", "_", "as", "DECIMAL", "exists", "forall", "let", "NUMERAL", "par", "STRING", 
      // Commands:
      "assert", "check-sat", "declare-sort", "declare-fun", "define-sort,", "define-fun", "exit",
      "get-assertions", "get-assignment", "get-info", "get-option,", "get-proof", "get-unsat-core",
      "get-value", "pop", "push", "set-logic", "set-info", "set-option",
      // Core theory:
      "and", "or", "not", "iff", "true", "false", "xor", "distinct", "ite", "=", "Bool",
      "=>", // implies (sic!)
      // Integers
      "Int", "*", "/", "-", "+", "<", "<=", ">", ">=",
      // SMT v1 stuff
      "flet", "implies", "!=", "if_then_else",
      // Z3 extensions
      "lblneg", "lblpos", "lbl-lit",
      "if", "&&", "||", "equals", "equiv", "bool",
      // Boogie-defined
      "int_mod", "int_div", "UOrdering2", "UOrdering3", 
    };

    static Dictionary<string, bool> reservedSmtWords;
    static bool[] validIdChar;
    static bool symbolListsInitilized;

    static void InitSymbolLists()
    {
      lock (reservedSmtWordsList) {
        // don't move out, c.f. http://en.wikipedia.org/wiki/Double-checked_locking
        if (symbolListsInitilized)
          return;
        reservedSmtWords = new Dictionary<string, bool>();
        foreach (var w in reservedSmtWordsList)
          reservedSmtWords.Add(w, true);
        validIdChar = new bool[255];
        for (int i = 0; i < validIdChar.Length; ++i)
          validIdChar[i] = char.IsLetterOrDigit((char)i) || idCharacters.IndexOf((char)i) >= 0;
        symbolListsInitilized = true;
      }
    }

    static string AddQuotes(string s)
    {
      var allGood = true;

      foreach (char ch in s) {
        var c = (int)ch;
        if (c >= validIdChar.Length || !validIdChar[c]) {
          allGood = false;
          break;
        }
      }

      if (allGood)
        return s;

      return "|" + s + "|";
    }

    static string NonKeyword(string s)
    {
      if (reservedSmtWords.ContainsKey(s) || char.IsDigit(s[0]))
        s = "q@" + s;

      // | and \ are illegal even in quoted identifiers
      if (s.IndexOf('|') >= 0)
        s = s.Replace("|", "_");

      if (s.IndexOf('\\') >= 0)
        s = s.Replace("\\", "_");

      return s;
    }

    public static string QuoteId(string s)
    {
      return AddQuotes(NonKeyword(s));
    }

    public override string GetQuotedLocalName(object thingie, string inherentName)
    {
      return AddQuotes(base.GetLocalName(thingie, NonKeyword(inherentName)));
    }

    public override string GetQuotedName(object thingie, string inherentName)
    {
      return AddQuotes(base.GetName(thingie, NonKeyword(inherentName)));
    }

    public SMTLibNamer()
    {
      this.Spacer = "__";
      InitSymbolLists();
    }
  }
}
