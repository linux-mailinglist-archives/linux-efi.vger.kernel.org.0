Return-Path: <linux-efi+bounces-1388-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E992CF2C
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE4F1C239A1
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C3194AC2;
	Wed, 10 Jul 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkDY4/4d"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE0190068
	for <linux-efi@vger.kernel.org>; Wed, 10 Jul 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607110; cv=none; b=lEl0dZkHBt96nHlGsomKe0ke/GgN3PtmrtBcuZjmDWMMeWEyr2qiD88n2OBejgahEZZ79fxRHcCXiA/1ks2s46XtgZNK2maA5jxuyE8hRSwEfXITZs4g1KR9ofpX7HMTTboAmjX+HQHu+2+H6SO4MHJQ4ad4eqC8ZPJ3whCar+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607110; c=relaxed/simple;
	bh=IUQz3WFiMyo4YbjsJ71LerMQIUmSovKy5Wgnr+29kok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pq44jShcpvx/DwsUNV8pq99VbZ6TgWgxT5hkPDksqRkRSJ/49xL7YKg8C9uyzjqfgyz+eFhDQLDa2ZPreStUtgleafiuotEJreMNviHnF2rNzoB4n8uB+oX5XHCC2E2ozAxF4hhXImwHLbsPtTrVb3Foix9f4O9qrH0ndTunT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QkDY4/4d; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3678f832c75so5397602f8f.3
        for <linux-efi@vger.kernel.org>; Wed, 10 Jul 2024 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720607107; x=1721211907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPXW48f67Pa0QiqVTCj6GbxY2tThjJ1etEujTn4sqv0=;
        b=QkDY4/4d2GSpf9mR5BjxD96k+Q/X21f8/4kQNhLeFcms0id763+5Qcd4fCfPzwH+8u
         ypoOHwCWzrw7qOr4AwMtW1teiUsVEPGOW8wlQ7nPjqRgtE4GI8We4m2dNJJg8p31moF2
         ascUEyH4qQjVjxmBIJTmaxEPMkzv6u2cwn75FJzT0Fj6q7B3fDi7E130Lxo8xWqNUOw8
         C0ZO1WLWTisicTTklDvIwxmc4J4/v33SQWm3urIq2UAlmVo7393KVZpY/AGHiDbKzjoi
         QdX8hlaM+Cfm6UJNK7EiWoZYlrAQsZKI3rTnuqEXAbAFQ7grD3qdytqOM6Z4bqFShfZN
         SMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607107; x=1721211907;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPXW48f67Pa0QiqVTCj6GbxY2tThjJ1etEujTn4sqv0=;
        b=uhqtX4zb7t7ajAuhrqnTqsREk9Y/nfSnTPy5T+fk+iXRIpUISR0uAe9hgxwOmjbcze
         ZxQEy3UtHTp2x5GXmEpko0fSpNNY+vW4HddELz+uj1xKtCJowCoDLwNPDTj56w6g174c
         EBPaQeZr6vna9ySA+ILvdjzWRG2JhLEWL7Nopoiilgvevhg6DoNG2b2fLI0sqZ/eb2Ub
         KI7jaFjgK20qyVyWcb59i8lvWhvGOtkJ6fdbZCqm4vSi1h0p9BEs+bROz9AsqBeWC9L9
         PcOOkATOUqbgihZiFxCTrJN7ou5Nwr+uvLHypGLwgFmx+3HmuGHa/3BS4Xxtwvsh7ke+
         JAzg==
X-Gm-Message-State: AOJu0YwmJiqZHdJ8U0U834XQ/uzlywxMoWdUBTIIE6nuk90oZzXwUsCu
	XcYSlHDTdAkc+awX8cKifBNOUQZiFWyZEs96s+pJoeE5YVGYbm0CHmkWyX+pOMY6K4U/o162QL3
	8lQ1GXjpnqYxahXbTfv0eIzg6gsN9iWrpk/2Z/3uNHpcf8REoDC5Ozfwu6O13DxMlQsq9uMG+BL
	mGzul1qb+Kdsd+e6Vm4R4jFQsRcQ==
