import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/new_transactions.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); //this is used before changing anything in the orientation mode becaus ein other old devices  it might not work

  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily:
              'Quicksand', //this to make this font global to the whole app and this name must match the name that is infront (family:) in pubspec.yaml
          appBarTheme: AppBarTheme(
            // here I define a new theme for appbar that's gonna be for all the appbars in the app and i set a text theme by using theme data, dot light is a set of defaults that i normally must have when i just create a theme data and after that i can access the text theme and copy it with our own settings so what we basically do here is we assign a new text theme for our app bar so that all text elements in the app are received that theme and we based it  on the default text theme which is (.light()) so we don't have to override every thing like fontsize and so on but we use the default text theme and copy that with some new overwritten values and here i override (titels) Titels are specific style of text flutter knows that title receive a specific style like font family which we want and we can add fontsize and now with that we're using the basic text theme with our own settings and we apply that to all texts with mark title on the appbar and to be very precise  we don't overwrite all texts in there ((((((______but only text which is marked as a title______))))))
            textTheme: ThemeData.light().textTheme.copyWith(
                  subtitle1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ), //so what we basically do here is we assign a new text theme for our app bar so that all text elements in the app are received that theme and we based it on the default text theme so that  we don't have to override everything like font size and so on
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
  ];

  bool _switchChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      //we of course take all our transactions but now we want to filter out transactions that did happen in the last week
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      ); // here is an example for illustrating what is happening here for esample i made a transaction in day 3 today's date is 20 so 20-7=13 is 3 after 13 .. no then this transaction is not from the recent last week transactions
    }).toList(); //i have to convert it to list because using where by default return a type Iterable
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime txDateTime) {
    final newTx = Transaction(
      amount: txAmount,
      date: txDateTime,
      id: DateTime.now().toString(),
      title: txTitle,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  final titleController = TextEditingController();

  final amountContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        )
      ], //to add a widget to the appbar this done by the help of the actions argument which take list of widgets
      title: Text(
          'Personal Expenses App'), // i can change the text of this app bar of this page by wiriting like this ==>(style: TextStyle(fontFamily:'Open Sans')) but this won't be helpful if i have multiple pages since i'm gonna have to write this code for every page alternative way and better way is used up inside theme inside material app
    );

    final transactionList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            (0.7),
        child: TransactionList(_userTransactions, _removeTransaction));

    return Scaffold(
      appBar:
          appBar, //i intended to put appBar as a variable because down a little bit where putting the chart and the transactions i'm gonna need to use its properties

      body: SingleChildScrollView(
        //i needed to git rid SingleChildScrollView (which is responsible for  scrolling the whole page not only the transactions as they split the available height and never need to be scrollable )
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape == true)
              Row(
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _switchChart,
                      onChanged: (value) {
                        setState(() {
                          _switchChart = value;
                        });
                      })
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            if (isLandScape == true)
              _switchChart == true
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          (0.7), //the problem here when writng a static value for the heigt is when i put the phone in landscape mode the legnth of the screen becomes alot smaller than the 600 that it needs so when i start scrolling and pass the chart i can't go back to the chart again so this value need to be put dunamically so it detect the landscape mode
                      child: Chart(_recentTransactions),
                    )
                  : //it does not need all transactions we could have more transactions here but I only want is transactions from the last week, so we should make sure that we only add those,
                  transactionList,
            if (!isLandScape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    (0.25), //the problem here when writng a static value for the heigt is when i put the phone in landscape mode the legnth of the screen becomes alot smaller than the 600 that it needs so when i start scrolling and pass the chart i can't go back to the chart again so this value need to be put dunamically so it detect the landscape mode
                child: Chart(_recentTransactions),
              ),
            if (!isLandScape) transactionList
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, //this is an addition argument to center the floating button
    );
  }
}
