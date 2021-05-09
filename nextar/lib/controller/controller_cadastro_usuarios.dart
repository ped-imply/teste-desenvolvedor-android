import 'package:Nextar/database/database.dart';
import 'package:Nextar/model/model_usuario.dart';
import 'package:get/get.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerCadastroUsuarios extends GetxController {
  // Variável para chamar a instância do banco de dados
  // para então, consequentemente, obter acesso aos comandos de SGBD
  final DatabaseHelper _database = DatabaseHelper.instance;

  // O método é responsável por cadastrar usuários corretamente no banco de dados.
  void cadastrarUsuario(String nomeUsuario, String cpf, String senha,
      String confirmarSenha) async {
    // Verifica se o campo "Usuário" foi preenchido corretamente
    if (nomeUsuario.isEmpty ||
        nomeUsuario == null ||
        nomeUsuario.length <= 2 ||
        nomeUsuario == '') {
      Get.snackbar('Divergência',
          'O nome de usuário não pode estar vazio e precisa ser maior que dois caracteres. Por favor, revise seus dados.');
    }
    // Se o anterior fora preenchido corretamente, verifica se o cpf digitado é válido
    else if (cpf.isEmpty || cpf == null || cpf.length < 14 || cpf == '') {
      Get.snackbar(
          'Divergência', 'CPF inválido. Por favor, revise seus dados.');
    }
    // Se o campo anterior fora preenchido corretamente, verifica se a senha digitada é válida
    else if (senha.isEmpty ||
        senha == null ||
        senha.length < 6 ||
        senha == '') {
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
      final _verificarUsuario = await _database.selectUsuarios(
          columns: ['usuario'], where: 'usuario = ?', whereArgs: [nomeUsuario]);

      final _verificarCpf = await _database.selectUsuarios(
          columns: ['cpf'], where: 'cpf = ?', whereArgs: [cpf]);

      if (_verificarUsuario.isNotEmpty) {
        Get.snackbar('Divergência',
            'Nome de usuário já existente. Por favor, selecione outro nome de usuário');
      } else if (_verificarCpf.isNotEmpty) {
        Get.snackbar('Divergência',
            'CPF já existente. Caso tenha esquecido de sua senha, recupere-a no link "Esqueceu sua senha?"');
      }

      // Se as validações anteriores forem falsas, então o processo de criação de usuário é iniciado
      else {
        final String _token = DBCrypt().hashpw(senha, DBCrypt().gensalt());

        final Usuario _usuario =
            Usuario(usuario: nomeUsuario, cpf: cpf, token: _token);

        final int _resposta =
            await _database.insertUsuario(row: _usuario.toMap());

        // Se o retorno for maior que zero, então o usuário foi criado com sucesso
        // caso contrário, ocorreu um erro na criação do usuário
        if (_resposta > 0) {
          Get.offAllNamed('/login');
          Get.snackbar('Sucesso', 'Usuário cadastrado com sucesso!');
        } else {
          Get.snackbar('Erro',
              'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
        }
      }
    }
  }

  // O método é responsável por permitir ou negar acessos ao sistema
  // se caso o usuário não for reconhecido
  void login(String usuario, String senha) async {
    // Se os campos "Usuário" e "Senha" não forem preenchidos corretamente
    // então é solicitado que os mesmos sejam preenchidos corretamente
    if (usuario.isEmpty ||
        usuario == null ||
        usuario.length <= 0 ||
        usuario == '' ||
        senha.isEmpty ||
        senha == null ||
        senha.length <= 0 ||
        senha == '') {
      Get.snackbar(
          'Divergência', 'Por favor, preencha os dados de login corretamente.');
    }

    // Caso contrário é feita uma verificação no banco de dados acerca da
    // existência do usuário
    else {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      final List<Map<String, dynamic>> _resposta =
          await _database.selectUsuarios(
              columns: ['id', 'token'],
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

        // Se o token verificado for verdadeiro, concede o acesso
        if (_verificarToken) {
          _prefs.setString('token', _resposta[0]['token']);
          _prefs.setInt('idUsuario', _resposta[0]['id']);
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

  void recuperarSenha(String cpf, String senha, String confirmarSenha) async {
    if (cpf.isEmpty || cpf == null || cpf.length < 14 || cpf == '') {
      Get.snackbar(
          'Divergência', 'CPF inválido. Por favor, revise seus dados.');
    } else if (senha.isEmpty ||
        senha == null ||
        senha.length < 6 ||
        senha == '') {
      Get.snackbar('Divergência',
          'A senha não pode estar vazia e precisa ser maior que seis caracteres. Por favor, revise seus dados.');
    } else if (senha != confirmarSenha) {
      Get.snackbar('Divergência',
          'As senhas não conferem. Por favor, revise seus dados.');
    } else {
      final List<Map<String, dynamic>> procurarCpf = await _database
          .selectUsuarios(columns: ['cpf'], where: 'cpf = ?', whereArgs: [cpf]);

      if (procurarCpf.isEmpty) {
        Get.snackbar('Divergência',
            'Usuário não encontrado. Verifique seus dados e tente novamente');
      } else {
        final String token = DBCrypt().hashpw(senha, DBCrypt().gensalt());

        final int senhaAtualizada =
            await _database.update(row: {'cpf': cpf, 'token': token});

        if (senhaAtualizada > 0) {
          Get.offAllNamed('/login');
          Get.snackbar('Sucesso', 'Senha atualizada com sucesso!');
        } else {
          Get.snackbar('Erro',
              'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
        }
      }
    }
  }
}
