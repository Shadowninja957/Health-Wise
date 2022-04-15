<?php

    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Headers: Origin, Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

    include_once '../config/database.php';    
    include_once '../objects/medicalConditions.php';

    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        // The request is using the POST method
        header("HTTP/1.1 200 OK");
        return;
    
    }

    $database = new Database();
    $conn = $database->getConnection();
    

    $medicalConditions = new MedicalCondition($conn);
    $data = json_decode(file_get_contents("php://input"));

    $medicalConditions->search_phrase = $data->search_phrase;


    $stmt = $medicalConditions->read();
    $num = $stmt->rowCount();
    $records = array();
    $data = array();


    if($num > 0){
       
        while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            
            extract($row);

            $treatments = array();
            $stmtTreatment = $medicalConditions->treatments($id);
            while($rowTreament = $stmtTreatment->fetch(PDO::FETCH_ASSOC)){
                $treatments[] = $rowTreament;
            }

            $records[] = array(
                "id" => $id,
                "diagnosis" => $diagnosis,                
                "symptoms" => $symptoms,
                "description" => $description,
                "treatments" => $treatments,
                "created_at" => $created_at,
                "updated_at" => $updated_at,
            );


        }       
    }
    
    http_response_code(200);

    echo json_encode($records);    
    

?>