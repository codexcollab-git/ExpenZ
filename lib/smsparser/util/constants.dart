
import '../model/types.dart';

const List availableBalanceKeywords = [
  'avbl bal',
  'available balance',
  'available limit',
  'available credit limit',
  'limit available',
  'a/c bal',
  'ac bal',
  'available bal',
  'avl bal',
  'updated balance',
  'total balance',
  'new balance',
  'bal',
  'avl lmt',
  'available',
];

const List blackListedKeywords = [
  'recharge',
  'recharged',
  'talktime',
  'otp',
  'voucher',
  'apply',
  'deal',
  'data',
  'loan',
  'offer',
  'calls',
  'validity'
  'securities'
];

const List outstandingBalanceKeywords = ['outstanding'];

const List wallets = ['paytm', 'simpl', 'lazypay', 'amazon_pay', 'mobikwik', 'yono', 'payzapp' 'phone_pe', 'google_pay', 'bhim'];

const List upiKeywords = ['upi', 'ref no', 'upi ref', 'upi ref no'];

final List<CombinedWords> combinedWordsList = [
  CombinedWords(
      regExp: RegExp(r"bank\scard"), word: "c_card", type: AccountType.CARD, name: 'Credit Card'),
  CombinedWords(
      regExp: RegExp(r"debit\scard"), word: "d_card", type: AccountType.CARD, name: 'Debit Card'),
  CombinedWords(
      regExp: RegExp(r"credit\scard"), word: "c_card", type: AccountType.CARD, name: 'Credit Card'),
  CombinedWords(
      regExp: RegExp(r"amazon\spay",),
      word: "amazon_pay",
      type: AccountType.WALLET, name: 'Amazon Pay'),
  CombinedWords(
      regExp: RegExp(r"uni\scard"), word: "uni_card", type: AccountType.CARD, name: 'Uni Card'),
  CombinedWords(
      regExp: RegExp(r"niyo\scard"), word: "niyo", type: AccountType.ACCOUNT, name: 'Niyo Card'),
  CombinedWords(
      regExp: RegExp(r"slice\scard"),
      word: "slice_card",
      type: AccountType.CARD, name: 'Slice Card'),
  CombinedWords(
      regExp: RegExp(r"one\s*card"),
      word: "one_card",
      type: AccountType.CARD, name: 'One Card'),
  CombinedWords(
      regExp: RegExp(r"rupay\scard"),
      word: "rupay_card",
      type: AccountType.CARD, name: 'Rupay Card'),
  CombinedWords(
      regExp: RegExp(r"mastercard"),
      word: "mastercard",
      type: AccountType.CARD, name: 'Mastercard'),
  CombinedWords(
      regExp: RegExp(r"visa\scard"),
      word: "visa_card",
      type: AccountType.CARD, name: 'Visa Card'),
];

