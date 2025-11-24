![Power BI](https://img.shields.io/badge/Power%20BI-Analytics-F2C811?logo=powerbi&logoColor=black)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-336791?logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-Data%20Cleaning-3776AB?logo=python&logoColor=white)

# ⚽ English Premier League 2025–2026 Data Analysis
### *Season Snapshot as of 11/17/2025*

This is my personal data analysis project where I analyzed the current EPL season (as of **11/17/2025**) to find certain trends and behaviors among the teams and draw actionable conclusions.
Raw event and stats data were scraped from [FBref’s 2025–2026 Premier League season reports](https://fbref.com/en/comps/9/Premier-League-Stats).
<br>

To interact with the visuals:
1. Download `epl_2025_2026_dashboards.pbix` from the repo  
2. Open in Power BI Desktop (free)  
3. Use slicers and filters to explore the data  

---

# 📚 Table of Contents
- [Technical Stack](#-technical-stack)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Full Analysis](#-full-analysis)
- [Team Style](#-team-style)
- [Conclusion](#-conclusion)

<br>

# 🧰 Technical Stack

- **PostgreSQL** — data storage, table creation, SQL queries
- **pgAdmin 4** — database management
- **Python (CSV cleaning)** — data cleaning
- **Power BI** — visual analytics + dashboarding

---

# 📊 POWER BI DASHBOARD

This project includes a full Power BI analytics suite, including:

---

## **Page 1 – Performance Dashboard**

This page identifies which clubs are overachieving or underachieving relative to their underlying numbers.

---

**1. xG Under/Over-Performance scatterplot**

<img src="./assets/Power BI Visuals/01_xg_performance_powerbi.png" alt="xg performance" width="50%">

Shows how each team’s league points per match compare to their underlying xG numbers, revealing which clubs are overperforming (results > xG) or underperforming (results < xG).

<details> <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

This scatterplot compares points per match (vertical axis) against overperformance score (horizontal axis), calculated as the gap between a team’s league position and its underlying xG-based ranking.
- Teams far to the right (Aston Villa, Tottenham, Sunderland) are significantly outperforming what their xG would predict.
- Teams far to the left (Crystal Palace, Brighton, Newcastle United, Nottingham Forest) are underperforming relative to their underlying quality.
- A team high on the y-axis but near 0 on the x-axis (Arsenal, Manchester City) indicates strong results supported by strong underlying numbers.
- Meanwhile, teams low on the y-axis and with negative xG difference (Wolves, Burnley, West Ham) confirm both poor performance and weak underlying metrics.

This visual highlights which teams’ results may regress (positively or negatively) based on their statistical profile.

</details>

<br>

---

**2. PPM vs xG Difference scatterplot**

<img src="./assets/Power BI Visuals/02_ppm_vs_xg_powerbi.png" alt="xg performance" width="50%">

Shows how points per match correlate with xG difference per 90, identifying which teams play well but don’t get results—and which get results without strong underlying play.

<details> <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

This bubble chart plots xG difference per 90 (horizontal) against points per match (vertical) to expose each team’s true underlying strength.
- Top-right quadrant (Arsenal, Chelsea, Man City): strong xG numbers and strong results → elite teams.
- Top-left quadrant (Aston Villa, Tottenham, Sunderland, Bournemouth): poor underlying xG but strong results → likely regression candidates.
- Bottom-right quadrant (Crystal Palace, Newcastle United, Brentford, Brighton): strong underlying xG but poor results → unlucky or wasteful finishing.
- Bottom-left quadrant (Burnley, Wolves, West Ham, Fulham, Nottingham Forest, Leeds United): poor xG and poor results → performances match outcomes.

Bubble size reflects goals per 90, reflecting actual performances compared to xG values.

</details>

<br>

---

**3. Team / Big 6 / Position Group filters**

Global filters that allow visual comparisons and analysis on specific teams.

---

## **Page 2 – Finishing & Defending Dashboard**
This page isolates execution quality, showing:
- Who finishes above/below expectation
- Who concedes more/less than expected

---

**1. Finishing Over xG per 90 bar chart**

<img src="./assets/Power BI Visuals/03_finishing_powerbi.png" alt="xg performance" width="50%">

Ranks teams by goals scored per 90 relative to expected goals per 90, highlighting clinical finishers vs wasteful ones.

<details> <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

This bar chart measures finishing_over_xg_per90, the difference between actual goals scored and expected goals.
- Top performers (Tottenham, Burnley, Aston Villa) finish chances well above expectation, either due to strong shooters or tactical shot selection.
- Bottom teams (Crystal Palace, Wolves, Nottingham Forest) score far fewer goals than expected, often due to poor finishing, low shot quality, or below-par attackers.

This visual isolates execution from chance creation quality, helping identify clinical vs inefficient teams.

</details>

<br>

---

**2. Goals Against vs xGA per 90 bar chart**

<img src="./assets/Power BI Visuals/04_defense_powerbi.png" alt="xg performance" width="50%">

Compares goals conceded per 90 vs expected goals allowed, showing which teams are overperforming or underperforming defensively.

<details> <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

This chart displays ga_vs_xga_per90, the difference between actual goals conceded and expected goals conceded.
- Positive values (Tottenham, Aston Villa, Crystal Palace) indicate teams conceding fewer goals than expected—often due to good goalkeeping or defensive execution.
- Negative values (Wolves, West Ham, Leeds United) signal teams conceding more than expected, usually from poor defensive structure or goalkeeper underperformance.

It visually separates defensive process from defensive execution, helping diagnose which teams rely on shot-stopping vs structured prevention.

</details>

<br>

---

**3. Dual sliders to explore ranges**

Sliders that narrow down the teams that are displayed based on finishing over xG per 90 and/or ga vs xGA per 90

---

**4. Consistent formatting and custom colors**

Consistent formatting and colors across both charts for easy identification and comparisons between teams.

---

## **Page 3 – Team Style Dashboard**
This page breaks down stylistic identity:
- Progression method (passes vs carries)
- Width of attack (crossing / switching)
- Shot-creation profiles

---

**1. Direct vs Possession scatterplot (progressive pass share × pass completion)**

<img src="./assets/Power BI Visuals/05_direct_vs_possession_powerbi.png" alt="xg performance" width="50%">

Shows how teams progress the ball—via progressive passes (direct play) or progressive carries (possession/carrying)—plotted against pass completion.

<details> <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

This visual maps two stylistic dimensions:
- Horizontal axis: progressive pass share → higher values = more direct progression
- Vertical axis: pass completion % → higher values = more safe/controlled possession

Teams sort into clear stylistic clusters:
- Top-left (Man City, Arsenal) → possession-dominant, high accuracy, carry-driven buildup
- Upper-mid (Chelsea, Liverpool, Brighton) → controlled possession but slightly more direct
- Middle (Fulham, Leeds United, Nottingham Forest) → balanced overall between passes and carries → varies based on opponent's style/structure
- Bottom-right (Burnley, Brentford, Crystal Palace) → very direct progression and low pass completion → vertical long-ball tendencies
- Lower-mid (Sunderland, Bournemouth) → turnover-prone, transitional rather than structured possession

This scatterplot is the core tactical identity map for the league.

</details>

<br>

---

**2. Wide vs Narrow bar chart (crosses + switches per 90)**

<img src="./assets/Power BI Visuals/06_wide_vs_narrow_powerbi.png" alt="xg performance" width="50%">

Ranks teams by their use of wide areas, using crosses and long switches as proxies for width.

<details> <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

By combining crosses and switches, this visual estimates how frequently each team attacks down the flanks and moves the ball horizontally.
- Most wide teams (Nottingham Forest, Tottenham, Newcastle) create width through aggressive fullbacks and winger involvement.
- Mid-width teams (West Ham, Chelsea, Leeds, Everton) mix central and wide buildup depending on match context.
- Narrow teams (Man City, Crystal Palace, Brentford, Burnley) emphasize central play, controlled buildup, or vertical long balls.

This visual provides a clear picture of how teams structure their possession around width.

</details>

<br>

---

**3. Chance Creation scatterplot (SCA/90 × GCA/90)**

<img src="./assets/Power BI Visuals/07_chance_creation_powerbi.png" alt="xg performance" width="50%">

Plots shot-creating actions per 90 against goal-creating actions per 90, identifying which teams create chances and which turn chances into actual goals.

<details> <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

This chart highlights:
- Top-right (Chelsea, Man City, Arsenal) → elite creative output AND elite final action quality
- Top-left (Burnley, Tottenham) → few GCA but decent SCA → buildup breaks down late
- Bottom-right (Nottingham Forest, Newcastle United) → good goal-creation but lower shot-creation volume → efficient tactical patterns
- Bottom-left (Wolves, West Ham, Fulham) → low creativity in both metrics

It reveals how teams translate possession into chances, and chances into dangerous actions.

</details>

<br>

---

# 🔍 FULL ANALYSIS


## 1. 📊 xG Over/Under-Performance (Rank Difference)

<img src="./assets/SQL Tables/01_xg_performance.png" alt="xg performance" width="50%">

This table shows each team's current performance in the league relative to their **points per match** and **expected goal (xG) difference**, ordered by the **overperformance_rank_diff (rank_xg_diff - rank_points)** coefficient.

- **Positive** → Team performs better in the table than xG suggests.  
- **Negative** → Team performs worse in the table than xG suggests.

---

### 🔵 Aston Villa

Aston Villa rank far higher in the league than their xG suggests.
They hold an overperformance score of +13, despite a –0.49 xG difference per 90—bottom-three in the league.
Current form (WWWLW) shows momentum-driven success.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Aston Villa top the overperformance rankings, sitting 6th in the league despite an xG difference of -0.49 per 90 mins – the third-worst in the division just behind relegation contenders Wolves (-.058) and Burnley (-1.39). Their overperformance score of +13 indicates that their league position is significantly higher than their underlying numbers suggest. In a competitive league where variance plays a large role, such a large gap raises concerns about sustainability. However, Villa's recent form (WWWLW) shows resilience, suggesting that momentum – not underlying performance – maybe be a driving factor for their results.

</details>

---

### 🔵 Crystal Palace

Crystal Palace post a strong +0.58 xG difference per 90 (top four), yet sit lower in the table, giving them an underperformance score of –6.
They are more unlucky than poor, and are strong candidates for upward regression.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Crystal Palace sit at the bottom of the overperformance table with -6, meaning they rank far lower than their xG metrics predict. Despite being 10th, they post a strong +0.58 xG difference per 90 mins – the fourth highest in the league – placing them statistically alongside league leaders Arsenal (1.16), Manchester City (0.82), and Chelsea (0.63). This suggests Palace have been unlucky rather than poor, especially with only one win in their last five matches (LDLWD). If their finishing and match management improve, their league position should converge upward toward their underlying performance.

</details>

---

## 2. 🎯 Finishing Efficiency (Clinical vs Wasteful)

<img src="./assets/SQL Tables/02_finishing.png" alt="finishing" width="50%">

This table shows each team's finishing stats, ordered by **finishing_over_xg_per90 (goals_per90 - xg_per90)**.

---

### 🔵 Tottenham (Clinical)

Tottenham finish 0.64 goals above expectation per 90, best in the league. They also lead in goals per shot and goals per shot on target.
Their elite finishing compensates for weaker chance creation.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Tottenham lead the finishing efficiency rankings, scoring 0.64 more goals per 90 than expected, with a league-best +7.0 goals-minus-xG total. They also rank first in both goals per shot and goals per shot on target, highlighting exceptional shot quality conversion. Despite a negative xG difference (–0.38 per 90), Tottenham sit 5th in the league, suggesting that elite finishing is compensating for defensive weaknesses. Their form (WLWLD) reflects this volatility: when their finishing cools, their underlying issues become exposed.

</details>

---

### 🔵 Crystal Palace (Wasteful)

Palace finish 0.55 goals below expectation per 90, bottom of the league.
Combined with their excellent xG difference, this makes them the league’s biggest “sleeping giant” statistically.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Crystal Palace sit at the bottom of another table with 0.55 fewer goals than expected per 90 and a –6.0 goals-minus-xG total, indiciating consistently poor finishing efficiency. This finishing underperformance is strongly reflected in their negative overperformance score in the performance table. Interestingly, while their finishing is weak, Palace's underlying defensive metrics (including a top-four xG difference per 90) suggest that they are structurally solid without the ball. If they can improve their ability to convert chances while maintaining their defensive level, they have significant upside and are strong candidates for positive regression in the coming matches.

</details>

---

## 3. 🛡️ Defensive Solidity (Goals vs xG Allowed)

<img src="./assets/SQL Tables/03_defense.png" alt="defense" width="50%">

This table shows each team's defensive stats, ordered by **ga_vs_xga_per90 (xga_per90 - ga_per90)**.

---

### 🔵 Tottenham

Spurs concede 0.47 fewer goals per 90 than expected.
Their defensive output is driven by high-level goalkeeping and efficient chance prevention in-box.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Tottenham top the defensive overperformance metric, conceding 0.473 fewer goals per 90 than expected. While this seems contradictory given their negative xG difference, the explanation is simple: Spurs concede higher-quality chances than they create, but they outperform both ends of the pitch through elite execution. They finish their chances far better than expected and concede far fewer goals than expected, indicating strong shot-stopping and clinical attacking. In short, Tottenham’s results are driven more by finishing efficiency and goalkeeping overperformance than by their underlying chance-quality process.

</details>

---

### 🔵 Wolves

Wolves concede 0.82 more goals per 90 than expected, worst in the league.
They show structural and execution weaknesses at the back.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Wolves rank last with 0.82 more goals conceded per 90 than expected, reflecting both poor defensive execution and subpar goalkeeping. Combined with bottom-tier finishing, this explains their last-place standing and lack of a league win. Their metrics suggest systemic issues on both ends of the pitch, and a significant tactical overhaul may be required to reverse their trajectory.

</details>

---

## 4. 🧭 Team Style

<img src="./assets/SQL Tables/04_passing.png" alt="passing" width="50%">

This table shows each team's passing stats, ordered by **prog_pass_share (pass_progressive_distance / (pass_progressive_distance + carries_progressive_distance))**.

---

### 🔺 Direct / Vertical Teams  
- Brentford (0.772)  
- Burnley (0.771)  
- Crystal Palace (0.761)  

These teams most rely on fast, forward-driven progression, using vertical passing rather than long possession sequences to move up the pitch. Their low pass completion and low possession reflect a direct style designed to break lines quickly and counter from deeper positions.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Brentford, Burnley, and Crystal Palace share the top of the table, with all three combining in low pass completion and low possession, but generating a high share of forward movement through progressive passing. This indicates a vertical, direct style built around moving the ball forward quickly rather than sustaining long passing sequences. These teams frequently defend deep and transition forward rapidly, a common approach for sides outside the top tier.

</details>

---

### 🔻 Possession / Carry-Driven Teams  
- Manchester City (0.666)  
- Arsenal (0.695)  
- Brighton (0.698)  

These teams are the top in progressing through controlled buildup, using progressive carries and short passing combinations to advance through pressure. Their lower progressive pass share reflects a stylistic emphasis on dribbling, close control, and sustained possession in advanced areas.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Manchester City, Arsenal, and Brighton fill the bottom of the table as the only teams below a 0.70 share. This shows a greater reliance on progressive carries—advancing the ball through dribbling, player movement, and short interconnected passes. These teams are built for sustained possession and fluid buildup play, trusting their players to navigate pressure with close control.

Notably, Brighton’s numbers stand out: despite mid-table possession, they record one of the highest progressive carry distances in the league, explaining their lower progressive pass share.

</details>

---

## 📌 Trend Observation

**8 of the 10 teams with the lowest progressive passing reliance earn above-average points per match.** While correlation does not imply causation, this suggests that teams who progress through carries - and therefore maintain more control between lines - may be rewarded with stronger overall performances.

---

## 🌐 Wide vs Narrow Play (Crosses & Switches)

### **Wide / Cross-heavy Teams**
- Nottingham Forest
- Tottenham
- Newcastle
- Wolves
- Liverpool
- Arsenal

High reliance on:
- Wing progression
- Frequent crosses
- Wide overloads
- Attacking through flanks

These teams stretch the pitch horizontally and deliver high volumes of balls into the penalty area.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

These teams rely heavily on traditional wing play, delivering a large number of crosses into the box. High cross volume usually indicates:
- Attacks driven through the flanks
- Wingers/fullbacks positioned aggressively
- A focus on creating chances through aerial or cutback deliveries
- Stretching the opposition horizontally

Nottingham Forest, Tottenham, Newcastle, Wolves, Liverpool, and Arsenal consistently target wide areas to open space and deliver balls into dangerous zones. Their tactical profiles show wide overloads, frequent wing rotations, and reliance on wide ball progression.

</details>

### **Switch-heavy Teams**
- Fulham
- Manchester United
- Brighton
- Burnley

Characteristics:
- Frequent horizontal shifts
- Diagonal balls to opposite flank
- Weak-side wing isolation
- Less reliance on pure crossing

These sides use switches to manipulate defensive structure rather than relying purely on wing-crossing.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

Switch-heavy teams frequently play long diagonal passes from one flank to the other. This indicates:
- Intentional width manipulation
- Moving defenders side-to-side to disrupt compact blocks
- Preference for rapid, direct changes in attacking direction
- Wide players positioned high and opposite the ball

Fulham, Manchester United, Brighton, and Burnley use switches to stretch opponents without relying exclusively on crosses. These teams emphasize exploiting weak-side overloads, creating 1v1 isolation for wingers, and opening channels through horizontal ball movement.

</details>

### Moderate Width Teams
- Aston Villa
- Bournemouth
- West Ham
- Chelsea
- Everton
- Leeds United

Characteristics:
- Balanced use of wide areas  
- Width applied situationally  
- Neither strong cross-heavy nor switch-heavy tendencies  
- Flexible attacking structure that adapts to match context 

These teams operate near the league average in wide actions, using width *situationally* rather than as a primary attacking route. Their approach reflects a balanced mix of central buildup and wide progression, adjusting width based on match context rather than emphasizing it consistently.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

These teams sit around the league average in total wide actions. They use the wings situationally rather than as a dominant attacking route. This usually suggests:
- Balanced structure between central progression and wide play
- Flexibility based on opponent or game state
- Occasional overloads in wide channels but not a constant emphasis

Aston Villa, Bournemouth, West Ham, Chelsea, Everton, and Leeds United demonstrate adaptable width patterns that shift depending on match context and buildup structure.

</details>

### **Narrow / Central Teams**
- Manchester City
- Crystal Palace
- Brentford
- Sunderland

These teams progress through:
- Vertical combinations
- Midfield interplay
- Controlled central buildup
- Reduced wide activity

Low crosses + low switches → compact buildup, central progression.

<details>
  <summary><strong>DETAILED ANALYSIS (click to expand)</strong></summary>

These teams generate fewer crosses and fewer switches, signaling a more compact, central attacking structure. This typically suggests:
- Play concentrated through midfield zones
- Vertical passing combinations rather than wide progression
- Less emphasis on touchline width
- Lower fullback involvement in final-third actions

Manchester City, Crystal Palace, Brentford, and Sunderland often build through the middle or rely on direct progression rather than wide patterns. Their structure reflects intentional central play or a stylistic preference for compact buildup, combination rotations, or controlled possession in central corridors.

</details>

---

# 🏁 Conclusion

This project demonstrates how **SQL, data modeling, and Power BI visualization** can uncover meaningful insights into football team performance. Using xG models, efficiency metrics, and stylistic indicators, the analysis reveals:

- Which teams overperform/underperform their underlying numbers
- Which teams are clinical vs wasteful
- Which defenses are exceeding expectations
- How stylistic differences (direct vs possession-based) relate to results