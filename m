Return-Path: <linux-efi+bounces-4814-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCAB56650
	for <lists+linux-efi@lfdr.de>; Sun, 14 Sep 2025 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284D23B6887
	for <lists+linux-efi@lfdr.de>; Sun, 14 Sep 2025 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1AB2749DA;
	Sun, 14 Sep 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpZiWlSh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD480255F31
	for <linux-efi@vger.kernel.org>; Sun, 14 Sep 2025 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822595; cv=none; b=bCB0lqFAPcZNKA7ZZxQ5Az/PXFJw8J7lvyrKyPrNpdGBm7nlzJ1y4c7ldKt/UwTuUMyyX+GQdjQqKtQRaeRF1yv4VsnofNvWO9VZa6Zi0ftZjhsxm4iQJloJHdijauCFfvkBJ9KMT/MQSgyPLvWSXrSBgnZ0GBOFj0ITkzGlaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822595; c=relaxed/simple;
	bh=j1E8Kr4jri6e4/xcRlVoRXdDxGXBFXomZgH/7x9XPOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ2R4jiDzk3plh+BO6+F7caXtZ04TMUB/RhPiDjX/neBKETDmctIYuqsvA8WFqad7EpKWPzoriUbBCu+/aliBzIyyziz4eXe1TCmN6LTjjF7YRnkhtlCmx+MGpuWYQp7uBpNQbLe7RK4vN8Hyy1cNRApfaTEvN+ZEzjBXI/4SRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpZiWlSh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a16441so466050666b.2
        for <linux-efi@vger.kernel.org>; Sat, 13 Sep 2025 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822589; x=1758427389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbcdxSDkMFQBJSgZHl6W+ZOyEjWb42NhxwZCg+OO1T8=;
        b=NpZiWlShLH9JRZ5zdLbGJlqHmjwb03BAvIBhjVhW9NOpWee7Hrw+67QefUzPAjTQ06
         rCe1TfeApxB/9B5bY6GP1htZE0Rp/8fgICcXkQOQF36js01CpoScD8i39daDrGzOa5zv
         KNKWBOlMBb4D9FTpsTe/MR99XUpACKzEiDjpYjuku10gdxkSKYSCcV1udsBGp+jLpqel
         MYfohaz315cEdsHWx5Q29CgD5gaNX0/kM0IWjQ2sQB9D6j0Ydp8lINwbmcqXOuit1XpW
         tw2u+3CqL3sdxlCT8AqJuG0nGtIzqY6sxDPJzA6YVx22rA/P33Pt0JGWFj6IefT9iBcn
         7wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822589; x=1758427389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbcdxSDkMFQBJSgZHl6W+ZOyEjWb42NhxwZCg+OO1T8=;
        b=tB88Z5X1/B5PT9tikhKH8Paairal2VpnkGvofYjFPYHSDn3Z+HwxnbYuOFGBCfNGuj
         hLewH65wPPqf4YtOaMU9bc8So3ilcHe0b+NSHsVMebhbpUe8b1nbIrIaLYBOoRQkRTsk
         vNK+oDuomSWhkq51nKsF2DGQxMsdygwXS9DT6J5MHsgrF34h1YfwIAG8Xb7HtM1ZMjB9
         KxXgaS3iFqbFgu7g5DbHj9EeOtCJqdvHovaOT+/TrPXzWGFmgW2gG+T0Q4BA1oUi18Rz
         t5vn8fFR9xyQrJmQ81bz4R3SQg7GhXSC0ivF4FV5WVb+ZHQ5zmAYVYfcbFsyB82XF5DL
         /qnw==
X-Forwarded-Encrypted: i=1; AJvYcCXe1IsaFWhlHndhc+Zp+epMuO1HnHOnpUVjaZeTp6fX0thGpx4y4Det8ERxTco5JtiN4P2a6fJ26SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznRjNXBpW+iO14kd9wrJ6q1TyUjFK3S8r1HtTUvn3HR+bbcVBn
	d1z05szkf4wlth+bUgp1y8wb9H3uR4e0WaYpNCldc0nuAENEexzEBOI8
