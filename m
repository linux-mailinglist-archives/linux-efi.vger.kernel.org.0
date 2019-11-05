Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10FF071F
	for <lists+linux-efi@lfdr.de>; Tue,  5 Nov 2019 21:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfKEUj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Nov 2019 15:39:57 -0500
Received: from foss.arm.com ([217.140.110.172]:60572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKEUj5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 Nov 2019 15:39:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E3E97B9;
        Tue,  5 Nov 2019 12:39:56 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C084D3FAD2;
        Mon,  4 Nov 2019 21:23:36 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] efi: Return EFI_RESERVED_TYPE in efi_mem_type() for absent addresses
Date:   Tue,  5 Nov 2019 10:53:49 +0530
Message-Id: <1572931429-487-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The function efi_mem_type() is expected (per documentation above) to return
EFI_RESERVED_TYPE when a given physical address is not present in the EFI
memory map. Even though EFI_RESERVED_TYPE is not getting checked explicitly
anywhere in the callers, it is always better to return expected values.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 69f00f7453a3..bdda90a4601e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -914,7 +914,7 @@ int efi_mem_type(unsigned long phys_addr)
 				  (md->num_pages << EFI_PAGE_SHIFT))))
 			return md->type;
 	}
-	return -EINVAL;
+	return EFI_RESERVED_TYPE;
 }
 #endif
 
-- 
2.20.1

