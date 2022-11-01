from database.postgres import create_pg_engine 


class TestPostgresConnection:

    """ Test the connection the Postgres RDS """ 
    
    db_target = 'source'
    engine = create_pg_engine(db_target)

    assert engine is not None
