<?php
    class Doctor{
        
        private $conn;
        private $table_name = "doctors";
        
        public $user_name;
        public $password;
        public $role_id;
        
        public function __construct($conn){
            $this->conn = $conn;
            
        }

        function read(){            

            // $query = "select * from ".$this->table_name;
            $query = "select ".$this->table_name.".*, specialities.detail FROM specialities, ".
            $this->table_name." WHERE ".$this->table_name.".speciality_id = specialities.id";
            
            $stmt = $this->conn->prepare($query);

            $stmt->execute();

            return $stmt;
        }
        
        function create(){

            $query = "insert into 
                        ".$this->table_name."
                        SET first_name =:first_name , last_name =:last_name, 
                        date_of_birth=:date_of_birth, gender=:gender,
                        work_address=:work_address, email_address=:email_address,
                        work_number=:work_number, work_days=:work_days, work_hours=:work_hours,
                        created_at=CURRENT_TIMESTAMP, update_at=CURRENT_TIMESTAMP ";
            
            $stmt = $this->conn->prepare($query);
            
            $this->first_name=htmlspecialchars(strip_tags($this->first_name));

            $stmt->bindParam(":user_name", $this->user_name);
            $stmt->bindParam(":password", $this->password);
            $stmt->bindParam(":role_id", $this->role_id);

            if($stmt->execute()){
                return true;
            }

            return false;
            //return $stmt->errorInfo();
        }
    }
?>