const List banksList = [
    'Axis Bank Ltd, Axis',
    'Bandhan Bank Ltd, Bandhan',
    'CSB Bank Limited, CSB',
    'City Union Bank Ltd, CUB',
    'DCB Bank Ltd, DCB',
    'Dhanlaxmi Bank Ltd, Dhanlaxmi',
    'Federal Bank Ltd, Federal',
    'HDFC Bank Ltd, HDFC',
    'ICICI Bank Ltd, ICICI',
    'IndusInd Bank Ltd, IndusInd',
    'IDFC FIRST Bank Limited, IDFC FIRST',
    'Jammu & Kashmir Bank Ltd, J&K Bank',
    'Karnataka Bank Ltd, Karnataka',
    'Karur Vysya Bank Ltd, Karur Vysya',
    'Kotak Mahindra Bank Ltd, Kotak',
    'Nainital bank Ltd, Nainital',
    'RBL Bank Ltd, RBL',
    'South Indian Bank Ltd, SIB',
    'Tamilnad Mercantile Bank Ltd, TMB',
    'YES Bank Ltd, YES',
    'IDBI Bank Limited, IDBI',
    'Coastal Local Area Bank Ltd, Coastal',
    'Krishna Bhima Samruddhi LAB Ltd, KBS LAB',
    'Au Small Finance Bank Ltd, Au SFB',
    'Capital Small Finance Bank Ltd, Capital SFB',
    'Equitas Small Finance Bank Ltd, Equitas SFB',
    'ESAF Small Finance Bank Ltd, ESAF SFB',
    'Suryoday Small Finance Bank Ltd, Suryoday SFB',
    'Ujjivan Small Finance Bank Ltd, Ujjivan SFB',
    'Utkarsh Small Finance Bank Ltd, Utkarsh SFB',
    'North East Small finance Bank Ltd, NE SFB',
    'Jana Small Finance Bank Ltd, Jana SFB',
    'Shivalik Small Finance Bank Ltd, Shivalik SFB',
    'Unity Small Finance Bank Ltd, Unity SFB',
    'Airtel Payments Bank Ltd, Airtel PB',
    'India Post Payments Bank Ltd, IPPB',
    'FINO Payments Bank Ltd, FINO PB',
    'Paytm Payments Bank Ltd, Paytm PB',
    'Jio Payments Bank Ltd, Jio PB',
    'NSDL Payments Bank Limited, NSDL PB',
    'Bank of Baroda, BoB',
    'Bank of India, BoI',
    'Bank of Maharashtra, BoM',
    'Canara Bank, Canara',
    'Central Bank of India, CBI',
    'Indian Bank, IB',
    'Indian Overseas Bank, IOB',
    'Punjab & Sind Bank, P&SB',
    'Punjab National Bank, PNB',
    'State Bank of India, SBI',
    'UCO Bank, UCO',
    'Union Bank of India, UBI',
    'Export-Import Bank of India, EXIM Bank',
    'National Housing Bank, NHB',
    'Small Industries Development Bank of India, SIDBI',
    'Assam Gramin Vikash Bank, AGVB',
    'Andhra Pradesh Grameena Vikas Bank, APGVB',
    'Andhra Pragathi Grameena Bank, APGB',
    'Arunachal Pradesh Rural Bank, APRB',
    'Aryavart Bank, Aryavart',
    'Bangiya Gramin Vikash Bank, BGVB',
    'Baroda Gujarat Gramin Bank, BGGB',
    'Baroda Rajasthan Kshetriya Gramin Bank, BRKGB',
    'Baroda UP Bank, BUPB',
    'Chaitanya Godavari GB, CGGB',
    'Chhattisgarh Rajya Gramin Bank, CRGB',
    'Dakshin Bihar Gramin Bank, DBGB',
    'Ellaquai Dehati Bank, EDB',
    'Himachal Pradesh Gramin Bank, HPGB',
    'J&K Grameen Bank, JKGB',
    'Jharkhand Rajya Gramin Bank, JRGB',
    'Karnataka Gramin Bank, KGB',
    'Karnataka Vikas Gramin Bank, KVGB',
    'Kerala Gramin Bank, KGB',
    'Madhya Pradesh Gramin Bank, MPGB',
    'Madhyanchal Gramin Bank, MGB',
    'Maharashtra Gramin Bank, MGB',
    'Manipur Rural Bank, MRB',
    'Meghalaya Rural Bank, MRB',
    'Mizoram Rural Bank, MRB',
    'Nagaland Rural Bank, NRB',
    'Odisha Gramya Bank, OGB',
    'Paschim Banga Gramin Bank, PBGB',
    'Prathama UP Gramin Bank, PUPGB',
    'Puduvai Bharathiar Grama Bank, PBGB',
    'Punjab Gramin Bank, PGB',
    'Rajasthan Marudhara Gramin Bank, RMGB',
    'Saptagiri Grameena Bank, SGB',
    'Sarva Haryana Gramin Bank, SHGB',
    'Saurashtra Gramin Bank, SGB',
    'Tamil Nadu Grama Bank, TNGB',
    'Telangana Grameena Bank, TGB',
    'Tripura Gramin Bank, TGB',
    'Uttar Bihar Gramin Bank, UBGB',
    'Utkal Grameen Bank, UGB',
    'Uttarbanga Kshetriya Gramin Bank, UKGB',
    'Vidharbha Konkan Gramin Bank, VKGB',
    'Uttarakhand Gramin Bank, UKGB',
    'AB Bank PLC, AB Bank',
    'American Express Banking Corporation, AMEX',
    'Australia and New Zealand Banking Group Ltd, ANZ',
    'Barclays Bank Plc, Barclays',
    'Bank of America, BofA',
    'Bank of Bahrain & Kuwait BSC, BBK',
    'Bank of Ceylon, BOC',
    'Bank of China, BOC',
    'Bank of Nova Scotia, Scotiabank',
    'BNP Paribas, BNP',
    'Citibank NA, Citi',
    'Cooperatieve Rabobank UA/ Cooperatieve Centrale Raiffeisen-Boerenleenbank BA, Rabobank',
    'Credit Agricole Corporate & Investment Bank, Credit Agricole',
    'Credit Suisse AG, Credit Suisse',
    'CTBC Bank Co Ltd, CTBC',
    'DBS Bank India Limited, DBS',
    'Deutsche Bank AG, Deutsche',
    'Doha Bank QPSC, Doha',
    'Emirates NBD Bank PJSC, Emirates NBD',
    'First Abu Dhabi Bank PJSC, FAB',
    'FirstRand Bank Limited, FirstRand',
    'Hong Kong and Shanghai Banking Corporation Limited, HSBC',
    'Industrial & Commercial Bank of China Ltd, ICBC',
    'Industrial Bank of Korea, IBK',
    'JP Morgan Chase Bank NA, JPMorgan',
    'JSC VTB Bank, VTB',
    'KEB Hana Bank, Hana',
    'Kookmin Bank, Kookmin',
    'Krung Thai Bank Public Co Ltd, KTB',
    'Mashreq bank PSC, Mashreq',
    'Mizuho Bank Ltd, Mizuho',
    'MUFG Bank Ltd, MUFG',
    'NatWest Markets Plc, NatWest',
    'PT Bank Maybank Indonesia TBK, Maybank',
    'Qatar National Bank QPSC, QNB',
    'Sberbank, Sberbank',
    'SBM Bank India Limited, SBM',
    'Shinhan Bank, Shinhan',
    'Societe Generale India, SocGen',
    'Sonali Bank PLC, Sonali',
    'Standard Chartered Bank, StanChart',
    'Sumitomo Mitsui Banking Corporation, SMBC',
    'United Overseas Bank Limited, UOB',
    'Woori Bank, Woori'
];

