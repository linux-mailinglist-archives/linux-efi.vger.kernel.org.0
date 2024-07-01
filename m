Return-Path: <linux-efi+bounces-1355-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0812991E1E9
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898861F24822
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352C1607A8;
	Mon,  1 Jul 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaSOMf1Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482916087B
	for <linux-efi@vger.kernel.org>; Mon,  1 Jul 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843036; cv=none; b=H4XNtvZhofPkDa0qWVrWL2eGK2NLRoqNAiL65c3QEWmGKURq/6PR0VnKM47tHAph1HfaLmiAc0g16sxOHRtBcNhqYSZQwthUr6BvHy2l7EJZDFqr+0kPqjqSorASs3tBGspDziMWFyzqYw93CW2N2rd3RPuhUDxEk1caEgQg5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843036; c=relaxed/simple;
	bh=l8Ualwom2J8JwCI+Zf8Aiq40+waFGySB881xmXf1eP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iGohQoQQcONqdxQ1c+Y6Ixp4VumcYmqsUifRNpdUrj8D/nfXOaqUqGHr6zQNcsMEpGcgKDgt/hPd6luMteRuIgnU+SD/Gmzdrxgf/G6wCzJq8zcikP92n71dnofzaq80/wtMznXQHr+a68Frkmi+aWYY3dok8ttfB1jCbt2iza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaSOMf1Z; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-36735fbac94so2230817f8f.3
        for <linux-efi@vger.kernel.org>; Mon, 01 Jul 2024 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843033; x=1720447833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83i245u7toDjlY+7ig/slTXd44Gu7U3/g62W19tTjqs=;
        b=TaSOMf1Ze4qJtVkQ2EDWUg62mQISgEkefASkjQgQhpBeIkOzsdjHHyKBrEUduVcF4q
         XTqFZIWyhiN8ZGdweM82mqHqw8mUlRUBDUOH9C7ylz6H558EBvvSlJAfIqj/zziX0KHp
         owMs6pPN8BFaTo++TOFsFRdWyQWGGzlZhxCnnNaX3zbRz1+Ht1ObgN8YlSnk8y+DqoU3
         9Yga3HA6sF1Mx20K8Ky/D0cRFcduwmnDv6iNFsHqGMqoHqvWa033ri+8NjXv7J2+Irw1
         lN1HnCsaT22MfCgKe7qj3vAaT7/R/Ql0amm9O0zzhMjzNG8Mk53sX9yjtDTY3acrXNdm
         inVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843033; x=1720447833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83i245u7toDjlY+7ig/slTXd44Gu7U3/g62W19tTjqs=;
        b=XsC+scLWd2K8s2YvQLkipvjYhuaf7+xRqrsvbr1v0xK1OvP8VVypGoKr9LPl+ZIOI6
         +SJu2hBlYzY2+juKhl/EmNz2wV81qbAik4jeio5UuJvIKMwD69Kbc47HuMt8kpClogKX
         d8hoUv1ps7xY0imAQsOCfc3zrck8ePO0ppIG/p/H2Gu5Q+W43lHZ1CrMC/Kv09N6YPOl
         z6iFSiqaEt5JwiVvsLdOBGdDhunUNb6TYKd7P88/tdrId5e2eNflkERqJ3cQZ1n3fqB0
         JQksHDyMYdARJOdvv87kaiE2E0R708diNAO/2Sk19SsGs48DAJSFYnY9wQZyGomvNVYy
         cZ4Q==
X-Gm-Message-State: AOJu0Ywjmy9JQAFpzi+86oa502qtknOqJKSI9VlgTzq2i7qMsH+YKlny
	RptITSRvSHrNRRvyRd1LRyWuBV1/sXCXRjv5xeQpLriwQk0h6ByzQYHc1eqmMv+lA8QorY+sghM
	l7g5PZT5BByQnssn33Y/nR20ZBprHgIcnr1iTdO/6mK8eofWreMh41Ed5e1NTZcIK6aW8wkHfb+
	eOzXKjpOOzlV16Cr1J88wTzeNjew==
