import 'package:nextar/database/database.dart';
import 'package:nextar/model/model_usuario.dart';
import 'package:get/get.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerCadastroUsuarios extends GetxController {
  void onInit() {
    super.onInit();
  }

  // Variável para chamar a instância do banco de dados
  // para então, consequentemente, obter acesso aos comandos de SGBD
  final DatabaseHelper _database = DatabaseHelper.instance;

  // O método é responsável por cadastrar usuários corretamente no banco de dados.
  void cadastrarUsuario(String nomeUsuario, String cpf, String senha,
      String confirmarSenha) async {
    // Obtém o nome de usuário do banco de dados com base nos parâmetros do método
    List<Map<String, dynamic>> _verificarUsuario =
        await _database.selectUsuarios(
            columns: ['usuario'],
            where: 'usuario = ?',
            whereArgs: [nomeUsuario]);

    // Obtém o cpf do banco de dados com base nos parâmetros do método
    List<Map<String, dynamic>> _verificarCpf = await _database.selectUsuarios(
        columns: ['cpf'], where: 'cpf = ?', whereArgs: [cpf]);

    // Se alguma das duas consultas realizadas retornarem algo, indica que
    // o usuário já existe no banco de dados
    if (_verificarUsuario.length > 0 || _verificarCpf.length > 0) {
      Get.snackbar('Divergência',
          'Usuario já existente. Caso tenha esquecido de sua senha, recupere-a no link "Esqueceu sua senha?"');
    }

    // Verifica se o nome de usuário fora preenchido corretamente
    else if (nomeUsuario.trim().isEmpty || nomeUsuario.length < 2) {
      Get.snackbar('Divergência',
          'O nome de usuário não pode estar vazio e precisa ser maior que dois caracteres. Por favor, revise seus dados.');
    }

    // Se o anterior fora preenchido corretamente, verifica se o cpf digitado é válido
    else if (cpf.trim().isEmpty || cpf.length < 14) {
      Get.snackbar(
          'Divergência', 'CPF inválido. Por favor, revise seus dados.');
     
    }
    // Se o campo anterior fora preenchido corretamente, verifica se a senha digitada é válida
    else if (senha.trim().isEmpty || senha.length < 6) {
      Get.snackbar('Divergência',
          'A senha não pode estar vazia e precisa ser maior que seis caracteres. Por favor, revise seus dados.');
      
    }
    // Se o campo anterior fora preenchido corretamente, realiza uma comparação dos campos
    // "Senha" e "Confirmar senha" se ambos são válidos
    else if (senha != confirmarSenha) {
      Get.snackbar('Divergência',
          'As senhas não conferem. Por favor, revise seus dados.');
     
    }
    // Se todos os campos anteriores foram preenchidos corretamente
    // então é realizada uma busca no banco de dados para verificar a existêcnia do usuário
    // o mesmo é feito para o CPF
    else {
      // Se as validações anteriores forem falsas, então o processo de criação de usuário é iniciado
      final String _token =
          DBCrypt().hashpw(senha, '\$2b\$10\$Ziu5wr71p1cY4H.hOeS/q.');

      final Usuario _usuario =
          Usuario(usuario: nomeUsuario, cpf: cpf, token: _token);

      int _resposta = await _database.insertUsuario(row: _usuario.toMap());

      print(_resposta);

      // Se o retorno for maior que zero, então o usuário foi criado com sucesso
      // caso contrário, ocorreu um erro na criação do usuário
      if (_resposta > 0) {
        Get.back();
        Get.snackbar('Sucesso', 'Usuário cadastrado com sucesso!');
        
      } else {
        Get.snackbar('Erro',
            'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
       
      }
    }
  }

  // O método é responsável por permitir ou negar acessos ao sistema
  // se caso o usuário não for reconhecido
  void login(String usuario, String senha) async {
    // Se os campos "Usuário" e "Senha" não forem preenchidos corretamente
    // então é solicitado que os mesmos sejam preenchidos corretamente
    if (usuario.trim().isEmpty || senha.trim().isEmpty) {
      Get.snackbar(
          'Divergência', 'Por favor, preencha os dados de login corretamente.');
      
    }

    // Caso contrário é feita uma verificação no banco de dados acerca da
    // existência do usuário
    else {
      // Biblioteca responsável por persistir os dados localmente, como um cookie
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      List<Map<String, dynamic>> _resposta = await _database.selectUsuarios(
          columns: ['id_usuario', 'token', 'usuario'],
          where: 'usuario = ?',
          whereArgs: [usuario]);

      // Se o usuário não existir, o sistema nega o acesso
      if (_resposta.isEmpty) {
        Get.snackbar(
            'Divergência', 'Usuário inexistente. Por favor, revise seus dados');
        
      }
      // Caso contrário, é feita uma verificação dos seus dados no banco de dados
      else {
        final bool _verificarToken =
            DBCrypt().checkpw(senha, _resposta[0]['token']);

        // Se o token verificado for verdadeiro, concede o acesso e
        // persiste os dados do usuário localmente
        if (_verificarToken) {
          await _prefs.setString('token', _resposta[0]['token']);
          await _prefs.setInt('idUsuario', _resposta[0]['id_usuario']);
          await _prefs.setString('usuario', _resposta[0]['usuario']);
          Get.toNamed('/principal');
        
        }

        // Caso contrário, nega o mesmo
        else {
          Get.snackbar('Divergência',
              'Dados divergentes. Por favor, verifique suas credenciais e tente novamente');
        }
      }
    }
  }

  /*void verificarUsuarioLogado() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');

    if (token.isEmpty) {
      Get.toNamed('/login');
    } else {
      Get.toNamed('/principal');
    }
  }*/

  // Método responsável por encerrar a sessão do usuário no sistema
  void deslogar() async {
    // Biblioteca responsável por persistir os dados do usuário localmente, como um cookie
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    // Limpa os dados deste usuário
    _prefs.clear();

    // Retorna a tela principal
    Get.back();
  }

  // Método responsável por recuperar a senha do usuário corretamente
  void recuperarSenha(String cpf, String senha, String confirmarSenha) async {
    // Verifica se todos os campos foram preenchidos corretamente
    if (cpf.trim().isEmpty || cpf.length < 14) {
      Get.snackbar(
          'Divergência', 'CPF inválido. Por favor, revise seus dados.');
    } else if (senha.trim().isEmpty || senha.length < 6) {
      Get.snackbar('Divergência',
          'A senha não pode estar vazia e precisa ser maior que seis caracteres. Por favor, revise seus dados.');
    } else if (senha != confirmarSenha) {
      Get.snackbar('Divergência',
          'As senhas não conferem. Por favor, revise seus dados.');
    }

    // Se os campos forem validados, então procede com a recuperação da senha
    else {
      // Realiza uma busca pelo usuário com o respectivo cpf no banco de dados
      List<Map<String, dynamic>> _procurarCpf = await _database.selectUsuarios(
          columns: ['cpf'], where: 'cpf = ?', whereArgs: [cpf]);

      // Se o retorno da consulta for vazio, indica a inexistência do usuário
      if (_procurarCpf.isEmpty) {
        Get.snackbar('Divergência',
            'Usuário não encontrado. Verifique seus dados e tente novamente');
      }

      // Caso contrário, uma nova senha é criada e atualizada no banco de dados
      else {
        final String token =
            DBCrypt().hashpw(senha, '\$2b\$10\$Ziu5wr71p1cY4H.hOeS/q.');

        int _senhaAtualizada =
            await _database.updateUsuarios(row: {'cpf': cpf, 'token': token});

        // Se o id de edição da linha for retornado, então uma notificação de sucesso é mostrada
        // e retorna a tela iniciaç
        if (_senhaAtualizada > 0) {
          Get.offAllNamed('/login');
          Get.snackbar('Sucesso', 'Senha atualizada com sucesso!');
        }

        // Caso contrário, notifica um erro
        else {
          Get.snackbar('Erro',
              'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
        }
      }
    }
  }
}
