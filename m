Return-Path: <linux-efi+bounces-895-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FD890BFA
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 21:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50913B22542
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315865B1E3;
	Thu, 28 Mar 2024 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="XWbG/r8m"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0C13A3E7
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659084; cv=none; b=rPXBrpCl75UQTXeTKM0jOCHtc+NBppjGKdNQZgy8tMl+TCucA9ZETGb2MmWZPR5HAG9cXF8VcIbEFL5m6Es16aknJpOtCakfoiWZ6yGbrBevf0bBn/Oe4tIW6cTLAZSjeRFfXmnS1L8tKGCr6ILReGvD2Mt372e3cKgPW/HjgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659084; c=relaxed/simple;
	bh=4mysez7lD1vKLQufVGQpeVDXY3KNZoEL5k6rpwnJG5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh/ljUO9BVdkd78QGSWuLLyMU7DdAtjbZWk2yP6IGyW/gH8YGvwcmIW/Mi/9ugyHXiPSuBlHrClnghgrqxoDSgggjQ6lDtqokl4rk2mBHlWQPqMJZvWXJaeeQokUuTzj77Lk1heWhwJtGBeoeL1fU5AEjd5Bbh2+pcwAxXaJRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=XWbG/r8m; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711659074; x=1712263874; i=timschumi@gmx.de;
	bh=6ORMjfkr+xilT0cm/WbOy99GHRbCruCTXAGNKgYCQX0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=XWbG/r8mWNw3uJpUhrTu8uwPTUy+cKxfQQM7VdiELk102Giux/GuKHVQAOGtw+OQ
	 tG9JUxSYUNnkLEEgSLdAbCgRUA+n5FXikFPeTfMKoErRXa1nFJuBC5mjdqs5OghbE
	 LE4tw/SnJs8CDLoL7PtzVp9taVLWJg5XC78+bFnmyIfcMOxUQtTJub9BT//zOI+rF
	 MKga/KM3BAGpEZtsQjc96+9nkI/RUz3RoYwAyPuOsSq0OYeHovBMg04jAX1keGe3e
	 Ew5KS94CIg3Lz4xA+h+oF3LJ3yKjNLQuPY0zbsnlTrBW3Gu42rIPt5kA8Sscpa2JA
	 jBrXmtHETADkop4MVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M3DNt-1rqlfL2sDV-003gqw; Thu, 28 Mar 2024 21:51:14 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH v2 4/4] efi: Clear up misconceptions about a maximum variable name size
Date: Thu, 28 Mar 2024 21:50:33 +0100
Message-ID: <20240328205041.76812-4-timschumi@gmx.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328205041.76812-1-timschumi@gmx.de>
References: <20240315002616.422802-1-timschumi@gmx.de>
 <20240328205041.76812-1-timschumi@gmx.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ik1jGDY/Ziu7GHg5hW3aufW0oiC6PQlztnSZVGMPDwxfHTW6xZU
 ZD5hNciPDMdiC/1fasAMSfmN8dGXmLcIVLcNMzwTbrVSxxAQP5+BgKanzm1GsluuGeFzJz9
 dT45QbaYXfVOMDvnivXT/gSQ7HlaXQWUPWlvkqPAB2PF3Bqoe6kOeHd5SEG/26xUNR0ZtXz
 exwmVnvWUGvsHApngBd/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+1xIh9xekeM=;a5XdEGhUcgJzCJNhWh1hZd+8GKb
 ornTuxVubP8Q+HKBZagLYAp5rbHsfLl9wBGwfOwQuWPY+OaZfE8LSStXM8yoFBVYaFIZVLnbN
 1BstD0ZOdXmydvrCMfmZIYOIfLjui48DF5lqJV9V1+85GTmv10h0J1Qr9phVGK1fUcvUUo57O
 fGM+OBNoYxv81E97FFcn7QrVmgauYjaD9BF+/nklHYPf7zqhwg3gMIbe9841h844ANhtdGigJ
 IoCQVvygKVWB+DrKbB2/atrElr9r6BkuSZUYkpiQrYjUqkzFHDY4BxC0Vh1lOLPsRe37Ll/Mc
 zqXzzZ6g4biBoPeRJQp1nx0qDGls7EQPHUkn3uIZxYFEXp5VGJAp/tdGqpcYeYjJDmT5bcDNp
 sEeT3emRD9h7kHKDe3I3qgeKJMDvB89tsihdQvNtnCFLqVFag/fDD6ptofHph7M0PjjFAwxbv
 T+PhumAFQ7eBYQgkqUKDHbSdcVENe0Zr7oh6JjUfNDkqAk6mzzqNQuNpErptsnmp2m3zC7v/Z
 0JmjFI1W+v98IB2DnlGApis7zv2LyK553Txb0gg/xGwOc51y98kKI605X3gGhxgE1jhBe3XrI
 haxba9SrDiyVkFz+WwlRvvtElHXvYIRn6WapRNTN+RfLMOXkMRudkUnyxyIfbFEKOgDE8bU6a
 Gl7qyMOUXJH9dQgkmXQLzCyN2rkWuWlHYsLQYCjmh2dnuPDz45MQWbhfd395t8pDJ2bYrbvVd
 HLDedqp7wWxc217eRozz4+YIJp5BeS61cykcSEXUksHNXb6k5cgO2M1l0MIoCcY3JN9WyCejl
 5tzmllGe0yykO0W3YMY6rw0JsQBWauv0kLJnFvFqQ5VE0=

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
Changes from v1:
 - None, resubmitted as part of a patch chain
=2D--
 drivers/firmware/efi/vars.c | 2 +-
 fs/efivarfs/vars.c          | 5 +++--
 include/linux/efi.h         | 9 ++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index f654e6f6af873..4056ba7f34408 100644
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
index 4d722af1014f2..3cc89bb624f07 100644
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
index d59b0947fba08..418e555459da7 100644
=2D-- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1072,12 +1072,11 @@ static inline u64 efivar_reserved_space(void) { re=
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


