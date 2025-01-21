Return-Path: <linux-efi+bounces-2702-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A25A187AA
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2025 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928F07A45D8
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2025 22:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A31F78ED;
	Tue, 21 Jan 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tarpvpuv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27201F5433
	for <linux-efi@vger.kernel.org>; Tue, 21 Jan 2025 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497781; cv=none; b=n+PNy33JkAYe7ZcrsNFQBh6hpoHPPunTpqcBlDlU2mmuVYpVa+IdkiDhNp7LTtaKqwzgc9rFBKpinm9TMaTxssWUQpOfzwW63pcp78GESsBFOzNMwCwm6y1g2mEWiNGM3eTEFtezibCEmcYHU93Hd2sl9tX3qX/7HKD9+tfHjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497781; c=relaxed/simple;
	bh=kuS9+usQUnoAJ7h3I+IY6V/rxzIi2s09XeV3LdJfMj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NCoQb7x2APqZtEfrgenbzbRm+XNmdXOFQcLVnd/0HwgWTiDEqBgJVtGruNJg6QtT94khVxAkaRqpYI0ueDROpjfJ/VXXtL+F3j79UEy5QQNfqvG2gaZ3bpOU04zMV7lXelYaM9T3Lk8WMqS3XUodNwMqB0kVEZLwxH6LZqGarsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tarpvpuv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso20245e9.0
        for <linux-efi@vger.kernel.org>; Tue, 21 Jan 2025 14:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737497778; x=1738102578; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzmBoQbCE7e2VTnHw9DXW5AVmYWzyx5m18uEgeNFLzY=;
        b=tarpvpuv4xiueR/p14iFdvyCevj49Rp8T0tQQfGoeZkDzqCEyza1FVCdTBTx5PBgeA
         7l2xqUS0ip+1maRwuXsaesTmiMrQDFaLkLHh1ZKemY9usfk34BqMXhR4spAXBNcXcVwZ
         5ya+5j5QdhECcdeBmGDqx+m63KRgKJkBzyrM7xRgpSCq8ppsQzd01da1gSNQTrMIpMAl
         VnMOUtpcqfnmm8RKOJ4womfftEzGZERRNIJWvqzLfSkiLuNZs32rug1eA82oNXGjSqLC
         EN6bSk/40/e1MRfZcNzQ7S/RPRHjKa1ICSBLovLGsXg6TAS+/wNeJbGJpRwRqPYBHlBb
         iczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737497778; x=1738102578;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzmBoQbCE7e2VTnHw9DXW5AVmYWzyx5m18uEgeNFLzY=;
        b=I2wxl2MYVR/RhfR5C3Vqck5cTrFrQwRaglWI+ut9W0UanhqoyI5fq3bij4LE1izIlo
         mVNwi0Yg9AgsfJwAT5K7O2AY7MnCo2ykFdSOCVZgv2BoKtGalr7KCYn2yRy4HNukKM6Z
         gDg4C0U+IBELZqkofgKvlaceHHUGkZnfA6Ohulka1CKip0GE1Hu5usSDiLFducN/SFVy
         sKN9KhqrImRvYvJsfyW/FTHO9mW3e7D3lXFgmC3C0EkmyzdSkz7+vdGTDzMZv7VZyrDH
         ngpgDK3xOT1Uv5pMZSldkxiXgtZKyFqs/yxmDGEbKNRp8NUiYlnMjnT6ZNdrPGSE7Gnh
         KJkw==
X-Forwarded-Encrypted: i=1; AJvYcCVMRxfX8xw6TPZG5yRUzGsjSjFn20cHByXOPFLAYOvZj0MJC4Vh0KXqz2Eb8Irccn1sRV2nB5+rtzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrcotaVGv7x+XfMwRJPJdOrJ/DdxobqIQVDXuN1ULHJU7NJ25
	5PcwdYA827+HT56P5Mt+GVnjSnU1EPBW+Qw15akfZVcjpNPIQ7otFW1YPj4p8Q==
X-Gm-Gg: ASbGncuA5Ydiegw0IBi3sKQSlIr1zPO+OKtXYLnnKd37ASP54J2Wc4fsDcJr/+CUaIK
	tRA16WB7ljbVy8iL5ywh+9+zTYayVS3rPHmV3Qu3Q0sZHbbsM2qqKc6rKf7ijfQ2V2/Ec4HNio8
	6jBMIZnT9mpxmeF7zENIFEm3V3hu60Pwa3YznCzNe+ZSO9fkaffYQaeowUVBO/NMWBay0tvlk+I
	QxHwOmC9AOvoY24YWULFeaBzc4EnGLFH0+OlS7pznPLI+bouaXuJnIYZRY=
X-Google-Smtp-Source: AGHT+IEqPNSzuNcGCyt683L4AIyW1+5qRuiQlVD9dVHlSQohAlvQuzg66TxKiMMiLwQ9SGS4xTcpSQ==
X-Received: by 2002:a05:600c:4f0d:b0:435:921b:3535 with SMTP id 5b1f17b1804b1-438b2da754fmr74955e9.3.1737497777602;
        Tue, 21 Jan 2025 14:16:17 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:93eb:28f6:6b52:a48e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318aae1sm274245e9.1.2025.01.21.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 14:16:17 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Tue, 21 Jan 2025 23:16:09 +0100
Subject: [PATCH RFC] x86: Add CONFIG_KERNEL_UNCOMPRESSED support
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com>
X-B4-Tracking: v=1; b=H4sIAKgckGcC/x2MMQqAMAwAvyKZDbSVgrgKPsBVHKRGDWqVRkSQ/
 t3ieBx3LwgFJoEqeyHQzcKHT6DzDNwy+JmQx8RglLFKG40rBU8bumM/A4ngNMiFhVWObKm0MyW
 kNKmJn3/bQdvU0Mf4AVU57VBrAAAA
