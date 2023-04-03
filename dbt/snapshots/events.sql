{% snapshot event_snapshot %}

{{ config(target_database='fitbod', 
	  	  target_schema='snapshot',
          unique_key='user_id || feature_key',
          strategy='timestamp',
          updated_at='updated_at',
          invalidate_hard_deletes=True
 )
}} 

SELECT user_id,
       feature_key,
       feature_value,
       CAST(to_timestamp(timestamp / 1000) as timestamp) as updated_at
FROM {{ source('fitbod', 'latest_events') }}

{% endsnapshot %}