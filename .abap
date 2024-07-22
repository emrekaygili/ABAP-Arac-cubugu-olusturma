# ABAP-Pratice-3
Abap da Araç çubuğu oluşturma 

*&---------------------------------------------------------------------*
*& Report  ZRR_EKRAN_OLUSTURMA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZRR_EKRAN_OLUSTURMA.

data: gv_ad TYPE char20,
      gv_soyad TYPE char30.

data: gv_rad1 TYPE char1,
      gv_rad2 TYPE xfeld.

data: gv_cbox TYPE xfeld.

data: gv_yas TYPE i.

data: gv_id TYPE vrm_id,
      gt_values TYPE vrm_values,
      gs_value TYPE vrm_value.

data: gv_ind TYPE i.

data: gv_date TYPE datum.

data: gs_log TYPE ZRR_EKRAN_SAVE.

data: ok_code TYPE sy-ucomm.



START-OF-SELECTION.

gv_cbox = abap_true.

  gv_ind = 18.
  do 60 times.
    gs_value-key = gv_ind.
    gs_value-text = gv_ind.
    append gs_value to gt_values.
    gv_ind = gv_ind + 1.
  enddo.

  CALL SCREEN 0100.

module status_0100 output.
  SET PF-STATUS '0100'.
*  SET TITLEBAR 'xxx'.

gv_id = 'gv_yas'.



  call function 'VRM_SET_VALUES'
    exporting
      id                    = gv_id
      values                = gt_values.
            .
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.


endmodule.

module user_command_0100 input.
  CASE ok_code.
    when '&BACK'.
      LEAVE TO SCREEN 0.
    when '&CLEAR'.
      PERFORM clear_dataa.
    when '&SAVE'.
      PERFORM save_data.
  ENDCASE.
endmodule.


form save_data .
  gs_log-ad = gv_ad.
  gs_log-soyad = gv_soyad.
  gs_log-cbox = gv_cbox.
  gs_log-yas = gv_yas.
  gs_log-zdate = gv_date.
  IF gv_rad1 eq abap_true.
    gs_log-cinsiyet = 'E'.
  ELSE.
    gs_log-cinsiyet = 'K'.
  ENDIF.
  INSERT ZRR_EKRAN_SAVE from gs_log.
  COMMIT WORK AND WAIT.

  MESSAGE 'Veriler Tabloya Kaydedilmiştir.' TYPE 'I' DISPLAY LIKE 'S'.
endform.                    " SAVE_DATA

form clear_dataa .
  CLEAR: gv_ad,
         gv_soyad,
         gv_yas,
         gv_cbox,
         gv_date,
         gv_rad2.
  gv_rad1 = abap_true.
endform.                    " CLEAR_DATAA
