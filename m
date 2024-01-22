Return-Path: <linux-efi+bounces-421-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362283779D
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 00:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7728B1C25844
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jan 2024 23:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024B4BAA0;
	Mon, 22 Jan 2024 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="uTeTlZ7s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA713495FC;
	Mon, 22 Jan 2024 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965318; cv=none; b=Ajxp2IJL+tTr0s9ymg4E+Bc5nPqEni2YBO/hD7LuSP2YgllqYxVka6wXYsuw7zq0fdmRiV1ixIiW1WmxHy2vAZa6hYm1F8D9PmuBI0QIdNjsqkAskmFKfupaLebQ2M8TSOV7UWv64fyCtvkxKrUxZYPgc5K8Rt7ZveIo96kTMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965318; c=relaxed/simple;
	bh=mHoVToJdg9lSsJtvh74c2XX6GXRpiszou/ybfX9aNhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xc8xxlQauzIfaBBSX2E8zSWMxZ30Skg/wtkZBaRq0dx7K4thQQNpMsP9mpO7Bm3ze2yAAcp7w5vsRyPXnFuXSULFMhJadmqDmCW4dgD0dVtOGOcew1oEX8gKr+J/f2FQ8LG2K37IEOOpwy5+M4fLjsozuKYEXWiGL5KJf/RFYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=uTeTlZ7s; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705965308; x=1706570108; i=timschumi@gmx.de;
	bh=mHoVToJdg9lSsJtvh74c2XX6GXRpiszou/ybfX9aNhw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=uTeTlZ7sGVk12V0wC9JlHFLBF5pUGqQQuJgis9a6MKyABaAPZbYd5zrDf90J3DUu
	 dq9id9j+YY/+0Lr9BI567vQ0QdmL3t6vA1pwDvBmEE2Pmqj101jmd9/6X80c1iuOE
	 r9fC5lh3qZOy6MbKiWNF4rA5ThjyUniL6CJXqVUiZAmYNOPDvUYnQCdOs+yIjJXJt
	 UqMocBvM7z+URHR8AUCqpfw6V6gCdbdCopwyWy/BIt19Nt9KJNqo0ny7x2W/qDBfj
	 mNDPMg5Z3nyUNKEqxcHpsSig7C2yQmGKcHlbqAOm/Nu2+IFlLo9MkX3JubNOByRO1
	 qvofSZM3aSz+aYUVZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.111.23]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MpUZ4-1qkyNE1Voi-00psK9; Tue, 23 Jan 2024 00:15:08 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efivarfs: Iterate variables with increasing name buffer sizes
Date: Tue, 23 Jan 2024 00:15:05 +0100
Message-ID: <20240122231507.1307793-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lbC9O+leBNej2307ZV7QzLn8/V3PfaPIB07+/RCMcAmoED0zCAc
 5jkmhg81TnZBroMV051zVhCpMEeUCn85pUg8oH5BaIC9vn8jsNkojBLijSaAoY6NyZ1ncuF
 MB02pCRsz2zjKVOk2vML1nvHH1ebiVNTBJj1tcM4oqhjASEk3fI//LdGMa4vOYXxIs5ZPuC
 bbzPnWtU6CcXuObta9qDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nkrJKBUhS+o=;4PPd/T+xEGa22Xz/SDkRgUbc5s5
 Yph4ueyIszKpcN3Zf31mDBmecLTDeDZERHoH6QBZoTqDpP7cM34FJpxwJQlMug3LJk4w0S/aj
 K+ejBeTzoqGN4xlmo0K2lHKcRmPZePYvllH0C2MD5xTz/E/rQyQICwrE4kCzTHLe4qfRYZPe2
 EkMdw5NN+n5HuWKBbaFtHdws1lNmBOtoSi4YEc00yUKx8NVvONuTpCN2jzr0vsTaP5dBQSVcn
 i6t7q49hNONaP4Jmtn9IG7NjBn3D+mDCr2orkngttZsdPqwwnEhFFqk/7sazb4k7oZ4NazXX7
 NyH7KD9Y5ZVCDCU1AfreGpgZOTYNhWjzlcMVYBBy47q3gmFBDk9BxGcjX4RoBo6nlrNQizSM1
 6HQ2z0UuLNZ99kjiS24XNRf1Ug81KLSzm2EjuPOOHUW0fTMIFvTmptIaR2hJ7ZGM90VafRwP0
 cj0AJuof9z05WSs/my6RVi8h5JN+vYYJRfQy8PQTkbMSU5aDHksAFFfYILZxIfIZ/+A+bKPn7
 6MZ6x4YjqTETz7HK1SRnQToPY7tigEtG7LkPVvjM5mFs5c9E6Gd8ta3X/FmUFG7w6lzZqKjIh
 1rRtVIMWmn94SuNh9qeTx7A0v0LnXCpJtGvA7z57OoP57kovisrIsQdOhb+QRCvV3BEpwwHjr
 +qQoTFcsS6TUMjLQdh8g5NqcfoFZPa+SnUlPxHTAl+Qx46HQ8CJOtw4UTrnCNitWJgqo+zUPj
 gx2XcVR4PdJkDNdS1TFp6j5mstCoeauLBDWbFvKtoM264r4qLxUmMeNl5etYZrwQCa/f8xr6R
 PTtr75vfl4PsGGRl2HdBbVeYfZP9cDJ+BndHrPBL53RKfmSXY/NwvaQ/IW4zWtNW2Qk5s7f0p
 LcNewYkxWdzTXkM5USGm8fo6DT0A4/vUfxNzzMeRq6ZnE5GU0KVqFgrQl+5jPs9Y7CStOzQZC
 J7uj/9s/ynKwG1lsBAq3uh7rNj0=

