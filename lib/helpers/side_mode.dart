enum SideMode { front, back, right }

String getSideModeName(SideMode sideMode) {
  switch (sideMode) {
    case SideMode.front:
      return 'روبرو';
    case SideMode.back:
      return 'پشت سر';
    case SideMode.right:
      return 'راست';
    default:
      return '';
  }
}

String getImageFromSideMode(SideMode sideMode) {
  switch (sideMode) {
    case SideMode.front:
      return 'assets/images/front_side.png';
    case SideMode.back:
      return 'assets/images/back_side.png';
    case SideMode.right:
      return 'assets/images/left_side.png';
    default:
      return '';
  }
}
