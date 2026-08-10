# 🚴 Cyclistic Bikeshare: Conversion Strategy & Executive Case Study

**Role:** Data Analyst  
**Tools:** BigQuery SQL (Sandbox), Power BI, Spatial Analytics  
**Scope:** Analysis of 5.5M+ trip records (`cleaned_year_tripdata`)  

---

## 🎯 Executive Overview
The objective of this project is to convert high-value **Casual riders** into long-term **Annual Members**. 

Rather than applying broad weekend discounts that dilute tourist profitability, this strategy targets **Local Casuals** to build weekday commute habits using spatial marketing, structured subscription pathways, and operational incentives.

---

## 📊 Core Data Insights

* **Usage Profiles:** Annual Members account for **62%** of total trips (3.55M trips) with short, consistent commutes (11.8 min avg). Casual riders represent **38%** of volume (2.00M trips) with double the ride duration (22.1 min avg) focused on leisure.
* **Timing Separation:** Casual activity peaks heavily on weekends (Saturday/Sunday avg. 25.6 min), whereas Member usage peaks strictly during weekday commuting hours (Tuesday–Thursday).
* **Asset Preference:** Both groups prefer Electric Bikes. However, Casuals take their longest rides on **Classic Bikes (38.98 min avg)** for extended recreational use.
* **Spatial Separation:** Casual hotspots cluster exclusively around tourist locations (*Navy Pier, Millennium Park, DuSable Lake Shore*), while Member hotspots center around business and transit hubs (*Kingsbury & Kinzie, Clinton & Washington*).

---

## 🖥️ Interactive Dashboard & Visualizations
* 📂 **Power BI Interactive File (.pbix):** [Download Full Dashboard via Google Drive](https://drive.google.com/file/d/1i2gdlrlXwOtlJ5fofru4fP8AO5XzCbO_/view?usp=drive_link)
* 🖼️ **Visual Images:** Explore high-resolution dashboards and charts in the [`/dashboards`](./dashboards) directory.

---

## 💡 Strategic Recommendations

### Strategy 1: Stepping-Stone Subscriptions & Retroactive Credit Upgrades
* **Target:** Local Casual Riders.
* **Concept:** Direct conversion to an Annual Membership creates high friction. Introduce a structured progression: **Weekday Pass (Mon–Fri) -> Monthly Pass -> 3-Month Pass**.
* **Retroactive Upgrade:** If a user upgrades from a 3-Month Pass to an Annual Membership, **100% of the 3-Month Pass fee is credited** toward the annual fee.
* **Business Benefit:** Protects full-price weekend tourist revenue while removing financial risk for local commuters.

### Strategy 2: Geofenced Spatial Marketing & Commuter Targeting
* **Target:** Casuals riding near transit corridors and business districts.
* **Execution:** Deploy automated, location-based In-App push notifications during weekday morning hours for Casuals ending trips near commercial hubs (e.g., *"Skip the traffic — try the Weekday Commute Pass"*).
* **Business Benefit:** Converts leisure riders into daily commuters without wasting ad spend on tourists.

### Strategy 3: E-Bike Fleet Optimization & Gamified Logistics
* **Target:** E-Bike Enthusiasts & High-Frequency Casuals.
* **Gamified Rebalancing:** Reward Casual riders with Membership Credits when they pick up an E-Bike from an overcrowded tourist station and dock it at an under-utilized transit/commercial station.
* **Business Benefit:** Enhances membership value while reducing manual fleet rebalancing and operational costs for the business.

---

## 📈 Expected Business Impact & Next Steps
* **Revenue Protection:** Preserves high-margin tourist revenue on peak weekends.
* **Operational Savings:** Cuts manual fleet rebalancing expenses via user-driven gamification incentives.
* **Actionable Step:** Launch a **90-day pilot test** of the Retroactive Credit Upgrade for high-frequency weekday Casual users.
