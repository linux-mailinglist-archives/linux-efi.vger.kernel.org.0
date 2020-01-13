Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352AF139787
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgAMRXb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgAMRX1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:27 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A72921556;
        Mon, 13 Jan 2020 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936207;
        bh=6I/2D+31V6MW3cEthNUUKIA6MmnULXVS6B/ucqvCFHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1kjSBHC7afRi3ljsNFWH9Z31xZ7fP6FoorHSJMzNfnhUPTQetDtyZTxsNZne2Lko7
         Xy9CXgRxCFfYL5jlCgJ5G7hxkfJlXzn16p9TULO8bi1Z14cCu+lcCUd0Aa/CmDYtK/
         cRc05611WLiiDCZNMtahE5Vspur3ueuA9kHHBmyc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 09/13] efi: Fix comment for efi_mem_type() wrt absent physical addresses
Date:   Mon, 13 Jan 2020 18:22:41 +0100
Message-Id: <20200113172245.27925-10-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Anshuman Khandual <anshuman.khandual@arm.com>

A previous commit f99afd08a45f ("efi: Update efi_mem_type() to return an
error rather than 0") changed the return value from EFI_RESERVED_TYPE to
-EINVAL when the searched physical address is not present in any memory
descriptor. But the comment preceding the function never changed. Let's
change the comment now to reflect the new return value -EINVAL.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 2b02cb165f16..621220ab3d0e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -908,7 +908,7 @@ u64 efi_mem_attributes(unsigned long phys_addr)
  *
  * Search in the EFI memory map for the region covering @phys_addr.
  * Returns the EFI memory type if the region was found in the memory
- * map, EFI_RESERVED_TYPE (zero) otherwise.
+ * map, -EINVAL otherwise.
  */
 int efi_mem_type(unsigned long phys_addr)
 {
-- 
2.20.1

