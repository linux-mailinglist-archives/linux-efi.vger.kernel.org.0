Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4696255F96
	for <lists+linux-efi@lfdr.de>; Fri, 28 Aug 2020 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH1RVF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Aug 2020 13:21:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11689 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgH1RUv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Aug 2020 13:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598635250; x=1630171250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/aLmMoaf+R1cfTR4Mi4doOLt0MJCtDnvFjCl4cVqNk=;
  b=SuQTVVx8rLPwIJdvNnNBSbGinLP1VDhYyTxTJKIp0DzyHEwVa70PCaGh
   xmZx4A6S6gq6KVOB++4yHvzdkOu0056y8QRb9sEv/GdCPwPZZHiratt1f
   pCauP2+5fenfqSVqxuRYtGEGwJ6qLulPBh/XwvJgoLUigi03CJUArDBB3
   RujCLObYKfl5GTvcBPEvAxDfvG45gfYdhklni+gEKHxuCYGdj7G2ry/uQ
   djUOif3HznN1iU9rZ70Lei4qh31LltmbMmaw7qzkpAxN8rjCs9oLRQlmQ
   pqVzme/WjgOtuHT7zvVI9MlakNcRKbrR6RS4UT0RA89kxlpd2BFod+ge7
   Q==;
IronPort-SDR: ArI+1Z/4Az0+RBpUaIKIF1SSdDQL5Juyyu1d3NLKkh+sg/gkcUO+rEMNEOtme1AVAYYFXk+NsI
 vD4xnkBDnqkKBNVnhHuKGe8zHJdVuc05/oQ5gub2A5AEGaULMlszWvpBq1sWSJG+Obmm+cUGJ4
 BUvwtLnbW0FmLP2T9cGc8fuAgqzEwRteNkxmp76339gezuHB2v1d4pGomwey3+RtvpBAkB7Ucn
 LtCoUOCf3CpBtY+ROWB1isGIJfos+V7Kix68WMiq4lsD4GB6ZJMxDupmverNHNECKK4GU/4s6W
 2SA=
X-IronPort-AV: E=Sophos;i="5.76,364,1592841600"; 
   d="scan'208";a="146018515"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2020 01:20:45 +0800
IronPort-SDR: mCgtZpw4e4P6+ECsjoWkr0Jf6gzOmWdMlNxDxWuDUuPjNYf8KS2hNuxMuur3SIVGajEW15FMja
 mUdMwlSGvG8Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:08:17 -0700
IronPort-SDR: ZTyP3mzi45xXb/+m147BTGWwAF6GtiLXedYwJhhQekkEgjpwYpbo6+F+/IIBdcv4sxJ4ZLuu5A
 eq1Xay/iPsAg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.137])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Aug 2020 10:20:44 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
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
Subject: [PATCH v7 4/9] include: pe.h: Add RISC-V related PE definition
Date:   Fri, 28 Aug 2020 10:20:31 -0700
Message-Id: <20200828172036.8056-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200828172036.8056-1-atish.patra@wdc.com>
References: <20200828172036.8056-1-atish.patra@wdc.com>
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

