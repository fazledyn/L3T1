/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison implementation for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.7"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
/* Line 371 of yacc.c  */
#line 1 "1705066.y"


#include "bits/stdc++.h"
#include "lib/SymbolTable.h"
#include "lib/Parameter.h"
#include "lib/util.h"

#define yydebug 1
#define ERROR "error"


SymbolTable st(30);
FILE *inputFile, *logFile, *errorFile;

extern FILE* yyin;

int lineCount = 1;
int errorCount = 0;

string currentFunctionReturnType = ERROR;

int yyparse(void);
int yylex(void);


void yyerror(const char* str) {
	fprintf(errorFile, "Syntax error at line: %d : \"%s\" \n", lineCount, str);
}


/* Line 371 of yacc.c  */
#line 99 "1705066.tab.c"

# ifndef YY_NULL
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULL nullptr
#  else
#   define YY_NULL 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BREAK = 258,
     CASE = 259,
     CONTINUE = 260,
     DEFAULT = 261,
     RETURN = 262,
     SWITCH = 263,
     VOID = 264,
     CHAR = 265,
     DOUBLE = 266,
     FLOAT = 267,
     INT = 268,
     DO = 269,
     WHILE = 270,
     FOR = 271,
     IF = 272,
     ELSE = 273,
     INCOP = 274,
     DECOP = 275,
     ASSIGNOP = 276,
     NOT = 277,
     LPAREN = 278,
     RPAREN = 279,
     LCURL = 280,
     RCURL = 281,
     LTHIRD = 282,
     RTHIRD = 283,
     COMMA = 284,
     SEMICOLON = 285,
     PRINTLN = 286,
     ID = 287,
     CONST_INT = 288,
     CONST_FLOAT = 289,
     CONST_CHAR = 290,
     ADDOP = 291,
     MULOP = 292,
     RELOP = 293,
     LOGICOP = 294,
     LOWER_THAN_ELSE = 295
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 387 of yacc.c  */
#line 34 "1705066.y"

	SymbolInfo* syminfo;


/* Line 387 of yacc.c  */
#line 184 "1705066.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* Copy the second part of user declarations.  */

