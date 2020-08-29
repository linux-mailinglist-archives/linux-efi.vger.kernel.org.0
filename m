Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1922564D8
	for <lists+linux-efi@lfdr.de>; Sat, 29 Aug 2020 07:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgH2FWx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Aug 2020 01:22:53 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:20539 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgH2FWx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Aug 2020 01:22:53 -0400
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-06.nifty.com with ESMTP id 07T5GhZf022344;
        Sat, 29 Aug 2020 14:16:43 +0900
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 07T5FRB9012582;
        Sat, 29 Aug 2020 14:15:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 07T5FRB9012582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598678130;
        bh=0XqtnXdF9CBIU4ohxV38tjVOaVgk2FYWRD/pAepS2uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQSAq7nIHgy+IR776Vq74wL4lRy3094D58JmmoZNCLF8gz48TeSNFQq698RvzI8wz
         18MgFLhbgeFL34IzkzKp1m3csB04ACOMAXwG45KZcOMsORKfja80oTxOpDjQFtR1y/
         LhODeCkE7FxruIEoIHkWxOTzizaAohvmDsgGSuSHQ1OX1PZlBMFo4nyiW0SjuSyIgF
         CucZT1eqDk8emwM89ZQeLeKr1tGWAwGYWeLf0zrw9p0x4lQsCJ53LthZdNYypt2ogC
         2MLb2lSa3rEkAhLqhc6LoVpjXKN3+EvklxLvrZd8R1ADzRgnAAjG40L3bCt4qkHtKR
         r3XHONQiIk6Ag==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ia64: remove unneeded header includes from <asm/mca.h>
Date:   Sat, 29 Aug 2020 14:15:23 +0900
Message-Id: <20200829051524.706585-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829051524.706585-1-masahiroy@kernel.org>
References: <20200829051524.706585-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

<asm/mca.h> includes too many unneeded headers.

This commit cuts off a lot of header includes.

What we need to include are:

 - <linux/percpu.h> for DECLARE_PER_CPU(u64, ia64_mca_pal_base)
 - <linux/threads.h> for NR_CPUS
 - <linux/types.h> for u8, u64, size_t, etc.
 - <asm/ptrace.h> for KERNEL_STACK_SIZE

The other header includes are actually unneeded.

<asm/mca.h> previously included 436 headers, and now it includes
only 138. I confirmed <asm/mca.h> is still self-contained.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/ia64/include/asm/mca.h | 9 +++------
 arch/ia64/kernel/efi.c      | 1 +
 arch/ia64/kernel/mca.c      | 1 +
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/include/asm/mca.h b/arch/ia64/include/asm/mca.h
index c92b9c15962c..05805249296c 100644
--- a/arch/ia64/include/asm/mca.h
+++ b/arch/ia64/include/asm/mca.h
@@ -14,13 +14,10 @@
 
 #if !defined(__ASSEMBLY__)
 
-#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <linux/threads.h>
 #include <linux/types.h>
-
-#include <asm/param.h>
-#include <asm/sal.h>
-#include <asm/processor.h>
-#include <asm/mca_asm.h>
+#include <asm/ptrace.h>
 
 #define IA64_MCA_RENDEZ_TIMEOUT		(20 * 1000)	/* value in milliseconds - 20 seconds */
 
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index f932b25fb817..b6bb718ed1ff 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -39,6 +39,7 @@
 #include <asm/meminit.h>
 #include <asm/processor.h>
 #include <asm/mca.h>
+#include <asm/sal.h>
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 17151269d655..3911c561d2bb 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -96,6 +96,7 @@
 #include <asm/ptrace.h>
 #include <asm/sal.h>
 #include <asm/mca.h>
+#include <asm/mca_asm.h>
 #include <asm/kexec.h>
 
 #include <asm/irq.h>
-- 
2.25.1

