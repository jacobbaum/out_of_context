# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#   t.string   "tag"
#   t.string   "description"

pos_tags = PosTag.create([
  { tag: "CC",   description: "Coordinating conjuction",                example: "'and', 'but', etc" },
  { tag: "CD",   description: "Cardinal number",                        example: "'three', '82', etc" },
  { tag: "DET",  description: "Determiner",                             example: '' },
  { tag: "EX",   description: "Pronoun, existential there",             example: '' },
  { tag: "FW",   description: "Foreign words",                          example: '' },
  { tag: "IN",   description: "Preposition / Conjunction",              example: '' },
  { tag: "JJ",   description: "Adjective",                              example: "'big', 'awesome', etc" },
  { tag: "JJR",  description: "Comparative Adjective",                  example: "'bigger', 'awesomer', etc" },
  { tag: "JJS",  description: "Superlative Adjective",                  example: "'biggest', 'awesomest', etc" },
  { tag: "LS",   description: "Symbol, list item",                      example: '' },
  { tag: "MD",   description: "Verb, modal",                            example: '' },
  { tag: "NN",   description: "Noun (singular)",                        example: '' },
  { tag: "NNP",  description: "Noun (proper & singular)",               example: '' },
  { tag: "NNPS", description: "Noun (proper & plural)",                 example: '' },
  { tag: "NNS",  description: "Noun (plural)",                          example: '' },
  { tag: "PDT",  description: "Determiner, prequalifier",               example: '' },
  { tag: "POS",  description: "Possessive",                             example: '' },
  { tag: "PRP",  description: "Determiner, possessive second",          example: '' },
  { tag: "PRPS", description: "Determiner, possessive",                 example: '' },
  { tag: "RB",   description: "Adverb",                                 example: '' },
  { tag: "RBR",  description: "Adverb, comparative",                    example: '' },
  { tag: "RBS",  description: "Adverb, superlative",                    example: '' },
  { tag: "RP",   description: "Adverb, particle",                       example: '' },
  { tag: "SYM",  description: "Symbol",                                 example: '' },
  { tag: "TO",   description: "Preposition",                            example: '' },
  { tag: "UH",   description: "Interjection",                           example: '' },
  { tag: "VB",   description: "Verb (infinitive)",                      example: "'run', 'speak', etc" },
  { tag: "VBD",  description: "Verb (past participle)",                 example: "'ran', 'spoke', etc" },
  { tag: "VBG",  description: "Verb (present participle)",              example: "'running', 'speaking', etc" },
  { tag: "VBN",  description: "Verb (past & passive)",                  example: "'spoken', 'taken', etc" },
  { tag: "VBP",  description: "Verb (base present)",                    example: "'run', 'speak', etc" },
  { tag: "VBZ",  description: "Verb (present, third person)",           example: "'runs', 'speaks', etc" },
  { tag: "WDT",  description: "Determiner, question",                   example: '' },
  { tag: "WP",   description: "Pronoun, question",                      example: '' },
  { tag: "WPS",  description: "Determiner, possessive & question",      example: '' },
  { tag: "WRB",  description: "'Wh' Adverb",                            example: "'where', 'when', etc" },
  { tag: "PP",   description: "Punctuation, sentence ender",            example: '' },
  { tag: "PPC",  description: "Punctuation, comma",                     example: '' },
  { tag: "PPD",  description: "Punctuation, dollar sign",               example: '' },
  { tag: "PPL",  description: "Punctuation, quotation mark left",       example: '' },
  { tag: "PPR",  description: "Punctuation, quotation mark right",      example: '' },
  { tag: "PPS",  description: "Punctuation, colon, semicolon, elipsis", example: '' },
  { tag: "LRB",  description: "Punctuation, left bracket",              example: '' },
  { tag: "RRB",  description: "Punctuation, right bracket",             example: '' },
  { tag: "FNNP", description: "First name",                             example: "'Barak', 'Hillary', etc" },
  { tag: "LNNP", description: "Last name",                              example: "'Obama', 'Clinton', etc" },
])