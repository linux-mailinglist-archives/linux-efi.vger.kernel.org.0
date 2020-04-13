Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA31A693B
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgDMPzm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 11:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbgDMPzm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Apr 2020 11:55:42 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10472074B;
        Mon, 13 Apr 2020 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586793341;
        bh=+Tttb0huoTKw4Ijl4wZLMTzjGhDuFYIUmN0xtS3Uu8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYt4ZJwov+lrO9dBwuFbE+/3tT7eKk4Q4lPtkNDOCp6pDeidruxK0ndeNlAMftJ/6
         EE55wHJhPL7J0Qnrw1Di8SZ6hArpEGneqpIU8YHS27gIOMqK78Xp+dh58o1RQgJ38b
         xiQC1am92GQc/1nJS7JAq1KKdLpCkx6a3RB81Fw0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, nivedita@alum.mit.edu,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 5/8] efi/libstub/arm64: align PE/COFF sections to segment alignment
Date:   Mon, 13 Apr 2020 17:55:18 +0200
Message-Id: <20200413155521.24698-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413155521.24698-1-ardb@kernel.org>
References: <20200413155521.24698-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The arm64 kernel's segment alignment is fixed at 64 KB for any page
size, and relocatable kernels are able to fix up any misalignment of
the kernel image with respect to the 2 MB section alignment that is
mandated by the arm64 boot protocol.

Let's increase the PE/COFF section alignment to the same value, so that
kernels loaded by the UEFI PE/COFF loader are guaranteed to end up at
an address that doesn't require any reallocation to be done if the
kernel is relocatable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-header.S  | 2 +-
 arch/arm64/kernel/vmlinux.lds.S | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 914999ccaf8a..6f58998ef647 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -32,7 +32,7 @@ optional_header:
 
 extra_header_fields:
 	.quad	0					// ImageBase
-	.long	SZ_4K					// SectionAlignment
+	.long	SEGMENT_ALIGN				// SectionAlignment
 	.long	PECOFF_FILE_ALIGNMENT			// FileAlignment
 	.short	0					// MajorOperatingSystemVersion
 	.short	0					// MinorOperatingSystemVersion
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 497f9675071d..1d399db0644f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -175,7 +175,7 @@ SECTIONS
 		*(.altinstr_replacement)
 	}
 
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(SEGMENT_ALIGN);
 	__inittext_end = .;
 	__initdata_begin = .;
 
@@ -246,6 +246,7 @@ SECTIONS
 	. += INIT_DIR_SIZE;
 	init_pg_end = .;
 
+	. = ALIGN(SEGMENT_ALIGN);
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
 
-- 
2.17.1

