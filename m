Return-Path: <linux-efi+bounces-2389-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C69F695E
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 16:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2E61677DB
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D41D45FC;
	Wed, 18 Dec 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJRAS29A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC71C5CCF
	for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534215; cv=none; b=YSa1Nt9bglUql6nI0XAw555Zj4jec8zbwztricgg+fvSUy3SuBiBs7rCKUzHBwUD0rXmMVM3p0dc0dG8nW2eoNGkjURP8a29fAf31RWJjdp7e2JM0+5f3CQn24JpVJNIFqx2/onBFVk6B5aEg11M7ZJJoCfuqYaCfRhSu2hppCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534215; c=relaxed/simple;
	bh=3GFm17Gc+6T4haDEAV6CbnWMIZrtp2CBH2AwPVaT/wk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpBcm76eAS9gz5O14mN6cpqhJ48yTErzwsRxzC4z/vsyjETSaFahBDXIzRbSCiWHBgTtPzmFg/7N5BeUfduUO5e6Cj+3kflHyWK+vGhqtkzrciMCX3xYtJrraOSiLrrag3SUtehgvFJFI7fgMfnZ8+AZRgrXn8ek0y5DqsbiZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJRAS29A; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385dcae001fso2950186f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734534212; x=1735139012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEvz3WkqoxlF0K6VcJwCgl3tz0ai2j43+8VZsmCvsTg=;
        b=NJRAS29A3H3JdwtfEaQXC+4LUAb8T6c8+hR2S81UnzyPZMxnRIQ8iK41bRVnaBcT3f
         kBaWS7wc/fFH5F2XhrFtFtZ3RmKgx+GQczGyjITRyTK1f4buOu4EK0QjuT5ZrZkL74+A
         mustYUajcKMfv7XfG7cALEjWg1FdvRkJcFI6/0/2NmfA7gx02NDq6cM9xYWZsabLjbtb
         5gGJiNWyg8Ip3h4E79nuHZL96TD1gShMOXi0/jdRyCCx0G9hoRkpLeiqLUi/vvmNJ+Fo
         dpWmOosKn3ik0FksU4Cj8hz63qQ6u76bLo07isnXX5pIdMXGHcuJ9/dGkXT6LajqOf85
         FLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534212; x=1735139012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEvz3WkqoxlF0K6VcJwCgl3tz0ai2j43+8VZsmCvsTg=;
        b=kHQUNoDSUYmJ/l9kXtZHlM3QpsImFuyJsUo0HFeTqz55seULm5PxBNfcivY1Yk8BV1
         mbTPMM1hCynifQ/YE2/EprOy0reIoPh7bU8VEOZCBS+MljjHcRYtxI0DjrvS38LJykYf
         g/r7KN+2tlDSGCVIDKjXpP80H5Whv9Qc3AxqYz60nrC1RWfKGFl76PzkirficYd/0spl
         gB+UCNReKHOwhd25/6Zi97nmIITAe8sbwkeILwmwY7/Q1GDcBbfbDuKpwVN1x6qQQwDf
         Z+6rKph9Vkg3m7eh4AfhuBBR/9KZpcIuFAM2rOEYITxx+YaPKgtnO1fOzNjhcYDOXD69
         BPlg==
X-Gm-Message-State: AOJu0YydmF+gg2eUPIkllNPKVVQDVV8ykMwBviWr7b7VXShJhV2Nu4YL
	vxcAS0k2cEQ+tj8+aACbYKXU+VVVt79paoqY8LuHC3M3La/Va1rSZwOSrrRP9Ek40CDut1Kofl6
	Tqmq0UvA1svcqjK0tvuyTz0f77+DjzdYnrgrtIvuDbuULk7HO99iXJcc8YwlZ9mdTn/fJNAz9b0
	ACb5bA+h6DbwXdZ9/nsRtKn2Q80g==
X-Google-Smtp-Source: AGHT+IEWZolnCKG7iU5fUYcCHbKJHKCWd9k51M4vGXEMA4pR0Qo2YM1Mg4EpBBuqvk1yrSiAOQbK5KRA
X-Received: from wmrn13.prod.google.com ([2002:a05:600c:500d:b0:434:9e7b:42c1])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5846:0:b0:386:378c:b7ec
 with SMTP id ffacd0b85a97d-388e4da21f3mr2529657f8f.58.1734534212211; Wed, 18
 Dec 2024 07:03:32 -0800 (PST)
Date: Wed, 18 Dec 2024 16:03:17 +0100
In-Reply-To: <20241218150316.1583806-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9968; i=ardb@kernel.org;
 h=from:subject; bh=MBzjTZ4rXvoYTGPsHDhEdVg7zo7i35qAoS9awftgito=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3piVlpTZvnnltHV777IdkfEHvANyf7uaXxu/q2kvXaP
 WpT1/t3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlwfWH4H/htod+EjeatnFy6
 WvnLNLIl7ixjLLOPCJsgMj1UKvXabYb/9T+ZD5/YfpV/HsumvTF35eNXrrHm+s2xe3nnqal9Ny4 f5QUA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218150316.1583806-7-ardb+git@google.com>