This sidesteps a quirk in a few old (2011-ish) UEFI implementations,
where a call to `GetNextVariableName` with a buffer size larger than 512
bytes will always return `EFI_INVALID_PARAMETER`.

It is currently unknown whether this is just a botched check or if the
length is interpreted differently, so the underlying buffer is still
sized for 1024 bytes, even if we communicate a smaller size to the
runtime service.

Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
linux-stable is CC'd because this issue (together with a few other
unfortunate non-kernel edge-cases) resulted in semi-bricked machines
when installing various Linux distributions across the last 10+ years.

The short explanation is that efibootmgr created an entirely new list
of boot options when not being able to read the existing one, which
wiped the device-based entries from `BootOrder` and overwrote the "BIOS
Setup" entry that was stored in `Boot0000`, making the setup menu
completely inaccessible on the hardware that I'm testing on.

Matching bug reports exist for Ubuntu [1] and Debian [2], they just
don't mention the root issue because I finished tracking this down only
yesterday.

As mentioned in the commit message and comment, the reason for rejecting
buffers larger than 512 bytes is still unknown, but I plan to continue
looking at the UEFI binary once I have a bit more time. Depending on the
results of that, the accommodations we make here could be toned down
again.

[1] https://bugs.launchpad.net/ubuntu/+source/efibootmgr/+bug/1082418
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D887139
=2D--
 fs/efivarfs/vars.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 9e4f47808bd5..55a1468af3fa 100644
=2D-- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -372,13 +372,15 @@ static void dup_variable_bug(efi_char16_t *str16, ef=
i_guid_t *vendor_guid,
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, vo=
id *),
 		void *data, bool duplicates, struct list_head *head)
 {
-	unsigned long variable_name_size =3D 1024;
+	unsigned long variable_name_allocation_size =3D 1024;
+	unsigned long variable_name_advertised_size =3D 512;
 	efi_char16_t *variable_name;
+	efi_char16_t *variable_name_tmp;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
 	int err =3D 0;

-	variable_name =3D kzalloc(variable_name_size, GFP_KERNEL);
+	variable_name =3D kzalloc(variable_name_allocation_size, GFP_KERNEL);
 	if (!variable_name) {
 		printk(KERN_ERR "efivars: Memory allocation failed.\n");
 		return -ENOMEM;
@@ -391,10 +393,16 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid=
_t, unsigned long, void *),
 	/*
 	 * Per EFI spec, the maximum storage allocated for both
 	 * the variable name and variable data is 1024 bytes.
+	 *
+	 * However, a small set of old UEFI implementations
+	 * reject large sizes, so we start off with advertising
+	 * something that is more digestible. The underlying
+	 * buffer is still 1024 bytes in size, in case the implementation
+	 * interprets the size differently.
 	 */

 	do {
-		variable_name_size =3D 1024;
+		unsigned long variable_name_size =3D variable_name_advertised_size;

 		status =3D efivar_get_next_variable(&variable_name_size,
 						  variable_name,
@@ -431,6 +439,22 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_=
t, unsigned long, void *),
 			break;
 		case EFI_NOT_FOUND:
 			break;
+		case EFI_BUFFER_TOO_SMALL:
+			variable_name_advertised_size =3D variable_name_size;
+			if (variable_name_size <=3D variable_name_allocation_size)
+				break;
+
+			variable_name_tmp =3D krealloc(variable_name, variable_name_size, GFP_=
KERNEL);
+
+			if (!variable_name_tmp) {
+				printk(KERN_ERR "efivars: Memory reallocation failed.\n");
+				err =3D -ENOMEM;
+				status =3D EFI_NOT_FOUND;
+				break;
+			}
+			variable_name =3D variable_name_tmp;
+			variable_name_allocation_size =3D variable_name_size;
+			break;
 		default:
 			printk(KERN_WARNING "efivars: get_next_variable: status=3D%lx\n",
 				status);
=2D-
2.43.0


