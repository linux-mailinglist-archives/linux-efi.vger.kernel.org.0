Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6811243180
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 01:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLXsv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Aug 2020 19:48:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52579 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgHLXsi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Aug 2020 19:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597276119; x=1628812119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6HBziqjPfpEOovieQwcPFPkqxzZPptEH0FVtMgRIac=;
  b=O0maVcWYWJm0JpWK7Zwf6EtJmsROG1Z/4hfPcLAge2aIgCFW1e9jK8sv
   MMJ/OXA9DAlJK3H1Et/3YDxv4CHNx4CY20iFL0z4OwRrglg+3qqw2j83M
   dCOz8NdYj7S+IDvad51PyBmpwRwUQBdsKXm25jCVRjbo6fzfZCl/KX41W
   NGM5p6tHfUKmOdwFIFG9MNKXY96CnzyGInRJvwgMj3Z/yDBRB3DRL7ABA
   tn1XZr5BKv+t0gGMK+Rf4dmh6d5+9+NpnI7ZM39kjK2OLonSRRqJrw3v7
   eN97rNUNE9n1GUDv4EI8WfFpykT0U/zp3rrf6T44LS3TrdkXiRooTM/Go
   Q==;
IronPort-SDR: mdWAqeG/WM5U6Me8T8iwNYlvmIQDsJ91FXsaj+5MUkPyRzFwZXObl73brhzIgp0MpJtNOUUynt
 LPIqyJVLw+iLgRR8j6R33RZDtr5HdXkxG/fNHjB98LA1ulKorOurhFERZuUSgtkuDsH3+IYcvU
 ehBxtZDPolGGGF94ASeVKgMqXG07MB7rtXp55TmVHw/5APO3/jVRnrR9Y++7y6ZrbVJ0nK/loc
 N3VLdizvG8wMSfTxZbZKeL2ujo8YvN5ir8kJ16rzfRRECKKQsEStrk1ddsQKiIvCp7Fae3/nHT
 UZA=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; 
   d="scan'208";a="149145678"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 07:48:39 +0800
IronPort-SDR: 2cJGOk8TKvdhZPOyjZrNC3E8YJ2J9vCckyrtOKkETXy2gOVZp5ysyYwmbJrLYNLqUPDGcqd9sD
 li9wemJyYWaA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 16:35:46 -0700
IronPort-SDR: O+vleDwdgNpf3+2oP8xArSX/++jjUSr7GNwSK8op4zl/Hvx9QM238mzPfMh8vi6BCgYI+Tv0sN
 qx8sx+6zXXqw==
WDCIronportException: Internal
Received: from usa002576.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.59])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 16:48:35 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH v5 7/9] efi: Rename arm-init to efi-init common for all arch
Date:   Wed, 12 Aug 2020 16:47:56 -0700
Message-Id: <20200812234758.3563-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200812234758.3563-1-atish.patra@wdc.com>
References: <20200812234758.3563-1-atish.patra@wdc.com>
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

