import 'package:bytebank_persistencia/database/dao/contact_dao.dart';
import 'package:bytebank_persistencia/http/webclients/transactions_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao {}
class MockTransactionWebClient extends Mock implements TransactionWebClient{}