X-Gm-Gg: ASbGncs5kfsSI47JewfW1OT6FWhB8u4/IfGQF4M0UfropYCEbx6NZTabBeweuyCd7Ex
	h5taw46t4ycADaWUcdY0Ok7d0IHIWxhxqQQbg8dKpE8RmARrCGZ625gVYAgcXwEdQHnW+PPGqQ8
	6C2coBkh9SXiJUFmTpqH0QvgdDpUUfYSLjdAurY3n5TPZKye5dk7epq2FqWVgR6up2gkRPUygvZ
	nerhLX2QrPL+vFeFzQihG/N1nLUe89qoS3Evyyw7NkJJYxyeg6brpEdbum1Cu3Hdu2aT1nI0/6F
	pePdJBea1EIhqdefaw5+IDdYr2jy2/mKp71jTwArxdQWr08rJYflG7mB56BveC5pbZ9ZBqwQ8z0
	VUW4X+1A8esQDzdXxZb84LueZ7Q9h9g==
X-Google-Smtp-Source: AGHT+IHGuPAdg2hc8vTX17sqHx8yH9klMMnyHgZ7wpg91V0NDBcC4FFg8p5OfHIPrffFIiq2LKJR3w==
X-Received: by 2002:a17:907:3e1e:b0:afe:35d:fd5d with SMTP id a640c23a62f3a-b07c3475927mr787789466b.1.1757822589070;
        Sat, 13 Sep 2025 21:03:09 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0906a9640esm221968366b.110.2025.09.13.21.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:03:08 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 59/62] init: rename CONFIG_RD_XZ to CONFIG_INITRAMFS_DECOMPRESS_XZ
Date: Sun, 14 Sep 2025 07:03:03 +0300
Message-ID: <20250914040303.3823154-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initrd support was removed,
and CONFIG_RD_XZ has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/configs/lpc18xx_defconfig         | 2 +-
 arch/arm/configs/sp7021_defconfig          | 2 +-
 arch/arm/configs/vf610m4_defconfig         | 2 +-
 arch/mips/configs/ath25_defconfig          | 2 +-
 arch/mips/configs/bmips_stb_defconfig      | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 arch/powerpc/configs/44x/fsp2_defconfig    | 2 +-
 arch/riscv/configs/nommu_k210_defconfig    | 2 +-
 arch/riscv/configs/nommu_virt_defconfig    | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig  | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig  | 2 +-
 usr/Kconfig                                | 4 ++--
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index b1d5d8e4d7fe..816586530ff5 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -3,7 +3,7 @@ CONFIG_PREEMPT=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
index cfb20e693e1e..2d9bbda67e85 100644
--- a/arch/arm/configs/sp7021_defconfig
+++ b/arch/arm/configs/sp7021_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index 9b20db4bb8e6..7d457a196dfc 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -2,7 +2,7 @@ CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index 7c1ec18b0eeb..e401b29ce706 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -5,7 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 300e67507a1f..072bfdc87771 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -17,7 +17,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-CONFIG_RD_XZ=y
+CONFIG_INITRAMFS_DECOMPRESS_XZ=y
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_PCI=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 5e46664549ec..7080bdedea01 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -5,7 +5,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index 038a261ebc20..ffb345222649 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -10,7 +10,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_KALLSYMS_ALL=y
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 282b889596a1..10ffb9ea40bd 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -4,7 +4,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 # CONFIG_RD_ZSTD is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index e9231eadcbad..9383e3445ead 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -3,7 +3,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 6b38ba64a2aa..f102ed913e9b 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -16,7 +16,7 @@ CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 9b260f57e63f..d3916408eaf6 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -17,7 +17,7 @@ CONFIG_RELAY=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_XZ is not set
+# CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
diff --git a/usr/Kconfig b/usr/Kconfig
index 030c6a898d7a..69f95a5a1847 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -76,7 +76,7 @@ config INITRAMFS_DECOMPRESS_LZMA
 	  Support loading of a LZMA encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_XZ
+config INITRAMFS_DECOMPRESS_XZ
 	bool "Support initial ramfs compressed using XZ"
 	default y
 	select DECOMPRESS_XZ
@@ -170,7 +170,7 @@ config INITRAMFS_COMPRESSION_LZMA
 
 config INITRAMFS_COMPRESSION_XZ
 	bool "XZ"
-	depends on RD_XZ
+	depends on INITRAMFS_DECOMPRESS_XZ
 	help
 	  XZ uses the LZMA2 algorithm and has a large dictionary which may cause
 	  problems on memory constrained systems. The initramfs size is about
-- 
2.47.2


