Return-Path: <linux-efi+bounces-815-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90587C6C2
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 01:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948F8B20A2C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 00:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B163B;
	Fri, 15 Mar 2024 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="r9i+WBaE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F38635
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710462446; cv=none; b=bFMvGHXYvmfA9nKuBl1wCOQyjVv/yunLTH+Cx7DVzBcfWc3IJWaMG7R4ZtnP0waly/TimtJooM6CU/Vrco+Iz4awgBYVzWnbc2Q6RO7xksKh6oDTECCGkFgTTTy+r/DmbJxBZAAkKH6qxyDP58CzPsj9tUw127spK8VHeUmqhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710462446; c=relaxed/simple;
	bh=xPDbkryWxiDnUwFYvhMFevb3S4af5j72e5RarYjwX6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hswq1MqpXSi+jcwsswvP1U//vB3KYcdxqJOWZLKcFKZRRNTPIimMoiDFbYHEgQcaBtunGpCkaGBxxKutar59VP0HdzukG3Bj9C08Bu3jdbosLWiMNj7V/VPmGt9b7A4utB8RUiLMZ/Uu+WgixutQhmhQObXRgkG8Mi7VdOjp0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=r9i+WBaE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710462437; x=1711067237; i=timschumi@gmx.de;
	bh=STGrPfJB80j4RRfwb7NE9gGbjlU6Yd9gsmoXUO1Ln/I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=r9i+WBaEfLIdwMVMRJPVgN5FUQ0QWTcK6/O2X+9E2gCSSL5kJfPLfrW4TCm5EnAO
	 B2sIM2zXZ08NiDZonZSCfd6BvWRXhzdQvFqNDuhet3irZBfWLzcmxUt6ICMNeTg/1
	 AiH0FMKKpSPMUsldd5tMOtp7QFeF7MXiIw6/1AgDh9M2jbVcGltMsS+BwqaN8A87/
	 3elvagGziACRMVSEuC763R4tUh7us9HCayuAs3gipTJXih4293Nr6oUv1AdLaFNXK
	 dfx+Pp9exavBTa7Dk26/XI5Wp+gIr9R5ZA6oaP3Fa/34BV/jd3vDndjmJUk2NeG4j
	 zaOvmo8gDmYtuBnzog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7zBR-1qg3La3E3P-01545K; Fri, 15 Mar 2024 01:27:17 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 3/3] efi: Clear up misconceptions about a maximum variable name size
Date: Fri, 15 Mar 2024 01:26:00 +0100
Message-ID: <20240315002616.422802-3-timschumi@gmx.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315002616.422802-1-timschumi@gmx.de>
References: <20240315002616.422802-1-timschumi@gmx.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JbPOD9SZDPPe7pRzqLwnZEYn+rHBC6frmgE7ccUmFG4NsjD3+NE
 2zQ3csPkF0F1/bSzcqQDj73po8ZNXVy0IxHZ/mStzu8Uw3CI2TxLOT079YLa3Js/t3h9sKR
 zyRU2uLIdFlfwRyOcWxvJHlJyIN8XGIL+edDP/ux26h/EzaQMWfug5BjSucfQSvzgSqUh6H
 vxVdy9dA25AH9MrwBDgoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4S6D5Su/eEQ=;gFtLV07hE/mkAjRxDcrFg/HCoOL
 43ZtwCrGNrKSQhlpBSs0n2oARldbnEdzxRgymQ6KN5UaEoX71fBFO1DRZtEHELxQ2yuSJ1OyR
 e7IxAhjineH0VlaZVpOd2TbySR6AxQovhuo7X2U52gVJRo3wcinHrB3fN3hRl76kkui/8hIIb
 4FzzdY0w1S+bwKjJnPu/Bjb91mLBC7yG6ZFHoVKfIlYiQ3j0YH+fj9F9ZYVmrULd3ylKQ1CM+
 SE9sBiL+Ku7ga+cxwCfZP41EAWqqjwhPSPPhwBHVEQNkbTX1oHsDF4BBHXspcp8e1TVgFLSYO
 4ZAlYAw6NwFo5Pe/h1noM8diFafsHPvhQNOHSlk2BTRQNzEppN4Hh0fREnpbTA+QTYSNLCjo6
 oaI0rGpS2NWaCsPMdXHrwTa+zY6dzjiibtzcwEBdJuX3Z20Q+XXMTiIrpWP7WQFU6tE/djs6Z
 QYiSp6dlCSZJsfhJ6qW+X2Tq//oaVMZ6e/v58JDlSald9vmjhWblngDsJbDuElo0m4HZ6rQkU
 DLRuc3K1YpvO40I70XhJANF1HRccQrMJ/nLwlqm5b0eufa+fg1VS89HTTOzYMtrnvc6c8aSfY
 2jtesWSKpIFVeJIX/Mcu4dgXSekl48Z7hXUVrGhV7lJfrjVjqZWMsOyX+0WwBmuJRHq1MWyPl
 zdxpS475R0k1w3kcVgp+6kRteRKZvnCboHR1qw0JtQznOei7gM05Tlns70n6GCeDOeQIOZAj3
 Qld5jVQiUHZLPncumfDKoss7k86g5+EKcmSiahFmTnrTvo4s4WmR8Cu7ItuaUM0nway9ucNWq
 eOqN/bTPB2wbOL9JD17l+vSBrtPE+pO3mxeghLszPrE5Q=

