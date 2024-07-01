Return-Path: <linux-efi+bounces-1364-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892A91EB2D
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jul 2024 00:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932A11C21694
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 22:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E0F172BAB;
	Mon,  1 Jul 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8OPMiiU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68617279E
	for <linux-efi@vger.kernel.org>; Mon,  1 Jul 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874355; cv=none; b=Xhdq7cd9zG8JWv42Uex7DzsE3TwrX2CGFY82KDV1PGTjge5UjnpL69W8/ruV0P9b3NsZvLoI9JBVVmFCeK4S9HwpTAlz4WI9KWmDmAdD4ZcCwWfEwwQLD8ICUS+fGZ2RKug8xKNXvy90zOHxJZ6Ih6Zn8ckgaxQcdHIyKy77Nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874355; c=relaxed/simple;
	bh=YHwEN9j+f050/Sz8/8W326pifoB6ZGjsp+be+sSkWJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sT2KphOEe3OSuG07u/6CEgUc09i0rETWmeIZ3HP5Upp35Opol1AIEshCLFsmca6xd63ZLVPKkuVya+tJnJ/tLMNW9YECXRaLJJ1foKsi2BacSSgY+P8b0obUWIwTx+RqDSzIe0+uBH0BbQ3FzmJN+pShLhDKeDm1Xr6+jOIfzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8OPMiiU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64f4b849b7cso13631737b3.2
        for <linux-efi@vger.kernel.org>; Mon, 01 Jul 2024 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719874353; x=1720479153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krn2FFaP01Gf7w0tt8NWoS0e5If/hiQRgvGobVehr08=;
        b=E8OPMiiUhYGCZWaj2iFi7G9wAPUOvaHnl3/FTf7qruHBD84dqn5XbJvZPf0dLaYQ/X
         pizELKHjbQVcDZYqO8lj7jP/whDW+FX6mAscTFD3ChAlN49FozaMJmmD7P6N7A1f+e9M
         4xXRM619eexWOlfVgzVg3DmxbtZ9GZndT6/N1uZiSgxAixaGPWk5aM1FFrTaeP0OAwlT
         kVSZgnStKXTEELcAXKEJ21hBdryzc/M5B67fJy4Snr0/iCCn5JiaYjaiPV1direFRyy7
         WjGDBeM2J9SZmf8yimn8Kt7cZ5bjGtUkZkgMPJT25rcOBGHNMV9AvAM3WRVLSzKIHkYP
         IZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719874353; x=1720479153;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krn2FFaP01Gf7w0tt8NWoS0e5If/hiQRgvGobVehr08=;
        b=sjZZbF7HKl/+zpfEzBXtQW9N8ADXAFnluNbf78KfEF3PXlY8NNGejXd6eiipx+XMis
         1RAYDXF/DYNpSwY15dDd/FozEBKSFbBuE9XQzA+4xBOBvqyKaNm3S2NgnLgQg0h7DTFh
         nrSF7UcNjq57O5USI3GqNwjTiBCcarmdtoerUJy0RVjUUr4LtuiNKQ4pp6+Eta6IfNKO
         kZqgIqCOpOqbN6AntA3671kaqx4rJsTpvXp2aE+bBkIQeSbOwXrIQiRk2cdO/oY8z6O4
         rIn0OqiPpzXWhDyGRO3Hj7mVYRWHYLdNrATr7Orz/L81e3pnZobSEwlSGDyDY1GMVkkK
         w0aQ==
X-Gm-Message-State: AOJu0Yza0quzT2Q65m6cffdfgrHvpBROyuxBbRPT6CRKc2Nh0Ge1b/TF
	gkkQ5Ie7MqPZtu99W2XKSXm2YcA03VyZrMDr7Z+YFPRsxIKttlX02yxE3ZrIfTnuO94F99+6woC
	YdJTPUfBKKJzDWaNwYIn3oQQxV3W5UfOOM8QsH24MMh83VkOk2PdNNDtiV0Af6zBjyEkLwo+cLE
	6l1QIwcCmWHMZwdj/HOykNcvqfpA==
X-Google-Smtp-Source: AGHT+IFpbjOngKZ/nOT93FVCtI2b26qIPxcZJSKa7G2YKOjS6GyEHb1HVnRtbhNPQCaL5uq+sQUvx9IQ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1142:b0:e03:3cfa:1aa7 with SMTP id
 3f1490d57ef6-e036eabf996mr15043276.1.1719874352509; Mon, 01 Jul 2024 15:52:32
 -0700 (PDT)
Date: Tue,  2 Jul 2024 00:52:25 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2931; i=ardb@kernel.org;
 h=from:subject; bh=l9dlW8YRRsM2dq/d8cT6jilJFrbbIWvizZcn8lcTRBs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa3ZWGOae2rwc54PgQ9nWe8KO6f++6wpS3T0rUP7CnVv6
 V2aZHGvo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEx57hr8xsb/9bu0UcA2rW
 Bt+4Jlw/6ZLaYaWPUfxCEiL9RUK/VjH8Uzi9scNl6Y/ET3b3cn6tuHase5P1L/+ZefMXf5Sa/eD qNH4A
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701225224.2686901-2-ardb+git@google.com>
Subject: [PATCH] efistub/smbios: Simplify SMBIOS enumeration API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Update the efi_get_smbios_string() macro to take a pointer to the entire
record struct rather than the header. This removes the need to pass the
type explicitly, as it can be inferred from the typed pointer. Also,
drop 'type' from the prototype of __efi_get_smbios_string(), as it is
never referenced.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64.c   | 3 +--
 drivers/firmware/efi/libstub/efistub.h | 9 ++++-----
 drivers/firmware/efi/libstub/smbios.c  | 4 ++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index 446e35eaf3d9..e57cd3de0a00 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -39,8 +39,7 @@ static bool system_needs_vamap(void)
 		static char const emag[] = "eMAG";
 
 	default:
-		version = efi_get_smbios_string(&record->header, 4,
-						processor_version);
+		version = efi_get_smbios_string(record, processor_version);
 		if (!version || (strncmp(version, altra, sizeof(altra) - 1) &&
 				 strncmp(version, emag, sizeof(emag) - 1)))
 			break;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 27abb4ce0291..d33ccbc4a2c6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1204,14 +1204,13 @@ struct efi_smbios_type4_record {
 	u16				thread_enabled;
 };
 
-#define efi_get_smbios_string(__record, __type, __name) ({		\
-	int off = offsetof(struct efi_smbios_type ## __type ## _record,	\
-			   __name);					\
-	__efi_get_smbios_string((__record), __type, off);		\
+#define efi_get_smbios_string(__record, __field) ({			\
+	__typeof__(__record) __rec = __record;				\
+	__efi_get_smbios_string(&__rec->header, &__rec->__field);	\
 })
 
 const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
-				  u8 type, int offset);
+				  const u8 *offset);
 
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index c217de2cc8d5..520c9079717a 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -38,7 +38,7 @@ const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 }
 
 const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
-				  u8 type, int offset)
+				  const u8 *offset)
 {
 	const u8 *strtable;
 
@@ -46,7 +46,7 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
 		return NULL;
 
 	strtable = (u8 *)record + record->length;
-	for (int i = 1; i < ((u8 *)record)[offset]; i++) {
+	for (int i = 1; i < *offset; i++) {
 		int len = strlen(strtable);
 
 		if (!len)
-- 
2.45.2.803.g4e1b14247a-goog


