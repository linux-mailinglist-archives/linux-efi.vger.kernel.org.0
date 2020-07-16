Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68BF222F39
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jul 2020 01:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGPXlW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jul 2020 19:41:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7103 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGPXlT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jul 2020 19:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594942879; x=1626478879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/aLmMoaf+R1cfTR4Mi4doOLt0MJCtDnvFjCl4cVqNk=;
  b=r7QsZjKUNI8QBZPcaOjHSIKMEHvLinv2XV4nHJkUXJk2Tm2iXelGAkla
   0+F+YC/049oVrUxoJG9BSXjPmo9bdLfYKP6NsFrBU6qRho2uN2jYQj0i+
   XfqxC1fDLXn0/2i3HQiMb97+EKOJ0yShmKN9LI2kfsDzTq1diK0A9ttu5
   SftdcPvLuzxKIIE62pJYkkDd+jYwjm1nYJFaw4WFojbF6VSFBUo6tvQFn
   bODExy9EPK+G/5e1KE9ua8enR3uz7oWKsRu1hodZBl31q5il7bwP7NoeJ
   E8Lrl74asRxEjzbWaAPXsUTEVdtatBdsd8nGjafn55TpwERTsAMV0Bz8b
   Q==;
IronPort-SDR: n8nat28bz9GS2+SNJeLMO8IEaPsRtxa51GIT0oCqAX58gA/KisvgIMM6punm8AtkaV3Yse6wV/
 CdgomydHn1QmyvOmiHgad3vKqYyW6APW1lac8KqyJcR3su3tQGZIJAejPqn2DJZSWrm6v1dmaP
 /WQAZ8ONhdTOZ8CYvfnhtgtfghH/1wr4NLSucCy+pIH9UOCu/UliMyybTtwX5ty8U9nG4Y+pwC
 5lVBO8PQhAKGWLANW5WKWA8SLiQ0jFOm2QHud6z143Uag2Qz6rPynJLvgBQusJ42rX+YwASYoK
 Prg=
X-IronPort-AV: E=Sophos;i="5.75,360,1589212800"; 
   d="scan'208";a="251923216"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 07:41:18 +0800
IronPort-SDR: x6VY320J3nEx0ve/kFyEbupTLabn0dxMSub/FE/rLw6q7i6jlN/v5lWLPQ6VjKy9f3g1SdOzzB
 T7ru4dDghY23y4D6t6tHxjrIa5JturZ+Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 16:29:42 -0700
IronPort-SDR: mvb6V7T1kzM/mdVXBhPssCnk0svEdQRax5iRV/H9DXHuJJ+ah2FZShI5xbLjomx4rNIMC/I1z+
 jV7WUySWQxmQ==
WDCIronportException: Internal
Received: from phd004806.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.54])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 16:41:17 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anup Patel <anup.patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: [RFT PATCH v3 4/9] include: pe.h: Add RISC-V related PE definition
Date:   Thu, 16 Jul 2020 16:40:59 -0700
Message-Id: <20200716234104.29049-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200716234104.29049-1-atish.patra@wdc.com>
References: <20200716234104.29049-1-atish.patra@wdc.com>
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

