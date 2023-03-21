Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C06C36CB
	for <lists+linux-efi@lfdr.de>; Tue, 21 Mar 2023 17:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCUQSg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Mar 2023 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCUQSg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Mar 2023 12:18:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BD2CC41
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 09:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC02CCE19FC
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 16:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E99C433EF;
        Tue, 21 Mar 2023 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679415489;
        bh=5NkzRSSf2ER5qjOYkcH3vxSdxpVrfZwhlZzLzqMydXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsX5VC/sYFX9Vg3kxRtHB2mWvBi/btMTOVuQaDTNfdQZnHyZrLOCIXRKvyCYTvs89
         bkkgmYv3e7N2QvIQL3ImiZhIjrBAR/l/LmEPXjM4ToaChwvdQq568CUg8LKl++5DyA
         UbZdFaH6oXzxHCWju24ifG5dhTZTE3QfaPfbVfzVzULLrAunSyQJu/E7kTmjjkkrkf
         ooyEKV7eZ/9zHGWDbRIjyytA3oxCS1/g6OgTdcZIF/HkAeGFSDQ0njD5wYkObqc93+
         qOIso/fl07HcKoUmoIYDz8kGGrRMgMQlvKtHLTN26ESlmcovNLPz912Xi0qZrc6NwK
         Wzv1KxGs8sw4g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Michael Brown <mcb30@ipxe.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/3] efi/libstub: Use const qualified device path protocol pointers
Date:   Tue, 21 Mar 2023 17:18:01 +0100
Message-Id: <20230321161803.3289140-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321161803.3289140-1-ardb@kernel.org>
References: <20230321161803.3289140-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3231; i=ardb@kernel.org; h=from:subject; bh=5NkzRSSf2ER5qjOYkcH3vxSdxpVrfZwhlZzLzqMydXs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXyxo6LfbFrEpxKqp26F6l+iXoeoXIsSl1nXvqZXy+f2 Ds/DFjWUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYicJnhf+4cBx0B9cQGuTNb Z3iofPkdVTHpwZ6D3Y5VkbO97KQPdDEynFVV/fh1tovVXP09Ey9sCBA48/7Ha4/Fl+cEhy77Xli 6iwkA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI APIs that deal with device path protocol instances never modify
them, but given that these APIs do not use const qualified pointers at
all, but instead uses IN and OUT modifiers that are #define'd to empty
tokens, we cannot currently pass a device path protocol pointer that
refers to a read-only object.

So add the const qualification where appropriate, and drop a cast that
is no longer necessary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
 drivers/firmware/efi/libstub/efistub.h         | 4 ++--
 drivers/firmware/efi/libstub/file.c            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1e0203d74691ffcc..ff60e3a78337ce5c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -499,12 +499,12 @@ efi_status_t efi_load_initrd_dev_path(struct linux_efi_initrd *initrd,
 				      unsigned long max)
 {
 	efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
-	efi_device_path_protocol_t *dp;
+	const efi_device_path_protocol_t *dp;
 	efi_load_file2_protocol_t *lf2;
 	efi_handle_t handle;
 	efi_status_t status;
 
-	dp = (efi_device_path_protocol_t *)&initrd_dev_path;
+	dp = &initrd_dev_path.vendor.header;
 	status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
 	if (status != EFI_SUCCESS)
 		return status;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 6bd3bb86d9679a1c..96a04ee05cdbb8bf 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -285,7 +285,7 @@ union efi_boot_services {
 						       void *, unsigned long *,
 						       efi_handle_t *);
 		efi_status_t (__efiapi *locate_device_path)(efi_guid_t *,
-							    efi_device_path_protocol_t **,
+							    const efi_device_path_protocol_t **,
 							    efi_handle_t *);
 		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
 								     void *);
@@ -894,7 +894,7 @@ typedef union efi_load_file_protocol efi_load_file2_protocol_t;
 union efi_load_file_protocol {
 	struct {
 		efi_status_t (__efiapi *load_file)(efi_load_file_protocol_t *,
-						   efi_device_path_protocol_t *,
+						   const efi_device_path_protocol_t *,
 						   bool, unsigned long *, void *);
 	};
 	struct {
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index d6a025df07dcf9ef..207dc578db910336 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -131,7 +131,7 @@ static efi_status_t efi_open_device_path(efi_file_protocol_t **volume,
 	efi_guid_t text_to_dp_guid = EFI_DEVICE_PATH_FROM_TEXT_PROTOCOL_GUID;
 	static efi_device_path_from_text_protocol_t *text_to_dp = NULL;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
-	efi_device_path_protocol_t *initrd_dp;
+	const efi_device_path_protocol_t *initrd_dp;
 	efi_simple_file_system_protocol_t *io;
 	struct efi_file_path_dev_path *fpath;
 	efi_handle_t handle;
-- 
2.39.2

