Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4701C2DA3
	for <lists+linux-efi@lfdr.de>; Sun,  3 May 2020 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgECPpS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 3 May 2020 11:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbgECPpS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 3 May 2020 11:45:18 -0400
Received: from pol.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8307420661;
        Sun,  3 May 2020 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588520718;
        bh=sbrTzDtXJoN3GJZ0eRoE/uDzacCvvwMz5g4VZszk/gY=;
        h=From:To:Cc:Subject:Date:From;
        b=qPq9Nzazm1UDQ9AnIm9UGFAHYsqvDJXYeblQ6NK3OX9MpEqWYfcnbTEH5jsII/AZ6
         goKqNNysxfRZVIAGzaMWtVus8OfQkVFGpR3AdHEOKxq5WJTi1AN5S/HC2DzxclA8Wb
         72MKcrn7IY2UWYrnOI948YUFCgabU2+wSxTKjT8Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux@roeck-us.net, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub/x86: fix mixed mode boot issue after macro refactor
Date:   Sun,  3 May 2020 17:45:07 +0200
Message-Id: <20200503154507.82880-1-ardb@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  22090f84bc3f8081 ("efi/libstub: Unify EFI call wrappers for non-x86")

refactored some macros that are used to wrap EFI service calls, and
allow us to boot the 64-bit x86 kernel from 32-bit firmware. Sadly, due
to an oversight, this caused a boot issue on mixed mode, due to the fact
that efi_is_native() is not a macro on x86, and so #ifndef will not
detect that it is already defined.

Fix this by defining the macro as well.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cd0c3fbf6156..42b2fd123a2f 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -240,6 +240,7 @@ static inline bool efi_is_native(void)
 		return true;
 	return efi_is_64bit();
 }
+#define efi_is_native efi_is_native
 
 #define efi_mixed_mode_cast(attr)					\
 	__builtin_choose_expr(						\
-- 
2.26.2