X-Change-ID: 20250121-kernel-compress-fast-350ce5801c28
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737497773; l=5794;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=kuS9+usQUnoAJ7h3I+IY6V/rxzIi2s09XeV3LdJfMj4=;
 b=vFk+qsZp8iDibxHFL/PkhT2fOb37LGRH19Iyz9tA2NghkFd8EcF3616hnZCM3I52KXUPZrI3s
 Jo5gw+7fi1PBsepq8YqzxMUxrU4ZYo7v/qp55xb5Z4kegUMb2Sy/6uF
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Support storing the kernel uncompressed for developers who want to quickly
iterate with one-off kernel builds.
Store it in the usual format with a 4-byte length suffix and keep this new
codepath as close as possible to the normal path where decompression
happens.

The other compression methods offered by the kernel take some time;
even LZ4 (which the kernel uses at compression level 9) takes ~2.8
seconds to compress a 110M large vmlinux.bin on my machine.

An alternate approach to this would be to offer customization of the LZ4
compression level through a kconfig variable; and yet another approach
would be to abuse the existing gzip decompression logic by storing the
kernel as "non-compressed" DEFLATE blocks, so that the decompression code
will essentially end up just doing a bunch of memcpy() calls.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/boot/compressed/Makefile    |  3 +++
 arch/x86/boot/compressed/misc.c      |  4 ++++
 arch/x86/boot/header.S               |  2 ++
 drivers/firmware/efi/libstub/zboot.c |  2 ++
 lib/decompress_dummy.c               | 15 +++++++++++++++
 scripts/Makefile.lib                 |  3 +++
 7 files changed, 30 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ef6cfea9df7333c52e331f487a0b29f037a6bf14..6d468d47861ae0b6ec6b7649af6ab4dd123eb5c8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -250,6 +250,7 @@ config X86
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
+	select HAVE_KERNEL_UNCOMPRESSED
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de9432e3466ac0ef1c4d3abc378e37d3..06079e02d9e01704cc0da06c1195854c8d0602ac 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -137,6 +137,8 @@ $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lz4_with_size)
 $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,zstd22_with_size)
+$(obj)/vmlinux.bin.store: $(vmlinux.bin.all-y) FORCE
+	$(call if_changed,store_with_size)
 
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
 suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
@@ -145,6 +147,7 @@ suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
 suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
 suffix-$(CONFIG_KERNEL_ZSTD)	:= zst
+suffix-$(CONFIG_KERNEL_UNCOMPRESSED)	:= store
 
 quiet_cmd_mkpiggy = MKPIGGY $@
       cmd_mkpiggy = $(obj)/mkpiggy $< > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 0d37420cad0259554f8160dea0c502cb7e2fc6cd..5d514a147d5d1ae252419e4c7cdc09e9c29f110f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -88,6 +88,10 @@ static int cols __section(".data");
 #ifdef CONFIG_KERNEL_ZSTD
 #include "../../../../lib/decompress_unzstd.c"
 #endif
+
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+#include "../../../../lib/decompress_dummy.c"
+#endif
 /*
  * NOTE: When adding a new decompressor, please update the analysis in
  * ../header.S.
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359bcde2c4c3c5ed796e8780f7979774..8397470231cf571a33ac75f7ca7020608e170eef 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -483,6 +483,8 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 # larger margin.
 #
 # extra_bytes = (uncompressed_size >> 8) + 131072
+#
+# Uncompressed data does not grow.
 
 #define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 131072)
 #if ZO_z_output_len > ZO_z_input_len
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index af23b3c502282f9bd644c38af445875c225cdf42..1c43a6ae5e665aa3bff3bd467c8a2f5525b1a6e9 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -27,6 +27,8 @@ static unsigned long free_mem_ptr, free_mem_end_ptr;
 #include "../../../../lib/decompress_unxz.c"
 #elif defined(CONFIG_KERNEL_ZSTD)
 #include "../../../../lib/decompress_unzstd.c"
+#elif defined(CONFIG_KERNEL_UNCOMPRESSED)
+#include "../../../../lib/decompress_dummy.c"
 #endif
 
 extern char efi_zboot_header[];
diff --git a/lib/decompress_dummy.c b/lib/decompress_dummy.c
new file mode 100644
index 0000000000000000000000000000000000000000..49435e199a07f6ed376ff93adeae8ee08a9dd3d7
--- /dev/null
+++ b/lib/decompress_dummy.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+STATIC int INIT __decompress(unsigned char *buf, long len,
+			   long (*fill)(void*, unsigned long),
+			   long (*flush)(void*, unsigned long),
+			   unsigned char *out_buf, long out_len,
+			   long *pos,
+			   void (*error)(char *x))
+{
+	if (out_len < len-4) {
+		error("output buffer too small");
+		return -1;
+	}
+	memcpy(out_buf, buf, len-4);
+	return 0;
+}
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7395200538da89a2f6e6d21f8959f3f60d291d79..bb8116ba8ba189d5246fcb0e71c7be6e05ce5148 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -525,6 +525,9 @@ quiet_cmd_zstd22 = ZSTD22  $@
 quiet_cmd_zstd22_with_size = ZSTD22  $@
       cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
 
+quiet_cmd_store_with_size = STORE  $@
+      cmd_store_with_size = { cat $(real-prereqs); $(size_append); } > $@
+
 # ASM offsets
 # ---------------------------------------------------------------------------
 

---
base-commit: 95ec54a420b8f445e04a7ca0ea8deb72c51fe1d3
change-id: 20250121-kernel-compress-fast-350ce5801c28

-- 
Jann Horn <jannh@google.com>


