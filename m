Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84E12A2B5
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLXPKz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLXPKy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:54 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711322073B;
        Tue, 24 Dec 2019 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200253;
        bh=IDgopTzPNMLYToiOgpA74+8l5wqSbSfivNp5XERZd1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XR/6v9q5+syNpdoo4IPo3kBz+cPyUfHn/MUglG4YAj6YMaF8uLRZVR97FY5lzvXIm
         i1IQOzTDsC0xfZVnTh5Xo0oSy4XauQ7HCjHMR6ejRTtzDxCMWIyZJvSEb9E61inWtM
         tuU13mLl3bnWyr1M2enhdOgzbOQFCsOBYSp2VRvI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 05/25] efi/libstub: remove unused __efi_call_early() macro
Date:   Tue, 24 Dec 2019 16:10:05 +0100
Message-Id: <20191224151025.32482-6-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The macro __efi_call_early() is defined by various architectures but
never used. Let's get rid of it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h   | 1 -
 arch/arm64/include/asm/efi.h | 1 -
 arch/x86/include/asm/efi.h   | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 7667826b93f1..2306ed783ceb 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -51,7 +51,6 @@ void efi_virtmap_unload(void);
 /* arch specific definitions used by the stub code */
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
-#define __efi_call_early(f, ...)	f(__VA_ARGS__)
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
 #define efi_is_64bit()			(false)
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index b54d3a86c444..7cfac5e0e310 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -94,7 +94,6 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 }
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
-#define __efi_call_early(f, ...)	f(__VA_ARGS__)
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
 #define efi_is_64bit()			(true)
 
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index d028e9acdf1c..59c19e0b6027 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -233,9 +233,6 @@ static inline bool efi_is_64bit(void)
 	__efi_early()->call(efi_table_attr(efi_boot_services, f,	\
 		__efi_early()->boot_services), __VA_ARGS__)
 
-#define __efi_call_early(f, ...)					\
-	__efi_early()->call((unsigned long)f, __VA_ARGS__);
-
 #define efi_call_runtime(f, ...)					\
 	__efi_early()->call(efi_table_attr(efi_runtime_services, f,	\
 		__efi_early()->runtime_services), __VA_ARGS__)
-- 
2.20.1

