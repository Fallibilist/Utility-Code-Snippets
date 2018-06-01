-- Search columns in a SINGLE table for whitespace
DECLARE 
  dynamic_cursor VARCHAR2(1000);
  dynamic_table_name VARCHAR2(30) := 'MY_TABLE_NAME'; 
BEGIN
  FOR col_name IN (
    SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = dynamic_table_name AND DATA_TYPE = 'VARCHAR2'
  )
  LOOP
    dbms_output.put_line('Column ' || col_name.COLUMN_NAME || ' Results: ');
    dynamic_cursor := 'DECLARE ' ||
                        'CURSOR my_cursor IS SELECT ' || col_name.COLUMN_NAME || ' AS CURRENT_COL_NAME FROM ' || dynamic_table_name || '; ' ||
                        'my_row_type my_cursor%ROWTYPE; ' ||
                        'counter integer := 0; ' ||
                      'BEGIN ' ||
                        'OPEN my_cursor; ' ||
                        'LOOP ' ||
                        '  FETCH my_cursor INTO my_row_type; ' ||
                        '   IF (my_row_type.CURRENT_COL_NAME <> TRIM(my_row_type.CURRENT_COL_NAME)) THEN ' ||
                        '     counter := counter + 1; ' ||
                        '     dbms_output.put_line(counter || '': "'' || my_row_type.CURRENT_COL_NAME || ''"''); ' ||
                        '   END IF; ' ||
                        '  EXIT WHEN my_cursor%NOTFOUND; ' ||
                        'END LOOP; ' ||
                      'END;';
    EXECUTE IMMEDIATE dynamic_cursor;
  END LOOP;
END;

-- Search columns in ALL tables for whitespace
DECLARE
  dynamic_cursor VARCHAR2(1000);
BEGIN
  FOR tab_name IN (
    SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'MY_TABLESPACE_NAME'
  )
  LOOP
    DECLARE 
      dynamic_table_name VARCHAR2(30) := tab_name.TABLE_NAME; 
    BEGIN
      dbms_output.put_line('Table: ' || dynamic_table_name);
      dbms_output.put_line('----------------------------------');
      FOR col_name IN (
        SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = dynamic_table_name AND DATA_TYPE = 'VARCHAR2'
      )
      LOOP
        dbms_output.put_line('Column ' || col_name.COLUMN_NAME || ' Results: ');
        dynamic_cursor := 'DECLARE ' ||
                            'CURSOR my_cursor IS SELECT ' || col_name.COLUMN_NAME || ' AS CURRENT_COL_NAME FROM ' || dynamic_table_name || '; ' ||
                            'my_row_type my_cursor%ROWTYPE; ' ||
                            'counter integer := 0; ' ||
                          'BEGIN ' ||
                            'OPEN my_cursor; ' ||
                            'LOOP ' ||
                            '  FETCH my_cursor INTO my_row_type; ' ||
                            '   IF (my_row_type.CURRENT_COL_NAME <> TRIM(my_row_type.CURRENT_COL_NAME)) THEN ' ||
                            '     counter := counter + 1; ' ||
                            '     dbms_output.put_line(counter || '': "'' || my_row_type.CURRENT_COL_NAME || ''"''); ' ||
                            '   END IF; ' ||
                            '  EXIT WHEN my_cursor%NOTFOUND; ' ||
                            'END LOOP; ' ||
                          'END;';
        EXECUTE IMMEDIATE dynamic_cursor;
      END LOOP;
      dbms_output.put_line('----------------------------------');
    END;
  END LOOP;
END;

-- Search columns in ALL tables for whitespace
-- Output count instead of instances
DECLARE
  dynamic_cursor VARCHAR2(1000);
BEGIN
  FOR tab_name IN (
    SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'MY_TABLESPACE_NAME'
  )
  LOOP
    DECLARE 
      dynamic_table_name VARCHAR2(30) := tab_name.TABLE_NAME; 
    BEGIN
      dbms_output.put_line('Table: ' || dynamic_table_name);
      dbms_output.put_line('----------------------------------');
      FOR col_name IN (
        SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = dynamic_table_name AND DATA_TYPE = 'VARCHAR2'
      )
      LOOP
        dbms_output.put_line('Column ' || col_name.COLUMN_NAME || ' Results: ');
        dynamic_cursor := 'DECLARE ' ||
                            'CURSOR my_cursor IS SELECT ' || col_name.COLUMN_NAME || ' AS CURRENT_COL_NAME FROM ' || dynamic_table_name || '; ' ||
                            'my_row_type my_cursor%ROWTYPE; ' ||
                            'counter integer := 0; ' ||
                          'BEGIN ' ||
                            'OPEN my_cursor; ' ||
                            'LOOP ' ||
                            '  FETCH my_cursor INTO my_row_type; ' ||
                            '   IF (my_row_type.CURRENT_COL_NAME <> TRIM(my_row_type.CURRENT_COL_NAME)) THEN ' ||
                            '     counter := counter + 1; ' ||
                            '   END IF; ' ||
                            '  EXIT WHEN my_cursor%NOTFOUND; ' ||
                            'END LOOP; ' ||
                            'dbms_output.put_line(''Num of Instances: '' ||counter); ' ||
                          'END;';
        EXECUTE IMMEDIATE dynamic_cursor;
      END LOOP;
      dbms_output.put_line('----------------------------------');
    END;
  END LOOP;
END;

-- To fix specific whitespace issues in known columns
BEGIN

  UPDATE MY_TABLE_NAME SET MY_COLUMN_NAME = TRIM(MY_COLUMN_NAME);
  ...

END;

