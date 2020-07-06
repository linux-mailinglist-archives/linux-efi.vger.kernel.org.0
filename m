Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABCB215D19
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgGFR0k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:26:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41516 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbgGFR0j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056425; x=1625592425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6HBziqjPfpEOovieQwcPFPkqxzZPptEH0FVtMgRIac=;
  b=SdIdrOrDpFbHjBj27yxCk+NHUU8PNW0u0peQdWCdnnhPVAODIBk0Gnx+
   dK5Y3J0Gkijh67zt9qd2BhmBXgSbeb1cJ4mbEHZX2+SfvUtxg4+j2viqi
   7hyhE9BZTb46px0WWfa3nBbPk1vqzIik2Y5Nt1ePP7XlJG9xni9iS1ojg
   RI1EWbQKBbtlhcdNy4lgvEDstq6ZGjhmH9Lu/96rSNglJPv8oUD4c+Qg6
   7omTT4C8GQCn4xGHcwzSk3ijbX7XELjATI9itRlEbd2Bmw386UD/jwA3v
   1NA4FnfA8Qd/nZxwxj7hZRX/wadRXVdpcETDkguJZU7tSH4Ri9DTai2CN
   A==;
IronPort-SDR: iw4MRH1zDt0nA0KBfaVrWklw8B+zBEbj7cMpWBsVQcBPXbx/2wIbiO7NEce6h+UTFcsepbWLR6
 Jx31DAFzMu2sPmT1/GAwVAVOqbJXtxjZJWOkRi+HkNqUoNOHV8FnrdJXOOC24GZDg92a5Uy7MW
 M6rERywTOKEyINubO6NuxOsUcpXoGjjNjYND4pdOKlAWUfDiTMsEl7kIsZSAMN5W7azlFPO+tz
 MJ1svWj/F+S2rCe8xvEX5Q8yFO0HRLocKvdmMRYefxWv5EeUY471AOHhAU4viXgo5jAFXiKUQ7
 vHk=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770195"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:56 +0800
IronPort-SDR: hcW3Zne+TmD4cHTdSmgSYyHUop651IyN6UoeDB6vI37z4tIRWCquunF0Qs9362CpaVUnisyyBo
 ny4p8nrrL1/1Xo4ep0d+OqDyf6ZW1Q1xY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:41 -0700
IronPort-SDR: fc+bi6bmnTcCFuCWM/PJW/yBtOU6y4/pHTfXU1Clu5VWt4q9Ry8RKZYrjsn3CC61aOfXjrlJif
 vRay6P2HQtfQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:33 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 10/11] efi: Rename arm-init to efi-init common for all arch
Date:   Mon,  6 Jul 2020 10:26:08 -0700
Message-Id: <20200706172609.25965-11-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
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

