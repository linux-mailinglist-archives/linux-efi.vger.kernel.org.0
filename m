Return-Path: <linux-efi+bounces-826-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FC587DC42
	for <lists+linux-efi@lfdr.de>; Sun, 17 Mar 2024 03:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341971C2087B
	for <lists+linux-efi@lfdr.de>; Sun, 17 Mar 2024 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A06E291E;
	Sun, 17 Mar 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="jbP8vORH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1913FD4;
	Sun, 17 Mar 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710642878; cv=none; b=aECV4B3O+JpXiIzvuYGMgLX/f9z9MNSSmU2yCWsW0sP8nOVDZ+iBux9vIsWBMbalijDfiOs8NUNw44KiDJTA4mGfKxKWUeNC6ia4bC/B35LEe6gnGmD5vWh1Wq8qyjE1NJSPK78KyBom+4dMMt3zOSyksdCnRW1YUKyEsEu+frc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710642878; c=relaxed/simple;
	bh=tJaJJred577vOPsMHOBTK5Cf+xg/GJMJBBCtaPnAhe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BN4ei6EZcqLhSbO8c7vCbsdL7oBTjsZ6JHXu1EYa8eSaBrL+3qNAFoWFPjzKHb7mesUOm6gIux+mQo6KHR3hyEkRK8Na+eXcWDXVUgi0elcQT8tTd/Aq+DXODrheI7JqXlBryw+p7g7x4kZL2ibQFGzjynhddBuPdxrSLJ5V8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=jbP8vORH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710642862; x=1711247662; i=timschumi@gmx.de;
	bh=Iu6Ea+P0wgKVpCTinPs8NLQRA5oz6QwOGeGWv+5ybOc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=jbP8vORHe/rye1XpqHn3c1RT/FVw9OQT0IbQYIyUW1ybS9GRI6qkFH73NzbpJvo/
	 C6LhgK6BKc+oDIKpgUyR8yMi9eAd0KJwt1PZxImIWV7E4wIJeXvukGeU+/bfrDa0y
	 xKauwRhRatXkT0vbHt+CE6Q3y5UzTdjqQsTP9zFPt2k38cIMHEjaFwnCQwPCe/fAz
	 MBgWcVfOAYb38GkbYcR7SBke+TRs9vRzJlqV13CCdIWt8szic+6QY1iyU56636Rd6
	 TOPykGkVBH3TLTLUMn2fdF5NidBBy0K5y083NoNN2e2od+ul/yKHMKdqXJb9By4lC
	 6HLJeF5Kns1UQsgHbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MQe5u-1rNwRE1Rzi-00Nh92; Sun, 17 Mar 2024 03:34:22 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: stable@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH 5.15-] efivars: Request at most 512 bytes for variable names
Date: Sun, 17 Mar 2024 03:33:21 +0100
Message-ID: <20240317023326.285140-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z9uILynzNQSbtsP0jTPtpxumGN+ynNPSCCW9fpqKdTfYljrJD9e
 e0UJhDXfwPj3YfsFKJllz9Do1SXmfOIYBaA6Q3jXOuVNm7drbe6MaSXgY4jydxnvdL+4hu5
 ZHiwIpNjFUiI56eS7HliYVmo6A7vSZHkzjqPw3sSG9fM2Q6AzAwcY3kNl5gV6CDGaPjFykq
 bSgi6AyRk49y6nw2W/2ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sPxOwSC3jcM=;M1io3FQv+xJwGp0tmiXmQ/s6zBL
 39UxB/QcxHbg0gG+eUaiLet51m0SjD45q7/5jKpKYM6bIeGtNu8q7FtxoKGpuLlu25b2L5CbY
 rUt54uBaRM5sfpBfKtL9zMYynHO4Mpb8gPWm9mg5T48VaxTWtCSZ/1km3fpejkkwJafxfnqNF
 UWXtdCalOl/DMrzYhECauyPxPCKOL3sVVtTrPGZ+VsnRWLYwqJfMvBGk5WH0V+aLoLbm4NHQ7
 C28H+0Sg2Hh6/ce1FUp/3hB8oITrA7S1dmlRA2CyWBdjOmDGtCV2t6I+vh3mAKUKEmYFdfFFq
 IgRUIIXAJTXDbw4VwibuGo1J+Lp1k+l7na1kLcIILtoov28ehzjxpoQIbDYiO5AjKAo+KA1ey
 CdzyIvJL26tuAw63swIw90s0VNhX4UhjyKrWaKgEh3ETfB3i5UDnxoSz2Iayv5kWYjhd41fXl
 +Ha/CjbNl+0AQS3HFS5ugAmutxEnLZ8okpv1dx4NkWqNhDSGCXgcyWKXJPCLxT5RMiUIlQzPm
 +JydaPZb2PSAF/hokNiJtoysgfR9RvtnmygtyMAE0sFEPfXTUEwWONmzHJSkxEEi+qtfythgg
 WHeiOohrGBesnsShHeJrGgYnoT37McuDFuf5aQTaizEsS7nweFZDvT6vG1FoBsrzcg1VnqUxl
 itFViq+lhj424KSICvuKAHhDM4KW/Pyl3zvguj2gk4eC0PPIfZcSMMCigGsz7h/D9iTP1llKM
 Mw6bU1EbkL01wbmzTUKMKvK6W3SwmFMqwi81vHOwwyjbn8duLZaHjhe97URnE7mugl5qjBRGh
 ad2tiORM8S/MWbi/b2ZitCwoKLMawMX6/GS3wDWzrCTdY=

