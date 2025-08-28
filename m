Return-Path: <linux-efi+bounces-4645-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5EFB399BE
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191211C80A39
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87A30BBBC;
	Thu, 28 Aug 2025 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMVnTKpZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DD30FC1A
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376581; cv=none; b=EYXk2z/BstNGZV+x/GMer3hpEwc7lzzOe1VsIBaGqPQC5HSXI0AETpyFHQpJQtOJ3sPrUeEvGdJ8uR4M2DuasvrefpycpumqBdAghy0Kv7NGyieCNoKQi20Vxt7MyCMds6swOfQdCf4xb7ywzpzcriU0efSOXtyoRPm555G1d04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376581; c=relaxed/simple;
	bh=Wm4huExo/rWiPpdWdhwHOyqLO27lCE2gsJm7jQz21sI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jab2JkKrR6uN++s5en+M6odUA/ZSVTKnC+y9PlDuYDNhvf1mSSEkuZk06WlHYw5JGnooJAHCq3PY6I+0+q3+kHXM5PKuxkIytZJiMEbILe5qqYXNuZUCd5WeQQzyd7r7WEpLDLuz4gV43glh3tEYJ0kA3h5uJWr9QwXIXkSJlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMVnTKpZ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cca50781ddso370467f8f.2
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376578; x=1756981378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1f3ZjcWlsJLihtECrmhyMD9LWgGuDxqBMcG5WPlfDU=;
        b=YMVnTKpZTSjWsRg1qy20qRAI3r+6EPb85vXRwporlYncuRYvj3MC9YcW69X6fP/HNJ
         kN9xK6+W46wjN4Aop5+0YF9BaJA0LCZ6eEiAM4000iu5/m2zbLGAh0BuSRKX04gYccbh
         Sx7frExQsZS0cj79tlYIlKWu1eq1bbidrExbjhShWGF+4dVKerIDGPoUGV4+6P2Zzy8x
         A5Fo1RpwYHFp2ZeEcq083dgiJS6uR6iYORAF8QaYZ+vZc7MeODNDNEovyhKo4L6homvf
         EFfLbYz0Ji8S3MwUXvbJ9LnL7RNJ2Kv5J4m4pJ7JQMT9SRI3KZdAWSSUp9WMeDUUhgyC
         L6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376578; x=1756981378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1f3ZjcWlsJLihtECrmhyMD9LWgGuDxqBMcG5WPlfDU=;
        b=Gh8GnPISxpAx605/WNHb02uas1Xg3dMYPYQIGx3pFYFuTnTw4f1PILqrSEP/kLW/dz
         3SbYPAt7tq53/j7gSQr3sZ8SWy595rwfIL0NDLs65tKK3iOLMn9f8WptNepxqRkk/cMi
         nRAbrdF107brO6KdZ/93Az6deVx0HSMChdEZVbaTFQJi+2okyYW6lQ7qDKFsgnw6ndbj
         LETtUmPVz9LOmF7cNxRLpIAQu9egNklCfIyqY7mkrIWqMFKpbVZXs6p3Owr20Sm9Wn95
         /U8qIdiXUmxwNLC12/tCZszuKJXnQO1pxRE0B7IoGKEJGDGeRtza3kjzCk7AHssiCj2X
         tBDw==
X-Gm-Message-State: AOJu0YwY0mRvRSzvC/mPSshzQUsWnhtjXl7hcmSJhdfWMjFe9tyNdTX5
	zqkIAaIKts0cYl3pBnAv4dtdBwccucKBKPKdz7DUsn19l79YJQTS53jG2HCKykDae8ohXBK0Pg=
	=
X-Google-Smtp-Source: AGHT+IHfSbSnLfuE7FTPww0QwZtyNvI1oXr8LtflFNUkiMg0DCUXdG/tT5Pimf0unX0Wk4FPfG5u8SOu
X-Received: from wrvk12.prod.google.com ([2002:a5d:518c:0:b0:3b8:dd81:b66])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:178d:b0:3a3:7593:818b
 with SMTP id ffacd0b85a97d-3c5daefcb76mr17278099f8f.21.1756376577967; Thu, 28
 Aug 2025 03:22:57 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:23 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=iJpaDFlxD/1hgayKj8lz/cO9Xi0vBaplz15UnrLLXnE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7iPj6OMHPsz6uPZSmJ1ZfFqtvpLxq6lnZkfMF9y6T
 cVYMcato5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkPpzhF/PyD5PnMP951bX9
 hcwD9S3PXv1LqQ+ddZ05/tXOBYfE9W0Y/go+P71wTj3Tt91dqa2dW2tfHc97opa2/oSvg5GaybL wtTwA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-44-ardb+git@google.com>
Subject: [PATCH v7 20/22] efistub/x86: Remap inittext read-execute when needed
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
2.51.0.268.g9569e192d0-goog


