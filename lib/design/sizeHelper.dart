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
      response = containerHeight * textPart;
    }

    return response;
  }
}