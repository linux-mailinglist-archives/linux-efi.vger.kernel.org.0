Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA9340CCE
	for <lists+linux-efi@lfdr.de>; Thu, 18 Mar 2021 19:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhCRSVF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Mar 2021 14:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhCRSU5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Mar 2021 14:20:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A362164F1D;
        Thu, 18 Mar 2021 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616091656;
        bh=gVJl4kPht+oxkeuEuGnBtMPQ5kdYUCGId4HBATLbc1w=;
        h=From:To:Cc:Subject:Date:From;
        b=LwsMesVsfBq4YQKl7j1CRVV0i9wlLgkFmcK5pg9KYFSsU+f2FiURkd9/FdNgx7/X1
         v0i/25EVV5t27+9DtJ9iq9et7S5Y+zpnb2TPuVYKWxLx16sGoctoktLu/VCO4kTe4I
         o0vP6wQNE0xE7IEK2t0hmlbgGokxk4NXyfcG1LnFkz4z+UFItQWmJ+dICUaAqAVt1P
         v6t6/hy0n+kt5ECclOW9RJquCSJbriZJTT1gGdd5XvOh8tDfF2RYPtzyLxLJNWB48w
         r9zr+01KB29SYcauyWSGZYJ2mjFQHZ1Oaa8B/SlthW9/66YQ1WbDsJ4p5EVUXDWq1M
         zqws96vl5ja2w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] efi: use 32-bit alignment for efi_guid_t literals
Date:   Thu, 18 Mar 2021 19:20:46 +0100
Message-Id: <20210318182046.211165-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 494c704f9af0 ("efi: Use 32-bit alignment for efi_guid_t") updated
the type definition of efi_guid_t to ensure that it always appears
sufficiently aligned (the UEFI spec is ambiguous about this, but given
the fact that its EFI_GUID type is defined in terms of a struct carrying
a uint32_t, the natural alignment is definitely >= 32 bits).

However, we missed the EFI_GUID() macro which is used to instantiate
efi_guid_t literals: that macro is still based on the guid_t type,
which does not have a minimum alignment at all. This results in warnings
such as

  In file included from drivers/firmware/efi/mokvar-table.c:35:
  include/linux/efi.h:1093:34: warning: passing 1-byte aligned argument to
      4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
      access [-Walign-mismatch]
          status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
                                          ^
  include/linux/efi.h:1101:24: warning: passing 1-byte aligned argument to
      4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
      access [-Walign-mismatch]
          get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);

The distinction only matters on CPUs that do not support misaligned loads
fully, but 32-bit ARM's load-multiple instructions fall into that category,
and these are likely to be emitted by the compiler that built the firmware
for loading word-aligned 128-bit GUIDs from memory

So re-implement the initializer in terms of our own efi_guid_t type, so that
the alignment becomes a property of the literal's type.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8710f5710c1d..6b5d36babfcc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -72,8 +72,10 @@ typedef void *efi_handle_t;
  */
 typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 
-#define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
-	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
+#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {					\
+	(a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff,	\
+	(b) & 0xff, ((b) >> 8) & 0xff,						\
+	(c) & 0xff, ((c) >> 8) & 0xff, d } }
 
 /*
  * Generic EFI table header
-- 
2.30.2

