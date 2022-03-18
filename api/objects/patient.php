<?php
    class Patient{
        
        private $conn;
        private $table_name = "patients";
        
        public $user_id;
        public $first_name;
        public $last_name;
        public $contact_number;
        public $address;
        
        public function __construct($conn){
            $this->conn = $conn;
            
        }

        function read(){            

            $query = "select * FROM ".$this->table_name." WHERE user_id = ".$this->user_id;
            
            $stmt = $this->conn->prepare($query);

            $stmt->execute();

            return $stmt;
        }
        
        function create(){
           //create patient record
            $query = "insert into 
            ".$this->table_name."
            SET user_id =:user_id , first_name =:first_name, 
            last_name=:last_name, contact_number=:contact_number,
            address=:address";

            $stmt = $this->conn->prepare($query);

            // $this->first_name=htmlspecialchars(strip_tags($this->first_name));

            $stmt->bindParam(":user_id", $this->user_id);
            $stmt->bindParam(":first_name", $this->first_name);
            $stmt->bindParam(":last_name", $this->last_name);
            $stmt->bindParam(":contact_number", $this->contact_number);
            $stmt->bindParam(":address", $this->address);

            if($stmt->execute()){
            return true;
            }

            return false;
        }
    }
?>