{ lib, buildPythonPackage, fetchPypi, pytestCheckHook, lxml, matplotlib
, nibabel, numpy, pandas, scikit-learn, scipy, joblib, requests }:

buildPythonPackage rec {
  pname = "nilearn";
  version = "0.10.1";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-koo2Tn7XfRXQK38icZfqfHj0Ty/ngP61VdbXz5Iy+EY=";
  };

  nativeCheckInputs = [ pytestCheckHook ];
  disabledTests = [ "test_clean_confounds" ];  # https://github.com/nilearn/nilearn/issues/2608
  # do subset of tests which don't fetch resources
  pytestFlagsArray = [ "nilearn/connectome/tests" ];

  propagatedBuildInputs = [
    joblib
    lxml
    matplotlib
    nibabel
    numpy
    pandas
    requests
    scikit-learn
    scipy
  ];

  meta = with lib; {
    homepage = "https://nilearn.github.io";
    description = "A module for statistical learning on neuroimaging data";
    license = licenses.bsd3;
  };
}
