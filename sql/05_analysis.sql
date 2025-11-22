------------------------------------------------------------
-- 1. xG Over/Under-Performance (rank difference)
------------------------------------------------------------

WITH ranked AS (
    SELECT
        squad,
        position,
        points_per_match,
        xg_diff_per90,
        RANK() OVER (ORDER BY points_per_match DESC) AS rank_points,
        RANK() OVER (ORDER BY xg_diff_per90 DESC) AS rank_xg_diff
    FROM mv_team_summary
)
SELECT
    squad,
    position,
    points_per_match,
    xg_diff_per90,
    rank_points,
    rank_xg_diff,
    rank_xg_diff - rank_points AS overperformance_rank_diff
FROM ranked
ORDER BY overperformance_rank_diff DESC
-- Positive overperformance_rank_diff = Team performs better in the table than xG suggests
-- Negative = Team performs worse in the table than xG suggests


------------------------------------------------------------
-- 2. Finishing Efficiency (clinical vs wasteful)
------------------------------------------------------------

SELECT
    squad,
    goals_per90,
    xg_per90,
    goals_per90 - xg_per90 AS finishing_over_xg_per90,
    goals_per_shot,
    goals_per_sot,
    npxg_per_shot,
    goals_minus_xg,
    npk_goals_minus_xg
FROM mv_team_summary
ORDER BY finishing_over_xg_per90 DESC
-- Higher finishing_over_xg_per90 = scoring more than expected from xG


------------------------------------------------------------
-- 3. Defensive Solidity (goals vs xG conceded)
------------------------------------------------------------

SELECT
    squad,
    goals_against,
    xg_allowed,
    ROUND((goals_against * 1.0) / matches_played, 3) AS ga_per90,
    ROUND((xg_allowed / matches_played), 3) AS xga_per90,
	ROUND((xg_allowed / matches_played), 3) - ROUND((goals_against * 1.0) / matches_played, 3) AS ga_vs_xga_per90,
    tackles,
    tackles_won,
    dribblers_tackled_pct,
    blocks_total
FROM mv_team_summary
ORDER BY ga_vs_xga_per90 DESC
-- Positive goals_saved_vs_xga_per90 = conceding fewer goals than xG allowed


------------------------------------------------------------
-- 4. Team Style
------------------------------------------------------------

SELECT
    squad,
    possession,
    pass_completion_pct,
    pass_progressive_distance,
    carries_progressive_distance,
    progressive_carries,
    crosses,
    switches,
    corners,
    CASE
        WHEN pass_progressive_distance + carries_progressive_distance > 0
        THEN ROUND(pass_progressive_distance * 1.0 / (pass_progressive_distance + carries_progressive_distance), 3)
        END AS prog_pass_share
FROM mv_team_summary
ORDER BY prog_pass_share DESC

-- Use prog_pass_share + completion% to identify possession vs direct teams


------------------------------------------------------------
-- 5. PPM vs xG Diff dataset (for scatterplot in Power BI)
------------------------------------------------------------

SELECT
    squad,
    position,
    points_per_match,
    xg_diff_per90,
    goals_per90,
    xg_per90,
    ga_per90,
    sca_per90,
    gca_per90
FROM mv_team_summary
ORDER BY position
-- Great source for scatter: xg_diff_per90 (X) vs points_per_match (Y)


------------------------------------------------------------
-- 6. Chance Creation Leaders
------------------------------------------------------------

SELECT
    squad,
    sca_per90,
    gca_per90,
    sca_per90 - gca_per90 AS chance_waste_gap   -- Large chance_waste_gap = create lots of shots but fewer turning into goals
FROM mv_team_summary
ORDER BY sca_per90 DESC
