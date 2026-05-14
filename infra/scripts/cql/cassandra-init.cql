-- Create a Keyspace for the Project
CREATE KEYSPACE IF NOT EXISTS meridian 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE meridian;

-- Create the Telemetry Table
-- Using BLOB for the raw binary 'payload' to preserve the 'Golden Record'
CREATE TABLE IF NOT EXISTS telemetry (
    device_id text,
    event_time timestamp,
    payload blob,
    ingestion_time timestamp,
    metadata map<text, text>,
    PRIMARY KEY (device_id, event_time)
) WITH CLUSTERING ORDER BY (event_time DESC)
  AND compaction = {'class': 'TimeWindowCompactionStrategy', 'compaction_window_unit': 'DAYS', 'compaction_window_size': 1};