/* Line 390 of yacc.c  */
#line 212 "1705066.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(N) (N)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (YYID (0))
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  11
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   160

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  26
/* YYNRULES -- Number of rules.  */
#define YYNRULES  66
/* YYNRULES -- Number of states.  */
#define YYNSTATES  120

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   295

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     5,     8,    10,    12,    14,    16,    23,
      29,    30,    38,    39,    46,    51,    55,    58,    60,    64,
      67,    71,    73,    75,    77,    81,    88,    90,    95,    97,
     100,   102,   104,   106,   114,   120,   128,   134,   140,   144,
     146,   149,   151,   156,   158,   162,   164,   168,   170,   174,
     176,   180,   182,   186,   189,   192,   194,   196,   201,   205,
     207,   209,   212,   215,   217,   218,   222
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      42,     0,    -1,    43,    -1,    43,    44,    -1,    44,    -1,
      51,    -1,    45,    -1,    46,    -1,    52,    32,    23,    49,
      24,    30,    -1,    52,    32,    23,    24,    30,    -1,    -1,
      52,    32,    23,    49,    24,    47,    50,    -1,    -1,    52,
      32,    23,    24,    48,    50,    -1,    49,    29,    52,    32,
      -1,    49,    29,    52,    -1,    52,    32,    -1,    52,    -1,
      25,    54,    26,    -1,    25,    26,    -1,    52,    53,    30,
      -1,    13,    -1,    12,    -1,     9,    -1,    53,    29,    32,
      -1,    53,    29,    32,    27,    33,    28,    -1,    32,    -1,
      32,    27,    33,    28,    -1,    55,    -1,    54,    55,    -1,
      51,    -1,    56,    -1,    50,    -1,    16,    23,    56,    56,
      58,    24,    55,    -1,    17,    23,    58,    24,    55,    -1,
      17,    23,    58,    24,    55,    18,    55,    -1,    15,    23,
      58,    24,    55,    -1,    31,    23,    32,    24,    30,    -1,
       7,    58,    30,    -1,    30,    -1,    58,    30,    -1,    32,
      -1,    32,    27,    58,    28,    -1,    59,    -1,    57,    21,
      59,    -1,    60,    -1,    60,    39,    60,    -1,    61,    -1,
      61,    38,    61,    -1,    62,    -1,    61,    36,    62,    -1,
      63,    -1,    62,    37,    63,    -1,    36,    63,    -1,    22,
      63,    -1,    64,    -1,    57,    -1,    32,    23,    65,    24,
      -1,    23,    58,    24,    -1,    33,    -1,    34,    -1,    57,
      19,    -1,    57,    20,    -1,    66,    -1,    -1,    66,    29,
      59,    -1,    59,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    60,    60,    67,    72,    79,    84,    89,    97,   128,
     159,   158,   282,   281,   352,   357,   362,   367,   375,   382,
     390,   436,   441,   446,   454,   459,   464,   469,   477,   482,
     490,   495,   500,   505,   510,   515,   520,   525,   548,   567,
     571,   579,   605,   645,   650,   695,   700,   721,   726,   734,
     739,   753,   758,   815,   820,   825,   833,   838,   901,   906,
     911,   916,   921,   929,   935,   942,   950
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "BREAK", "CASE", "CONTINUE", "DEFAULT",
  "RETURN", "SWITCH", "VOID", "CHAR", "DOUBLE", "FLOAT", "INT", "DO",
  "WHILE", "FOR", "IF", "ELSE", "INCOP", "DECOP", "ASSIGNOP", "NOT",
  "LPAREN", "RPAREN", "LCURL", "RCURL", "LTHIRD", "RTHIRD", "COMMA",
  "SEMICOLON", "PRINTLN", "ID", "CONST_INT", "CONST_FLOAT", "CONST_CHAR",
  "ADDOP", "MULOP", "RELOP", "LOGICOP", "LOWER_THAN_ELSE", "$accept",
  "start", "program", "unit", "func_declaration", "func_definition", "$@1",
  "$@2", "parameter_list", "compound_statement", "var_declaration",
  "type_specifier", "declaration_list", "statements", "statement",
  "expression_statement", "variable", "expression", "logic_expression",
  "rel_expression", "simple_expression", "term", "unary_expression",
  "factor", "argument_list", "arguments", YY_NULL
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    41,    42,    43,    43,    44,    44,    44,    45,    45,
      47,    46,    48,    46,    49,    49,    49,    49,    50,    50,
      51,    52,    52,    52,    53,    53,    53,    53,    54,    54,
      55,    55,    55,    55,    55,    55,    55,    55,    55,    56,
      56,    57,    57,    58,    58,    59,    59,    60,    60,    61,
      61,    62,    62,    63,    63,    63,    64,    64,    64,    64,
      64,    64,    64,    65,    65,    66,    66
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     6,     5,
       0,     7,     0,     6,     4,     3,     2,     1,     3,     2,
       3,     1,     1,     1,     3,     6,     1,     4,     1,     2,
       1,     1,     1,     7,     5,     7,     5,     5,     3,     1,
       2,     1,     4,     1,     3,     1,     3,     1,     3,     1,
       3,     1,     3,     2,     2,     1,     1,     4,     3,     1,
       1,     2,     2,     1,     0,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    23,    22,    21,     0,     2,     4,     6,     7,     5,
       0,     1,     3,    26,     0,     0,     0,     0,    20,    12,
       0,    17,     0,    24,     9,     0,    10,     0,    16,    27,
       0,     0,    13,     8,     0,    15,     0,     0,     0,     0,
       0,     0,     0,    19,    39,     0,    41,    59,    60,     0,
      32,    30,     0,     0,    28,    31,    56,     0,    43,    45,
      47,    49,    51,    55,    11,    14,    25,     0,     0,     0,
       0,    56,    54,     0,     0,    64,     0,    53,    26,    18,
      29,    61,    62,     0,    40,     0,     0,     0,     0,    38,
       0,     0,     0,    58,     0,    66,     0,    63,     0,    44,
      46,    50,    48,    52,     0,     0,     0,     0,    57,     0,
      42,    36,     0,    34,    37,    65,     0,     0,    33,    35
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     4,     5,     6,     7,     8,    34,    25,    20,    50,
      51,    52,    14,    53,    54,    55,    56,    57,    58,    59,
      60,    61,    62,    63,    96,    97
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -72
static const yytype_int16 yypact[] =
{
      75,   -72,   -72,   -72,     9,    75,   -72,   -72,   -72,   -72,
     -16,   -72,   -72,    16,    69,     6,   -11,    -3,   -72,    10,
       7,    23,    38,    44,   -72,    12,    72,    75,   -72,   -72,
      41,    60,   -72,   -72,    12,    49,    61,    26,    85,    86,
      89,    26,    26,   -72,   -72,    92,    30,   -72,   -72,    26,
     -72,   -72,    84,    88,   -72,   -72,    59,    96,   -72,    78,
      25,    90,   -72,   -72,   -72,   -72,   -72,   100,    26,    -9,
      26,    87,   -72,   110,   103,    26,    26,   -72,   109,   -72,
     -72,   -72,   -72,    26,   -72,    26,    26,    26,    26,   -72,
     113,    -9,   118,   -72,   119,   -72,   120,   111,   117,   -72,
     -72,    90,   115,   -72,   116,    26,   116,   123,   -72,    26,
     -72,   -72,   130,   137,   -72,   -72,   116,   116,   -72,   -72
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -72,   -72,   -72,   151,   -72,   -72,   -72,   -72,   -72,    -8,
      51,     5,   -72,   -72,   -52,   -63,   -41,   -35,   -71,    73,
      70,    74,   -38,   -72,   -72,   -72
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      71,    80,    67,    72,    95,    10,    91,    73,    71,    11,
      10,    77,    99,    41,    42,     1,    13,    32,     2,     3,
      21,    44,    22,    46,    47,    48,    64,    49,   105,    23,
      19,    26,    35,    90,    71,    92,    27,    31,   115,    15,
      24,    98,    71,    16,    71,    71,    71,    71,    41,    42,
     103,     9,   111,    75,   113,    28,     9,    76,    46,    47,
      48,    86,    49,    87,   118,   119,    29,    37,    71,     1,
     112,    30,     2,     3,    36,    38,    39,    40,    81,    82,
      83,    65,    41,    42,     1,    31,    43,     2,     3,    66,
      44,    45,    46,    47,    48,    37,    49,     1,    17,    18,
       2,     3,    33,    38,    39,    40,    81,    82,    68,    69,
      41,    42,    70,    31,    79,    74,    78,    85,    44,    45,
      46,    47,    48,    37,    49,     1,    84,    88,     2,     3,
      89,    38,    39,    40,    93,    94,    16,   104,    41,    42,
     109,    31,   106,   107,   108,   110,    44,    45,    46,    47,
      48,    86,    49,   114,   116,   117,    12,   102,   100,     0,
     101
};

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-72)))

#define yytable_value_is_error(Yytable_value) \
  YYID (0)

