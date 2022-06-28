Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297BA55E3F2
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiF1M7q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 08:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiF1M7p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 08:59:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D3742FFD3
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 05:59:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06924152B;
        Tue, 28 Jun 2022 05:59:44 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EE2D3F5A1;
        Tue, 28 Jun 2022 05:59:42 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: efi: Simplify arch_efi_call_virt() macro by using typeof()
Date:   Tue, 28 Jun 2022 13:59:38 +0100
Message-Id: <20220628125938.694256-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, the arch_efi_call_virt() assumes all users of it will have
defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
forcing the users to create a new typedef when __efi_rt_asm_wrapper()
actually expects void pointer.

Simplify the arch_efi_call_virt() macro by using typeof(p->f) which must
be a pointer as required by __efi_rt_asm_wrapper() and eliminate the
explicit need for efi_##f##_t type for every user of this macro.

This change is done to align with implementations on other similar
architectures.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/include/asm/efi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Hi,

Reference for this change [1] and in particular[2]

Regards,
Sudeep

[1] https://lore.kernel.org/r/20220628125346.693304-1-sudeep.holla@arm.com
[2] https://lore.kernel.org/r/20220628125346.693304-3-sudeep.holla@arm.com/

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 27218eabbf9a..d4a405c9b4b6 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -26,8 +26,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define arch_efi_call_virt(p, f, args...)				\
 ({									\
-	efi_##f##_t *__f;						\
-	__f = p->f;							\
+	typeof(p->f) __f = p->f;					\
 	__f(args);							\
 })
 
-- 
2.37.0

