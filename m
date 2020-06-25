Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96220A96A
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgFYXqJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:46:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4091 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFYXp0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128725; x=1624664725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M20HiMQD9oL/II9j9nUHwk6euEXhFNaJrLjuGryzaCg=;
  b=gbHOUEiyGXu/kJ1BiKAve4ask7uFKVt9GmtGRlekNtq/8nrkA6LWHBpi
   VZScGMb4abUTeRbiWIT3wN4Tf9pvuvG5yCnrd7kGHpLt0kZDP7GfAqjPg
   rzqVosPRJwy05a0uehf8mlYIPp41parCm45GBnHrkoWnjR0SF1ayFtT/p
   nmmQaBvm4z3W/D+GoSSL2988+9eFyxh8dyhkRqfs+u2hl6SSliQ+ItkX9
   ytaMieXU5g/+c0y6Jqi9sjXGEXWjynotTAPD4h97s6Z+6WAoSDd6gr4wy
   SPuw+FRx0bA+twKZ6RfCurVKxja1PYCePtsY1pgXZFW4bMysm5ZsNIUml
   Q==;
IronPort-SDR: Vmu/UbIHI7nielglOcG+ZdUrB+fIL55iticEcU3IDWMcj1hE8jCg77HdjvBIk5kUWWcWZKKASf
 0Es6EAx+t/6G2VhqT2HHkDKrTFzNpExLnWShfeuaF4EdwQLmN6CDCykfaA0qS9wEie2CHv/MfI
 m7zmvbmhIvnmZzeUa+pzXovHhZW9OXGjpd4IA2+HJp6nGdxpD4ZBAKA/n1h5HP/dUCQtKzlrfY
 TvNeZBhudtgMib2j9o+JBX82747pGFWf8MRhYiO/eqlTuv5cmLheElb5rI1g9zANZ3rtybl8dg
 dt0=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953454"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:25 +0800
IronPort-SDR: b+QMd6h8hb0gop6Kom53nMiQsutxugX0em5cT+9SyN3ksFyfAykZWg65JYNe0aj0u5UlyZqhNV
 IyyjJ2YqfCWOiP12PmBNjUD2GIgl0NcIc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:25 -0700
IronPort-SDR: khYCqebgabkJ7OmHX9caktKOD4V4TcpsYIxqNzM9dj5nEB94M2b+iarGnwOnVnuCSjRcLYVinX
 PHvoAzKFAmkw==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:24 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 03/11] RISC-V: Setup exception vector early
Date:   Thu, 25 Jun 2020 16:45:08 -0700
Message-Id: <20200625234516.31406-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The trap vector is set only in trap_init which may be too late in some
cases. Early ioremap/efi spits many warning messages which may be useful.

Setup the trap vector early so that any warning/bug can be handled before
generic code invokes trap_init.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/head.S    | 10 ++++++++--
 arch/riscv/kernel/smpboot.c |  1 -
 arch/riscv/kernel/traps.c   |  8 +-------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index c5b529234ad8..eb123eda3663 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -77,10 +77,16 @@ relocate:
 	csrw CSR_SATP, a0
 .align 2
 1:
-	/* Set trap vector to spin forever to help debug */
-	la a0, .Lsecondary_park
+	/* Set trap vector to exception handler */
+	la a0, handle_exception
 	csrw CSR_TVEC, a0
 
+	/*
+	 * Set sup0 scratch register to 0, indicating to exception vector that
+	 * we are presently executing in kernel.
+	 */
+	csrw CSR_SCRATCH, zero
+
 	/* Reload the global pointer */
 .option push
 .option norelax
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 4e9922790f6e..5a9c127a380e 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -154,7 +154,6 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
-	trap_init();
 	notify_cpu_starting(smp_processor_id());
 	update_siblings_masks(smp_processor_id());
 	set_cpu_online(smp_processor_id(), 1);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index ecec1778e3a4..fbedf6c018a3 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -174,13 +174,7 @@ int is_valid_bugaddr(unsigned long pc)
 }
 #endif /* CONFIG_GENERIC_BUG */
 
+/* stvec & scratch is already set from head.S */
 void trap_init(void)
 {
-	/*
-	 * Set sup0 scratch register to 0, indicating to exception vector
-	 * that we are presently executing in the kernel
-	 */
-	csr_write(CSR_SCRATCH, 0);
-	/* Set the exception vector address */
-	csr_write(CSR_TVEC, &handle_exception);
 }
-- 
2.24.0

