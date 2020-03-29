Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BEB196BCF
	for <lists+linux-efi@lfdr.de>; Sun, 29 Mar 2020 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC2IGB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Mar 2020 04:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgC2IGB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 29 Mar 2020 04:06:01 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A2120732;
        Sun, 29 Mar 2020 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585469161;
        bh=GbZAaOXgR3jz+8nkwefkR612DbLVdMAnKZhYHRnkl8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zk/uI30qXFimglH5Ti+VIiM5pUoCKU5NADoPlxz396SSOsDLncaK3L1SSgO/yGKMN
         G38KT4Fr3VvufkJb8o5kNls+WlZSHVkPn5kPqrUOIpQrM/iUaiiC7VXMIzGkN1GMvJ
         YVZaBGhQgRdISXjwx2V6SlgFyJcp9mna5T1F0Wj4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi/libstub/arm64: avoid image_base value from efi_loaded_image
Date:   Sun, 29 Mar 2020 10:05:43 +0200
Message-Id: <20200329080544.25715-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329080544.25715-1-ardb@kernel.org>
References: <20200329080544.25715-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
PE/COFF entrypoint") did some code refactoring to get rid of the
EFI entry point assembler code, and in the process, it got rid of the
assignment of image_addr to the value of _text. Instead, it switched
to using the image_base field of the efi_loaded_image struct provided
by UEFI, which should contain the same value.

However, Michael reports that this is not the case: older GRUB builds
corrupt this value in some way, and since we can easily switch back to
referring to _text to discover this value, let's simply do that.

While at it, fix another issue in commit 9f9223778ef3, which may result
in the unassigned image_addr to be misidentified as the preferred load
offset of the kernel, which is unlikely but will cause a boot crash if
it does occur.

Finally, let's add a warning if the _text vs. image_base discrepancy is
detected, so we can tell more easily how widespread this issue actually
is.

Reported-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 9254cd8ab2d3..db0c1a9c1699 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -116,6 +116,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 * Mustang), we can still place the kernel at the address
 		 * 'dram_base + TEXT_OFFSET'.
 		 */
+		*image_addr = (unsigned long)_text;
 		if (*image_addr == preferred_offset)
 			return EFI_SUCCESS;
 
@@ -140,7 +141,11 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 		*image_addr = *reserve_addr + TEXT_OFFSET;
 	}
-	memcpy((void *)*image_addr, image->image_base, kernel_size);
+
+	if (image->image_base != _text)
+		pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
+
+	memcpy((void *)*image_addr, _text, kernel_size);
 
 	return EFI_SUCCESS;
 }
-- 
2.17.1

