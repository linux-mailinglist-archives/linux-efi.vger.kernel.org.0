Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C876D6715
	for <lists+linux-efi@lfdr.de>; Tue,  4 Apr 2023 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDDPUP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Apr 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjDDPUP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Apr 2023 11:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BE4205
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 08:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C295635CE
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 15:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A211C433D2;
        Tue,  4 Apr 2023 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621612;
        bh=3xyHT1OtWiQVUUMET2eYvQyZR3EWBYolFXO32v+waq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhJIUMo9QccUr51qalHsyQ0RRUZluG/7miU9i1tX7u7zJoBfLxESneJbDAgjmM89I
         zoq8W09uQwrba8X1z1GI0tySj9MzgyjRLpCkY/ANge1JvH7/QSGAigqHc3ShQ3nkDc
         g2DHCxnv/hCbU+91pvzmYXocGg07/+4/VjM/uZ1N++heRnnjsvaXejN8yA/gQ2Q0BQ
         Df6SZx6wcUMlzi1M8cdTGGZSpTeBCAUsSzRtFAyhgcnDsogkkzo39L+jqb5z6RbS3Z
         Y40vbVGQ9B83Gni2Z1EObqJW60tFsZqNiUXZsxgnJVu8JPb8wYhpQTcuRIYbnA/qbx
         s9BdPlaYAFyGw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, broonie@Kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/6] arm64: image: Add code size to the image header
Date:   Tue,  4 Apr 2023 17:19:56 +0200
Message-Id: <20230404151959.2774612-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404151959.2774612-1-ardb@kernel.org>
References: <20230404151959.2774612-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3480; i=ardb@kernel.org; h=from:subject; bh=3xyHT1OtWiQVUUMET2eYvQyZR3EWBYolFXO32v+waq8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXHQWpDHVvme7G7Zx5EitjEWIldY5z244m/zuMJO38Er T0hnbulo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEZh4jwxbjAx47uM7OCrFW 45+UvUDWbNnruYU3Flp+yXM7+mWfmzfDHw7rN8t/Hnq99LCFQ+NdEfW6IB5WR83zNhXCqbcD9pb bcAEA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In order for loaders to be able to create a preliminary mapping of the
image without having to rely on mappings that have both write and
execute permissions, it is necessary to expose the size of the leading
part of the image consisting of .text, .rodata and .inittext.

So add this information to the arm64 bare metal boot header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/arm64/booting.rst |  3 ++-
 arch/arm64/include/asm/image.h  |  3 ++-
 arch/arm64/kernel/head.S        |  3 ++-
 arch/arm64/kernel/image.h       | 10 +++++++---
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index ffeccdd6bdac9442..4d6966833c8c7472 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -79,7 +79,8 @@ The decompressed kernel image contains a 64-byte header as follows::
   u64 text_offset;		/* Image load offset, little endian */
   u64 image_size;		/* Effective Image size, little endian */
   u64 flags;			/* kernel flags, little endian */
-  u64 res2	= 0;		/* reserved */
+  u32 code_size;		/* Image code size, little endian */
+  u32 res2	= 0;		/* reserved */
   u64 res3	= 0;		/* reserved */
   u64 res4	= 0;		/* reserved */
   u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
diff --git a/arch/arm64/include/asm/image.h b/arch/arm64/include/asm/image.h
index c2b13213c7207c02..5361694c5a7b4956 100644
--- a/arch/arm64/include/asm/image.h
+++ b/arch/arm64/include/asm/image.h
@@ -47,7 +47,8 @@ struct arm64_image_header {
 	__le64 text_offset;
 	__le64 image_size;
 	__le64 flags;
-	__le64 res2;
+	__le32 code_size;
+	__le32 res2;
 	__le64 res3;
 	__le64 res4;
 	__le32 magic;
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b98970907226b36c..8f684a2e8f05ac7e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -62,7 +62,8 @@
 	.quad	0				// Image load offset from start of RAM, little-endian
 	le64sym	_kernel_size_le			// Effective size of kernel image, little-endian
 	le64sym	_kernel_flags_le		// Informative flags, little-endian
-	.quad	0				// reserved
+	.long	_kernel_codesize_le		// Size of leading text/rodata/inittext region, LE
+	.long	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.ascii	ARM64_IMAGE_MAGIC		// Magic number
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 7bc3ba8979019182..4c08409b2129d510 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -34,6 +34,9 @@
 #define DATA_LE32(data) ((data) & 0xffffffff)
 #endif
 
+#define DEFINE_IMAGE_LE32(sym, data)				\
+	sym = DATA_LE32((data) & 0xffffffff)
+
 #define DEFINE_IMAGE_LE64(sym, data)				\
 	sym##_lo32 = DATA_LE32((data) & 0xffffffff);		\
 	sym##_hi32 = DATA_LE32((data) >> 32)
@@ -60,8 +63,9 @@
  * regardless of the endianness of the kernel. While constant values could be
  * endian swapped in head.S, all are done here for consistency.
  */
-#define HEAD_SYMBOLS						\
-	DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);	\
-	DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
+#define HEAD_SYMBOLS								\
+	DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);			\
+	DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);			\
+	DEFINE_IMAGE_LE32(_kernel_codesize_le, __initdata_begin - _text);
 
 #endif /* __ARM64_KERNEL_IMAGE_H */
-- 
2.39.2

