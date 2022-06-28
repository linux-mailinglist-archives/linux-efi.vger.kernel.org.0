Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C978A55E62D
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbiF1OSf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbiF1OSc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 10:18:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AED4EB2
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 07:18:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EF981477;
        Tue, 28 Jun 2022 07:18:24 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 270263F5A1;
        Tue, 28 Jun 2022 07:18:23 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2] ARM: efi: Simplify arch_efi_call_virt() macro
Date:   Tue, 28 Jun 2022 15:18:21 +0100
Message-Id: <20220628141821.849643-1-sudeep.holla@arm.com>
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

Simplify the arch_efi_call_virt() macro by eliminating the explicit
need for efi_##f##_t type for every user of this macro.

This change is done to align with implementations on other similar
architectures.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/include/asm/efi.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

v1[1]->v2:
	- Dropped the usage of even typeof() and simply call p->f(args)
	  as suggested by Ard

[1] https://lore.kernel.org/r/20220628125938.694256-1-sudeep.holla@arm.com/

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 27218eabbf9a..bb4d15101de4 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -24,12 +24,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 #define arch_efi_call_virt_setup()	efi_virtmap_load()
 #define arch_efi_call_virt_teardown()	efi_virtmap_unload()
 
-#define arch_efi_call_virt(p, f, args...)				\
-({									\
-	efi_##f##_t *__f;						\
-	__f = p->f;							\
-	__f(args);							\
-})
+#define arch_efi_call_virt(p, f, args...)	((p)->f(args))
 
 #define ARCH_EFI_IRQ_FLAGS_MASK \
 	(PSR_J_BIT | PSR_E_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | \
-- 
2.37.0

