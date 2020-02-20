Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FFA165C6D
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 12:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTLHK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 06:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgBTLHK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 06:07:10 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EE324673;
        Thu, 20 Feb 2020 11:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582196828;
        bh=C7+2ZUNeJiu4mk7bIZv6NrbdW7NxoMMUePJjR7qbNAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLFPIT8LQ34tqmRQK+ytyjvuMnFkDqCFcUqp4sH1OjDQym9Ap7dBB8/kWO+/DNtSF
         hiD3FQyoc3P1zyzISoBmn9i1x932Qcj44We3xk1/25BiJiXo9f6yYDG2VQy1ioHw8R
         MDHs9//dfvyyHkg3FQqoy3/NssE9iWu54h4hZtAQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com
Subject: [RFC PATCH 2/3] efi/libstub: Introduce symbolic constants for the stub major/minor version
Date:   Thu, 20 Feb 2020 12:06:48 +0100
Message-Id: <20200220110649.1303-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220110649.1303-1-ardb@kernel.org>
References: <20200220110649.1303-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that we have added new ways to load the initrd or the mixed mode
kernel, we will also need a way to tell the loader about this. Add
symbolic constants for the PE/COFF major/minor version numbers (which
fortunately have always been 0x0 for all architectures), so that we
can bump them later to document the capabilities of the stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/efi-header.S | 4 ++--
 arch/arm64/kernel/efi-header.S        | 4 ++--
 arch/x86/boot/header.S                | 4 ++--
 include/linux/pe.h                    | 3 +++
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index e38fbda02b93..62286da318e7 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -70,8 +70,8 @@ extra_header_fields:
 		.long	SZ_512				@ FileAlignment
 		.short	0				@ MajorOsVersion
 		.short	0				@ MinorOsVersion
-		.short	0				@ MajorImageVersion
-		.short	0				@ MinorImageVersion
+		.short	LINUX_EFISTUB_MAJOR_VERSION	@ MajorImageVersion
+		.short	LINUX_EFISTUB_MINOR_VERSION	@ MinorImageVersion
 		.short	0				@ MajorSubsystemVersion
 		.short	0				@ MinorSubsystemVersion
 		.long	0				@ Win32VersionValue
diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 40c704c5d3a5..914999ccaf8a 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -36,8 +36,8 @@ extra_header_fields:
 	.long	PECOFF_FILE_ALIGNMENT			// FileAlignment
 	.short	0					// MajorOperatingSystemVersion
 	.short	0					// MinorOperatingSystemVersion
-	.short	0					// MajorImageVersion
-	.short	0					// MinorImageVersion
+	.short	LINUX_EFISTUB_MAJOR_VERSION		// MajorImageVersion
+	.short	LINUX_EFISTUB_MINOR_VERSION		// MinorImageVersion
 	.short	0					// MajorSubsystemVersion
 	.short	0					// MinorSubsystemVersion
 	.long	0					// Win32VersionValue
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9110b58aa2ec..a87d788ea54e 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -147,8 +147,8 @@ extra_header_fields:
 	.long	0x20				# FileAlignment
 	.word	0				# MajorOperatingSystemVersion
 	.word	0				# MinorOperatingSystemVersion
-	.word	0				# MajorImageVersion
-	.word	0				# MinorImageVersion
+	.word	LINUX_EFISTUB_MAJOR_VERSION	# MajorImageVersion
+	.word	LINUX_EFISTUB_MINOR_VERSION	# MinorImageVersion
 	.word	0				# MajorSubsystemVersion
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
diff --git a/include/linux/pe.h b/include/linux/pe.h
index c86bd3a2f70f..e0869f3eadd6 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -10,6 +10,9 @@
 
 #include <linux/types.h>
 
+#define LINUX_EFISTUB_MAJOR_VERSION		0x0
+#define LINUX_EFISTUB_MINOR_VERSION		0x0
+
 #define MZ_MAGIC	0x5a4d	/* "MZ" */
 
 #define PE_MAGIC		0x00004550	/* "PE\0\0" */
-- 
2.17.1

