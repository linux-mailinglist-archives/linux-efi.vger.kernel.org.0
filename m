Return-Path: <linux-efi+bounces-4456-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52400B0D365
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3EF6C38CB
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF82D3743;
	Tue, 22 Jul 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a73XFqX4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12452E1C50
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169414; cv=none; b=U1ilPXELBiK57OM/p83wDK+9nxPkMyfDtGDb8DqRG4SQtfJ0D5jHwBMl0uzNKFsXa1OfYrfxbp6b6KTtAew3cXQcvBewEhYY7hGd8pa9ppuYvaZ3acN3W+O14yq+LSZ7RKIJObjb7uYzCAe/7YPiPANksL4sHkefjczNpPYSb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169414; c=relaxed/simple;
	bh=RfO7bxnrvkm3EAfuN+XVxgry6A3ikIVlIqCUVBjfqOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fdPM2hYfwt00FecTKPsVOVr6obAUl2hE0j7nEgDNEMoRfKa23amK4WQ374qT+34FDhQEOXyxZm9swERvEOhSZeKFPoeMOcaP0rRdD9kdSnVJVAmKQ/uIDIUlu0Pl71PBCZ/0ghuHps1HpL2sy20+6a1pyuQ6I+VZNiwTI5E/1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a73XFqX4; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so2034189f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169410; x=1753774210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=a73XFqX4Yo3wTcWDDPUjR9c1RIdgImY6eJkpUvH3SgAv1vQ0Fd4AzAuBUW3pgA2Xdl
         32R5qZlwP57tYmB+OgXLQLwTenYKwnYsQlyLykP88fdBbzwIJoy0bh9q1pdJqe6UoG09
         bm6NqxvLd1rKPBIhfhS7fp1sLBYNQshY4fzxAChtnb8ARqYlkZSThZHnpgU19WaUJstg
         UNaJ6eFH+t/qS/mCUm+xKTOBRm3XT11T4M3yvL+Joycwc8l19JNxsyhFEibCH2ZxRrPB
         7DdK62IUaKJ20q/V0k6kjtfVv1nYFWf/c0wGpXZHiqVZ1miKfKOd+A6ScRF+5JHiUm5W
         tfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169410; x=1753774210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=Z62AnIuP8JlXamfM9tLT3JFH8yCrrgyvl2k+V59vMelTlk9GjnMfqXMRE9jsQ5Heyf
         8k2gIhiN+st0IU68GZRp+us1CHNBL6sPMfsUbPoy4OgiQ/E/4yOi7zCAzWFxY7trh4x1
         HgTUJfpsIfWfWaNlr3ZPYMa7WlEMwXTZ81p0lPo5SEbwmt9nnlrJoFMmTu3zXAikOQDp
         vXyf3lspe5HpvIotJtJJJfl+Ut3mYfWPeoT+WbJ5OkAzpe5PPLEwlSWkym9/eyqbcsK3
         MFBI6/aerIu39YYTuve65UXUfx+RMl34W25+hrTqlRpEHpJVMX6+BWWWCK945sPBLPim
         2XvQ==
X-Gm-Message-State: AOJu0YzdSF3g/3GzyvEO6EK8qtQTVLdqiRVulbKXFbAyjYv0k5gb34B5
	DC2W9IqldrdW625vikMNRDOdDjSKM2q4Wq41j9D6oSeoj4aHPtS+XQh/d+u8d8zTlTH+I6/k7w=
	=
X-Google-Smtp-Source: AGHT+IH5xwjHFcnT9ZTssnfXE3Q1P32gK3BQqmZs4PrBrGP+O6OvsYUUxIAm+s6cVuFs0g46W4zb2E/D
X-Received: from wmbes26.prod.google.com ([2002:a05:600c:811a:b0:442:f9fc:2a02])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:490c:b0:3a4:d02e:84af
 with SMTP id ffacd0b85a97d-3b60e5531d6mr15630107f8f.58.1753169410298; Tue, 22
 Jul 2025 00:30:10 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:29 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=GtM5Ky3cWjJjWfzB1UFTM+fqdT7qquH5JBfrdp2rkyg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedt3MCbvLrIrClJuMlGRn2KplntZQi+Z87D3b1OO4X
 NiBKyodpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCLmEgz/FA9WuPzLcGyS/bnn
 xoLH/Wvc2RzWcc8/IHH80g7b+9nfbjL8r7t/zONsd+U/J6YtdmYuTUWp2q82zvzzPnnXyaqsIhY mRgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-44-ardb+git@google.com>
Subject: [PATCH v6 20/22] efistub/x86: Remap inittext read-execute when needed
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


