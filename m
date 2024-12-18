Return-Path: <linux-efi+bounces-2390-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE49F696A
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 16:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C31188D19D
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE361B042C;
	Wed, 18 Dec 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/fSG0Dv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399131C5CCF
	for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534218; cv=none; b=OYI1A+fX3DAxEoLz1VsPwYVnzs0Deq7O8ho+8ePfSnwrGi53UnREStxL98T4750p9MIgJT6dx8JAC6zsUZISiZUcj8xm37BeKX7QMe12+AADNcUYIsfAr9IObschmfOW5PmrTKwFDF5D0y7DrGHDVrUZXQ9SKLxCjXzsGWAi4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534218; c=relaxed/simple;
	bh=U4cHDMcfPRusQq8PMbCuBEMWc9zrewwQ0Kku3ElObxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ayNjD28dUg0iEu9ZVwje1YDxdP5I5z5YUgdJn40fb8agH86lju0yR5AnDKtbswfcvbb2mBbNarjY9yYtYm66lnH8pYtzlelDrHnXy7FDF6QexF99ACRncAMYXu23+7j4KN8SU/75HTW7ZcUDb7Ty0AE39BMkeV6Vc05vZAjEOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/fSG0Dv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso10129345e9.1
        for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 07:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734534214; x=1735139014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNQbG6H5H6XADyINQgA2DDX+81fSWOZqhKxaQqigsX4=;
        b=s/fSG0DvoR1SxzYtgEgs6p6NejgkG6uryPndHfUck1pvX3URnBsTHfGBYXgcO1PTmr
         qhncOAL9PUVpOAT8pPMoRCO5JhH6QG1mVNyl+AjvI5pt0B0zqX4KP1AOaS2/gvUh9cUI
         X/go8cz6SKg8ABTFJ23pfJ3GbL9UdV4aONphm5dBT4bkJKeL7H2bs07PHx2a6GZJpxe8
         1X3l/zqk+M8pPq/asmPRHuZmvU5/3IfYIUo4uPMLvToGcpZhTXF9MD0N4McKhVc+E/D4
         jgS6dL1qAdiENTg56U0b/3oqrC1MAph/iQE4fjcirg53rCJFIrx+96U+zwqIuMjoEwi+
         xc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534214; x=1735139014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNQbG6H5H6XADyINQgA2DDX+81fSWOZqhKxaQqigsX4=;
        b=pQJlX3y+ULYRvwnJLvGGWDDovNCvF4gd/R9UmCZ3Zs6nJpxamMm92fhJPldxnOSIjW
         frZ53JbzbTVyjHiRiO9QDdLwjdIdexXreLubMclmEhFgxZUhrWUo4WC19wSO9JOH20BX
         ixxPTB79tPi1guVKL1pU0d3b4NsImDaW3QS941oPULIbsKeLQH9fOId5bX8FEeSnSdlt
         WW2XYjem2MGVcwTQiM6aP8X91nwWG9YyUECKgsitzapmXrZZnpK6/0iwFBzTKpZrwadm
         /4Ep/BIoiTPXiYJpmaKHRgjkokbQOKIDtoTNvv3YQXD2ugjO+d7PTt4oj814vMPyLi3s
         tC8A==
X-Gm-Message-State: AOJu0YzeUhYeFfQvlp3KS/F06XlmrJnh/9GuTyAehtwTX7DAUg7PkEH7
	vMcA7nk1KBhhpkBrwPrGPjvaURMWO7XloQPCYSrX5hmqzMY7reAxEEjnzpvWfsSQ7MbaKvzjWMk
	BSXQFC72IxL1tPvMSubsu4l4gmou+Ds63uBsPCPqTw0rkU+EHNEQ3nX7GWMgMpmSZkH7xrUkAfL
	JclfdhbU2HD+UnrLCBZbExJch6hw==
X-Google-Smtp-Source: AGHT+IG6ccznB3EClUSdci9uiwo+dV47rrW4SBEb0jzk8Wgv315gjnYs4IYfT/rGE3/6sgwPlLIQ1aP+
X-Received: from wmbbi21.prod.google.com ([2002:a05:600c:3d95:b0:434:f21d:7e31])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:584b:0:b0:388:e178:ddb7
 with SMTP id ffacd0b85a97d-388e4d9d498mr2996698f8f.56.1734534214313; Wed, 18
 Dec 2024 07:03:34 -0800 (PST)
