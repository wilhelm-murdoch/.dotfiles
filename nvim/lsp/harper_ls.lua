-- Harper: the always-on inline grammar check. It runs in process on this
-- machine. It sends nothing anywhere.
--
-- Harper is the fast layer. It catches typos in about 10ms. LanguageTool at
-- grammar.nightcity.network is the deep layer. It catches confusion pairs
-- such as "their" and "there", and it costs about 400ms for a paragraph.
--
-- nvim-lspconfig supplies cmd = { "harper-ls", "--stdio" } and the filetype
-- list. This file adds the settings only.
--
-- Full rule list: https://writewithharper.com/docs/rules

return {
	settings = {
		["harper-ls"] = {
			-- Homelab terms such as Proxmox, Traefik and LXC. Add a word with
			-- the code action on the diagnostic, or edit the file directly.
			userDictPath = vim.fn.expand("~/.config/nvim/harper-dict.txt"),

			dialect = "Australian",

			-- "hint" keeps grammar out of the error column. Code diagnostics
			-- stay the loud ones.
			diagnosticSeverity = "hint",

			linters = {
				SpellCheck = true,
				AnA = true,
				UnclosedQuotes = true,
				RepeatedWords = true,
				Spaces = true,
				CorrectNumberSuffix = true,
				SpelledNumbers = false,

				-- The documentation voice is ASD-STE100. It caps a procedural
				-- sentence at 20 words and a descriptive sentence at 25. The
				-- vale STE linter enforces those limits. Harper uses a
				-- different threshold, so it would flag the same lines again
				-- with a different number.
				LongSentences = false,

				-- Markdown lists, code comments and table cells hold
				-- fragments. This rule flags each one.
				SentenceCapitalization = false,

				-- On by default. Named here because the house rule is the
				-- straight apostrophe, never the backtick, so a future
				-- reader knows the rule is wanted and not an accident.
				WrongApostrophe = true,

				-- The documentation voice is ASD-STE100. That voice forbids
				-- a contraction, and the house rule forbids the Oxford
				-- comma. Both rules apply to a code comment as well, so
				-- they stay on for every file type.
				--
				-- Harper ships two opposed comma rules. OxfordComma is on by
				-- default and it asks for the comma. NoOxfordComma is off by
				-- default and it removes the comma. Set both, or the default
				-- rule wins and asks for the comma you do not want.
				OxfordComma = false,
				NoOxfordComma = true,
				AvoidContractions = true,
			},

			markdown = {
				-- Do not spell check the text inside a link target.
				IgnoreLinkTitle = true,
			},
		},
	},
}
