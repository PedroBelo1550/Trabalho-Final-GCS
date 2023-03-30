window.onload = function(){

    var url_atual = window.location.search;

    if(url_atual == "?pacientesucess=true"){
        alert('Paciente cadastrado com sucesso')
    }else if(url_atual == "?medicosucess=true"){
        alert('Médico cadastrado com sucesso')
    }
    else if(url_atual == "?consultasucess=true"){
            alert('Consulta cadastrado com sucesso')
        }
        else if(url_atual == "?consultasucess=false"){
                    alert('Consulta cancelada com sucesso')
                }
                 else if(url_atual == "?nenhummedico=true"){
                                    alert('É necessário ter no mínimo um médico cadastrado')
                                }
                                else if(url_atual == "?nenhummedicoepaciente=true"){
                                                                    alert('É necessário ter no mínimo um paciente e um médico cadastrado')
                                                                }
                                                                else if(url_atual == "?nenhumpaciente=true"){
                                                                                                                                    alert('É necessário ter no mínimo um paciente cadastrado')
                                                                                                                                }


}