Date: Wed, 18 Dec 2024 16:03:18 +0100
In-Reply-To: <20241218150316.1583806-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=15536; i=ardb@kernel.org;
 h=from:subject; bh=1XUDRpFF0wEqMKBIW6qxREWBIHWww70FQxyUSFWIEag=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3pibnZVA+F6iWyIowruALvCBY4ah+apcTOcHEGT4fyE
 mXLfMmOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJH4+4wMm+trpVZrVtyeWiC5
 v9um/X3L/fjuO1Pm1QZqFrz5ZdTKwshweYmz6hols4Mzd+kFv2iaPNtAV/rLclexy1mKj75tWvS NCQA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218150316.1583806-8-ardb+git@google.com>
Subject: [RFC PATCH 2/4] efi/zboot: Add support for ELF payloads
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Some architectures (such as x86) embed the ELF build of vmlinux in the
decompressor, and this is relied upon by, e.g., the Xen loader, which
uses the ELF notes to find the various entrypoints into the executable.

Implement support for this in EFI zboot, but avoid the need to
decompress the entire ELF image, and instead, use the PT_LOAD headers to
selectively decompress those slices of the the payload that are actually
part of the memory image.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h                         |   2 +-
 drivers/firmware/efi/libstub/Makefile                |   2 +-
 drivers/firmware/efi/libstub/Makefile.zboot          |   6 +
 drivers/firmware/efi/libstub/arm64-stub.c            |   2 +-
 drivers/firmware/efi/libstub/arm64.c                 |  16 +-
 drivers/firmware/efi/libstub/efistub.h               |   8 +-
 drivers/firmware/efi/libstub/zboot-decompress-gzip.c |  25 ++-
 drivers/firmware/efi/libstub/zboot-decompress-zstd.c |  26 +++-
 drivers/firmware/efi/libstub/zboot-decompress.c      | 161 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c                 |   9 +-
 10 files changed, 223 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index bcd5622aa096..da502c34a5ea 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -103,7 +103,7 @@ static inline unsigned long efi_get_kimg_min_align(void)
 #define EFI_ALLOC_ALIGN		SZ_64K
 #define EFI_ALLOC_LIMIT		((1UL << 48) - 1)
 
-extern unsigned long primary_entry_offset(void);
+extern unsigned long entry_offset(void);
 
 /*
  * On ARM systems, virtually remapped UEFI runtime services are set up in two
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index e04285a7a6b9..8e2fe499f1f6 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -95,7 +95,7 @@ zboot-obj-$(CONFIG_KERNEL_ZSTD)	:= zboot-decompress-zstd.o lib-xxhash.o
 CFLAGS_zboot-decompress-zstd.o	+= -I$(srctree)/lib/zstd
 
 zboot-obj-$(CONFIG_RISCV)	+= lib-clz_ctz.o lib-ashldi3.o
-lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o zboot-decompress.o $(zboot-obj-y)
 
 lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
 
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 48842b5c106b..bb598544b6ba 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -8,9 +8,15 @@ quiet_cmd_copy_and_pad = PAD     $@
       cmd_copy_and_pad = cp $< $@; \
 			 truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@
 
+ifneq ($(EFI_ZBOOT_PAYLOAD),)
 # Pad the file to the size of the uncompressed image in memory, including BSS
 $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
 	$(call if_changed,copy_and_pad)
+else
+$(obj)/vmlinux.bin: OBJCOPYFLAGS := -R .note -R .note.gnu.build-id -R .comment -S
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+endif
 
 # in GZIP, the appended le32 carrying the uncompressed size is part of the
 # format, but in other cases, we just append it at the end for convenience,
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 2c3869356147..56509a1f8406 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -45,7 +45,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 asmlinkage void primary_entry(void);
 
-unsigned long primary_entry_offset(void)
+unsigned long entry_offset(void)
 {
 	/*
 	 * When built as part of the kernel, the EFI stub cannot branch to the
diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index e57cd3de0a00..f6c8e1992e54 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -100,7 +100,7 @@ void efi_cache_sync_image(unsigned long image_base,
 	/* only perform the cache maintenance if needed for I/D coherency */
 	if (!(ctr & BIT(CTR_EL0_IDC_SHIFT))) {
 		unsigned long base = image_base;
-		unsigned long size = code_size;
+		unsigned long size = alloc_size;
 
 		do {
 			asm("dc " DCTYPE ", %0" :: "r"(base));
@@ -116,24 +116,12 @@ void efi_cache_sync_image(unsigned long image_base,
 	efi_remap_image(image_base, alloc_size, code_size);
 }
 
-unsigned long __weak primary_entry_offset(void)
-{
-	/*
-	 * By default, we can invoke the kernel via the branch instruction in
-	 * the image header, so offset #0. This will be overridden by the EFI
-	 * stub build that is linked into the core kernel, as in that case, the
-	 * image header may not have been loaded into memory, or may be mapped
-	 * with non-executable permissions.
-	 */
-       return 0;
-}
-
 void __noreturn efi_enter_kernel(unsigned long entrypoint,
 				 unsigned long fdt_addr,
 				 unsigned long fdt_size)
 {
 	void (* __noreturn enter_kernel)(u64, u64, u64, u64);
 
-	enter_kernel = (void *)entrypoint + primary_entry_offset();
+	enter_kernel = (void *)entrypoint + entry_offset();
 	enter_kernel(fdt_addr, 0, 0, 0);
 }
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 172f4edab30b..76bfc9f9017e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1232,7 +1232,13 @@ void process_unaccepted_memory(u64 start, u64 end);
 void accept_memory(phys_addr_t start, unsigned long size);
 void arch_accept_memory(phys_addr_t start, phys_addr_t end);
 
-efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size);
+efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size,
+				       unsigned long *entry);
 efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen);
 
