Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5248D222F43
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jul 2020 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGPXlj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jul 2020 19:41:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7110 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGPXlX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jul 2020 19:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594942882; x=1626478882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6HBziqjPfpEOovieQwcPFPkqxzZPptEH0FVtMgRIac=;
  b=g7kIuAnvc4CQ9RnXn+Quauuvpv6nOZsyYKdYMDC+gzdF6d0+2+44/70n
   IkffZ3HjOpdKpIu4w93MGyPuwllXlei0E5+gQY/LC4AWVcXB0/hI8P728
   FM+SeeFsI92pYnnUyyyTwCPc2C3vkMqG1jZf7hEqL/XTxt27K0OrNQ29W
   k0CwlouCDnfqECIld83YutRZKsP88tbA1uEnVzneiREjlbAezkXI8Gm63
   maKFqKFEPTPGWBxHPjJT/Hw3TA83yhKpQ9Jk+W7zo4WkYjyg3bznXfRiI
   PzIFPJlpg2ajM+YbXaiDZOlxBm/hPLW23BDIAwNmtvJLEINHTO4/SFgqA
   w==;
IronPort-SDR: aL/iMxBB3Qt8P3IgHN333fp3ZJf2mRL6koqvvlI8+kjEQ4/rPFr+RbbNa0hbJvB4+Kwur8qq4F
 BUlQYLvgqLNC6V/ycrXegI5jQK4xhhq42/1QjGy7ujsPqhUr+syeYe6mkFpLmY0g0fyxVvN22n
 rxzfXTW7ahT28a56A6A2c3Hc+JD+d91yaVfg+p1p6y2CHSIpk+QhIbTUzLoJ8QJJeShAdscNJr
 bTcFWOgsDaCeMS0uJzoUbjnYI2Fc9M9lNAuaj7rOJYbQDCquMfzg73mH0SIZBDKdqaXLCLag/u
 I70=
X-IronPort-AV: E=Sophos;i="5.75,360,1589212800"; 
   d="scan'208";a="251923232"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 07:41:22 +0800
IronPort-SDR: mfmQYQVvBMFCl+eQVd2lovOXTvZ2YQ6meDmSA5W+RWCbqgxHruRNeRxex8+6ELYwrAtmyevG18
 D9Po2kf6wSl2vEPNhPHDXRGvPEfsLXYwQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 16:29:46 -0700
IronPort-SDR: PWbuYNsxssCn40vWmXhVNZwgTUSQ6DTTbK/IitymYljqtYtk8TxEeJt5x8q1A0677CraTBfRp3
 lXWjdBsAHw/A==
WDCIronportException: Internal
Received: from phd004806.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.54])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 16:41:21 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 7/9] efi: Rename arm-init to efi-init common for all arch
Date:   Thu, 16 Jul 2020 16:41:02 -0700
Message-Id: <20200716234104.29049-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200716234104.29049-1-atish.patra@wdc.com>
References: <20200716234104.29049-1-atish.patra@wdc.com>
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

