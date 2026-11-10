-- LTeX+: the deep grammar check. It talks to the LanguageTool server in the
-- homelab, which holds the 12GB English n-gram corpus.
--
-- This server starts with the others. It does not duplicate Harper, because
-- the rules that both engines report are off in disabledRules below. Harper
-- reports a typo in about 10ms. This server reports the confusion pairs and
-- the picky style rules on save.
--
-- ltex-ls-plus runs a local JVM. The corpus stays on the cluster, not the
-- Java runtime.
--
-- nvim-lspconfig supplies cmd and the filetype list. This file adds the
-- settings only.
--
-- Settings reference: https://ltex-plus.github.io/ltex-plus/settings.html

return {
	settings = {
		ltex = {
			-- The homelab server. An empty value here makes ltex-ls-plus load
			-- its own LanguageTool, without the n-grams. Give the base URI.
			-- The server appends /v2/check.
			--
			-- Use the Traefik route, not the container name and port.
			-- Technitium resolves every *.nightcity.network name to the
			-- Traefik VIP 10.0.0.200. Traefik routes on the Host header on
			-- ports 80 and 443, and it does not listen on 8010. A URI of
			-- http://languagetool.nightcity.network:8010 therefore hangs
			-- until the connection times out.
			--
			-- A failed request gives 0 rule matches, not an error. The
			-- symptom is silence, so test the route with curl before you
			-- debug anything in this file:
			--   curl -s https://grammar.nightcity.network/v2/languages
			--
			-- If the name does not resolve at all, a VPN client probably
			-- took over the resolver.
			languageToolHttpServerUri = "https://grammar.nightcity.network",

			language = "en-AU",

			-- A check costs about 400ms for a paragraph, because the request
			-- crosses the network and the server reads the n-grams. On each
			-- keystroke that is too slow. Harper covers the keystroke case.
			checkFrequency = "save",

			-- This is the deliberate deep pass, so ask for the strict style
			-- rules as well as the grammar rules.
			additionalRules = {
				enablePickyRules = true,
			},

			-- Harper reports these already, and it reports them immediately.
			-- A second report on save adds nothing but a duplicate.
			--
			-- MORFOLOGIK_RULE_EN_AU is the spell check. It is the whole
			-- overlap between the two engines. With it off, this server
			-- reports only what Harper cannot find: the confusion pairs
			-- (THEIR_IS, CONFUSION_RULE_HEAR_HERE and the rest, which need
			-- the n-gram corpus) and the picky style rules.
			--
			-- To find a rule id, send the sentence to the server and read the
			-- id from the response:
			--   curl -s -d "language=en-AU" --data-urlencode "text=<text>" \
			--     https://grammar.nightcity.network/v2/check | jq -r '.matches[].rule.id'
			disabledRules = {
				["en-AU"] = {
					-- Spelling. This is the largest overlap.
					"MORFOLOGIK_RULE_EN_AU",
					-- Harper: Spaces
					"WHITESPACE_RULE",
					-- Harper: RepeatedWords
					"ENGLISH_WORD_REPEAT_RULE",
					-- Harper: AnA
					"EN_A_VS_AN",
					-- Harper: TheirToThere
					"THEIR_IS",
				},
			},
		},
	},
}