static const yytype_int8 yycheck[] =
{
      41,    53,    37,    41,    75,     0,    69,    42,    49,     0,
       5,    49,    83,    22,    23,     9,    32,    25,    12,    13,
      15,    30,    33,    32,    33,    34,    34,    36,    91,    32,
      24,    24,    27,    68,    75,    70,    29,    25,   109,    23,
      30,    76,    83,    27,    85,    86,    87,    88,    22,    23,
      88,     0,   104,    23,   106,    32,     5,    27,    32,    33,
      34,    36,    36,    38,   116,   117,    28,     7,   109,     9,
     105,    27,    12,    13,    33,    15,    16,    17,    19,    20,
      21,    32,    22,    23,     9,    25,    26,    12,    13,    28,
      30,    31,    32,    33,    34,     7,    36,     9,    29,    30,
      12,    13,    30,    15,    16,    17,    19,    20,    23,    23,
      22,    23,    23,    25,    26,    23,    32,    39,    30,    31,
      32,    33,    34,     7,    36,     9,    30,    37,    12,    13,
      30,    15,    16,    17,    24,    32,    27,    24,    22,    23,
      29,    25,    24,    24,    24,    28,    30,    31,    32,    33,
      34,    36,    36,    30,    24,    18,     5,    87,    85,    -1,
      86
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     9,    12,    13,    42,    43,    44,    45,    46,    51,
      52,     0,    44,    32,    53,    23,    27,    29,    30,    24,
      49,    52,    33,    32,    30,    48,    24,    29,    32,    28,
      27,    25,    50,    30,    47,    52,    33,     7,    15,    16,
      17,    22,    23,    26,    30,    31,    32,    33,    34,    36,
      50,    51,    52,    54,    55,    56,    57,    58,    59,    60,
      61,    62,    63,    64,    50,    32,    28,    58,    23,    23,
      23,    57,    63,    58,    23,    23,    27,    63,    32,    26,
      55,    19,    20,    21,    30,    39,    36,    38,    37,    30,
      58,    56,    58,    24,    32,    59,    65,    66,    58,    59,
      60,    62,    61,    63,    24,    56,    24,    24,    24,    29,
      28,    55,    58,    55,    30,    59,    24,    18,    55,    55
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))

/* Error token number */
#define YYTERROR	1
#define YYERRCODE	256


/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */
#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
        break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULL;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - Assume YYFAIL is not used.  It's too flawed to consider.  See
       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
       for details.  YYERROR is fine as it does not invoke this
       function.
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
        break;
    }
}




/* The lookahead symbol.  */
int yychar;


#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval YY_INITIAL_VALUE(yyval_default);

