resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "aurora-cluster-example"
  engine             = "aurora-mysql"  
  engine_version     = "5.7.mysql_aurora.2.11.5" 
  master_username    = "admin"
  master_password    = "password"
  backup_retention_period = 5
  preferred_backup_window  = "07:00-09:00"
  skip_final_snapshot      = true
  db_subnet_group_name     = aws_db_subnet_group.aurora-db-gp.id
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = 3
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t3.small"
  engine             = "aurora-mysql"
}