X-Google-Smtp-Source: AGHT+IGUlnl5DcAoi2r0D4SHqlEQHTFSJK22D9ObIYuZQFjnBq/V+jwopX2FqOuY2EUP5xRXw3UbNSwF
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4b4c:0:b0:367:93e3:de8c with SMTP id
 ffacd0b85a97d-367cead9101mr8956f8f.13.1720607106565; Wed, 10 Jul 2024
 03:25:06 -0700 (PDT)
Date: Wed, 10 Jul 2024 12:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2809; i=ardb@kernel.org;
 h=from:subject; bh=MLqAsukuCsxZ4EXXdyPffLg3nS/XVin6b+uSFaXodJM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa0vsf7N+3eb+n48O/XH7se/JSbntmQnXxGXf73TUEhIy
 3pOS+LSjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARm60M/zTNzq4WCpFr2igt
 JazCaqe460L7h/Pz2N/1nQqLXPklfiojwwXp+c6M5+c9jlO7tWFbt3zfkd6JTbM++vCelLNdF7F YlgsA
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710102502.3198917-2-ardb+git@google.com>
Subject: [PATCH] arm64/efistub: Clean up KASLR logic
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Clean up some redundant code in the KASLR placement handling logic. No
functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 13 +++----------
 drivers/firmware/efi/libstub/kaslr.c      | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 452b7ccd330e..2c3869356147 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -21,7 +21,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_loaded_image_t *image,
 				 efi_handle_t image_handle)
 {
-	efi_status_t status;
 	unsigned long kernel_size, kernel_codesize, kernel_memsize;
 
 	if (image->image_base != _text) {
@@ -39,15 +38,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	*reserve_size = kernel_memsize;
 	*image_addr = (unsigned long)_text;
 
-	status = efi_kaslr_relocate_kernel(image_addr,
-					   reserve_addr, reserve_size,
-					   kernel_size, kernel_codesize,
-					   kernel_memsize,
-					   efi_kaslr_get_phys_seed(image_handle));
-	if (status != EFI_SUCCESS)
-		return status;
-
-	return EFI_SUCCESS;
+	return efi_kaslr_relocate_kernel(image_addr, reserve_addr, reserve_size,
+					 kernel_size, kernel_codesize, kernel_memsize,
+					 efi_kaslr_get_phys_seed(image_handle));
 }
 
 asmlinkage void primary_entry(void);
diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
index 1a9808012abd..6318c40bda38 100644
--- a/drivers/firmware/efi/libstub/kaslr.c
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -18,8 +18,6 @@
  */
 u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
 {
-	efi_status_t status;
-	u32 phys_seed;
 	efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
 	void *p;
 
@@ -32,18 +30,20 @@ u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
 			       &li_fixed_proto, &p) == EFI_SUCCESS) {
 		efi_info("Image placement fixed by loader\n");
 	} else {
+		efi_status_t status;
+		u32 phys_seed;
+
 		status = efi_get_random_bytes(sizeof(phys_seed),
 					      (u8 *)&phys_seed);
-		if (status == EFI_SUCCESS) {
+		if (status == EFI_SUCCESS)
 			return phys_seed;
-		} else if (status == EFI_NOT_FOUND) {
+
+		if (status == EFI_NOT_FOUND)
 			efi_info("EFI_RNG_PROTOCOL unavailable\n");
-			efi_nokaslr = true;
-		} else if (status != EFI_SUCCESS) {
-			efi_err("efi_get_random_bytes() failed (0x%lx)\n",
-				status);
-			efi_nokaslr = true;
-		}
+		else
+			efi_err("efi_get_random_bytes() failed (0x%lx)\n", status);
+
+		efi_nokaslr = true;
 	}
 
 	return 0;
-- 
2.45.2.803.g4e1b14247a-goog