The UEFI specification does not make any mention of a maximum variable
name size, so the headers and implementation shouldn't claim that one
exists either.

Comments referring to this limit have been removed or rewritten, as this
is an implementation detail local to the Linux kernel.

Where appropriate, the magic value of 1024 has been replaced with
EFI_VAR_NAME_LEN, as this is used for the efi_variable struct
definition. This in itself does not change any behavior, but should
serve as points of interest when making future changes in the same area.

A related build-time check has been added to ensure that the special
512 byte sized buffer will not overflow with a potentially decreased
EFI_VAR_NAME_LEN.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
 drivers/firmware/efi/vars.c | 2 +-
 fs/efivarfs/vars.c          | 5 +++--
 include/linux/efi.h         | 9 ++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index f654e6f6af87..4056ba7f3440 100644
=2D-- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -215,7 +215,7 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *=
name, efi_guid_t *vendor,

 	if (data_size > 0) {
 		status =3D check_var_size(nonblocking, attr,
-					data_size + ucs2_strsize(name, 1024));
+					data_size + ucs2_strsize(name, EFI_VAR_NAME_LEN));
 		if (status !=3D EFI_SUCCESS)
 			return status;
 	}
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 4d722af1014f..3cc89bb624f0 100644
=2D-- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -295,9 +295,9 @@ static bool variable_is_present(efi_char16_t *variable=
_name, efi_guid_t *vendor,
 	unsigned long strsize1, strsize2;
 	bool found =3D false;

-	strsize1 =3D ucs2_strsize(variable_name, 1024);
+	strsize1 =3D ucs2_strsize(variable_name, EFI_VAR_NAME_LEN);
 	list_for_each_entry_safe(entry, n, head, list) {
-		strsize2 =3D ucs2_strsize(entry->var.VariableName, 1024);
+		strsize2 =3D ucs2_strsize(entry->var.VariableName, EFI_VAR_NAME_LEN);
 		if (strsize1 =3D=3D strsize2 &&
 			!memcmp(variable_name, &(entry->var.VariableName),
 				strsize2) &&
@@ -396,6 +396,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t=
, unsigned long, void *,

 	do {
 		variable_name_size =3D 512;
+		BUILD_BUG_ON(EFI_VAR_NAME_LEN < 512);

 		status =3D efivar_get_next_variable(&variable_name_size,
 						  variable_name,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c74f47711f0b..62f552057b06 100644
=2D-- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1065,12 +1065,11 @@ static inline u64 efivar_reserved_space(void) { re=
turn 0; }
 #endif

 /*
- * The maximum size of VariableName + Data =3D 1024
- * Therefore, it's reasonable to save that much
- * space in each part of the structure,
- * and we use a page for reading/writing.
+ * There is no actual upper limit specified for the variable name size.
+ *
+ * This limit exists only for practical purposes, since name conversions
+ * are bounds-checked and name data is occasionally stored in-line.
  */
-
 #define EFI_VAR_NAME_LEN	1024

 int efivars_register(struct efivars *efivars,
=2D-
2.44.0


