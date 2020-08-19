Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928224A952
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgHSWYz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 18:24:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16013 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHSWYw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 18:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597875893; x=1629411893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/aLmMoaf+R1cfTR4Mi4doOLt0MJCtDnvFjCl4cVqNk=;
  b=XIlJFMYi8LYfJEI6fFdhEKiJ1SpC1wLprWkfFGRpcOuujbcmGb5ebxZQ
   u0NYScNVZ5PTeoq+TL9VrcVODD6UAyLrfXtiGpN8TcMLA0qw+PA9bIBzV
   s6MzpRQYZ0dY3TuXPYL09j2d2uLHv1kt9nCHE3cMMDa8S0DDC24luJu3n
   PyXD5rsRhs68xkuJYiFTn/q8fU5/X3jr6WxLa+PDTMRKqA1jrRGBP2ExO
   5s9EGmItgxs2mOKILpmKLiH1ec/1/mq1BSstQHhfFgsevuP9PGyg3Ncaa
   VSJTpdzdgA/nDSZx2opvY+Bqp+ZfwoaFAQBJw96KxEGrOzAa+p4JyENKm
   Q==;
IronPort-SDR: itF1sLMymDV99N5YrbMJuFcUFhS6lp6avD8vAXQUPSpRL/LX8clCUTCmCuQFucSg7J3Y55ZGAd
 xvT24m/XrAI04q2mY/nTByZpcIH8p+CzefQG+RJx4SZ+fErOGbraSU5lNy4ODmaRamHWz6XKON
 emK8yJU2enzlQzNCwpA0VVvNaUenpkjCNNHzKjh0Livw+LGILgv0HkVXV3+As8DTsry/is03OG
 YhzCNcO8NO9HxbXbgYHRKlbKWXbfl5VephDajcI5r6YHvFOPt8Eom7Glj6vGlvUkRpoCJ78UvH
 aaQ=
X-IronPort-AV: E=Sophos;i="5.76,332,1592841600"; 
   d="scan'208";a="145373602"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2020 06:24:35 +0800
IronPort-SDR: Blxsm2MpzXn+vTqeyPJgf/EIqUDlZMIYcdYlYaCVJQOVBbtFuLhDuA87A/shhp9aC9HTt8S58L
 epqXyRVbUq7Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:12:17 -0700
IronPort-SDR: 1epdToIyuDzZ4UJ/vsNBMIOLC82OPuo1rQZCyeBGFJvRm1nEU/fO6IxiC9Hl/KtZQq6gpQZ0OH
 X+bF6A7SGjYA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2020 15:24:34 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
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
Subject: [PATCH v6 4/9] include: pe.h: Add RISC-V related PE definition
Date:   Wed, 19 Aug 2020 15:24:20 -0700
Message-Id: <20200819222425.30721-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200819222425.30721-1-atish.patra@wdc.com>
References: <20200819222425.30721-1-atish.patra@wdc.com>
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