X-Google-Smtp-Source: AGHT+IEyUOS2qvddIR+vf8YFoD0CSmbKuw1dZ0cB+7G6AtRCr17Yg+XzRC0+YIDnxu724eN8PT+xfzKd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:d91:b0:35f:195f:bbe8 with SMTP id
 ffacd0b85a97d-367756b7e8bmr10484f8f.7.1719843031971; Mon, 01 Jul 2024
 07:10:31 -0700 (PDT)
Date: Mon,  1 Jul 2024 16:09:42 +0200
In-Reply-To: <20240701140940.2340297-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701140940.2340297-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=ardb@kernel.org;
 h=from:subject; bh=rpn41rOAt7Mo+ERBc+rJJUgNYcPSipWWVF2TfCtIHfY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1px7KSOI3Gxe3S617Vb05fwnTR2fml8n2F9fVSDhKZy
 uY8ZakdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJ8ixj+e+Q9mfZoizRP8JG2
 SoZLq2zv1MlrFEtv8d+5rGuX8CRFLkaGF57f1hVEreD50nbwySSLt6U6l9fx/5SZsnLdj71diYr feAA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701140940.2340297-5-ardb+git@google.com>
Subject: [PATCH v3 1/2] efistub/x86: Enable SMBIOS protocol handling for x86
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The smbios.c source file is not currently included in the x86 build, and
before we can do so, it needs some tweaks to build correctly in
combination with the EFI mixed mode support.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile |  2 +-
 drivers/firmware/efi/libstub/smbios.c | 42 +++++++++++++-------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 06f0428a723c..1f32d6cf98d6 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -76,7 +76,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
-lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index c217de2cc8d5..2b54b9c289be 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -6,30 +6,42 @@
 
 #include "efistub.h"
 
-typedef struct efi_smbios_protocol efi_smbios_protocol_t;
-
-struct efi_smbios_protocol {
-	efi_status_t (__efiapi *add)(efi_smbios_protocol_t *, efi_handle_t,
-				     u16 *, struct efi_smbios_record *);
-	efi_status_t (__efiapi *update_string)(efi_smbios_protocol_t *, u16 *,
-					       unsigned long *, u8 *);
-	efi_status_t (__efiapi *remove)(efi_smbios_protocol_t *, u16);
-	efi_status_t (__efiapi *get_next)(efi_smbios_protocol_t *, u16 *, u8 *,
-					  struct efi_smbios_record **,
-					  efi_handle_t *);
-
-	u8 major_version;
-	u8 minor_version;
+typedef union efi_smbios_protocol efi_smbios_protocol_t;
+
+union efi_smbios_protocol {
+	struct {
+		efi_status_t (__efiapi *add)(efi_smbios_protocol_t *, efi_handle_t,
+					     u16 *, struct efi_smbios_record *);
+		efi_status_t (__efiapi *update_string)(efi_smbios_protocol_t *, u16 *,
+						       unsigned long *, u8 *);
+		efi_status_t (__efiapi *remove)(efi_smbios_protocol_t *, u16);
+		efi_status_t (__efiapi *get_next)(efi_smbios_protocol_t *, u16 *, u8 *,
+						  struct efi_smbios_record **,
+						  efi_handle_t *);
+
+		u8 major_version;
+		u8 minor_version;
+	};
+	struct {
+		u32 add;
+		u32 update_string;
+		u32 remove;
+		u32 get_next;
+
+		u8 major_version;
+		u8 minor_version;
+	} mixed_mode;
 };
 
 const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 {
+	static const efi_guid_t guid = EFI_SMBIOS_PROTOCOL_GUID;
 	struct efi_smbios_record *record;
 	efi_smbios_protocol_t *smbios;
 	efi_status_t status;
 	u16 handle = 0xfffe;
 
-	status = efi_bs_call(locate_protocol, &EFI_SMBIOS_PROTOCOL_GUID, NULL,
+	status = efi_bs_call(locate_protocol, (efi_guid_t *)&guid, NULL,
 			     (void **)&smbios) ?:
 		 efi_call_proto(smbios, get_next, &handle, &type, &record, NULL);
 	if (status != EFI_SUCCESS)
-- 
2.45.2.803.g4e1b14247a-goog


