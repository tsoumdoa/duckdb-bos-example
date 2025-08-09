# 🦆 DuckDB + BIM Open Schema SQL Snippets

A collection of **ready-to-use SQL queries** for exploring and analyzing **BIM Open Schema** data stored in **Parquet** files using [DuckDB](https://duckdb.org/).

## 📌 What is BIM Open Schema?

[BIM Open Schema](https://github.com/ara3d/bim-open-schema) is an **open, platform-independent specification** for representing Building Information Modeling (BIM) data in a format optimized for analytics.  
It’s designed for **columnar storage** (like Parquet) and works seamlessly with tools like DuckDB, Power BI, and Pandas.

Typical workflow:

```
Revit / IFC → Parquet (BIM Open Schema) → DuckDB / BI / ML
```

## 📂 What’s in this repo?

- **Boilerplate SQL queries** for:
  - Inspecting BIM entities and relationships
  - Extracting property values
  - Joining descriptors with entities
  - Filtering by categories, types, or parameters
- **Example DuckDB commands** for loading Parquet files
- **Schema reference links** for quick lookup


## 📋 Prerequisites

Before you can run the example queries in this repo, you’ll need:

1. **BIM Open Schema Revit Plugin**  
   - Required to export your BIM model into the **BIM Open Schema Parquet format**.  
   - Download from: [BIM Open Schema Revit Plugin Releases](https://github.com/ara3d/bim-open-schema/releases)  
   - After installation, use the **"Export BIM Open Schema"** command in Revit to generate a `parquet.zip` file.

2. **DuckDB CLI with Web UI support**  
   - Required to run the SQL queries and use the browser-based DuckDB interface.  
   - Install by following the official guide:  
     [DuckDB Installation Guide](https://duckdb.org/docs/installation/?version=stable&environment=cli&platform=macos&download_method=direct)  
   - Once installed, you can start the Web UI with:
     ```bash
     duckdb -ui
     ```

## 🚀 Quick Start

This repo is designed to be **copied or cloned** as a starting point for working with BIM Open Schema data in DuckDB.  
You can follow the recommended folder structure below, or adapt it to your own workflow.

### 📂 Recommended Folder Structure

```
your-project/
│
├── data/        # Place your BIM Open Schema Parquet files here
│   └── (unzipped from parquet.zip exported by Revit plugin)
│
├── sql/         # SQL scripts for loading and querying data
│   ├── init.sql # Boilerplate to load Parquet + create useful views
│   └── *.sql    # Additional queries you can edit or add
│
└── README.md
```

---

### 1️⃣ Get BIM Open Schema Data

Export your BIM model from Revit using the **BIM Open Schema Revit Plugin**.  
This will give you a `parquet.zip` file containing multiple `.parquet` files (one per table in the schema).

Unzip it into the `data/` folder:

---

### 2️⃣ Start DuckDB with Web UI

Navigate to the folder containing your **Parquet files** in the terminal.  
For example, if you unzipped the **Snowdon Towers Sample**:

```bash
cd <where_your_parquet_files_are>/"Snowdon Towers Sample Architectural.parquet"
```

Then start DuckDB with the Web UI:

```bash
duckdb -ui
```

This will open a browser-based SQL editor connected to DuckDB.

---

### 3️⃣ Load the Schema and Create Views

From the DuckDB Web UI (or CLI), run the `init.sql` script to load all Parquet files and create denormalized views:

```sql
.read ../../sql/init.sql
```

The `init.sql` script will:
- Load all BIM Open Schema `.parquet` files into DuckDB tables
- Create **denormalized views** for easier querying (e.g., joining entities with descriptors and parameters)

---

### 4️⃣ Start Querying

Once the views are created, you can run queries like:

```sql
-- List all walls
 SELECT 
e1.category,
	e1.index,
	e1.name,
	e1.project_name,
	e1.path_name,
  ep1, dsp
FROM
	denorm_entities AS e1
	RIGHT OUTER JOIN denorm_points_params AS ep1 ON ep1.Entity = e1.index
  LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep1.Descriptor
WHERE
e1.category LIKE '%Walls'
ORDER BY
	e1.index;
```

Or run any of the example queries in the `sql/` folder.


## 🧑‍🤝‍🧑 Who is this for?

- **Data scientists** exploring BIM datasets
- **BI analysts** building dashboards from BIM data
- **Developers** integrating BIM analytics into apps

## 📖 Learn More

- [BIM Open Schema Official Spec](https://github.com/BIMOpenSchema)
- [DuckDB Documentation](https://duckdb.org/docs/)
- [Apache Parquet](https://parquet.apache.org/)

---

💡 **Tip:** These queries are meant to be **copied, pasted, and adapted** — treat this repo as your BIM + DuckDB cheat sheet.
