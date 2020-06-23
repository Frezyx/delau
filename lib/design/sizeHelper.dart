class SizeHelper{
  getAboutHeight(int textLenght, int textFontSize, int nameLenght, int nameFontSize){
    return textLenght / 30 * textFontSize * 2.60 + nameLenght / 15 * textFontSize * 4;
  }
}