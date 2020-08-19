Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C724A95A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHSWZK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 18:25:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16026 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgHSWYz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 18:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597875895; x=1629411895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bk2Gh/XGM+blmye1lG7fqQWiRAnoRdaJAzm3HH3f+As=;
  b=m6RLBJutwZv54DvbEE0zT5tPbEJhpZVsXJD85n9UPOzmfcyBqiYzHlni
   l2f78LZJvOLZn7laTe3K19d+PCD7kRbfhhzm05a3hqbGaIIZUbA0SHaJM
   hB0j2I56cewWycEGn92Z8f20SILUTIv/1ONCgpnmWzrRATPfsHys4WsWx
   E3FMFPkvFuq7s5CUN0S7QAwSnQ5PuEijJkr3sJVWkW4WVxenNvMZgswEy
   zVkFG+oADJrgB0qIHkA2ATM4kFLJkmV6RP5j08oL/hywyixdVfvEM/akR
   85Xhw+MpqRJpA7rR0aHz7sc6E1zSxN2RdrhVYgqykz7/kdGrW80nDOazM
   g==;
IronPort-SDR: 3CRM/tM5AjXvHmV9le7gdpeTFzUTPM77OuEaWnEokYZNDzsK3x2AQ8F5jeN0sU56UIXL90uWka
 vXk9xXRLt3+4ODnmHRCH3MnCo2SQLYgIvlfTnBQ+Nwi+UzRORpx0Vx+mJ8QxS6PU6c9pxBVeeP
 vW2MX8sqR3R7Oe9CIWrnGvimcJjLmFaqnB+CfxXXBhfbVUBdK0QeEnFvhW7euAvl11BaiK8Dwi
 D8l0c6lLsr0mdxAQLsNl2cY0FJuEPSuaHKfFYIlNBykYj5rlF6dmZsw6cANo8iLI6P92QqfJzq
 +hA=
X-IronPort-AV: E=Sophos;i="5.76,332,1592841600"; 
   d="scan'208";a="145373616"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2020 06:24:38 +0800
IronPort-SDR: m3lKB1A+CFjYqv/UgMUyjoNV5hgSh0I2AuTFxC211ekcM1t0W2D5UkOzzmJabXc1S17t1bDQCs
 Tu7AJVPAw2Ow==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:12:20 -0700
IronPort-SDR: mR5GQ++tJdfzFRFihTJaMucU1XgxcuUoLxd/gRMkE1wzAwfBUDzf6fR7PnP8j1c4pLfeMm+J6o
 LVUXXgAWTJVA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2020 15:24:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>, Zong Li <zong.li@sifive.com>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: [PATCH v6 7/9] efi: Rename arm-init to efi-init common for all arch
Date:   Wed, 19 Aug 2020 15:24:23 -0700
Message-Id: <20200819222425.30721-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200819222425.30721-1-atish.patra@wdc.com>
References: <20200819222425.30721-1-atish.patra@wdc.com>
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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
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

