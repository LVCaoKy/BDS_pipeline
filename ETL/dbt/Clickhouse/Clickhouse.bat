@echo off
PowerShell -Command "$env:DBT_PROFILES_DIR = "E:\DE_JOB\Presonal_Project\Pineline_ETL\ETL\dbt\Clickhouse\.dbt" ; dbt debug"
pause
