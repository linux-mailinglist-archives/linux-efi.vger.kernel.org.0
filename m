Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C251711E058
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMJLZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 04:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfLMJLZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Dec 2019 04:11:25 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438302077B;
        Fri, 13 Dec 2019 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576228284;
        bh=bpGXCnZyPTWGYkrE0KmOQkXsAHPqADAMw3xrEU4qZ/c=;
        h=From:To:Cc:Subject:Date:From;
        b=0HOd3C3kCrFkdhYIRnU93X8c2XkuXSHOJj9lq1/G06PRnAh1EROkyKwvDB+JI31fB
         rSBY6xSACPvU60wOT4UFbf6lYpNzLXHO2xb9zc5wbcVOV/dLolyvMhlAIILasj2k1E
         /TsWMszXPXmtfEDODZkH3TVGCsEzNXsSlFsFigfQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     hdegoede@redhat.com, matthewgarrett@google.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub: disable file loading and page deallocation in mixed mode
Date:   Fri, 13 Dec 2019 10:11:15 +0100
Message-Id: <20191213091115.567-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
on low end x86_64 machines that shipped with 32-bit UEFI as they were
built to run 32-bit Windows only.

Mixed mode relies on the ability to convert calls made using the
64-bit calling convention into calls using the 32-bit one. This
involves pushing a 32-bit word onto the stack for each argument
passed in a 64-bit register, relying on the fact that all quantities
that are the native size or smaller (including pointers) can be safely
truncated to 32 bits. (In the pointer case, we rely on the fact that
we are still executing in the firmware context, which uses a 1:1
mapping that can only access the lower 4 GB of the address space)

For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
or UINT64, this assumption doesn't hold. The correct way to marshall
such a call would be to push two consecutive 32-bit words onto the
stack, but given that the naive thunking code has no knowledge
whatsoever of the prototype of the function it is invoking, all we can
do is avoid calling such functions altogether.

The FreePages() boot service is affected by this, so we should not call
that at all in mixed mode. In practice, this doesn't change much, since
in the past, these calls would have been made with a bogus address, and
so we were leaking this memory already. Note that the scope of this leak
is the EFI execution context only, so it makes no difference for Linux.

The other piece of functionality that we need to disable is loading files
passed via file=xxxx on the command line, given that the Open() method
takes two UINT64s as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 0f3dbfed6306..f1f316e96819 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -353,7 +353,12 @@ void efi_free(efi_system_table_t *sys_table_arg, unsigned long size,
 {
 	unsigned long nr_pages;
 
-	if (!size)
+	/*
+	 * Mixed mode does not support calling firmware routines that take
+	 * explicit 64-bit wide arguments. So all we can do is leak the
+	 * allocation.
+	 */
+	if (!size || (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_is_64bit()))
 		return;
 
 	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
@@ -536,6 +541,18 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 	char *str;
 	int i, j, k;
 
+	/*
+	 * Using firmware services to load files is not supported in mixed mode
+	 * systems, because it involves calling functions that have 64-bit wide
+	 * parameters in their prototypes, which are not marshalled correctly
+	 * by the thunking code.
+	 */
+	if (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_is_64bit()) {
+		pr_efi(sys_table_arg,
+		       "Ignoring file= arguments on mixed mode system\n");
+		return EFI_SUCCESS;
+	}
+
 	file_addr = 0;
 	file_size_total = 0;
 
-- 
2.17.1

