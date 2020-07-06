Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D256B215D11
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgGFR0h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:26:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41516 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgGFR0g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056421; x=1625592421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5rYW4FEHjU+JIGZzSYacxByNR94cSOaxyWs5ncpc52A=;
  b=VQuVvXqhEm7wKm0mRedSxEveMzY2Gb2yjbhC1NyJDkpg8aEzN5R1CtmB
   9I0uXmjapjTEgkNkrJWV7p608FBMWeAJwh4jzauPYMTl6kk4mfOEztlW7
   LUlaO8zcbjs42DKaRqZ6Gxrp0Kq8hOr9QmP/LFgj3etBT4dgvZnEL6E0K
   pcBxSn7BrQa7dSqUw7DkDFQ3qpHyKXzJxAPvkspcjki6LWrXMWrrWhZjg
   hbo/c19UobimDIeUfRFeA447DqQ+VPfTDmuL3aO0+dCR+osN52Ot8QVfy
   i/1H/7UHdGiSWph2qWiyWRF6ysjuCD/FTpzrXuKQmOoa3kkzC02okcC3o
   g==;
IronPort-SDR: WBOKJGlBRrPSlwHlWVKXgQZkA6aj9e51zenO12nPi+haAzMkn3Ujm2V+Az3xCPrdFfs3W0Wyy6
 EYIpXY9MtRbcvbRUVokVJNH8XO4whEq/apAXIx1rCZ/9K8BUTYX6g6cl4oFPnR7/2HMB24PZRR
 8FNlbq3FUSEmw0RqHNswkQtGjVqpvWN6dPom8P+NwvbEMRObh5DNn+2xV8WrpPL7MriJohVlzA
 qxSH5m/xbPuw9wLeOuHJyT6qlT0EUriPEca4S9svUPSLh7Q2D7vnN8Qp0ZmIDVEPIHD7i50eaC
 Gjw=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770178"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:52 +0800
IronPort-SDR: kG4zbxCTvYQmzmdoGNc+/qEYxDqlqRIgTG65p2kbRGvYgD9iS7K2Gv39D4uwMeRuCDwSS6WayM
 WBrquLv+9kAOvUUcWaKLk42u66lcC4L3I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:38 -0700
IronPort-SDR: JpeLRq4Gv2B6hJdrG2x8+bUFZu6OWKRYQZiJUf0qjG/GWht2sUiscYCg6ulNaKrzumxLHgpPpe
 CuXowP9yI+XQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:30 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 03/11] RISC-V: Setup exception vector early
Date:   Mon,  6 Jul 2020 10:26:01 -0700
Message-Id: <20200706172609.25965-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
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
index 7d95cce5e47c..ad14f4466d92 100644
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

