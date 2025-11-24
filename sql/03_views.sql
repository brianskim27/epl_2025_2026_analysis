CREATE OR REPLACE VIEW team_metrics AS
SELECT
  s.squad,

  /* ===== Standings (table context) ===== */
  st.rk AS position,                           -- Table position
  st.mp AS league_mp,                          -- # of matches played
  st.w AS wins,                                -- Wins
  st.d AS draws,                               -- Draws
  st.l AS losses,                              -- Losses
  st.gf AS goals_for,                          -- Goals for
  st.ga AS goals_against,                      -- Goals against
  st.gd AS goal_diff,                          -- Goal difference
  st.pts AS points,                            -- # of points
  st.pts_mp AS points_per_match,               -- # of points per matches played
  st.xg AS xg,                                 -- Expected goals
  st.xga AS xg_allowed,                        -- Expected goals allowed
  st.xgd AS xg_diff,                           -- Expected goals difference
  st.xgd_90 AS xg_diff_per90,                  -- Expected goals difference per 90
  st.last_5 AS form,                           -- Form (last 5 games)
  st.attendance AS attendance,                 -- Attendance
  st.top_team_scorer AS top_team_scorer,       -- Team's top scorer
  st.goalkeeper AS goalkeeper,                 -- Team's goalkeeper

  /* ===== Team Standard (per-90 & totals) ===== */
  s.playing_time_mp AS matches_played,         -- # of matches played
  s.playing_time_starts AS starts,             -- # of starts
  s.playing_time_min AS minutes,               -- # of minutes
  s.playing_time_90s AS nineties_played,       -- # of 90 minutes played
  s.performance_gls AS goals,                  -- # of goals
  s.performance_ast AS assists,                -- # of assists
  s.performance_ga AS goals_plus_assists,      -- # of goals & assists
  s.performance_gpk AS goals_not_pk,           -- # of non-penalty goals
  s.performance_pk AS pk_goals,                -- # of penalty goals
  s.performance_pkatt AS pk_attempts,          -- # of penalty attempts
  s.performance_crdy AS yellows,               -- # of yellow cards
  s.performance_crdr AS reds,                  -- # of red cards
  s.expected_npxg AS npxg,                     -- Non-penalty expected goals
  s.expected_xag AS xag,                       -- Expected assisted goals
  s.expected_npxgxag AS npxg_xag,              -- Non-penalty expected goals + Expected assisted goals
  s.progression_prgp AS progressive_passes,    -- Progressive passes

  -- Per-90 metrics
  s.per_90_minutes_gls AS goals_per90,         -- Goals per 90 minutes
  s.per_90_minutes_ast AS assists_per90,       -- Assists per 90 minutes
  s.per_90_minutes_ga AS g_a_per90,             -- Goals + Assists per 90 minutes
  s.per_90_minutes_gpk AS gnpk_per90,          -- Non-penalty goals per 90 minutes
  s.per_90_minutes_gapk AS ganpk_per90,        -- Non-penalty goals + assists per 90 minutes
  s.per_90_minutes_xg AS xg_per90,             -- Expected goals per 90 minutes
  s.per_90_minutes_xag AS xag_per90,           -- Expected assisted goals per 90 minutes
  s.per_90_minutes_xgxag AS xg_xag_per90,      -- Expected goals + Expected assisted goals per 90 minutes
  s.per_90_minutes_npxg AS npxg_per90,         -- Expected non-penalty goals per 90 minutes
  s.per_90_minutes_npxgxag AS npxg_xag_per90,  -- Expected non-penalty goals + Expected assists per 90 minutes

  /* ===== Shooting ===== */
  sh.standard_sh AS shots_total,               -- Total # of shots
  sh.standard_sot AS shots_on_target,          -- # of shots on target
  sh.standard_sot_1 AS shots_on_target_pct,    -- Shots on target percentage
  sh.standard_sh_90 AS shots_per90,            -- Shots per 90 minutes
  sh.standard_sot_90 AS sot_per90,             -- Shots on target per 90 minutes
  sh.standard_g_sh AS goals_per_shot,          -- # of goals per shot
  sh.standard_g_sot AS goals_per_sot,          -- # of goals per shot on target
  sh.standard_dist AS avg_shot_distance,       -- Average shot distance
  sh.standard_fk AS shots_fk,                  -- Shots from free kicks
  sh.standard_pk AS shots_pk,                  -- Shots from penalty kicks
  sh.standard_pkatt AS shots_pkatt,            -- Penalty shot attempts
  sh.expected_npxg_sh AS npxg_per_shot,        -- Non-penalty expected goals per shot
  sh.expected_gxg AS goals_minus_xg,           -- Goals minus expected goals
  sh.expected_npgxg AS npk_goals_minus_xg,     -- Non-penalty goals minus expected goals

  /* ===== Passing (totals & distribution) ===== */
  p.total_cmp AS passes_completed,             -- Passes completed
  p.total_att AS passes_attempted,             -- Passes attempted
  p.total_cmp_pct AS pass_completion_pct,      -- Passes completed percentage
  p.total_totdist AS pass_total_distance,      -- Total passing distance
  p.total_prgdist AS pass_progressive_distance,-- Progressive passing distance
  p.short_cmp AS short_passes_completed,       -- Short passes completed
  p.short_att AS short_passes_attempted,       -- Short passes attempted
  p.short_cmp_pct AS short_pass_completion_pct,-- Short pass completion percentage
  p.medium_cmp AS medium_passes_completed,     -- Medium passes completed
  p.medium_att AS medium_passes_attempted,     -- Medium passes attempted
  p.medium_cmp_pct AS medium_pass_completion_pct, -- Medium pass completion percentage
  p.long_cmp AS long_passes_completed,         -- Long passes completed
  p.long_att AS long_passes_attempted,         -- Long passes attempted
  p.long_cmp_pct AS long_pass_completion_pct,  -- Long pass completion percentage
  p.expected_xa AS xa_total,                    -- Expected assists
  p.expected_axag AS xa_minus_xga_total,        -- Assists minus expected assisted goals

  /* ===== Pass Types (style) ===== */
  pt.pass_types_live AS live_passes,           -- Live-ball passes
  pt.pass_types_dead AS dead_passes,           -- Dead-ball passes
  pt.pass_types_fk AS free_kicks,              -- Free kicks
  pt.pass_types_tb AS through_balls,           -- Through balls
  pt.pass_types_sw AS switches,                -- Switches
  pt.pass_types_crs AS crosses,                -- Crosses
  pt.pass_types_ti AS throw_ins,               -- Throw ins
  pt.pass_types_ck AS corners,                 -- Corner kicks
  pt.corner_kicks_in AS corners_inswinging,    -- Inswinging corners
  pt.corner_kicks_out AS corners_outswinging,  -- Outswinging corners
  pt.corner_kicks_str AS corners_straight,     -- Straight corners
  pt.outcomes_off AS offsides,                 -- Offside passes
  pt.outcomes_blocks AS passes_blocked_opp,    -- Passes blocked by opponent

  /* ===== Shot/Goal Creation ===== */
  sc.sca_sca AS sca,                           -- Shot-creating actions
  sc.sca_per90 AS sca_per90,                   -- SCA per 90
  sc.sca_types_passlive AS sca_live_passes,    -- Live-ball passes that lead to shot attempt
  sc.sca_types_passdead AS sca_dead_passes,    -- Dead-ball passes that lead to shot attempt
  sc.sca_types_to AS sca_takeons,              -- Take-ons leading to shot attempt
  sc.sca_types_sh AS sca_shots,                -- Shots leading to shot attempt
  sc.sca_types_fld AS sca_fouls_drawn,         -- Fouls drawn leading to shot attempt
  sc.sca_types_def AS sca_def_actions,         -- Defensive actions leading to shot attempt
  sc.gca_gca AS gca,                           -- Goal-creating actions
  sc.gca_gca90 AS gca_per90,                   -- Goal-creating actions per 90 minutes
  sc.gca_types_passlive AS gca_live_passes,    -- Live-ball passes leading to goal
  sc.gca_types_passdead AS gca_dead_passes,    -- Dead-ball passes leading to goal
  sc.gca_types_to AS gca_takeons,              -- Take-ons leading to goal
  sc.gca_types_sh AS gca_shots,                -- Shots leading to goal-scoring shot
  sc.gca_types_fld AS gca_fouls_drawn,         -- Fouls drawn leading to goal
  sc.gca_types_def AS gca_def_actions,         -- Defensive actions leading to goal

  /* ===== Defensive Actions ===== */
  d.tackles_tkl AS tackles,                    -- # of tackles
  d.tackles_tklw AS tackles_won,               -- # of tackles won
  d.tackles_def_3rd AS tackles_def_3rd,        -- Tackles in defensive 1/3
  d.tackles_mid_3rd AS tackles_mid_3rd,        -- Tackles in middle 1/3
  d.tackles_att_3rd AS tackles_att_3rd,        -- Tackles in attacking 1/3
  d.challenges_tkl AS dribblers_tackled,       -- Dribblers tackled
  d.challenges_att AS dribblers_challenged,    -- Dribblers challenged
  d.challenges_tkl_pct AS dribblers_tackled_pct,-- Percentage of dribblers tackled
  d.challenges_lost AS challenges_lost,        -- Challenges lost
  d.blocks_blocks AS blocks_total,             -- Total blocks
  d.blocks_sh AS blocks_shots,                 -- Shots blocked
  d.blocks_pass AS blocks_passes,              -- Passes blocked

  /* ===== Possession / Carrying / Receiving ===== */
  pos.poss AS possession,                      -- # possession
  pos.touches_touches AS touches,              -- # of touches
  pos.touches_def_pen AS touches_def_pen,      -- Touches in defensive penalty area
  pos.touches_def_3rd AS touches_def_3rd,      -- Touches in defensive 3rd
  pos.touches_mid_3rd AS touches_mid_3rd,      -- Touches in middle 3rd
  pos.touches_att_3rd AS touches_att_3rd,      -- Touches in attacking 3rd
  pos.touches_att_pen AS touches_att_pen,      -- Touches in attacking penalty area
  pos.touches_live AS live_touches,            -- Live-ball touches
  pos.takeons_att AS takeons_attempted,        -- Take-ons attempted
  pos.takeons_succ AS takeons_successful,      -- Successful take-ons
  pos.takeons_succ_pct AS takeons_success_pct, -- Percentage of successful take-ons
  pos.takeons_tkld AS takeons_tackled,         -- Times tackled during take-ons
  pos.takeons_tkld_pct AS takeons_tackled_pct, -- Percentage tackled during take-ons
  pos.carries_carries AS carries,              -- Carries
  pos.carries_totdist AS carries_total_distance,  -- Total distance during carries
  pos.carries_prgdist AS carries_progressive_distance, -- Progressive carry distance
  pos.carries_prgc AS progressive_carries,     -- Progressive carries
  pos.carries_1_3 AS carries_final_third,      -- Carries into final third
  pos.carries_cpa AS carries_pen_area,         -- Carries into penalty area
  pos.carries_mis AS miscontrols,              -- Miscontrols
  pos.carries_dis AS dispossessed,             -- Dispossessions
  pos.receiving_rec AS passes_received,        -- Passes received
  pos.receiving_prgr AS progressive_passes_received, -- Progressive passes received

  /* ===== Playing-time extras ===== */
  ptm.starts_mn_start AS minutes_per_start,    -- # of minutes per match started
  ptm.starts_compl AS complete_matches,        -- # of completed matches played
  ptm.subs_subs AS games_as_sub,               -- # of games as subs
  ptm.subs_mn_sub AS minutes_per_sub,          -- # of minutes per substitution
  ptm.subs_unsub AS games_unused_sub           -- # of games as unused substitution

FROM team_standard s
LEFT JOIN team_shooting sh ON sh.squad  = s.squad
LEFT JOIN team_passing p ON p.squad   = s.squad
LEFT JOIN team_pass_types pt ON pt.squad = s.squad
LEFT JOIN team_shot_creation sc ON sc.squad = s.squad
LEFT JOIN team_defensive d ON d.squad   = s.squad
LEFT JOIN team_possession pos ON pos.squad = s.squad
LEFT JOIN team_playing_time ptm ON ptm.squad = s.squad
LEFT JOIN team_standings st ON st.squad  = s.squad;