commit f45812cc23fb74bef62d4eb8a69fe7218f4b9f2a upstream.

Work around a quirk in a few old (2011-ish) UEFI implementations, where
a call to `GetNextVariableName` with a buffer size larger than 512 bytes
will always return EFI_INVALID_PARAMETER.

There is some lore around EFI variable names being up to 1024 bytes in
size, but this has no basis in the UEFI specification, and the upper
bounds are typically platform specific, and apply to the entire variable
(name plus payload).

Given that Linux does not permit creating files with names longer than
NAME_MAX (255) bytes, 512 bytes (=3D=3D 256 UTF-16 characters) is a
reasonable limit.

Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Tim Schumacher <timschumi@gmx.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
[timschumi@gmx.de: adjusted diff for changed context and code move]
Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
Please apply this patch to stable kernel 5.15, 5.10, 5.4, and 4.19
respectively. Kernel 6.1 and upwards were already handled via CC,
5.15 and below required a separate patch due to a slight refactor of
surrounding code in bbc6d2c6ef22 ("efi: vars: Switch to new wrapper
layer") and a subsequent code move in 2d82e6227ea1 ("efi: vars: Move
efivar caching layer into efivarfs").

Please note that the upper Signed-off-by tags are remnants from the
original patch, I documented my modifications below them and added
another sign-off. As far as I was able to gather, this is the expected
format for diverged stable patches.

I'm not sure on the specifics of manual stable backports, so let me
know in case anything doesn't follow the process. The linux-efi team
and list are on CC both for documentation/review purposes and in case
a new sign-off/ack of theirs is required.
=2D--
 drivers/firmware/efi/vars.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index cae590bd08f2..eaed1ddcc803 100644
=2D-- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -415,7 +415,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t=
, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head)
 {
 	const struct efivar_operations *ops;
-	unsigned long variable_name_size =3D 1024;
+	unsigned long variable_name_size =3D 512;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
@@ -438,12 +438,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid=
_t, unsigned long, void *),
 	}

 	/*
-	 * Per EFI spec, the maximum storage allocated for both
-	 * the variable name and variable data is 1024 bytes.
+	 * A small set of old UEFI implementations reject sizes
+	 * above a certain threshold, the lowest seen in the wild
+	 * is 512.
 	 */

 	do {
-		variable_name_size =3D 1024;
+		variable_name_size =3D 512;

 		status =3D ops->get_next_variable(&variable_name_size,
 						variable_name,
@@ -491,9 +492,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_=
t, unsigned long, void *),
 			break;
 		case EFI_NOT_FOUND:
 			break;
+		case EFI_BUFFER_TOO_SMALL:
+			pr_warn("efivars: Variable name size exceeds maximum (%lu > 512)\n",
+				variable_name_size);
+			status =3D EFI_NOT_FOUND;
+			break;
 		default:
-			printk(KERN_WARNING "efivars: get_next_variable: status=3D%lx\n",
-				status);
+			pr_warn("efivars: get_next_variable: status=3D%lx\n", status);
 			status =3D EFI_NOT_FOUND;
 			break;
 		}
=2D-
2.44.0


