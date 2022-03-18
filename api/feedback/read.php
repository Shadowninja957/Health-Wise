<?php

    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Headers: Origin, Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

    include_once '../config/database.php';    
    include_once '../objects/feedback.php';

    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        // The request is using the POST method
        header("HTTP/1.1 200 OK");
        return;
    
    }

    $database = new Database();
    $conn = $database->getConnection();
    

    $feedback = new Feedback($conn);
    $data = json_decode(file_get_contents("php://input"));
    $feedback->patient_id = $data->patient_id;
    
    $stmt = $feedback->read();
    $num = $stmt->rowCount();


    if($num > 0){

        $records = array();

        while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            
            extract($row);

            $records[] = array(
                "id" => $id,
                "name" => $name,                
                "email" => $email,
                "contact" => $contact,
                "doctor" => $doctor,
                "subject" => $subject,
                "description" => $description,
            );

        }

        http_response_code(200);

        echo json_encode($records);
    }
    else{
        
        http_response_code(404);

        echo json_encode(
            array("message" => "No feedback found.")
        );
    }

    
    

?>