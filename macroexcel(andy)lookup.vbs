'andylookup(A2;H$2:I$1091;"PAS TROUVE!")

Function andyLookup(strInput As String, rngTable As Range, defaultvalue As String) As String
    Dim strArray() As String
    Dim i As Integer
    Dim strOut As String
    Dim temp1 As Variant

    strArray = Split(strInput, ",")
    For i = 0 To UBound(strArray)

        temp1 = Application.VLookup(strArray(i), rngTable, 2, 0)
        'if not found, apply default value
        If IsError(temp1) Then
        strOut = strOut & defaultvalue & "+"
        Else
        strOut = strOut & temp1 & "+"
        End If

    Next

    'remove trailing comma
    strOut = Left(strOut, Len(strOut) - 1)
    andyLookup = strOut

End Function