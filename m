Return-Path: <linux-efi+bounces-1700-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F8F974FE2
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D101F24B48
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D0185B69;
	Wed, 11 Sep 2024 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/WdMfc0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD30183CDC;
	Wed, 11 Sep 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051276; cv=none; b=g8W2rfdM2YP00d0Uz5xiE/OzthDbHGBweDKx6RfDDY8gTAbLfsvGAKCno/XcOflG+PRgOikq8L8cAbChonMIGFqBxG9YAwnQsnJGPgJTsMJR4+4frftwRTAkEit96f6Ya9w8Gds0ZnL0fpMfNKLWbP54MC+PKy/dshghvxD62fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051276; c=relaxed/simple;
	bh=Y25nuwt5Otrb49AxY8SF8uz2V3mapMpkR6GGCfrXIaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2YW59iZmAVDl6zcQYKlJQUG+40F+f3q25nEHhAOLz0wMl7ffA3zmiRQjAypyc1SMqkL0UZlyaL2kRfJlfJpxbfVvAseB40QI2Zaw/G4g0M7+NJFLIF7P8RnUfdPVnM5sQ37MQExQkpsw6yAcUR7xgfdjACnVfxf+sz4r6TOZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/WdMfc0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9aec89347so224111085a.0;
        Wed, 11 Sep 2024 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726051272; x=1726656072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1edNQlk5ea4r0KquDgZgNfAFToaTDxkGFM4S8J4/mCg=;
        b=g/WdMfc0NSiVah7szHplF+CtgSTeL0bFD5vX/xt7zohW6NTixdlDVcl8q7Xm7e8Ihb
         1MBYgYh9hKR7Z9ijKuuDiq7wL6OOVZmLMPzNamLDWgP9Dy8jp0eA2ZjbIZSH6u7bBWWF
         oC3OKuAx7xCPtDknkgcm6o7mqnk1edv6p9fc/mPexAyQ9I1TGgTlvv6yw+KZLNYl2BvX
         uZwwIcuhsf6YE/mMkPmC8+kNQXJmTjWlwxwUKMv3DpZ7KMsN0WT+wElzoLyvh7uH5xv5
         hLyEAJM6sA4VQk/SUQs8eF1BJPSVejmoYflLDFvi/CZWA3LzjrZT2zcMKfc3OeJjh3ya
         ERdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051272; x=1726656072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1edNQlk5ea4r0KquDgZgNfAFToaTDxkGFM4S8J4/mCg=;
        b=Wn91JsAFhc+cAVFtx3M9b716nEJgKhf9Os4cos6OGIMUdtCuIYu9Yk2APVbLPZC07A
         B2i+0lcxfC72M9dQtRPLkegwtRdbI3F7Fmdl1RnX/mGzTFwLhDxYnW8jn4n9hvkP6H9N
         qN2HQKc5WiH5zCtaIkMK1IsErSYJhTh5lvRhbgk7l6wG3TFLHHP83oEIbTqwmoPzmVnh
         ALVY7rX47idF468fYtlctEsTa8F8PQKJrvqPpHsMu7L/KgWaMQFR9EMD7EGQNTXM76PP
         9nyFfz/MYiGDm+BtRNRsGfTV3rcA9j+GF+OY3goUTOrqL4MWTD+yEODWOz0OmFrPKn04
         uUiw==
X-Forwarded-Encrypted: i=1; AJvYcCXnr7IcmEfB3YYGVOy1FUXkiW+noQ+t5s2vTroMYLVVuxdRinnvfAxDQ8+sj0qqy72YzKCbdVcm8qwzoig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJw12CV40bk1DdvTcrkY4uKCoT0Mus9pvFOc9t/5LryFOuRrqW
	rVDfdP1emj9U7Mt+BlC64nENlsc0Vfs26R60QvwfGVeOn7Gg5asWwZeyKA==
X-Google-Smtp-Source: AGHT+IEAJQ13VovN3MOTS+6Hjw3x8lAetl1VfnJ5y1/hS1UwpDsIO/+d03FxCjNQtSx+nHmHmIIoDA==
X-Received: by 2002:a05:620a:294c:b0:7a3:51ed:38b5 with SMTP id af79cd13be357-7a99727cb11mr3087991685a.0.1726051272264;
        Wed, 11 Sep 2024 03:41:12 -0700 (PDT)
Received: from localhost (fwdproxy-ash-001.fbsv.net. [2a03:2880:20ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a79455b1sm407594885a.19.2024.09.11.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:41:11 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: linux-efi@vger.kernel.org,
	devel@edk2.groups.io,
	kexec@lists.infradead.org
Cc: ardb@kernel.org,
	ebiederm@xmission.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	rmikey@meta.com,
	gourry@gourry.net,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
Date: Wed, 11 Sep 2024 11:41:08 +0100
Message-ID: <20240911104109.1831501-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Looking at the TPM spec [1]

If the ACPI TPM2 table contains the address and size of the Platform
Firmware TCG log, firmware “pins” the memory associated with the
Platform FirmwareTCG log, and reports this memory as “Reserved” memory
via the INT 15h/E820 interface.

It looks like the firmware should pass this as reserved in e820 memory
map. However, it doesn't seem to. The firmware being tested on is:
dmidecode -s bios-version
edk2-20240214-2.el9

When this area is not reserved, it comes up as usable in
/sys/firmware/memmap. This means that kexec, which uses that memmap
to find usable memory regions, can select the region where efi.tpm_log
is and overwrite it and relocate_kernel.

Having a fix in firmware can be difficult to get through. As a secondary
fix, this patch marks that region as reserved in e820_table_firmware if it
is currently E820_TYPE_RAM so that kexec doesn't use it for kernel segments.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 arch/x86/include/asm/e820/api.h | 2 ++
 arch/x86/kernel/e820.c          | 6 ++++++
 arch/x86/platform/efi/efi.c     | 9 +++++++++
 drivers/firmware/efi/tpm.c      | 2 +-
 include/linux/efi.h             | 7 +++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 2e74a7f0e935..4e9aa24f03bd 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
+extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+					enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
 extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4893d30ce438..912400161623 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
 	return __e820__range_update(t, start, size, old_type, new_type);
 }
 
+u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+				       enum e820_type new_type)
+{
+	return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
+}
+
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
 {
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 88a96816de9a..aa95f77d7a30 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -171,6 +171,15 @@ static void __init do_add_efi_memmap(void)
 	e820__update_table(e820_table);
 }
 
+/* Reserve firmware area if it was marked as RAM */
+void arch_update_firmware_area(u64 addr, u64 size)
+{
+	if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
+		e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__update_table(e820_table_firmware);
+	}
+}
+
 /*
  * Given add_efi_memmap defaults to 0 and there is no alternative
  * e820 mechanism for soft-reserved memory, import the full EFI memory
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index e8d69bd548f3..8e6e7131d718 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -60,6 +60,7 @@ int __init efi_tpm_eventlog_init(void)
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
+	arch_update_firmware_area(efi.tpm_log, tbl_size);
 	memblock_reserve(efi.tpm_log, tbl_size);
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
@@ -107,4 +108,3 @@ int __init efi_tpm_eventlog_init(void)
 	early_memunmap(log_tbl, sizeof(*log_tbl));
 	return ret;
 }
-
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6bf3c4fe8511..9c239cdff771 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1371,4 +1371,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
 
+#ifdef CONFIG_X86_64
+void __init arch_update_firmware_area(u64 addr, u64 size);
+#else
+static inline void __init arch_update_firmware_area(u64 addr, u64 size)
+{
+}
+#endif
 #endif /* _LINUX_EFI_H */
-- 
2.43.5


