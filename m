Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8931C4F16
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgEEHbJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 May 2020 03:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEHbJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 May 2020 03:31:09 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C03320663;
        Tue,  5 May 2020 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588663868;
        bh=0UX/KE5NPn6JSiA254bGg/BusFMtpcXn/r1pNYgqK6I=;
        h=From:To:Cc:Subject:Date:From;
        b=Hd0c5/vEAMKor/CWxJLx/7dXEDingti1ybAoxl27pm+31UQo1KGWpN+P7kMD0Fmqs
         2KP5clMYh0Nu5eTv+nvuF26DRlZKJpXIUulW086l784jfOLoce0m82YKI/BbQXQ0rQ
         dLew2KBisuNjy7ISsG4Qt66gTqVcD97E95chnZks=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     arnd@arndb.de, clang-built-linux@googlegroups.com,
        maskray@google.com, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH v2] efi/libstub/x86: Work around LLVM ELF quirk build regression
Date:   Tue,  5 May 2020 09:30:54 +0200
Message-Id: <20200505073054.22437-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When building the x86 EFI stub with Clang, the libstub Makefile rules
that manipulate the ELF object files may throw an error like:

    STUBCPY drivers/firmware/efi/libstub/efi-stub-helper.stub.o
  strip: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10
  objcopy: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10

This is the result of a LLVM feature [0] where symbol references are
stored in a LLVM specific .llvm_addrsig section in a non-transparent way,
causing generic ELF tools such as strip or objcopy to choke on them.

So force the compiler not to emit these sections, by passing the
appropriate command line option.

[0] https://sourceware.org/bugzilla/show_bug.cgi?id=23817

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8d246b51bd49..e5a49dc8e9bc 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -30,6 +30,7 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
 				   $(call cc-option,-fno-stack-protector) \
+				   $(call cc-option,-fno-addrsig) \
 				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
-- 
2.17.1