+bool efi_zboot_check_header(unsigned long *alloc_size,
+			    unsigned long *entry);
+bool efi_zboot_decompress_segments(u8 *out, unsigned long outlen);
+bool efi_zboot_decompress_slice(u8 *out, unsigned long outlen);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/zboot-decompress-gzip.c b/drivers/firmware/efi/libstub/zboot-decompress-gzip.c
index 79cf8c48b033..6a7b5d5b5a18 100644
--- a/drivers/firmware/efi/libstub/zboot-decompress-gzip.c
+++ b/drivers/firmware/efi/libstub/zboot-decompress-gzip.c
@@ -12,11 +12,11 @@
 #include "inflate.c"
 
 extern unsigned char _gzdata_start[], _gzdata_end[];
-extern u32 __aligned(1) payload_size;
 
 static struct z_stream_s stream;
 
-efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size)
+efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size,
+				       unsigned long *entry)
 {
 	efi_status_t status;
 	int rc;
@@ -38,14 +38,18 @@ efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size)
 		goto out;
 	}
 
-	*alloc_size = payload_size;
+	if (!efi_zboot_check_header(alloc_size, entry)) {
+		status = EFI_LOAD_ERROR;
+		goto out;
+	}
+
 	return EFI_SUCCESS;
 out:
 	efi_free(zlib_inflate_workspacesize(), (unsigned long)stream.workspace);
 	return status;
 }
 
-efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen)
+bool efi_zboot_decompress_slice(u8 *out, unsigned long outlen)
 {
 	int rc;
 
@@ -53,12 +57,19 @@ efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen)
 	stream.avail_out = outlen;
 
 	rc = zlib_inflate(&stream, 0);
-	zlib_inflateEnd(&stream);
 
