Return-Path: <linux-efi+bounces-893-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE7890BF8
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 21:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0320D1C31541
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDA12F385;
	Thu, 28 Mar 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="Sgaaa3RK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116F13A250;
	Thu, 28 Mar 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659083; cv=none; b=eHb3ptQ755f5+BnUHp/kVfsXZse6EGLkER5MXdc45Zn/JBm9pnzsKH2Lf2eEqwCAeu7tY1Fa3aBFKofzEUcsWuMN8Eti/jUxbSYxMYi7LL8n0fqDRHorVdxrc9oc4/WJBsbzKgqxgQCcrlRgXazHkMPd47X10Z6iI67E+X6jtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659083; c=relaxed/simple;
	bh=kEP8nmkOk4QJmLgse+4tccjONBlM45t9m0YZSjoDuGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgOdXsVoyZUJ8szNk7Hpi2YRYDsGYK9fqIpTlAD/dRtuBp5JjQiypN1XvPgPlD+eVrrayBopxbZxWzvvJTjb1MhNgoixZbWf3sck7qqsIQODjCnD/jPwQuODkEYIhWoa6Xkzf/ugrE5G2CvOGN9J5DPwJuOLHOUTpLNk0QLH8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=Sgaaa3RK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711659061; x=1712263861; i=timschumi@gmx.de;
	bh=HJHQk3LZIdKlpZNpET9Lr1IlYEfzNZsX8njffaK3JXs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Sgaaa3RKB2SPP3FiuDghk9nZ9/qZ0oXxK055369YgkIonrSCvwHNVuaOJP/5IuZO
	 /+suq0pdlJhVW6tdfwa+1b/stJh2C5UNCQsOpjgw6+lVc8X9kQtwN9+X0AJPE3GYy
	 Z/VIWnJeg9r8Vq8IlsfUQ6bN2WIfrditCeDEqmksBr/rBm45yM/OJ1bXRppGkt0VY
	 fsOu1GzVZuaWQpxZZMlrTDbHxMViqbag1/TOyIM4K6S4MVk7Y9BwQEs+UjpKqwWrG
	 ditb8ulPoEpbwGpnQGJKlCvitMgBA7ln/bvf9SPQIeFm4tedpg/XBfKqjH9xDEyVC
	 Z0RkMrxzASAWrPT+pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MAwbp-1s0hHI1C01-00BLok; Thu, 28 Mar 2024 21:51:01 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v2 1/4] efi: pstore: Request at most 512 bytes for variable names
Date: Thu, 28 Mar 2024 21:50:30 +0100
Message-ID: <20240328205041.76812-1-timschumi@gmx.de>
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
X-Provags-ID: V03:K1:F1wxBJQKy4dnK5cIOi8lgWEi4TGqi9qGOVLBCK8sYoCD1nUQ4uE
 DuNt93KLDs4rSSeGOcUZigEytD/dTHBDKN06qQou9PUUFswfxyB8b4wYSshfxbjl4PnYEnS
 RudB5zriVpRpncv1MFfkRYrh2fDLarPrDlMPJVCog+awg4uoVB+BO5wsbCq6tIOirZdWwJt
 QG9oNfeb8qAYaoS0dzFOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LpIuViflScA=;LHZQv8hTCInRamLh3u9+E4LIQLA
 8NaHLDXxZf1fr7uNiDOwNBPvAO3lumKbpoo7/XvY+JcfEbaMEhhyuUDiJoe+F8o6K9fcHAwVW
 ClJB9Qf3KedfGLH5xoKkCLDdjCiD3WQTnVVLHkeoRBrom2X+1oyDKQ9PHt7qe3CgQ/fq6dL6m
 SZ6Cx/z+ps8+OmhlYZPu/ngT0LI3DYCN9J9DGdqBxj9eIQUMMsZ+h1h6OcnmhsrWVcDuS5eAa
 lfHKLU+8SMO2UKpaEvQYF2rVmGwXJNqFpTuei/MZ+RdAD5sYpqFvZ5nuHPr/P0qMmrf2ovuQt
 lmHg+U+1cdKwdSSZwrLWaG7PJ5Qo15/1YKlAFpHeArqwA8iqG+TZMUnBzD2ScPUEEvQuHtHDY
 kL6MedULDyLZSd2DdPePjBdxEor2noPwlVx2OFWCQKWYl7vQtGs/P7VDTWPiQRnjDD6xhMEtz
 Hf3tjQw0B/132uNRotR7JCrfsQkKYm5mc0zlk0TB043WIS5RChyORqpxLEOqQxyF8gtRenvwU
 fDMeUT0vjz9QzYtd96CBM1AupH/zkeytRdtldMmksRblSPJjI+n7GAiu9ApmnzYKxqSL8R2bD
 BJ4YfEf9nC/O95TYfpXGHQdIjbFoQOego0+CzMJnwhwTKiYrlhb1GkCnaYaoQq7fXmO04suuu
 JWTAuytwDkxfw3ByvlA4iVuLtKCG4S+MEKYq69TGjLV/DDB27TB3RLHPI08bLir6Xuc/1Z8lh
 Kbwo9RQRGLVmWzlpxopNlBKhn4l+MbmKLcNAgw8B07IMSJdvZA3MTug3oO9Rjimo4J39XwBap
 w5yZZ/kxSeHDeyQ5y123XkHZ3A3ODb5h1xwd3gNtwBCnU=

Work around a quirk in a few old (2011-ish) UEFI implementations, where
a call to `GetNextVariableName` with a buffer size larger than 512 bytes
will always return EFI_INVALID_PARAMETER.

This was already done to efivarfs in commit f45812cc23fb ("efivarfs:
Request at most 512 bytes for variable names"), but the second copy of
the variable iteration implementation was overlooked.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
Changes from v1:
 - None, resubmitted as a part of a chain.
=2D--
 drivers/firmware/efi/efi-pstore.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-=
pstore.c
index 833cbb995dd3f..5b9dc26e6bcb9 100644
=2D-- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -162,7 +162,15 @@ static ssize_t efi_pstore_read(struct pstore_record *=
record)
 	efi_status_t status;

 	for (;;) {
-		varname_size =3D 1024;
+		/*
+		 * A small set of old UEFI implementations reject sizes
+		 * above a certain threshold, the lowest seen in the wild
+		 * is 512.
+		 *
+		 * TODO: Commonize with the iteration implementation in
+		 *       fs/efivarfs to keep all the quirks in one place.
+		 */
+		varname_size =3D 512;

 		/*
 		 * If this is the first read() call in the pstore enumeration,
=2D-
2.44.0


