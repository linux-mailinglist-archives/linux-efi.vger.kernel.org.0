Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BF333711
	for <lists+linux-efi@lfdr.de>; Wed, 10 Mar 2021 09:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCJIMq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Mar 2021 03:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhCJIMR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Mar 2021 03:12:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7B6D64F37;
        Wed, 10 Mar 2021 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615363937;
        bh=JG/KDVDWKQuLL2FjCZ1/wjC/6c4Hfq0whZC1yeJa7I0=;
        h=From:To:Cc:Subject:Date:From;
        b=NDS6gjWeQiAzqHXxRXyYEgSuWjIWMMR4sHpaULizZb+Njx760E0UiEXQ/JS9tqsRp
         aZC1Zc/mP89FUqhoWls+OLQgpv/Q5LxZiPWb3V9WlpLrTuSI/XJvD9T9XqbdI7S1tz
         mJ355veFHanCJGU94fuvqCkvuqGUs5OWVYEpBZtzUVsbcEAVkg1hh01ahv22lAOJFJ
         0ohYBDUkGIkzCgesfteDiJotmGT/EfLWlSFgbzVPVzHvBKMsx9owxwea9mepRaLOaH
         jyDXJOo+3o4Xlg+coZYdEXlIetxrNQWOMa+wg9VR6qmJOLpMCv8bEKD8QG3lm3D40N
         GIAQkKZiGpoRQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] efi: use 32-bit alignment for efi_guid_t literals
Date:   Wed, 10 Mar 2021 09:12:10 +0100
Message-Id: <20210310081210.95147-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
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

Instead of bodging this further, let's simply switch to our own definition
of efi_guid_t that carries a uint32_t as well. Since efi_guid_t is used as
an opaque type everywhere in the EFI code, this is only a minor code change.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---

I am currently testing this change via my for-kernelci branch. Please give
this some soak time in the other CIs that we have access to.

 include/linux/efi.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8710f5710c1d..f39e9ec7485f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -63,17 +63,22 @@ typedef void *efi_handle_t;
  * is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
  * this means that firmware services invoked by the kernel may assume that
  * efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
- * do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
+ * do not tolerate misalignment.
  *
  * Note that the UEFI spec as well as some comments in the EDK2 code base
  * suggest that EFI_GUID should be 64-bit aligned, but this appears to be
  * a mistake, given that no code seems to exist that actually enforces that
  * or relies on it.
  */
-typedef guid_t efi_guid_t __aligned(__alignof__(u32));
+typedef struct {
+	u32	a;
+	u16	b;
+	u16	c;
+	u8	d[8];
+} efi_guid_t;
 
 #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
-	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
+	(efi_guid_t){ a, b, c, { d0,d1,d2,d3,d4,d5,d6,d7 }}
 
 /*
  * Generic EFI table header
@@ -598,8 +603,8 @@ efi_guidcmp (efi_guid_t left, efi_guid_t right)
 static inline char *
 efi_guid_to_str(efi_guid_t *guid, char *out)
 {
-	sprintf(out, "%pUl", guid->b);
-        return out;
+	sprintf(out, "%pUl", guid);
+	return out;
 }
 
 extern void efi_init (void);
-- 
2.30.1