final List<UPIAddresses> upiAddresses = [
  UPIAddresses(
      regExp: RegExp(r"@apl"),
      name: "Amazon Pay UPI",
      address: "@apl"),
  UPIAddresses(
      regExp: RegExp(r"@aisbank"),
      name: "Playstore UPI",
      address: "@aisbank"),
  UPIAddresses(
      regExp: RegExp(r"@yapl"),
      name: "Amazon Pay UPI",
      address: "@yapl"),
  UPIAddresses(
      regExp: RegExp(r"@rapl"),
      name: "Amazon Pay UPI",
      address: "@rapl"),
  UPIAddresses(
      regExp: RegExp(r"@abfspay"),
      name: "Bajaj Finserv UPI",
      address: "@abfspay"),
  UPIAddresses(
      regExp: RegExp(r"@axisb"),
      name: "Axis Bank UPI",
      address: "@axisb"),
  UPIAddresses(
      regExp: RegExp(r"@idfcbank"),
      name: "IDFC Bank UPI",
      address: "@idfcbank"),
  UPIAddresses(
      regExp: RegExp(r"@fkaxis"),
      name: "Flipkart Bank UPI",
      address: "@fkaxis"),
  UPIAddresses(
      regExp: RegExp(r"@icici"),
      name: "ICICI Bank UPI",
      address: "@icici"),
  UPIAddresses(
      regExp: RegExp(r"@okaxis"),
      name: "Google Pay UPI",
      address: "@okaxis"),
  UPIAddresses(
      regExp: RegExp(r"@okhdfcbank"),
      name: "Google Pay UPI",
      address: "@okhdfcbank"),
  UPIAddresses(
      regExp: RegExp(r"@okicici"),
      name: "Google Pay UPI",
      address: "@okicici"),
  UPIAddresses(
      regExp: RegExp(r"@oksbi"),
      name: "Google Pay UPI",
      address: "@oksbi"),
  UPIAddresses(
      regExp: RegExp(r"@yesg"),
      name: "Yes Bank UPI",
      address: "@yesg"),
  UPIAddresses(
      regExp: RegExp(r"@jupiteraxis"),
      name: "Jupiter Money UPI",
      address: "@jupiteraxis"),
  UPIAddresses(
      regExp: RegExp(r"@goaxb"),
      name: "Kiwi UPI",
      address: "@goaxb"),
  UPIAddresses(
      regExp: RegExp(r"@ikwik"),
      name: "MobiKwik UPI",
      address: "@ikwik"),
  UPIAddresses(
      regExp: RegExp(r"@naviaxis"),
      name: "Navi UPI",
      address: "@naviaxis"),
  UPIAddresses(
      regExp: RegExp(r"@niyoicici"),
      name: "Niyo UPI",
      address: "@niyoicici"),
  UPIAddresses(
      regExp: RegExp(r"@ybl"),
      name: "PhonePe UPI",
      address: "@ybl"),
  UPIAddresses(
      regExp: RegExp(r"@ibl"),
      name: "PhonePe UPI",
      address: "@ibl"),
  UPIAddresses(
      regExp: RegExp(r"@axl"),
      name: "PhonePe UPI",
      address: "@axl"),
  UPIAddresses(
      regExp: RegExp(r"@pingpay"),
      name: "Samsung Pay UPI",
      address: "@pingpay"),
  UPIAddresses(
      regExp: RegExp(r"@shriramhdfcbank"),
      name: "Shriram One UPI",
      address: "@shriramhdfcbank"),
  UPIAddresses(
      regExp: RegExp(r"@sliceaxis"),
      name: "Slice UPI",
      address: "@sliceaxis"),
  UPIAddresses(
      regExp: RegExp(r"@tapicici"),
      name: "Tata Neu UPI",
      address: "@tapicici"),
  UPIAddresses(
      regExp: RegExp(r"@timecosmos"),
      name: "Time Pay UPI",
      address: "@timecosmos"),
  UPIAddresses(
      regExp: RegExp(r"@waicici"),
      name: "Whatsapp UPI",
      address: "@waicici"),
  UPIAddresses(
      regExp: RegExp(r"@waaxis"),
      name: "Whatsapp UPI",
      address: "@waaxis"),
  UPIAddresses(
      regExp: RegExp(r"@wahdfcbank"),
      name: "Whatsapp UPI",
      address: "@wahdfcbank"),
  UPIAddresses(
      regExp: RegExp(r"@wasbi"),
      name: "Whatsapp UPI",
      address: "@wasbi"),
  UPIAddresses(
      regExp: RegExp(r"@abcdicici"),
      name: "Aditya Birla UPI",
      address: "@abcdicici"),
  UPIAddresses(
      regExp: RegExp(r"@paytm"),
      name: "Paytm UPI",
      address: "@paytm"),
  UPIAddresses(
      regExp: RegExp(r"@ptyes"),
      name: "Paytm UPI",
      address: "@ptyes"),
  UPIAddresses(
      regExp: RegExp(r"@ptaxis"),
      name: "Paytm UPI",
      address: "@ptaxis"),
  UPIAddresses(
      regExp: RegExp(r"@pthdfc"),
      name: "Paytm UPI",
      address: "@pthdfc"),
  UPIAddresses(
      regExp: RegExp(r"@ptsbi"),
      name: "Paytm UPI",
      address: "@ptsbi"),
  UPIAddresses(
      regExp: RegExp(r"@yesfam"),
      name: "Yes Bank UPI",
      address: "@yesfam"),
];

