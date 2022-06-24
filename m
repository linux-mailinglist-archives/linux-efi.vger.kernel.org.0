Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5933559D36
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiFXPXs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiFXPXr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 11:23:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0148E47042;
        Fri, 24 Jun 2022 08:23:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F274E143D;
        Fri, 24 Jun 2022 08:23:45 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A00FC3F534;
        Fri, 24 Jun 2022 08:23:44 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Subject: [PATCH 1/3] arm64: efi: Simplify arch_efi_call_virt macro by not using efi_##f##_t type
Date:   Fri, 24 Jun 2022 16:23:29 +0100
Message-Id: <20220624152331.4009502-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624152331.4009502-1-sudeep.holla@arm.com>
References: <20220624152331.4009502-1-sudeep.holla@arm.com>
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

Simplify the arch_efi_call_virt() macro by typecasting p->f to (void *)
as required by __efi_rt_asm_wrapper() and eliminate the explicit need
for efi_##f##_t type for every user of this macro.

This is needed now in preparation to enable PRMT support on ARM64.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/efi.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Hi Ard,

I am not sure if you prefer to add type for each users of this or this
is acceptable. I see only compile time advantage but I am not sure if
it make sense to add typedefs in ACPI PRMT driver just for this reason.

Let me know.

Regards,
Sudeep

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index ad55079abe47..263d7fd67207 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -29,9 +29,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define arch_efi_call_virt(p, f, args...)				\
 ({									\
-	efi_##f##_t *__f;						\
-	__f = p->f;							\
-	__efi_rt_asm_wrapper(__f, #f, args);				\
+	__efi_rt_asm_wrapper((void *)p->f, #f, args);			\
 })
 
 #define arch_efi_call_virt_teardown()					\
-- 
2.36.1

