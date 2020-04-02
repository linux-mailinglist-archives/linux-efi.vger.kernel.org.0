Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551A219BF4A
	for <lists+linux-efi@lfdr.de>; Thu,  2 Apr 2020 12:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgDBKZj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Apr 2020 06:25:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36937 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgDBKZj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Apr 2020 06:25:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jJx2X-0001du-Gt; Thu, 02 Apr 2020 10:25:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-efi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub/x86: remove redundant assignment to pointer hdr
Date:   Thu,  2 Apr 2020 11:25:37 +0100
Message-Id: <20200402102537.503103-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer hdr is being assigned a value that is never read and
it is being updated later with a new value. The assignment is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8d3a707789de..e02ea51273ff 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -392,8 +392,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_base = efi_table_attr(image, image_base);
 	image_offset = (void *)startup_32 - image_base;
 
-	hdr = &((struct boot_params *)image_base)->hdr;
-
 	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
-- 
2.25.1

