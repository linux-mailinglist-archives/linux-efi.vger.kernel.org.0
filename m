Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4B215D26
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgGFR1J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:27:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41516 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgGFR0i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056423; x=1625592423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/aLmMoaf+R1cfTR4Mi4doOLt0MJCtDnvFjCl4cVqNk=;
  b=ictaNk6ECWDn3089mchVRyCEGTONjp+85LlqIuaOzG4JynP05llMTYl7
   5dXerp90/ml8dG9TzOPIFYRG63wudpriXgKz92pfL2d2odQflkpyWbrW3
   c/ZtZsR/j69JAzKDxObIA3Tgl5l1uSEGTzNxTBVIIez2EFfMDyqBmRGNc
   jvxHZfhc8vvbYVsSPU6F6bQP9wC98/pWbMUxRbR6WcIK+AFn2ybbxBG7S
   E4oraGVhdsIKTIX7Uw6/9+VyqFyAt7VlqwGh4aqwqRnIJAFOQCEGU2vKR
   t1gy/6/CsB9XXKmLFiIaRU42T2exlYWXMcmd1DcGeX5lxz1mflKdyNGUZ
   A==;
IronPort-SDR: 6/+Xbt0A1+A/QSejE9jmBpzs4YJatD583eAf+bOVTjN2xYHdM0LAje8YefaNSQXa3mUoNvF+t8
 o9tZWWRSZ+LiAnFp176IrMXbQahnrc7P+LJ4EKjU5WDxBXirV3t8Wc2VJsxzOyrf/js5v4fKjT
 yac7g5QTXNb/6WRs3KG+a4+rn8wm4/gnPdSM1cTcYDf1SnACsS5IMfxpWcsiVPFPCfDoreHdi7
 mB6ZMgk3Oqz4kSFouqVvM++aujEYH0VuuuT1OQb3xJvB9r8Ag7tBph2eDPp4zg4jUmRPhdEu8O
 Tms=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770187"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:54 +0800
IronPort-SDR: O1Q9/btg6AZ3qbQSvu77tmOqIEc3IsBUPbsALeW/OudZ2WKt5eWzTBn78KArZXcKMKwIWkT4r1
 T+86sNv65k1tgVIrVv58Ydy+jner3l7wA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:40 -0700
IronPort-SDR: LTnJdtYBmdu2sAHNvGIHgGHeR10ZGmc5DB5Q8zbIQxwIWgvrH9f5qhkYP2rNAS5Y7it7R/EMFq
 b2/mz85O6lyA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:32 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 07/11] include: pe.h: Add RISC-V related PE definition
Date:   Mon,  6 Jul 2020 10:26:05 -0700
Message-Id: <20200706172609.25965-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Define RISC-V related machine types.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20200415195422.19866-3-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 8ad71d763a77..daf09ffffe38 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -55,6 +55,9 @@
 #define	IMAGE_FILE_MACHINE_POWERPC	0x01f0
 #define	IMAGE_FILE_MACHINE_POWERPCFP	0x01f1
 #define	IMAGE_FILE_MACHINE_R4000	0x0166
+#define	IMAGE_FILE_MACHINE_RISCV32	0x5032
+#define	IMAGE_FILE_MACHINE_RISCV64	0x5064
+#define	IMAGE_FILE_MACHINE_RISCV128	0x5128
 #define	IMAGE_FILE_MACHINE_SH3		0x01a2
 #define	IMAGE_FILE_MACHINE_SH3DSP	0x01a3
 #define	IMAGE_FILE_MACHINE_SH3E		0x01a4
-- 
2.24.0

