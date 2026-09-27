you should keep your Snowflake connection details in profiles.yml. That's the recommended dbt approach.

What goes in profiles.yml?

profiles.yml contains environment-specific connection details:

YAML
DBT_First_Model:
target: dev
 
outputs:
dev:
type: snowflake
account: xxxx
user: xxxx
password: xxxx
role: ACCOUNTADMIN
warehouse: COMPUTE_WH
database: DBT_PRACTICE
schema: DBT_RB
Show more lines

This tells dbt:

Which Snowflake account to connect to
Username/password
Warehouse
Default database/schema
What goes in dbt_project.yml?

dbt_project.yml contains project-level configurations, such as where models should be built.

Example:

YAML
models:
DBT_First_Model:
 
staging:
+schema: STG
 
marts:
+schema: MART
Show more lines
How dbt combines them

Suppose profiles.yml contains:

YAML
database: DBT_PRACTICE
schema: DBT_RB
Show more lines

And dbt_project.yml contains:

YAML
models:
DBT_First_Model:
 
staging:
+schema: STG
 
marts:
+schema: FINAL
Show more lines

Then:

Plain Text
models/staging/stg_transactions.sql
Show more lines

will be created in:

Plain Text
DBT_PRACTICE.STG.STG_TRANSACTIONS
Show more lines

and

Plain Text
models/marts/fct_transactions.sql
 
Show more lines

will be created in:

Plain Text
DBT_PRACTICE.FINAL.FCT_TRANSACTIONS
Show more lines

The database comes from profiles.yml, while the model folder-specific schema comes from dbt_project.yml.

If Stage and Final are in Different Databases

Example:

Plain Text
Stage -> DBT_PRACTICE.STG
Final -> ANALYTICS_DB.MART
Show more lines

Then configure:

YAML
models:
DBT_First_Model:
 
staging:
+database: DBT_PRACTICE
+schema: STG
 
marts:
+database: ANALYTICS_DB
+schema: MART
Show more lines
Recommended for Your Case

Since you mentioned:

Plain Text
Source : RETAILS.PUBLIC
Stage : DBT_PRACTICE.STG
Final : DBT_PRACTICE.DBT_RB
Show more lines

Keep profiles.yml as:

YAML
database: DBT_PRACTICE
schema: DBT_RB
Show more lines

Then add to dbt_project.yml:

YAML
models:
DBT_First_Model:
 
staging:
+schema: STG
 
marts:
+schema: DBT_RB
Show more lines

Folder structure:

Plain Text
models/
├── staging/
│ └── stg_transactions.sql
└── marts/
└── fct_transactions.sql
Show more lines

This is the standard enterprise pattern:

profiles.yml = connection & default target settings
sources.yml = source databases/schemas/tables
dbt_project.yml = model deployment rules (database/schema/materialization)
.sql models = transformation logic only

This keeps your model SQL clean and makes environment promotion (DEV → QA → PROD) much easier.