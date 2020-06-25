Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18620A962
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFYXp0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4086 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgFYXpZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128724; x=1624664724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dZDSjJ3t1MSIr8n8TsrQ491YhsMuw7KafK1O8BitsUU=;
  b=cQCibGuR6nNh7BWB+7oXpQeHmaHQICB8awXUauZDFOhibB+1SNw2FIUT
   7YHNnd0ODyhgxBeb0risjHcHR7cOkgimG6+PDqdUtIVdR8DhEYBPczId9
   XRBah66uLB0QhQ6xv/AyxToZtjHdQdNDZuTtncYvdfIOkkC8VA1PxGn0Y
   4lYAlr6fOBnYa0/tr1rg8fo1EoVBuava2P/wKVmztsgyw+bGJYay+8imW
   ajd26hC2oMiwjmQjYyyyJTNBoEIW9Vd7hA3pifenv7sPC6ArDdm7hRGnN
   YAwIjnVde2dxHNUXb3yVLG94lcfXuDtf6jgveI45uMXLrsfg2vyEQvr3e
   Q==;
IronPort-SDR: pE+luNhOycacCBTZcX8Mk01FIbyZSJr1DM+zOS2rB4yNHeQWStxKGcF+UlkpnVjTnmWAuWnwcY
 6EzUSQJnBGiJqft/3YfPaDPkZ9MC4FQYJRqWE6Fw1ul1YEtlYwO8qHDyw6xmBfN76e1QnYkw2O
 x5xvNMe66Kaw+mr/5ktLGdaJx3jo4yzLt4R+sN0ELBjn3CTTnjD4rUqHPhHtt9U+anRxJYJOrm
 EkfIb9ZfJjyrVpSO1xQFUmDQl/DkCljdHrdeeoNSuWuqFEmHGiQHhvNhXN65RdenXqCPygqPGH
 ge8=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953450"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:24 +0800
IronPort-SDR: hrNF5+8L8ibiM9VFdbUQKloDM7RqMuvvFYnsb5NoGYg6tpxui5P2gsfJlpWr8t+54Kli6Kwcwt
 it/UP0NN6tr4vEDB/7fCFP+YWfaNmIAUg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:24 -0700
IronPort-SDR: hEw8ADmFsS1UNhDNRtJDi5RD8kl6Gt14KhsVC7MOMicSCEZm24PLXIM1GWGlN1n4WMslGowcYZ
 4BLBjmH2ILnw==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:24 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 01/11] efi: Fix gcc error around __umoddi3 for 32 bit builds
Date:   Thu, 25 Jun 2020 16:45:06 -0700
Message-Id: <20200625234516.31406-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

32bit gcc doesn't support modulo operation on 64 bit data. It results in
a __umoddi3 error while building EFI for 32 bit.

Use bitwise operations instead of modulo operations to fix the issue.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/firmware/efi/libstub/alignedmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index cc89c4d6196f..1de9878ddd3a 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 	*addr = ALIGN((unsigned long)alloc_addr, align);
 
 	if (slack > 0) {
-		int l = (alloc_addr % align) / EFI_PAGE_SIZE;
+		int l = (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;
 
 		if (l) {
 			efi_bs_call(free_pages, alloc_addr, slack - l + 1);
-- 
2.24.0

