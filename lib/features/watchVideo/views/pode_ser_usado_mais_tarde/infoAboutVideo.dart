import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoAboutVideo extends StatelessWidget {
  const InfoAboutVideo ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: (_screenWidth*964/1440)-10,
        minWidth: (_screenWidth*964/1440)-10,
        maxHeight: 400,
        minHeight: 100
      ),

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(12)),
        ),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Text(
              '29 views 1 ano atrás',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
              ConstrainedBox(
                constraints:  BoxConstraints(
                  maxWidth: (_screenWidth*964/1440)-10,
                  maxHeight: 400.0,
                    minHeight: 100

                ),
                child: Text(
                  '''⏩ Escolha seu serviço de música preferido: https://onerpm.link/pipoco
Contato para Shows:  (43) 99124-4117 Direção Geral: Agroplay Produção Musical: Chris no Beat (Máquina de Hit) Direção de Video: Fábio Rojas Direção de Fotografia: Chris no Beat (Máquina de Hit)Produtora de Vídeo: Inraw FilmesMarketing: Everton Albertoni (IG @oalbertoni)Assistente de Produção: Rodolfo Rodrigues RudLighting: Gustavo Sete (GL Eventos)Makeup: Ateliê Ana Giorgino Contato para Shows:  (43) 99124-4117 Direção Geral: Agroplay Produção Musical: Chris no Beat (Máquina de Hit) Direção de Video: Fábio Rojas Direção de Fotografia: Chris no Beat (Máquina de Hit)Produtora de Vídeo: Inraw FilmesMarketing: Everton Albertoni (IG @oalbertoni)Assistente de Produção: Rodolfo Rodrigues RudLighting: Gustavo Sete (GL Eventos)Makeup: Ateliê Ana Giorgino Contato para Shows:  (43) 99124-4117 Direção Geral: Agroplay Produção Musical: Chris no Beat (Máquina de Hit) Direção de Video: Fábio Rojas Direção de Fotografia: Chris no Beat (Máquina de Hit)Produtora de Vídeo: Inraw FilmesMarketing: Everton Albertoni (IG @oalbertoni)Assistente de Produção: Rodolfo Rodrigues RudLighting: Gustavo Sete (GL Eventos)Makeup: Ateliê Ana Giorgino Contato para Shows:  (43) 99124-4117 Direção Geral: Agroplay Produção Musical: Chris no Beat (Máquina de Hit) Direção de Video: Fábio Rojas Direção de Fotografia: Chris no Beat 
''',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],),
        ),
      ),
    );
  }
}



