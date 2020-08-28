Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAEF255F99
	for <lists+linux-efi@lfdr.de>; Fri, 28 Aug 2020 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgH1RV1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Aug 2020 13:21:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11689 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgH1RVE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Aug 2020 13:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598635263; x=1630171263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bk2Gh/XGM+blmye1lG7fqQWiRAnoRdaJAzm3HH3f+As=;
  b=lt5t85F9tqOlOR7zTKJ/sAlynrbTABWRAuVK6F4W4UPjqiwcMcJTpFtV
   KYFKp6+YbLzSHoGJCI7L1mafP7dfmjdgjH9oaiZHXEDb/yNJnsnVjyme+
   6SsIDf24YSTEVHZh/f2rsABelFOoNu+4BKRWx3TXKS3XVhcGUV4fqsSmq
   OCLI/HQvaxB/9EmUJUYKGMwXexsZCzs173RFazaWu/sqs6ebTCp4Hz8Wd
   Cb0F1xwrLu7Gs1N5KTR2uLctjRtRPJfMSTNNNHlt8QIIN/nqTfIaEC9Dt
   wWfFYySg67vTaXD2UmYViXddIfui46IXsbZKlsdJrTjlBTf+1H2SyjE7E
   w==;
IronPort-SDR: LwfLW3dnXZrFX2+PnVyqaXQfLLySwxcCf7soLzI51S0JOVqXkPlaDfh0n3HdLTUHV7oUcKYoDY
 dK9Kzk7FROROlW5NUPLSeOu9u+0GHfSbYCDNIQidA9EaaH2fxHYrgk66uBI9HEKaY3z6yd+Bvo
 R6uHHYpLbyce3my2dLbqjgUXJfY6j6R0j5B7cVzGMMrWUfK5qwbU1S8X9JpYBQ/O+37Q3W8fRv
 M9OGDgDV+BW8aWpjmq/2FD+AXtNBFtg/Gc9J/BZjrgHCTh8p5LAZZ4XYKLBvqGXXWfoL1ydM07
 VtQ=
X-IronPort-AV: E=Sophos;i="5.76,364,1592841600"; 
   d="scan'208";a="146018522"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2020 01:20:46 +0800
IronPort-SDR: 1fDyAO/mpt3ET0pOP0ypNlI7opAnl8mXkYl1VIftVzMhTmcM9IHjSla+pNf6o3tbEj9+WSQNzk
 4xHZpL7/YIVg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:08:19 -0700
IronPort-SDR: DMKenj1WplxHGuwNbsjHFV9MHODA2RxucJWJVYnstOrk1zE0LPtdWpDesbHuzbEc3OTdIuabKx
 2Du80PCFXn3g==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.137])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Aug 2020 10:20:46 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v7 7/9] efi: Rename arm-init to efi-init common for all arch
Date:   Fri, 28 Aug 2020 10:20:34 -0700
Message-Id: <20200828172036.8056-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200828172036.8056-1-atish.patra@wdc.com>
References: <20200828172036.8056-1-atish.patra@wdc.com>
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

