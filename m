Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2671524317F
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 01:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHLXsg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Aug 2020 19:48:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52579 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHLXsf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Aug 2020 19:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597276116; x=1628812116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/aLmMoaf+R1cfTR4Mi4doOLt0MJCtDnvFjCl4cVqNk=;
  b=FurpFRzZ2ZuhQ8LvBsxFVzQdS1WLcpb9fG7TJNHQqAgpketbdIP7VPlT
   IzAIOHtZGOCbowaAclBa0me2gGLLIbUI5OaMvBHNXS2Xio9V0zz7TK2C1
   qxXgU+PmWzaWFj0KEq0EffYOpYy+q6ewVfzf0Qb2FBOQ1aZ5DNP1Hf2ou
   ahRwYwuuhHWO1hj4zYOC/fHMGUuvE2AtzOpmvONNWOguxAQtcTUk93C1u
   h3+qvl9kbVC/bk/rMdJEGg0TpOz+KMjCJLEtlhdDgj2jyINslY/sLM9P0
   E2CF7siRVFozbAEwxMJ7Y9sNPu68/hW84RzSUyDsYqe3XF4qTp25aswMV
   A==;
IronPort-SDR: VdNjFKQlHDSRckQfSy7BZcxq8U5O7GE4e5oHtJX592fhtkGJQ0gzNsA+FQqxsTrhjRRzXaRsIu
 Q/4agqjSZ5F5cFuJELI7wIB9qf0toc2jjLjxdmYXXF//etrHHAL+cc+n4iK7Kzr6L2Qgk8H1Qe
 kfnLy6XyMJfONu5aEiuKoPg9lg3v3meWkAiTHDD4USZHPi3pE4trPDAq322w3qFecmF06I0+Fk
 EO6Zz9MNYQSSAsjy5sWz0hTY7eZt7BSOsMJxKga9dTxk/VZqw6kWSvlp65zJBjncToyDiMWXKp
 3QA=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; 
   d="scan'208";a="149145669"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 07:48:36 +0800
IronPort-SDR: FfatyBmrFppYGe30QXMu0ENmEv37kR0JnqgMHgV04Iy2MBoa2QXgy8vebztVwrNp4fsOXe57en
 DErI3Sip2gYQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 16:35:42 -0700
IronPort-SDR: P3ovugPv+fDHQa0kXG4xONb+xNMYChSxVI7c1P6E62oC4EfAS3HLQYntJ5lU99kbUACcLa5o7B
 X4ihSkv+Dn0w==
WDCIronportException: Internal
Received: from usa002576.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.59])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 16:48:32 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, fwts-devel@lists.ubuntu.com,
        Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: [PATCH v5 4/9] include: pe.h: Add RISC-V related PE definition
Date:   Wed, 12 Aug 2020 16:47:53 -0700
Message-Id: <20200812234758.3563-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200812234758.3563-1-atish.patra@wdc.com>
References: <20200812234758.3563-1-atish.patra@wdc.com>
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

