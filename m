Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65759215D10
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgGFR0g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:26:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41516 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgGFR0g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056420; x=1625592420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5X06JHUw7otD1cmcj2n/lx5hX3r8VhRKMlY+7ax6kt0=;
  b=gzBctf0jJmkRcUnRWlZh6eAXP7eYqlDKoL3DeJbn3rpUhBmjduLd6BKz
   k/LZ5c9drmFHRleufi6wzhl0xShH35AD4TKqecL1EAMVLl++PFw5mKzFy
   9SpZvbJ+wZPHdXApkE/1WfuCYJbg+Lyc4TGvGrAZdMqxPCVAD1rp3vzb3
   O6/cwCW/5H3Y1fI2FC6v+Ze3MMx5dAdobTAPZ/xkDBOwowEDwavcdwX5g
   NyN7mSfxRT3NOHMVq1xGENeRzHhfZOAANqvS4kJTKjoFejPuwBLpxQCtj
   UFXXgSTSBMZ3a12KIUfUZryBW1zsjqAHoTpitZdDAfIFRZchwwtftnPZy
   Q==;
IronPort-SDR: uGC4d1lEWs1gZWris8ckjB0QJ1kynDEIx79rofSV8pAeIYB20/F5RBY75MuUJcaSKBNdUu2gO6
 X3rOJP4Nf8FH6+HtaffhiNhHGRokeIMDYyP4j68JirUATjaLhk95wzs94V5ZVIo6bgJ47Hl7k+
 gs6kpFSOY8MX4elRKU3KWP8ewh0U4GSyG1uWoyV6wOi2cGYeDttr8V33aEZptVuWGuawKAmjcc
 hFoa/skNNOi4H5937s92s9BJmybHwI/Bw4qLcLkbmNFt2OFHz4PSmFNFtO1DRAyGTI/NJoyVIE
 krk=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770171"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:51 +0800
IronPort-SDR: lMBU/ddQr67XN8qJBYZD8vTdHqenVIfpdBrN1xj3R7ZYpFsItTuLSKvovGfKUHOzXzlsQETQai
 nS0bfoJsYVsCtrtsHCWMfs+mXikSah6Ps=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:38 -0700
IronPort-SDR: 0rNpNsBq9dJOaB/dCBImZi7qAbAVgQqcgUJOA8uQYYQJVZAspFE89p4TnGiU1Hf8fagRuuQmdt
 XiMqzYA3FRDA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 01/11] efi/libstub: Move the function prototypes to header file
Date:   Mon,  6 Jul 2020 10:25:59 -0700
Message-Id: <20200706172609.25965-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The prototype of the functions handle_kernel_image & efi_enter_kernel
are defined in efi-stub.c which may result in a compiler warnings if
-Wmissing-prototypes is set in gcc compiler.

Move the prototype to efistub.h to make the compiler happy.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/firmware/efi/libstub/efi-stub.c | 17 -----------------
 drivers/firmware/efi/libstub/efistub.h  | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 3318ec3f8e5b..a5a405d8ab44 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -121,23 +121,6 @@ static unsigned long get_dram_base(void)
 	return membase;
 }
 
-/*
- * This function handles the architcture specific differences between arm and
- * arm64 regarding where the kernel image must be loaded and any memory that
- * must be reserved. On failure it is required to free all
- * all allocations it has made.
- */
-efi_status_t handle_kernel_image(unsigned long *image_addr,
-				 unsigned long *image_size,
-				 unsigned long *reserve_addr,
-				 unsigned long *reserve_size,
-				 unsigned long dram_base,
-				 efi_loaded_image_t *image);
-
-asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
-					    unsigned long fdt_addr,
-					    unsigned long fdt_size);
-
 /*
  * EFI entry point for the arm/arm64 EFI stubs.  This is the entrypoint
  * that is described in the PE/COFF header.  Most of the code is the same
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2c9d42264c29..85050f5a1b28 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -776,6 +776,22 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_size,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit);
+/*
+ * This function handles the architcture specific differences between arm and
+ * arm64 regarding where the kernel image must be loaded and any memory that
+ * must be reserved. On failure it is required to free all
+ * all allocations it has made.
+ */
+efi_status_t handle_kernel_image(unsigned long *image_addr,
+				 unsigned long *image_size,
+				 unsigned long *reserve_addr,
+				 unsigned long *reserve_size,
+				 unsigned long dram_base,
+				 efi_loaded_image_t *image);
+
+asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
+					    unsigned long fdt_addr,
+					    unsigned long fdt_size);
 
 void efi_handle_post_ebs_state(void);
 
-- 
2.24.0

