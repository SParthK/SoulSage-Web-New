class Validations {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please Enter Email';
    final RegExp nameExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!nameExp.hasMatch(value.trim())) return 'Please Enter Valid Email';
    return null;
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'.{6,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'please enter a valid password containing 6 characters';
      } else {
        return null;
      }
    }
  }

  String? validateMobilenumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Number';
    } else if (value.trim().length < 10) {
      return 'please Enter Valid Number';
    }
    return null;
  }

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter OTP';
    } else if (value.trim().length < 6) {
      return 'please Enter Valid OTP';
    }
    return null;
  }

  String? validateFname(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Valid Name';
    }
    return null;
  }

  String? validateLname(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Valid Name';
    }
    return null;
  }

  /// Add bank validation
  String? validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Bank Name';
    }
    return null;
  }

  String? validateAccountHoldersName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Account Holders Name';
    }
    return null;
  }

  String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Account Number';
    }
    return null;
  }

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Mobile Number';
    }
    return null;
  }

  String? validateRoutingNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Routing Number';
    }
    return null;
  }

  String? validateLAddressLine1(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Address Line 1';
    }
    return null;
  }

  String? validateLAddressLine2(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Address Line 2';
    }
    return null;
  }

  String? validateLCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter City Name';
    }
    return null;
  }

  String? validateLState(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter State Name';
    }
    return null;
  }

  String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Postal Code Number';
    }
    return null;
  }

  String? validateLCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Country Name';
    }
    return null;
  }

  String? validateIban(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter IBAN Number';
    }
    return null;
  }

  String? validateLClearance(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Clearance Number';
    }
    return null;
  }

  String? validateLBic(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter BIC Number';
    }
    return null;
  }

  String? validateLFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter First Name';
    }
    return null;
  }

  String? validateLLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please Enter Last Name';
    }
    return null;
  }
}