/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
/* Line 1792 of yacc.c  */
#line 61 "1705066.y"
    {
			(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
			printLog(logFile, "start : program", "", lineCount);
		}
    break;

  case 3:
/* Line 1792 of yacc.c  */
#line 68 "1705066.y"
    {
			(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (2)].syminfo)->getName() + "\n" + (yyvsp[(2) - (2)].syminfo)->getName(), "program");
			printLog(logFile, "program : program unit", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 4:
/* Line 1792 of yacc.c  */
#line 73 "1705066.y"
    {
			(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
			printLog(logFile, "program : unit", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 5:
/* Line 1792 of yacc.c  */
#line 80 "1705066.y"
    {
			(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
			printLog(logFile, "unit : var_declaration", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 6:
/* Line 1792 of yacc.c  */
#line 85 "1705066.y"
    {
			(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
			printLog(logFile, "unit : func_declaration", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 7:
/* Line 1792 of yacc.c  */
#line 90 "1705066.y"
    {
			(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
			printLog(logFile, "unit : func_definition", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 8:
/* Line 1792 of yacc.c  */
#line 98 "1705066.y"
    {
					string funcType = (yyvsp[(1) - (6)].syminfo)->getName();
					string funcName = (yyvsp[(2) - (6)].syminfo)->getName();

					vector<string> paramTypeList = extractParameterType((yyvsp[(4) - (6)].syminfo)->getName());
					SymbolInfo* currFunc = st.lookup(funcName);
						
					if (currFunc != nullptr)	//	 Already declared
					{
						errorCount++;
						string msg = "Multiple declaration of function '" + funcName + "'";
						printError(errorFile, logFile,  msg, lineCount);
					}
					else		//	Is not declared yet
					{
						vector<Parameter> paramList;
						for (string paramType: paramTypeList) {	
							paramList.push_back(Parameter(" ", paramType));
						}

						SymbolInfo temp;
						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(false);
						
						st.insertSymbolInfo(temp);
					}

					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (6)].syminfo)->getName() + " " + (yyvsp[(2) - (6)].syminfo)->getName() + "(" + (yyvsp[(4) - (6)].syminfo)->getName() + ");", "func_declaration");
					printLog(logFile, "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 9:
/* Line 1792 of yacc.c  */
#line 129 "1705066.y"
    {
					string funcType = (yyvsp[(1) - (5)].syminfo)->getName();
					string funcName = (yyvsp[(2) - (5)].syminfo)->getName();

					SymbolInfo* currFunc = st.lookup(funcName);

					if (currFunc != nullptr)	//	 Already declared
					{
						errorCount++;
						string msg = "Multiple declaration of function '" + funcName + "'";
						printError(errorFile, logFile,  msg, lineCount);
					}
					else		//	Is not declared yet
					{
						vector<Parameter> paramList;

						SymbolInfo temp;
						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(false);

						st.insertSymbolInfo(temp);
					}

					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (5)].syminfo)->getName() + " " + (yyvsp[(2) - (5)].syminfo)->getName() + "();", "func_declaration");
					printLog(logFile, "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 10:
/* Line 1792 of yacc.c  */
#line 159 "1705066.y"
    {
					string funcType = (yyvsp[(1) - (5)].syminfo)->getName();
					string funcName = (yyvsp[(2) - (5)].syminfo)->getName();
					vector<Parameter> paramList = extractParameters((yyvsp[(4) - (5)].syminfo)->getName());

					SymbolInfo* currFunc = st.lookup(funcName);
					currentFunctionReturnType = funcType;
					
					if (currFunc != nullptr) // Function is declared
					{
						if (currFunc->isFunction())
						{
					
							if (currFunc->isDefined()) // Declared and Defined
							{
								errorCount++;
								string msg = "Re-definition of function '" + funcName + "'";
								printError(errorFile, logFile,  msg, lineCount);
							}
							else	// Declared, but not defined
							{
								bool definitionIsConsistent = true;

								int declaredParamSize = currFunc->getParamList().size();
								int  definedParamSize = paramList.size();

								if (declaredParamSize != definedParamSize)	//	ERROR - ParamList size doesnt match
								{
									definitionIsConsistent = false;
									errorCount++;
									printError(errorFile, logFile,  "Number of parameters isn't consistent with declaration", lineCount);
								}

								string declaredType = currFunc->getType();
								if (declaredType != funcType)		//	ERROR - Return type doesn't match
								{
									definitionIsConsistent = false;
									errorCount++;
									printError(errorFile, logFile,  "Function return type doesn't match with declaration", lineCount);	
								}

								vector<Parameter> declaredParamList = currFunc->getParamList();
								
								if ((declaredParamSize != 0) && (declaredParamSize == definedParamSize))
								{
									for (int i=0; i < declaredParamSize; i++)
									{
										string declaredType = declaredParamList[i].type;
										string currentType = paramList[i].type;

										if (declaredType != currentType)	//	ERROR - Type mismatch in function parameter
										{
											definitionIsConsistent = false;
											errorCount++;
											string msg = "Type mismatch of function parameter '" + paramList[i].name + "'";
											printError(errorFile, logFile,  msg, lineCount);
										}
									}
								}

								st.remove(funcName);

								SymbolInfo temp;
								temp.setAsFunction(funcName, funcType, paramList);
								temp.setDefined(true);

								st.insertSymbolInfo(temp);

								st.enterScope();

								bool inserted = false;
								for (int i=0; i < paramList.size(); i++)
								{
									inserted = st.insert(paramList[i].name, paramList[i].type);

									if (!inserted)
									{
										errorCount++;
										string msg = "Multiple declaration of variable '" + paramList[i].name + "' in parameter";
										printError(errorFile, logFile,  msg, lineCount);
									}
								}

							}
						}
						else
						{
							st.enterScope();

							errorCount++;
							string msg = "Identifier '" + currFunc->getName() + "' is not a function.";
							printError(errorFile, logFile,  msg, lineCount);
						}						
					}
					else	// The Function isn't even declared.
					{
						SymbolInfo temp;
						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(true);
						st.insertSymbolInfo(temp);
						
						st.enterScope();

						bool inserted = false;

						for (int i=0; i < paramList.size(); i++)
						{
							inserted = st.insert(paramList[i].name, paramList[i].type);
							if (!inserted)
							{
								errorCount++;
								string msg = "Multiple declaration of variable '" + paramList[i].name + "' in parameter";
								printError(errorFile, logFile,  msg, lineCount);
							}
						}
					}
				}
    break;

  case 11:
/* Line 1792 of yacc.c  */
#line 277 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (7)].syminfo)->getName() + " " + (yyvsp[(2) - (7)].syminfo)->getName() + "(" + (yyvsp[(4) - (7)].syminfo)->getName() + ")" + (yyvsp[(7) - (7)].syminfo)->getName() + "\n", "func_definition");
					printLog(logFile, "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 12:
/* Line 1792 of yacc.c  */
#line 282 "1705066.y"
    {
					string funcType = (yyvsp[(1) - (4)].syminfo)->getName();
					string funcName = (yyvsp[(2) - (4)].syminfo)->getName();
					
					SymbolInfo* currFunc = st.lookup(funcName);
				
					if (currFunc != nullptr) // Function is declared
					{
						if (currFunc->isDefined()) // Declared and Defined
						{
							errorCount++;
							string msg = "Re-definition of function '" + funcName + "'";
							printError(errorFile, logFile,  msg, lineCount);
						}
						else	// Declared, but not defined
						{
							bool definitionIsConsistent = true;

							int declaredParamSize = currFunc->getParamList().size();
							int  definedParamSize = 0;

							if (declaredParamSize != definedParamSize)	//	ERROR - ParamList size doesnt match
							{
								definitionIsConsistent = false;
								errorCount++;
								printError(errorFile, logFile,  "Number of parameters isn't consistent with declaration", lineCount);
							}

							string declaredType = currFunc->getType();

							if (declaredType != funcType)		//	ERROR - Return type doesn't match
							{
								definitionIsConsistent = false;
								errorCount++;
								printError(errorFile, logFile,  "Function return type doesn't match with declaration", lineCount);	
							}

							if (definitionIsConsistent)
							{
								st.remove(funcName);

								SymbolInfo temp;
								vector<Parameter> paramList;

								temp.setAsFunction(funcName, funcType, paramList);
								temp.setDefined(true);

								st.insertSymbolInfo(temp);
							}
						}
					}
					else	// The Function isn't even declared.
					{
						SymbolInfo temp;
						vector<Parameter> paramList;

						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(true);
						st.insertSymbolInfo(temp);
					}
					st.enterScope();
				}
    break;

  case 13:
/* Line 1792 of yacc.c  */
#line 345 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (6)].syminfo)->getName() + " " + (yyvsp[(2) - (6)].syminfo)->getName() + "()" + (yyvsp[(6) - (6)].syminfo)->getName() + "\n", "func_definition");
					printLog(logFile, "func_definition : type_specifier ID LPAREN RPAREN compound_statement", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 14:
/* Line 1792 of yacc.c  */
#line 353 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (4)].syminfo)->getName() + "," + (yyvsp[(3) - (4)].syminfo)->getName() + " " + (yyvsp[(4) - (4)].syminfo)->getName(), "parameter_list");
					printLog(logFile, "parameter_list : parameter_list COMMA type_specifier ID", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 15:
/* Line 1792 of yacc.c  */
#line 358 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + "," + (yyvsp[(3) - (3)].syminfo)->getName(), "parameter_list");
					printLog(logFile, "parameter_list : parameter_list COMMA type_specifier", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 16:
/* Line 1792 of yacc.c  */
#line 363 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (2)].syminfo)->getName() + " " + (yyvsp[(2) - (2)].syminfo)->getName(), "parameter_list");
					printLog(logFile, "parameter_list : type_specifier ID", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 17:
/* Line 1792 of yacc.c  */
#line 368 "1705066.y"
    {
					(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
					printLog(logFile, "parameter_list : type_specifier", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 18:
/* Line 1792 of yacc.c  */
#line 376 "1705066.y"
    {
						(yyval.syminfo) = new SymbolInfo("{\n"+ (yyvsp[(2) - (3)].syminfo)->getName() + "\n}", "compound_statement");
						printLog(logFile, "compound_statement : LCURL statements RCURL", (yyval.syminfo)->getName(), lineCount);
						
						st.printAllScope_(logFile);
					}
    break;

  case 19:
/* Line 1792 of yacc.c  */
#line 383 "1705066.y"
    {
						(yyval.syminfo) = new SymbolInfo("{\n}", "compound_statement");
						printLog(logFile, "compound_statement : LCURL RCURL", (yyval.syminfo)->getName(), lineCount);
					}
    break;

  case 20:
/* Line 1792 of yacc.c  */
#line 391 "1705066.y"
    {
					string varName = (yyvsp[(2) - (3)].syminfo)->getName();
					string varType = (yyvsp[(1) - (3)].syminfo)->getName();

					//	ERROR REPORTING - Void type variable
					if (varType == "void")
					{
						errorCount++;
						printError(errorFile, logFile,  "Variable type can't be void", lineCount);
					} // ERROR DONE
					else
					{
						vector<string> strList = splitString(varName, ',');
						for (string current: strList)
						{
							SymbolInfo temp;

							if ( isArray(current) )
							{
								int arraySize = extractArraySize(current);
								string arrayName = extractArrayName(current);

								temp.setAsArray(arrayName, varType, arraySize);
							}
							else
							{
								temp = SymbolInfo(current, varType);
							}
							//	ERROR REPORTING - Multiple declaration of variable

							if ( !st.insertSymbolInfo(temp) ) {
								errorCount++;
								string msg = "Multiple declaration of variable '" + temp.getName() + "'";
								printError(errorFile, logFile,  msg, lineCount);
							} // ERROR DONE

						}
					}

					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + " " + (yyvsp[(2) - (3)].syminfo)->getName() + ";", "var_declaration");
					printLog(logFile, "var_declaration : type_specifier declaration_list SEMICOLON", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 21:
/* Line 1792 of yacc.c  */
#line 437 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo("int", "int");
					printLog(logFile, "type_specifier : INT", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 22:
/* Line 1792 of yacc.c  */
#line 442 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo("float", "int");
					printLog(logFile, "type_specifier : FLOAT", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 23:
/* Line 1792 of yacc.c  */
#line 447 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo("void", "void");
					printLog(logFile, "type_specifier : VOID", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 24:
/* Line 1792 of yacc.c  */
#line 455 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + "," + (yyvsp[(3) - (3)].syminfo)->getName(), "declaration_list");
					printLog(logFile, "declaration_list : declaration_list COMMA ID", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 25:
/* Line 1792 of yacc.c  */
#line 460 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (6)].syminfo)->getName() + "," + (yyvsp[(3) - (6)].syminfo)->getName() + "[" + (yyvsp[(5) - (6)].syminfo)->getName() + "]",	"declaration_list");
					printLog(logFile, "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 26:
/* Line 1792 of yacc.c  */
#line 465 "1705066.y"
    {
					(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
					printLog(logFile, "declaration_list : ID", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 27:
/* Line 1792 of yacc.c  */
#line 470 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (4)].syminfo)->getName() + "[" + (yyvsp[(3) - (4)].syminfo)->getName() + "]",	"declaration_list");
					printLog(logFile, "declaration_list : ID LTHIRD CONST_INT RTHIRD", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 28:
/* Line 1792 of yacc.c  */
#line 478 "1705066.y"
    {
				(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
				printLog(logFile, "statements : statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 29:
/* Line 1792 of yacc.c  */
#line 483 "1705066.y"
    {
				(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (2)].syminfo)->getName() + "\n" + (yyvsp[(2) - (2)].syminfo)->getName(), "statements");
				printLog(logFile, "statements : statements statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 30:
/* Line 1792 of yacc.c  */
#line 491 "1705066.y"
    {
				(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
				printLog(logFile, "statement : var_declaration", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 31:
/* Line 1792 of yacc.c  */
#line 496 "1705066.y"
    {
				(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
				printLog(logFile, "statement : expression_statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 32:
/* Line 1792 of yacc.c  */
#line 501 "1705066.y"
    {
				(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
				printLog(logFile, "statement : compound_statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 33:
/* Line 1792 of yacc.c  */
#line 506 "1705066.y"
    {
				(yyval.syminfo) = new SymbolInfo("for(" + (yyvsp[(3) - (7)].syminfo)->getName() + (yyvsp[(4) - (7)].syminfo)->getName() + (yyvsp[(5) - (7)].syminfo)->getName() + ")" + (yyvsp[(7) - (7)].syminfo)->getName(),	"statement");
				printLog(logFile, "statement : IF LPAREN expression_statement expression_statement expression RPAREN statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 34:
/* Line 1792 of yacc.c  */
#line 511 "1705066.y"
    {
				(yyval.syminfo) = new SymbolInfo("if(" + (yyvsp[(3) - (5)].syminfo)->getName() + ")" + (yyvsp[(5) - (5)].syminfo)->getName(),	"statement");
				printLog(logFile, "statement : IF LPAREN expression RPAREN statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 35:
/* Line 1792 of yacc.c  */
#line 516 "1705066.y"
    {
				(yyval.syminfo) = new SymbolInfo("if(" + (yyvsp[(3) - (7)].syminfo)->getName() + ")" + (yyvsp[(5) - (7)].syminfo)->getName() + "else" + (yyvsp[(7) - (7)].syminfo)->getName(),	"statement");
				printLog(logFile, "statement : IF LPAREN expression RPAREN statement ELSE statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 36:
/* Line 1792 of yacc.c  */
#line 521 "1705066.y"
    {
				(yyval.syminfo) = new SymbolInfo("while(" + (yyvsp[(3) - (5)].syminfo)->getName() + ")" + (yyvsp[(5) - (5)].syminfo)->getName(),	"statement");
				printLog(logFile, "statement : WHILE LPAREN expression RPAREN statement", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 37:
/* Line 1792 of yacc.c  */
#line 526 "1705066.y"
    {
				string idName = (yyvsp[(3) - (5)].syminfo)->getName();
				SymbolInfo* currId = st.lookup(idName);

				if (currId == nullptr)
				{
					errorCount++;
					string msg = "Variable '" + idName + "' undeclared";
					printError(errorFile, logFile,  msg, lineCount);
				}
				else
				{
					if ( !currId->isVariable() )
					{
						errorCount++;
						string msg = "A function can't be inside printf";
						printError(errorFile, logFile,  msg, lineCount);
					}
				}
				(yyval.syminfo) = new SymbolInfo("printf(" + (yyvsp[(3) - (5)].syminfo)->getName() + ");",	"statement");
				printLog(logFile, "statement : PRINTLN LPAREN ID RPAREN SEMICOLON", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 38:
/* Line 1792 of yacc.c  */
#line 549 "1705066.y"
    {
				string currentReturnType = (yyvsp[(2) - (3)].syminfo)->getName();

				if (currentFunctionReturnType == "void")
				{
					errorCount++;
					string msg = "Function type void can't have a return statement";
					printError(errorFile, logFile,  msg, lineCount);

					currentFunctionReturnType = ERROR;
				}

				(yyval.syminfo) = new SymbolInfo("return " + (yyvsp[(2) - (3)].syminfo)->getName() + ";", "statement");
				printLog(logFile, "statement : RETURN expression SEMICOLON", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 39:
/* Line 1792 of yacc.c  */
#line 568 "1705066.y"
    {
						(yyval.syminfo) = new SymbolInfo(";", "SEMICOLON");
					}
    break;

  case 40:
/* Line 1792 of yacc.c  */
#line 572 "1705066.y"
    {
						(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (2)].syminfo)->getName() + ";", "expression_statement");
						printLog(logFile, "expression_statement : expression SEMICOLON", (yyval.syminfo)->getName(), lineCount);
					}
    break;

  case 41:
/* Line 1792 of yacc.c  */
#line 580 "1705066.y"
    {
				string _returnType;
				SymbolInfo* currId = st.lookup((yyvsp[(1) - (1)].syminfo)->getName());
				
				if (currId == nullptr)
				{
					errorCount++;
					string msg = "Undeclared variable '" + (yyvsp[(1) - (1)].syminfo)->getName() + "' referred";
					printError(errorFile, logFile,  msg, lineCount);
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (1)].syminfo)->getName(), ERROR);
				}
				else
				{
					if (currId->isArray())
					{
						(yyval.syminfo) = new SymbolInfo();
						(yyval.syminfo)->setAsArray(currId->getName(), ERROR, currId->getSize());
					}
					else
					{
						(yyval.syminfo) = new SymbolInfo(currId->getName(), currId->getType());
					}
				}
				printLog(logFile, "variable : ID", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 42:
/* Line 1792 of yacc.c  */
#line 606 "1705066.y"
    {
				SymbolInfo* currId = st.lookup((yyvsp[(1) - (4)].syminfo)->getName());

				if (currId == nullptr)
				{
					errorCount++;
					string msg = "Undeclared variable '" + (yyvsp[(1) - (4)].syminfo)->getName() + "' referred";
					printError(errorFile, logFile,  msg, lineCount);

					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (4)].syminfo)->getName() + "[" + (yyvsp[(3) - (4)].syminfo)->getName() + "]",	ERROR);
				}
				else
				{
					if ( currId->isArray() )	//		Array Type variable
					{	
						string _returnType = currId->getType();
						//	ERROR REPORTING - Non-integer array index
						if ((yyvsp[(3) - (4)].syminfo)->getType() != "int")
						{
							errorCount++;
							printError(errorFile, logFile,  "Non-integer array index of '" + (yyvsp[(1) - (4)].syminfo)->getName() + "'", lineCount);
						}	//	ERROR REPORTING END

						(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (4)].syminfo)->getName() + "[" + (yyvsp[(3) - (4)].syminfo)->getName() + "]", currId->getType());
					}
					else
					{
						errorCount++;
						string msg = "Type mismatch. Variable '" + currId->getName() + "' is not an array";
						printError(errorFile, logFile,  msg, lineCount);

						(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (4)].syminfo)->getName() + "[" + (yyvsp[(3) - (4)].syminfo)->getName() + "]",	ERROR);
					}
				}
				printLog(logFile, "variable : ID LTHIRD expression RTHIRD", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 43:
/* Line 1792 of yacc.c  */
#line 646 "1705066.y"
    {
				(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
				printLog(logFile, "expression : logic_expression", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 44:
/* Line 1792 of yacc.c  */
#line 651 "1705066.y"
    {
				SymbolInfo* leftVar  = (yyvsp[(1) - (3)].syminfo);
				SymbolInfo* rightVar = (yyvsp[(3) - (3)].syminfo);

				if (leftVar->getType() == rightVar->getType())
				{
					// ... all good
				}
				else
				{
					if (leftVar->getType() == ERROR || rightVar->getType() == ERROR)
					{
						if (leftVar->isArray() || rightVar->isArray())
						{
							string msg;
							
							if (leftVar->isArray())
								msg = "Type mismatch. Variable '" + leftVar->getName() + "' is an array";
							else if (rightVar->isArray())
								msg = "Type mismatch. Variable '" + rightVar->getName() + "' is an array";						
							
							errorCount++;
							printError(errorFile, logFile,  msg, lineCount);
						}
					}
					else if (leftVar->getType() == "float" && rightVar->getType() == "int")
					{
						// it's okay
					}
					else
					{
						errorCount++;
						string msg = "Warning: Type mismatch of variable '" + leftVar->getName() + "'";
						printError(errorFile, logFile,  msg, lineCount);
					}

				}
				
				(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + "=" + (yyvsp[(3) - (3)].syminfo)->getName(), "expression");
				printLog(logFile, "expression : variable ASSIGNOP logic_expression", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 45:
/* Line 1792 of yacc.c  */
#line 696 "1705066.y"
    {
						(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
						printLog(logFile, "logic_expression : rel_expression", (yyval.syminfo)->getName(), lineCount);
					}
    break;

  case 46:
/* Line 1792 of yacc.c  */
#line 701 "1705066.y"
    {
						string _returnType = "int";
						//	The result of RELOP and LOGICOP should be "int""
						string leftType = (yyvsp[(1) - (3)].syminfo)->getType();
						string rightType = (yyvsp[(3) - (3)].syminfo)->getType();
						
						if ((leftType != "int") || (rightType != "int"))
						{
							errorCount++;
							string msg = "Both operand of " + (yyvsp[(2) - (3)].syminfo)->getName() + " should be int type";
							printError(errorFile, logFile,  msg, lineCount);

							_returnType = ERROR;
						}

						(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + (yyvsp[(2) - (3)].syminfo)->getName() + (yyvsp[(3) - (3)].syminfo)->getName(),	_returnType);
						printLog(logFile, "logic_expression : rel_expression LOGICOP rel_expression", (yyval.syminfo)->getName(), lineCount);
					}
    break;

  case 47:
/* Line 1792 of yacc.c  */
#line 722 "1705066.y"
    {
					(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
					printLog(logFile, "rel_expression : simple_expression", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 48:
/* Line 1792 of yacc.c  */
#line 727 "1705066.y"
    {
					//	The result of RELOP and LOGICOP should be "int"
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + (yyvsp[(2) - (3)].syminfo)->getName() + (yyvsp[(3) - (3)].syminfo)->getName(),	"int");
					printLog(logFile, "rel_expression : simple_expression RELOP simple_expression", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 49:
/* Line 1792 of yacc.c  */
#line 735 "1705066.y"
    {
						(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
						printLog(logFile, "simple_expression : term", (yyval.syminfo)->getName(), lineCount);
					}
    break;

  case 50:
/* Line 1792 of yacc.c  */
#line 740 "1705066.y"
    {
						string finalType = "int";
						if (((yyvsp[(1) - (3)].syminfo)->getType() == "float") || ((yyvsp[(3) - (3)].syminfo)->getType() == "float"))
						{
							finalType = "float";
						}

						(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + (yyvsp[(2) - (3)].syminfo)->getName() + (yyvsp[(3) - (3)].syminfo)->getName(), finalType);
						printLog(logFile, "simple_expression : simple_expression ADDOP term", (yyval.syminfo)->getName(), lineCount);
					}
    break;

  case 51:
/* Line 1792 of yacc.c  */
#line 754 "1705066.y"
    {
			(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
			printLog(logFile, "term : unary_expression", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 52:
/* Line 1792 of yacc.c  */
#line 759 "1705066.y"
    {
			string leftType = (yyvsp[(1) - (3)].syminfo)->getType();
			string rightType = (yyvsp[(3) - (3)].syminfo)->getType();

			string _returnType = ERROR;
			string operatorSymbol = (yyvsp[(2) - (3)].syminfo)->getName();

			if (operatorSymbol == "%")
			{	//	ERROR REPORTING - Non-integer operand on MOD (%)
				if (leftType != "int" || rightType != "int")
				{
					errorCount++;
					printError(errorFile, logFile,  "Non-integer operand on modulus operator", lineCount);
					_returnType = ERROR;
				}	// ERROR REPORTING END
				else
				{
					string rightSymbol = (yyvsp[(3) - (3)].syminfo)->getName();
					if (rightSymbol == "0")
					{
						errorCount++;
						string msg = "Modulus by zero";
						printError(errorFile, logFile,  msg, lineCount);
					}
					_returnType = "int";
				}
			}
			else if (operatorSymbol == "*" || operatorSymbol == "/")
			{
				if (leftType == "float" || rightType == "float")	_returnType = "float";
				else												_returnType = "int";

				if (operatorSymbol == "/")
				{
					string rightSymbol = (yyvsp[(3) - (3)].syminfo)->getName();
					if (rightSymbol == "0")
					{
						errorCount++;
						string msg = "Divided by zero not possible";
						printError(errorFile, logFile,  msg, lineCount);

						_returnType = ERROR;
					}
				}
			}
			else
			{
				_returnType = "undeclared";
			}

			(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (3)].syminfo)->getName() + (yyvsp[(2) - (3)].syminfo)->getName() + (yyvsp[(3) - (3)].syminfo)->getName(), _returnType);
			printLog(logFile, "term : term MULOP unary_expression", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 53:
/* Line 1792 of yacc.c  */
#line 816 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (2)].syminfo)->getName() + (yyvsp[(2) - (2)].syminfo)->getName(),	(yyvsp[(2) - (2)].syminfo)->getType());
					printLog(logFile, "unary_expression : ADDOP unary_expression", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 54:
/* Line 1792 of yacc.c  */
#line 821 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo("!" + (yyvsp[(2) - (2)].syminfo)->getName(),	(yyvsp[(2) - (2)].syminfo)->getType());
					printLog(logFile, "unary_expression : NOT unary_expression", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 55:
/* Line 1792 of yacc.c  */
#line 826 "1705066.y"
    {
					(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
					printLog(logFile, "unary_expression : factor", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 56:
/* Line 1792 of yacc.c  */
#line 834 "1705066.y"
    {
			(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
			printLog(logFile, "factor : variable", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 57:
/* Line 1792 of yacc.c  */
#line 839 "1705066.y"
    {
			string _returnType = "undeclared";

			SymbolInfo *currFunc;
			currFunc = st.lookup((yyvsp[(1) - (4)].syminfo)->getName());
			
			if (currFunc == nullptr)
			{
				errorCount++;
				string msg = "Undeclared function '" + (yyvsp[(1) - (4)].syminfo)->getName() + "' referred";
				printError(errorFile, logFile,  msg, lineCount);
			}
			else
			{
				// whether we're accessing a function or a variable
				if (currFunc->isFunction())
				{
					_returnType = currFunc->getType();
					string argNameString = (yyvsp[(3) - (4)].syminfo)->getName();
					string argTypeString = (yyvsp[(3) - (4)].syminfo)->getType();
					
					vector<string> argNames = splitString(argNameString, ',');
					vector<string> argTypes = splitString(argTypeString, ',');
					
					vector<Parameter> paramList = currFunc->getParamList();

					if (_returnType == "void")
					{
						errorCount++;
						string msg = "Void function can't be used as factor";
						printError(errorFile, logFile,  msg, lineCount);
					}
					else if (paramList.size() != argNames.size())	//	Numbers of arguments don't match
					{
						errorCount++;
						string msg = "Number of arguments isn't consistent with function '" + currFunc->getName() + "'";
						printError(errorFile, logFile,  msg, lineCount);
					}
					else	//	Numbers of arguments match. Now let's match the types
					{
						for (int i=0; i < argNames.size(); i++)
						{
							if (argTypes[i] != paramList[i].type)
							{
								errorCount++;
								string msg = "Type mismatch on function '" + currFunc->getName() + "'s argument '" + paramList[i].name + "'";
								printError(errorFile, logFile,  msg, lineCount);
							}
						}
					}
				}
				else
				{
					errorCount++;
					string msg = "Non function Identifier '" + currFunc->getName() + "' accessed";
					printError(errorFile, logFile,  msg, lineCount);
				}
			}
			// arg_list check left
			(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (4)].syminfo)->getName() + "(" + (yyvsp[(3) - (4)].syminfo)->getName() + ")",	_returnType);
			printLog(logFile, "factor : ID LPAREN argument_list RPAREN", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 58:
/* Line 1792 of yacc.c  */
#line 902 "1705066.y"
    {
			(yyval.syminfo) = new SymbolInfo("(" + (yyvsp[(2) - (3)].syminfo)->getName() + ")",	(yyvsp[(2) - (3)].syminfo)->getType() );
			printLog(logFile, "factor : LPAREN expression RPAREN", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 59:
/* Line 1792 of yacc.c  */
#line 907 "1705066.y"
    {
			(yyval.syminfo) = yylval.syminfo;
			printLog(logFile, "factor : CONST_INT", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 60:
/* Line 1792 of yacc.c  */
#line 912 "1705066.y"
    {
			(yyval.syminfo) = yylval.syminfo;
			printLog(logFile, "factor : CONST_FLOAT", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 61:
/* Line 1792 of yacc.c  */
#line 917 "1705066.y"
    {
			(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (2)].syminfo)->getName() + "++",	(yyvsp[(1) - (2)].syminfo)->getType());
			printLog(logFile, "factor : variable INCOP", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 62:
/* Line 1792 of yacc.c  */
#line 922 "1705066.y"
    {
			(yyval.syminfo) = new SymbolInfo((yyvsp[(1) - (2)].syminfo)->getName() + "--",	(yyvsp[(1) - (2)].syminfo)->getType());
			printLog(logFile, "factor : variable DECOP", (yyval.syminfo)->getName(), lineCount);
		}
    break;

  case 63:
/* Line 1792 of yacc.c  */
#line 930 "1705066.y"
    {
					(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
					printLog(logFile, "argument_list : arguments", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 64:
/* Line 1792 of yacc.c  */
#line 935 "1705066.y"
    {
					(yyval.syminfo) = new SymbolInfo("", "void");
					printLog(logFile, "argument_list : ", (yyval.syminfo)->getName(), lineCount);
				}
    break;

  case 65:
/* Line 1792 of yacc.c  */
#line 943 "1705066.y"
    {
				string argNames = (yyvsp[(1) - (3)].syminfo)->getName() + "," + (yyvsp[(3) - (3)].syminfo)->getName();
				string argTypes = (yyvsp[(1) - (3)].syminfo)->getType() + "," + (yyvsp[(3) - (3)].syminfo)->getType();

				(yyval.syminfo) = new SymbolInfo(argNames, argTypes);
				printLog(logFile, "arguments : arguments COMMA logic_expression", (yyval.syminfo)->getName(), lineCount);
			}
    break;

  case 66:
/* Line 1792 of yacc.c  */
#line 951 "1705066.y"
    {
				(yyval.syminfo) = (yyvsp[(1) - (1)].syminfo);
				printLog(logFile, "arguments : logic_expression", (yyval.syminfo)->getName(), lineCount);
			}
    break;


/* Line 1792 of yacc.c  */
#line 2613 "1705066.tab.c"
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


/* Line 2055 of yacc.c  */
#line 958 "1705066.y"

int main(int argc,char *argv[])
{
    inputFile = fopen(argv[1], "r");

	if(inputFile == nullptr) {
		printf("Cannot Open Input File.\n");
		exit(1);
	}

    logFile = fopen("log.txt", "w");
    errorFile = fopen("error.txt", "w");

	yyin = inputFile;
	yyparse();

	// Logfile print
	st.printAllScope_(logFile);
	fprintf(logFile, "Total lines: %d\n", lineCount);
	fprintf(logFile, "Total errors: %d\n", errorCount);

	// // Console Print
	// cout << "\nTotal Lines: "  << lineCount << endl;
	// cout << "Total Errors: " << errorCount << endl;

	fclose(logFile);
	fclose(errorFile);

	return 0;
}
'_m4eof'
_m4eof
