import 'package:app_snowman/core/themes/app_colors.dart';
import 'package:app_snowman/models/Question.dart';

const String kTitleNullError = "Por favor, insira um título";
const String kReplyNullError = "Por favor, insira uma resposta";

const double kPaddingDefault = 10.0;
const double kBorderRadiusDefault = 10.0;
const double kItemBorderRadiusDefault = 30.0;

List<Question> kList = [
  new Question(
    id: 1,
    title: 'Em qual data foi fundada a Snowman Labs?',
    reply: 'A Snowman Labs foi fundada no dia 9 de agosto de 2012.',
    color: AppColors.itemColors1.toString(),
  ),
  new Question(
    id: 2,
    title: 'Qual foi o primeiro cliente/ projeto que a Snow teve?',
    reply:
        'O primeiro cliente que a Snow teve foi um candidato a deputado federal e fizemos o projeto dos santinhos digitais. Foi entregue em setembro de 2012.',
    color: AppColors.itemColors2.toString(),
  ),
  new Question(
    id: 3,
    title: 'Por que foi escolhido o nome Snowman Labs?',
    reply:
        'Por conta da neve em Curitiba que ocorreu em 2013. Queríamos um mascote e a partir dele, surgiu o nome (foi a primeira coisa que pensamos na época).',
    color: AppColors.itemColors3.toString(),
  ),
  new Question(
    id: 4,
    title: 'Quantos funcionários a Snow tinha no primeiro ano de existência?',
    reply: 'Em nosso primeiro ano éramos apenas 7 funcionários.',
    color: AppColors.itemColors4.toString(),
  ),
  new Question(
    id: 5,
    title: 'Qual é o propósito da Snowman Labs?',
    reply: 'Servir e impactar pessoas através de tecnologia e design.',
    color: AppColors.itemColors4.toString(),
  ),
  new Question(
    id: 6,
    title: 'Qual é a missão da Snowman Labs?',
    reply:
        'Criar soluções que promovam a transformação e evolução digital dos nossos clientes, gerando negócios, resultados e impactando positivamente pessoas e processos.',
    color: AppColors.itemColors3.toString(),
  ),
  new Question(
    id: 7,
    title: 'Qual é a visão da Snowman Labs?',
    reply:
        'Ampliar exponencialmente o potencial das empresas e das pessoas através de design e tecnologia.',
    color: AppColors.itemColors2.toString(),
  ),
  new Question(
    id: 8,
    title: 'Quais são os princípios e valores da Snowman Labs?',
    reply: 'Fé - que guia as nossas ações.\n\n'
        'Qualidade - que nos move sempre a darmos o nosso melhor.\n\n'
        'Transparência - que constrói a confiança.\n\n'
        'Respeito - que honra as pessoas.\n\n'
        'Relacionamento - que nos torna uma família.\n\n'
        'Comprometimento - que nos faz andar mais uma milha.\n\n'
        'Impacto - que cria esperança.',
    color: AppColors.itemColors1.toString(),
  ),
  new Question(
    id: 9,
    title: 'Quais stacks são utilizadas na Snowman Labs?',
    reply:
        'A Snow trabalha com diferentes stacks e tecnologias, entre elas estão Java/Kotlin para Android nativo, Swift para iOS, Flutter/Dart, Python, .NET, VueJS, NodeJS…',
    color: AppColors.itemColors2.toString(),
  ),
  new Question(
    id: 10,
    title: 'A Snow é aberta à novas idéias e tecnologias?',
    reply:
        'Sim! A Snow está sempre buscando se manter atualizada sobre novas tecnologias e sempre está aberta à novas ideias e sugestões. Fomos umas das primeiras em Curitiba a adotar o Flutter para projetos em produção e estamos sempre buscando por inovações e melhorias.',
    color: AppColors.itemColors3.toString(),
  ),
];