+	return rc == Z_OK || rc == Z_STREAM_END;
+}
+
+efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen)
+{
+	bool ret = efi_zboot_decompress_segments(out, outlen);
+
+	zlib_inflateEnd(&stream);
 	efi_free(zlib_inflate_workspacesize(), (unsigned long)stream.workspace);
 
-	if (rc != Z_STREAM_END) {
-		efi_err("GZIP decompression failed with status %d\n", rc);
+	if (!ret) {
+		efi_err("GZIP decompression failed\n");
 		return EFI_LOAD_ERROR;
 	}
 
diff --git a/drivers/firmware/efi/libstub/zboot-decompress-zstd.c b/drivers/firmware/efi/libstub/zboot-decompress-zstd.c
index 268ae53c6fda..61a25c75788f 100644
--- a/drivers/firmware/efi/libstub/zboot-decompress-zstd.c
+++ b/drivers/firmware/efi/libstub/zboot-decompress-zstd.c
@@ -9,14 +9,14 @@
 #include "efistub.h"
 
 extern unsigned char _gzdata_start[], _gzdata_end[];
-extern u32 __aligned(1) payload_size;
 
 static ZSTD_inBuffer zstd_buf;
 static ZSTD_DStream *dstream;
 static size_t wksp_size;
 static void *wksp;
 
-efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size)
+efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size,
+				       unsigned long *entry)
 {
 	zstd_frame_header header;
 	efi_status_t status;
@@ -51,29 +51,39 @@ efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size)
 		goto out;
 	}
 
-	*alloc_size = payload_size;
+	if (!efi_zboot_check_header(alloc_size, entry)) {
+		status = EFI_LOAD_ERROR;
+		goto out;
+	}
+
 	return EFI_SUCCESS;
 out:
 	efi_free(wksp_size, (unsigned long)wksp);
 	return status;
 }
 
-efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen)
+bool efi_zboot_decompress_slice(u8 *out, unsigned long outlen)
 {
 	ZSTD_outBuffer zstd_dec;
 	size_t ret;
-	int retval;
 
 	zstd_dec.dst = out;
 	zstd_dec.pos = 0;
 	zstd_dec.size = outlen;
 
 	ret = zstd_decompress_stream(dstream, &zstd_dec, &zstd_buf);
+
+	return zstd_get_error_code(ret) == 0;
+}
+
+efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen)
+{
+	bool ret = efi_zboot_decompress_segments(out, outlen);
+
 	efi_free(wksp_size, (unsigned long)wksp);
 
-	retval = zstd_get_error_code(ret);
-	if (retval) {
-		efi_err("ZSTD-decompression failed with status %d\n", retval);
+	if (!ret) {
+		efi_err("ZSTD-decompression failed\n");
 		return EFI_LOAD_ERROR;
 	}
 
diff --git a/drivers/firmware/efi/libstub/zboot-decompress.c b/drivers/firmware/efi/libstub/zboot-decompress.c
new file mode 100644
index 000000000000..964fe445713c
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot-decompress.c
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/efi.h>
+#include <linux/elf.h>
+
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+extern u32 __aligned(1) payload_size;
+
+static struct {
+#ifdef CONFIG_64BIT
+	Elf64_Ehdr	ehdr;
+	Elf64_Phdr	phdr[5];
+#else
+	Elf32_Ehdr	ehdr;
+	Elf32_Phdr	phdr[5];
+#endif
+} elf_header;
+
+static bool is_elf;
+
+bool efi_zboot_check_header(unsigned long *alloc_size,
+			    unsigned long *entry)
+{
+	unsigned long min = ULONG_MAX, max = 0;
+	bool ret;
+
+	ret = efi_zboot_decompress_slice((u8 *)&elf_header, sizeof(elf_header));
+	if (!ret) {
+		efi_err("failed to extract header\n");
+		return false;
+	}
+
+	/* Check the ELF magic */
+	if (elf_header.ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
+	    elf_header.ehdr.e_ident[EI_MAG1] != ELFMAG1 ||
+	    elf_header.ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
+	    elf_header.ehdr.e_ident[EI_MAG3] != ELFMAG3) {
+		/*
+		 * Raw images are padded to the memory size before compression,
+		 * so the payload size equals the allocation size.
+		 */
+		*alloc_size = payload_size;
+		*entry = 0;
+		return true;
+	}
+
+	/*
+	 * Check whether the executable header and program headers are laid out
+	 * as expected.
+	 */
+	if (elf_header.ehdr.e_phoff != offsetof(typeof(elf_header), phdr) ||
+	    elf_header.ehdr.e_phnum > ARRAY_SIZE(elf_header.phdr)) {
+		efi_err("Unexpected ELF header layout\n");
+		return false;
+	}
+
+	/*
+	 * Iterate over the PT_LOAD headers to find the size of the executable
+	 * image in memory.
+	 */
+	for (int i = 0; i < elf_header.ehdr.e_phnum; i++) {
+		__auto_type ph = &elf_header.phdr[i];
+
+		if (ph->p_type != PT_LOAD)
+			continue;
+
+		min = min(min, ph->p_paddr);
+		max = max(max, ph->p_paddr + ph->p_memsz);
+	}
+
+	if (min >= max) {
+		efi_err("Failed to determine ELF memory size\n");
+		return false;
+	}
+
+	efi_info("ELF zboot payload detected\n");
+
+	*alloc_size = max - min;
+	*entry = elf_header.ehdr.e_entry - elf_header.phdr[0].p_paddr;
+	is_elf = true;
+
+	return true;
+}
+
+bool efi_zboot_decompress_segments(u8 *out, unsigned long outlen)
+{
+	efi_memory_attribute_protocol_t *memattr = NULL;
+	unsigned long pos = sizeof(elf_header);
+
+	if (!is_elf) {
+		/*
+		 * If this is a raw image, first copy the data we already
+		 * extracted from the compressed blob into the output.
+		 */
+		memcpy(out, &elf_header, pos);
+
+		return efi_zboot_decompress_slice(out + pos, outlen - pos);
+	}
+
+	/* grab a reference to the memory attributes protocol, if available */
+	efi_bs_call(locate_protocol, &EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID, NULL,
+		    (void **)&memattr);
+
+	/*
+	 * Iterate over the program headers, and decompress the payload of each
+	 * PT_LOAD entry. This involves skipping the padding by decompressing
+	 * it into the output buffer before overwriting it with the actual
+	 * data.
+	 */
+	for (int i = 0; i < elf_header.ehdr.e_phnum; i++) {
+		__auto_type ph = &elf_header.phdr[i];
+		void *dst = out + ph->p_paddr - elf_header.phdr[0].p_paddr;
+		unsigned long pa = (unsigned long)dst;
+
+		if (ph->p_type != PT_LOAD)
+			continue;
+
+		if (ph->p_offset < pos) {
+			efi_err("ELF PT_LOAD headers out of order\n");
+			return false;
+		}
+
+		/* extract and discard the padding */
+		while (ph->p_offset > pos) {
+			unsigned long l = min(ph->p_offset - pos, ph->p_memsz);
+
+			efi_zboot_decompress_slice(dst, l);
+			pos += l;
+		}
+
+		/* decompress payload */
+		efi_zboot_decompress_slice(dst, ph->p_filesz);
+
+		/* clear area that was not covered by file data */
+		if (ph->p_memsz > ph->p_filesz)
+			memset(dst + ph->p_filesz, 0, ph->p_memsz - ph->p_filesz);
+
+		if (memattr && ph->p_flags == (PF_R | PF_X)) {
+			unsigned long l = ALIGN(ph->p_memsz, EFI_PAGE_SIZE);
+			efi_status_t status;
+
+			status = memattr->set_memory_attributes(memattr, pa, l, EFI_MEMORY_RO);
+			if (status != EFI_SUCCESS)
+				efi_warn("Failed to set EFI_MEMORY_RO on R-X region\n");
+
+			status = memattr->clear_memory_attributes(memattr, pa, l, EFI_MEMORY_XP);
+			if (status != EFI_SUCCESS)
+				efi_warn("Failed to clear EFI_MEMORY_XP from R-X region\n");
+		}
+
+		if (ph->p_flags & PF_X)
+			efi_cache_sync_image(pa, ph->p_filesz);
+
+		pos = ph->p_offset + ph->p_filesz;
+	}
+
+	return true;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index 4a885fbe1ccc..96546b6da59f 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -31,6 +31,13 @@ struct screen_info *alloc_screen_info(void)
 	return __alloc_screen_info();
 }
 
+static unsigned long entrypoint;
+
+unsigned long entry_offset(void)
+{
+	return entrypoint;
+}
+
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
@@ -54,7 +61,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 
 	efi_info("Decompressing Linux Kernel...\n");
 
-	status = efi_zboot_decompress_init(&alloc_size);
+	status = efi_zboot_decompress_init(&alloc_size, &entrypoint);
 	if (status != EFI_SUCCESS)
 		return status;
 
-- 
2.47.1.613.gc27f4b7a9f-goog