Subject: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Remove the dependency on the decompression wrappers used by the legacy
decompressor, which do some odd things like providing a barebones
malloc() implementation. Instead, implement GZIP deflate and ZSTD
decompression in terms of the underlying libraries.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile                |  7 +-
 drivers/firmware/efi/libstub/efistub.h               |  3 +
 drivers/firmware/efi/libstub/zboot-decompress-gzip.c | 66 ++++++++++++++++
 drivers/firmware/efi/libstub/zboot-decompress-zstd.c | 81 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c                 | 51 ++----------
 drivers/firmware/efi/libstub/zboot.lds               |  1 +
 6 files changed, 163 insertions(+), 46 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ed4e8ddbe76a..e04285a7a6b9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -89,7 +89,12 @@ lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
-zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
+zboot-obj-y			:= zboot-decompress-gzip.o
+CFLAGS_zboot-decompress-gzip.o	+= -I$(srctree)/lib/zlib_inflate
+zboot-obj-$(CONFIG_KERNEL_ZSTD)	:= zboot-decompress-zstd.o lib-xxhash.o
+CFLAGS_zboot-decompress-zstd.o	+= -I$(srctree)/lib/zstd
+
+zboot-obj-$(CONFIG_RISCV)	+= lib-clz_ctz.o lib-ashldi3.o
 lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
 
 lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 76e44c185f29..172f4edab30b 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1232,4 +1232,7 @@ void process_unaccepted_memory(u64 start, u64 end);
 void accept_memory(phys_addr_t start, unsigned long size);
 void arch_accept_memory(phys_addr_t start, phys_addr_t end);
 
+efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size);
+efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/zboot-decompress-gzip.c b/drivers/firmware/efi/libstub/zboot-decompress-gzip.c
new file mode 100644
index 000000000000..79cf8c48b033
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot-decompress-gzip.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/zlib.h>
+
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+#include "inftrees.c"
+#include "inffast.c"
+#include "inflate.c"
+
+extern unsigned char _gzdata_start[], _gzdata_end[];
+extern u32 __aligned(1) payload_size;
+
+static struct z_stream_s stream;
+
+efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size)
+{
+	efi_status_t status;
+	int rc;
+
+	/* skip the 10 byte header, assume no recorded filename */
+	stream.next_in = _gzdata_start + 10;
+	stream.avail_in = _gzdata_end - stream.next_in;
+
+	status = efi_allocate_pages(zlib_inflate_workspacesize(),
+				    (unsigned long *)&stream.workspace,
+				    ULONG_MAX);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	rc = zlib_inflateInit2(&stream, -MAX_WBITS);
+	if (rc != Z_OK) {
+		efi_err("failed to initialize GZIP decompressor: %d\n", rc);
+		status = EFI_LOAD_ERROR;
+		goto out;
+	}
+
+	*alloc_size = payload_size;
+	return EFI_SUCCESS;
+out:
+	efi_free(zlib_inflate_workspacesize(), (unsigned long)stream.workspace);
+	return status;
+}
+
+efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen)
+{
+	int rc;
+
+	stream.next_out = out;
+	stream.avail_out = outlen;
+
+	rc = zlib_inflate(&stream, 0);
+	zlib_inflateEnd(&stream);
+
+	efi_free(zlib_inflate_workspacesize(), (unsigned long)stream.workspace);
+
+	if (rc != Z_STREAM_END) {
+		efi_err("GZIP decompression failed with status %d\n", rc);
+		return EFI_LOAD_ERROR;
+	}
+
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/zboot-decompress-zstd.c b/drivers/firmware/efi/libstub/zboot-decompress-zstd.c
new file mode 100644
index 000000000000..268ae53c6fda
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot-decompress-zstd.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/zstd.h>
+
+#include <asm/efi.h>
+
+#include "decompress_sources.h"
+#include "efistub.h"
+
+extern unsigned char _gzdata_start[], _gzdata_end[];
+extern u32 __aligned(1) payload_size;
+
+static ZSTD_inBuffer zstd_buf;
+static ZSTD_DStream *dstream;
+static size_t wksp_size;
+static void *wksp;
+
+efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size)
+{
+	zstd_frame_header header;
+	efi_status_t status;
+	size_t ret;
+
+	zstd_buf.src = _gzdata_start;
+	zstd_buf.pos = 0;
+	zstd_buf.size = _gzdata_end - _gzdata_start;
+
+	ret = zstd_get_frame_header(&header, zstd_buf.src, zstd_buf.size);
+	if (ret != 0) {
+		efi_err("ZSTD-compressed data has an incomplete frame header\n");
+		status = EFI_LOAD_ERROR;
+		goto out;
+	}
+
+	if (header.windowSize > (1 << ZSTD_WINDOWLOG_MAX)) {
+		efi_err("ZSTD-compressed data has too large a window size\n");
+		status = EFI_LOAD_ERROR;
+		goto out;
+	}
+
+	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
+	status = efi_allocate_pages(wksp_size, (unsigned long *)&wksp, ULONG_MAX);
+	if (status != EFI_SUCCESS)
+		goto out;
+
+	dstream = zstd_init_dstream(header.windowSize, wksp, wksp_size);
+	if (!dstream) {
+		efi_err("Can't initialize ZSTD stream\n");
+		status = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	*alloc_size = payload_size;
+	return EFI_SUCCESS;
+out:
+	efi_free(wksp_size, (unsigned long)wksp);
+	return status;
+}
+
+efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen)
+{
+	ZSTD_outBuffer zstd_dec;
+	size_t ret;
+	int retval;
+
+	zstd_dec.dst = out;
+	zstd_dec.pos = 0;
+	zstd_dec.size = outlen;
+
+	ret = zstd_decompress_stream(dstream, &zstd_dec, &zstd_buf);
+	efi_free(wksp_size, (unsigned long)wksp);
+
+	retval = zstd_get_error_code(ret);
+	if (retval) {
+		efi_err("ZSTD-decompression failed with status %d\n", retval);
+		return EFI_LOAD_ERROR;
+	}
+
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index af23b3c50228..4a885fbe1ccc 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -7,36 +7,6 @@
 
 #include "efistub.h"
 
-static unsigned char zboot_heap[SZ_256K] __aligned(64);
-static unsigned long free_mem_ptr, free_mem_end_ptr;
-
-#define STATIC static
-#if defined(CONFIG_KERNEL_GZIP)
-#include "../../../../lib/decompress_inflate.c"
-#elif defined(CONFIG_KERNEL_LZ4)
-#include "../../../../lib/decompress_unlz4.c"
-#elif defined(CONFIG_KERNEL_LZMA)
-#include "../../../../lib/decompress_unlzma.c"
-#elif defined(CONFIG_KERNEL_LZO)
-#include "../../../../lib/decompress_unlzo.c"
-#elif defined(CONFIG_KERNEL_XZ)
-#undef memcpy
-#define memcpy memcpy
-#undef memmove
-#define memmove memmove
-#include "../../../../lib/decompress_unxz.c"
-#elif defined(CONFIG_KERNEL_ZSTD)
-#include "../../../../lib/decompress_unzstd.c"
-#endif
-
-extern char efi_zboot_header[];
-extern char _gzdata_start[], _gzdata_end[];
-
-static void error(char *x)
-{
-	efi_err("EFI decompressor: %s\n", x);
-}
-
 static unsigned long alloc_preferred_address(unsigned long alloc_size)
 {
 #ifdef EFI_KIMG_PREFERRED_ADDRESS
@@ -64,22 +34,17 @@ struct screen_info *alloc_screen_info(void)
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
-	unsigned long compressed_size = _gzdata_end - _gzdata_start;
 	unsigned long image_base, alloc_size;
 	efi_loaded_image_t *image;
 	efi_status_t status;
 	char *cmdline_ptr;
-	int ret;
 
 	WRITE_ONCE(efi_system_table, systab);
 
-	free_mem_ptr = (unsigned long)&zboot_heap;
-	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
-
 	status = efi_bs_call(handle_protocol, handle,
 			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&image);
 	if (status != EFI_SUCCESS) {
-		error("Failed to locate parent's loaded image protocol");
+		efi_err("Failed to locate parent's loaded image protocol\n");
 		return status;
 	}
 
@@ -89,9 +54,9 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 
 	efi_info("Decompressing Linux Kernel...\n");
 
-	// SizeOfImage from the compressee's PE/COFF header
-	alloc_size = round_up(get_unaligned_le32(_gzdata_end - 4),
-			      EFI_ALLOC_ALIGN);
+	status = efi_zboot_decompress_init(&alloc_size);
+	if (status != EFI_SUCCESS)
+		return status;
 
 	 // If the architecture has a preferred address for the image,
 	 // try that first.
@@ -127,13 +92,9 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	}
 
 	// Decompress the payload into the newly allocated buffer.
-	ret = __decompress(_gzdata_start, compressed_size, NULL, NULL,
-			   (void *)image_base, alloc_size, NULL, error);
-	if (ret	< 0) {
-		error("Decompression failed");
-		status = EFI_DEVICE_ERROR;
+	status = efi_zboot_decompress((void *)image_base, alloc_size);
+	if (status != EFI_SUCCESS)
 		goto free_image;
-	}
 
 	efi_cache_sync_image(image_base, alloc_size);
 
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index af2c82f7bd90..9ecc57ff5b45 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -17,6 +17,7 @@ SECTIONS
 	.rodata : ALIGN(8) {
 		__efistub__gzdata_start = .;
 		*(.gzdata)
+		__efistub_payload_size = . - 4;
 		__efistub__gzdata_end = .;
 		*(.rodata* .init.rodata* .srodata*)
 
-- 
2.47.1.613.gc27f4b7a9f-goog


