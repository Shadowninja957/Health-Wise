<?php
    class Feedback{
        
        private $conn;
        private $table_name = "patient_feedbacks";
        
        public $patient_id;
        
        public function __construct($conn){
            $this->conn = $conn;
            
        }

        function read(){            

            $query = "select * FROM ".$this->table_name." WHERE patient_id = ".$this->patient_id; 
            
            $stmt = $this->conn->prepare($query);

            $stmt->execute();

            return $stmt;
        }
        
        function create(){

            $query = "insert into 
                        ".$this->table_name."
                        SET patient_id =:patient_id , name =:name, 
                        email=:email, contact=:contact,
                        doctor=:doctor, subject=:subject, description=:description";
            
            $stmt = $this->conn->prepare($query);
            
            // $this->first_name=htmlspecialchars(strip_tags($this->first_name));

            $stmt->bindParam(":patient_id", $this->patient_id);
            $stmt->bindParam(":name", $this->name);
            $stmt->bindParam(":email", $this->email);
            $stmt->bindParam(":contact", $this->contact);
            $stmt->bindParam(":doctor", $this->doctor);
            $stmt->bindParam(":subject", $this->subject);
            $stmt->bindParam(":description", $this->description);

            if($stmt->execute()){
                return true;
            }

            return false;
            //return $stmt->errorInfo();
        }
    }
?>