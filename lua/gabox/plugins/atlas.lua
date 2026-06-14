return {
  "emrearmagan/atlas.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim", -- optional but recommended
    "esmuellert/codediff.nvim", -- optional (PullRequest diff)
    "sindrets/diffview.nvim", -- optional (PullRequest diff - alternative)
  },
  opts = {
    pulls = {
      diff = {
        -- Command must support range input: origin/<destination>...origin/<source>
        open_cmd = "DiffviewOpen", -- e.g. "DiffviewOpen" or "CodeDiff", defaults to nil.
      },
      repo_config = {
        paths = {
          [""] = "",
        },
      },
      providers = {
        ---@type AtlasBitbucketConfig
        bitbucket = {
          user = os.getenv("BITBUCKET_USER") or "",
          token = os.getenv("BITBUCKET_TOKEN")
            or "",
          cache_ttl = 300,

          ---@type AtlasBitbucketViewConfig[]
          views = {
            {
              name = "Me",
              key = "M",
              layout = "compact",
              repos = {
                { workspace = "", repo = "" },
              },

              ---@param pr PullRequest
              ---@param ctx { user: PullsUser|nil }
              filter = function(pr, ctx)
                local user = ctx.user
                return pr.author and user and pr.author.id == user.id
              end,
            },
            {
              name = "Team",
              key = "1",
              layout = "plain", -- "compact" or "plain"
              repos = {
                { workspace = "", repo = "" },
                { workspace = "", repo = "" },
              },
            },
          },
        }, -- See configuration below
        ---@type AtlasGitHubConfig
        github = {}, -- See configuration below
        ---@type AtlasGitLabPullsConfig
        gitlab = {}, -- See configuration below
      },
    },
    issues = {
      providers = {
        ---@type AtlasJiraIssuesConfig
        jira = {}, -- See configuration below
        ---@type AtlasGitHubIssuesConfig
        github = {}, -- See configuration below
        ---@type AtlasGitLabIssuesConfig
        gitlab = {}, -- See configuration below
      },
    },
  },
}
