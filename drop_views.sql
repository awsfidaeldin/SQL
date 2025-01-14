BEGIN
   FOR v IN (SELECT owner, view_name FROM all_views WHERE owner = 'YOUR_SCHEMA') LOOP
      EXECUTE IMMEDIATE 'DROP VIEW ' || v.owner || '.' || v.view_name;
   END LOOP;
END;
/
