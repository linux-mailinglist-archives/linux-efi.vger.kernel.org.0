Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3243B5782A2
	for <lists+linux-efi@lfdr.de>; Mon, 18 Jul 2022 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiGRMoe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jul 2022 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiGRMoe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Jul 2022 08:44:34 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A98B0D;
        Mon, 18 Jul 2022 05:44:29 -0700 (PDT)
X-QQ-mid: bizesmtp77t1658148208ture0qdj
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:43:25 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000000
X-QQ-FEAT: 2emgeMsfL/uG/uzL5nLmXFfF5xD76Np0VZSC4AXXJTWY2IJ1TWWY07aTlUx0k
        CL+k1cHscHxHXdM7eABgwz8q+ddYtrLbRVaG1CXJScRdunZHYlmuswGZhGNXyLhOChHZMDz
        CHWOxABkLcJnT7OvestQj5x8r3cF8pXTlTee77kTdjGUcX8V3fXUMS81XYf4syUZDRkaU0m
        WaGvlaRnbM9zteC22S9i5qif+bAyNvnDJf4DSgosuCPXEJZs+77gALuUviwYzXDYm8qh/87
        1z3usgqbgSeAFn33o5jjEbJhHRJUgRCRfrs05QpDAAgEBg/IRYdX63iIaBVNGFgy2gLoCX+
        i2QHrGp02KorPWezPpm1d02dmWa5Xj9QA5SWHYhGFJ0zm3HWHTl4AsBMzCOoKs4Myxyjvxy
        HqRZ9crpmSs=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tglx@linutronix.de
Cc:     ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] efi: Fix comment typo
Date:   Fri, 15 Jul 2022 12:41:29 +0800
Message-Id: <20220715044129.18712-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The double `there' is duplicated in line 172, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/x86/platform/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 6e598bd78eef..ebc98a68c400 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -169,7 +169,7 @@ static void __init do_add_efi_memmap(void)
 }
 
 /*
- * Given add_efi_memmap defaults to 0 and there there is no alternative
+ * Given add_efi_memmap defaults to 0 and there is no alternative
  * e820 mechanism for soft-reserved memory, import the full EFI memory
  * map if soft reservations are present and enabled. Otherwise, the
  * mechanism to disable the kernel's consideration of EFI_MEMORY_SP is
-- 
2.35.1

