class SizeHelper{
  double getAboutHeight(int textLenght, int textFontSize, int nameLenght, int nameFontSize, bool isTitle){
    if(textLenght / 30 < 1 || nameLenght / 15 < 1){
      if(isTitle){return 30.0;}
      else{return 15.0;}
    }
    var containerHeight = textLenght / 30 * textFontSize * 2.60 + nameLenght / 15 * textFontSize * 4;

    var sizeSum =  nameLenght * nameFontSize + textLenght * textFontSize;
    var namePart = nameLenght * nameFontSize / sizeSum;
    var textPart = textLenght * textFontSize / sizeSum;

    double response = 0.0;

    if(isTitle){
      response = containerHeight * namePart + 10;
    }
    else{
      response = containerHeight * textPart * 0.7;
    }

    return response;
  }

  int getGridHeigth(String content){
    var height = 1;
    var charCount = content.length;
    if (charCount > 80) {  height = 2;  }
    else if (charCount <= 80) {  height = 1;  }
    return height;
  }

  int getGridWidth(String content){
    var width = 1;
    var charCount = content.length;
    if (charCount > 3 ) { width = 2; }
    return width;
  }

  double determineFontSizeForContent(content) {
    int charCount = content.length ;
    double fontSize = 20 ;
    if (charCount > 150 ) { fontSize = 12; }
    else if (charCount > 70) {  fontSize = 14;  }
    else if (charCount > 50) {  fontSize = 16;  }
    else if (charCount > 10) {  fontSize = 18;  }
    return fontSize;
  }

}