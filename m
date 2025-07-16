Return-Path: <linux-efi+bounces-4373-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C113FB06C40
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088C51AA8080
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B128F935;
	Wed, 16 Jul 2025 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8OIzh2n"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AA28D859
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636173; cv=none; b=hSSVmwnh+QO63XZAbOmoaZFfhcXC7DD3KwPhfx32/5OhcB0Kokvuh+xKItOz/Br0Kd/owiqMHZu+a8zpEtJztEi4Z98YUmICjKYm9j8TrwddwQnVu0ReRx9gztV2X+JUgIjm6qjzVYeoB5CL2IzDZMr03DtP0KnCB890czDhdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636173; c=relaxed/simple;
	bh=RfO7bxnrvkm3EAfuN+XVxgry6A3ikIVlIqCUVBjfqOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0sr2s+5u5sjsAOsKg35+ute4426Q22OVoXuVJzR9SQ5kDuqpXLm8vBsOvM/zvrcr7rlpl2hrwvj/eewJPPbTfisILzUnFPnazgucN2Umol+ftrnNyi+GlR8Iigm+LkF969g1PnnSeUZcJbuzvGSN9VC+uyepwGEXkxO/CMgAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8OIzh2n; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so2284094f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636169; x=1753240969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=a8OIzh2nxp8H5JMm6V8TOi1PpU2BWkvD2zLDwlFMN10RmzgwwlBhDOVx6AN065M+5h
         8vCISQp3vIjND+5ILXgWokJuUCqSnS/nC68TjLpjZvR18PdTUQYoFT5rMLIKtp6IDQkQ
         k/l4renjtMd8kASGDqJcVt1QkC7z8lpzdbNmSiaWiBgdKrxA77a4v1LbtMy/Fj7rliSF
         /WGhA6E4fXBeIN/4OnVockME3zRvWW/V/dXt4uE7CHe1j2Une1HfiOyc498P3kyDUgMK
         c0/tAssDTIuO5xYY/VcYdmOig7Ig6rPn+/Z1HcyUzwAG9X5987E3S1c04BMz6gnDxtsb
         gqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636169; x=1753240969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=BmVJTquHECeuErMky+mb6esdv1O9/dYrTsa3BhFcnXAC5kqXR0XG3RG0A0m4JULr44
         4gFBv6IZH/7Ybf9OxHa5KvqsoIfKAYgUQFEkhT6hMq9SUofOmDVzJuzETULHCw6LaAiV
         fTBSTo/qyCylqP2dFG2RiPr1nHSjUD4EWuEqDFuRNDaSPXhk+MoujJkZ8QX69JqEbo2i
         YRKqxiy7s8r47VJZmSpZNIxDoT8hbSiPvE3hMwI6G0XbKuoyYy7jxYJ1RECHujGvJyov
         5ZRZcKCJ+Zy85dFwCM5LJo6jUkcco7Xi9zSmgkAzJBpf3LPeO6aybilHzMsNb9RkObIS
         hXiw==
X-Gm-Message-State: AOJu0YxWweGc/suiS3mNh715E3u3jL7L1f2oT12SCE9IblVvnQOVzo6F
	K68mRL/QiERgltzrn/iKhmqA5zUkN28+//VqAlF3YvMBM+acdhqBq/IhfI+AEROt4I8X7WH8hg=
	=
X-Google-Smtp-Source: AGHT+IEWhaE99OwCX/esjWHh8KBB3EsOMLyjjInmtN2ZrBnWyDFImIs4h/qmvtFvku7loso+0jZGwFxu
X-Received: from wmcq23.prod.google.com ([2002:a05:600c:c117:b0:453:b96:8ef9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4719:b0:3b5:dbd8:ad5f
 with SMTP id ffacd0b85a97d-3b60dd91d5amr861486f8f.58.1752636169819; Tue, 15
 Jul 2025 20:22:49 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:35 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=GtM5Ky3cWjJjWfzB1UFTM+fqdT7qquH5JBfrdp2rkyg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcKmnmhN1lVkVhyk1GSrIzbNUyT2uoRXM+9p5t6nFcL
 uzAFZWOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJFvzxgZTgvmbZ3yK6X4/tlU
 B52tDpo7wptyo2bwWv59Pue+SmyuMiPDgjPN/rwfPot+ud2sGO+2Rbq++qDg6Uye2v9LNwZ+0bL jAwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-44-ardb+git@google.com>
Subject: [PATCH v5 20/22] efistub/x86: Remap inittext read-execute when needed
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Recent EFI x86 systems are more strict when it comes to mapping boot
images, and require that mappings are either read-write or read-execute.

Now that the boot code is being cleaned up and refactored, most of it is
being moved into .init.text [where it arguably belongs] but that implies
that when booting on such strict EFI firmware, we need to take care to
map .init.text (and the .altinstr_aux section that follows it)
read-execute as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile       | 2 +-
 arch/x86/boot/compressed/misc.c         | 2 ++
 arch/x86/include/asm/boot.h             | 2 ++
 arch/x86/kernel/vmlinux.lds.S           | 2 ++
 drivers/firmware/efi/libstub/x86-stub.c | 4 +++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a38fdcdb9bd..74657589264d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -73,7 +73,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rodata\|_sinittext\|__inittext_end\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 94b5991da001..0f41ca0e52c0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -332,6 +332,8 @@ static size_t parse_elf(void *output)
 }
 
 const unsigned long kernel_text_size = VO___start_rodata - VO__text;
+const unsigned long kernel_inittext_offset = VO__sinittext - VO__text;
+const unsigned long kernel_inittext_size = VO___inittext_end - VO__sinittext;
 const unsigned long kernel_total_size = VO__end - VO__text;
 
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 02b23aa78955..f7b67cb73915 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -82,6 +82,8 @@
 #ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
+extern const unsigned long kernel_inittext_offset;
+extern const unsigned long kernel_inittext_size;
 extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5d5e3a95e1f9..4277efb26358 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -227,6 +227,8 @@ SECTIONS
 	 */
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
+		. = ALIGN(PAGE_SIZE);
+		__inittext_end = .;
 	}
 
 	INIT_DATA_SECTION(16)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..0d05eac7c72b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -788,7 +788,9 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 
 	*kernel_entry = addr + entry;
 
-	return efi_adjust_memory_range_protection(addr, kernel_text_size);
+	return efi_adjust_memory_range_protection(addr, kernel_text_size) ?:
+	       efi_adjust_memory_range_protection(addr + kernel_inittext_offset,
+						  kernel_inittext_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
-- 
2.50.0.727.gbf7dc18ff4-goog


