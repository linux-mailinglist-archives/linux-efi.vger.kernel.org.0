Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF80535ACA
	for <lists+linux-efi@lfdr.de>; Fri, 27 May 2022 09:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348431AbiE0H5i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 May 2022 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348610AbiE0H5Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 May 2022 03:57:24 -0400
X-Greylist: delayed 127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 00:57:17 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B3F74A2;
        Fri, 27 May 2022 00:57:17 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id VCE00104;
        Fri, 27 May 2022 15:55:04 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2308.27; Fri, 27 May 2022 15:55:04 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <ardb@kernel.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] x86: Fix all occurences of "the the"
Date:   Fri, 27 May 2022 02:14:00 -0400
Message-ID: <20220527061400.5694-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022527155504451bf6831600ff91ca03effc82286c60
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rather than waiting for the bots to fix these one-by-one,
fix all occurences of "the the" throughout arch/x86.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 arch/x86/kvm/vmx/vmx.c               | 2 +-
 arch/x86/kvm/x86.c                   | 2 +-
 arch/x86/platform/efi/efi_thunk_64.S | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e0d3bea73b28..e1aa14743cdb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6221,7 +6221,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
 	/*
-	 * This code is only executed when the the flush mode is 'cond' or
+	 * This code is only executed when the flush mode is 'cond' or
 	 * 'always'
 	 */
 	if (static_branch_likely(&vmx_l1d_flush_cond)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b5aeed18b9f5..921b1139c303 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11940,7 +11940,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (current->mm == kvm->mm) {
 		/*
 		 * Free memory regions allocated on behalf of userspace,
-		 * unless the the memory map has changed due to process exit
+		 * unless the memory map has changed due to process exit
 		 * or fd copying.
 		 */
 		mutex_lock(&kvm->slots_lock);
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 854dd81804b7..9ffe2bad27d5 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -8,7 +8,7 @@
  * The below thunking functions are only used after ExitBootServices()
  * has been called. This simplifies things considerably as compared with
  * the early EFI thunking because we can leave all the kernel state
- * intact (GDT, IDT, etc) and simply invoke the the 32-bit EFI runtime
+ * intact (GDT, IDT, etc) and simply invoke the 32-bit EFI runtime
  * services from __KERNEL32_CS. This means we can continue to service
  * interrupts across an EFI mixed mode call.
  *
-- 
2.27.0

