CREATE MATERIALIZED VIEW mv_team_summary AS
SELECT
  -- Identity / table context
  squad,
  position,
  matches_played,
  points,
  points_per_match,
  goals_for,
  goals_against,
  goal_diff,

  -- Attack & xG
  goals_per90,
  g_a_per90,
  xg,
  xg_allowed,
  xg_diff,
  xg_diff_per90,
  xg_per90,
  xag_per90,
  npxg_per90,
  npxg_xag_per90,

  -- Shooting & finishing
  shots_per90,
  sot_per90,
  goals_per_shot,
  goals_per_sot,
  npxg_per_shot,
  goals_minus_xg,
  npk_goals_minus_xg,

  -- Chance creation
  sca_per90,
  gca_per90,

  -- Passing & style
  pass_completion_pct,
  short_pass_completion_pct,
  medium_pass_completion_pct,
  long_pass_completion_pct,
  pass_total_distance,
  pass_progressive_distance,
  carries_total_distance,
  carries_progressive_distance,
  progressive_carries,
  carries_final_third,
  carries_pen_area,
  live_passes,
  dead_passes,
  crosses,
  switches,
  corners,

  -- Defensive profile
  tackles,
  tackles_won,
  dribblers_tackled_pct,
  blocks_total,

  -- Touches / take-ons
  touches,
  touches_def_3rd,
  touches_mid_3rd,
  touches_att_3rd,
  takeons_attempted,
  takeons_success_pct

FROM team_metrics;