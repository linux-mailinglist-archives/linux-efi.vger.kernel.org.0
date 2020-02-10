Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A654B157F69
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgBJQD3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgBJQD3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:29 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76FD824683;
        Mon, 10 Feb 2020 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350608;
        bh=1jCLSpuxWNvqDDktboTcTA462Gp+IJGKbFelxV2ZYVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03ux1Q+Vm+C2tBAUwfCPQasLYb2lOqUR20UipexcqE6i9is+wueJrEE6eQ0u9Y3/m
         pz4Z+FxKzkjKnkq6SFcTt6O60jVqo5RA+gPPGBJaw+7wbpgNSJtkpKFp1gEU73pgJL
         mkSFccEbdObwCxmOqA1yYlBVRDmgWqfTKjvkOIBo=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 18/19] efi/libstub: Expose LocateDevicePath boot service
Date:   Mon, 10 Feb 2020 17:02:47 +0100
Message-Id: <20200210160248.4889-19-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will be adding support for loading the initrd from a GUIDed
device path in a subsequent patch, so update the prototype of
the LocateDevicePath() boot service to make it callable from
our code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h             | 3 +++
 drivers/firmware/efi/libstub/efistub.h | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 85f79accd3f8..9ced980b123b 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -283,6 +283,9 @@ static inline void *efi64_zero_upper(void *p)
 #define __efi64_argmap_locate_protocol(protocol, reg, interface)	\
 	((protocol), (reg), efi64_zero_upper(interface))
 
+#define __efi64_argmap_locate_device_path(protocol, path, handle)	\
+	((protocol), (path), efi64_zero_upper(handle))
+
 /* PCI I/O */
 #define __efi64_argmap_get_location(protocol, seg, bus, dev, func)	\
 	((protocol), efi64_zero_upper(seg), efi64_zero_upper(bus),	\
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d282d907cd33..afa774a312f5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -100,6 +100,8 @@ struct efi_boot_memmap {
 	unsigned long		*buff_size;
 };
 
+typedef struct efi_generic_dev_path efi_device_path_protocol_t;
+
 /*
  * EFI Boot Services table
  */
@@ -134,7 +136,9 @@ union efi_boot_services {
 		efi_status_t (__efiapi *locate_handle)(int, efi_guid_t *,
 						       void *, unsigned long *,
 						       efi_handle_t *);
-		void *locate_device_path;
+		efi_status_t (__efiapi *locate_device_path)(efi_guid_t *,
+							    efi_device_path_protocol_t **,
+							    efi_handle_t *);
 		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
 								     void *);
 		void *load_image;
-- 
2.17.1

