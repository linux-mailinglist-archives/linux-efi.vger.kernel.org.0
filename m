Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CE123282A
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jul 2020 01:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgG2Xg6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 19:36:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22300 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgG2Xg5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 19:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596065818; x=1627601818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6HBziqjPfpEOovieQwcPFPkqxzZPptEH0FVtMgRIac=;
  b=DBsH8F3CuZHqVjV8lRRW5iu95YW4pFuYJH23kb/VD3iYBH5m0I/DaqPs
   vd5YXK/5nlynYeHMwhPrYueBmy6Q/Z6ERhWsl7av1m8HZVJgGHMYvZiGj
   8xFnWTpEDueV78xeacwNwCXfDuaQpNyOc5JHDOwH01QOIKbmHkSABVm7G
   skp2/AE9gqrvlLcolO/neL8lyjpXDOYME8oatL2H27SACV7deNQgXmKsl
   sAlQwdXAVrN3fOdTgywzE4jpoxG/rxZnbryoZQYg3PLZdE9QGRlV+h2aV
   3DJp5Orn8EYRSgfCJEYmQXSFJCiUvKg1JObrozIivTCws3fcAW9ZOwo/6
   Q==;
IronPort-SDR: wXTtYv+vL7Lm8VGw5EWjiO07F3jVTcvKPZ4Jp86UuOsj38to2gX6N38d46XcXthkn9U5fc7JIf
 1BY7EoWsmeTzklSIIsNlHnxyTl8pvnBeOVVlnkQ596ls8ypnRtwo8trNrbZ4TedXkFTNHBkKvQ
 RP8Sd8NXgj3e/GPxpGwZIixDbmGG/kyducgEfY3ycY3epUjeWyWv6w38buf06FMeQ3fvuQ+JG0
 /B4kMvaVMGjSLEf4eKEv3PtdAqKOsDOD+e9iviXRktgqDAyV9Dyug3ObkaAnOrxVb2+Ca7FkfP
 BJg=
X-IronPort-AV: E=Sophos;i="5.75,412,1589212800"; 
   d="scan'208";a="144951821"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 07:36:57 +0800
IronPort-SDR: byKoJuvrVRv5ivqOMDHm5gtFw3G3ff7NoR0L9X9rSg9QQ45qmc6eRUXIOoR9gDdFkPFXuC3E5n
 HsWln+XDLSNtT/TCdDkJdlpDMfYMIpUog=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:25:05 -0700
IronPort-SDR: be71gRvQ3Pgce42+Ak3b5nRel+0Bee347V5NKB6PgQByjA/0utLtd9N5rvAb9q7KmJrMRzzigZ
 XbpOBDDZ4Mfw==
WDCIronportException: Internal
Received: from jpf009043.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.210])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jul 2020 16:36:57 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: [RFT PATCH v4 7/9] efi: Rename arm-init to efi-init common for all arch
Date:   Wed, 29 Jul 2020 16:36:33 -0700
Message-Id: <20200729233635.14406-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200729233635.14406-1-atish.patra@wdc.com>
References: <20200729233635.14406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arm-init is responsible for setting up efi runtime and doesn't actually
do any ARM specific stuff. RISC-V can use the same source code as it is.

Rename it to efi-init so that RISC-V can use it.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/firmware/efi/Makefile                   | 2 +-
 drivers/firmware/efi/{arm-init.c => efi-init.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 7a216984552b..61fd1e8b26fb 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 fake_map-y				+= fake_mem.o
 fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
 
-arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
+arm-obj-$(CONFIG_EFI)			:= efi-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/efi-init.c
similarity index 100%
rename from drivers/firmware/efi/arm-init.c
rename to drivers/firmware/efi/efi-init.c
-- 
2.24.0

