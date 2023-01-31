Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AE2682326
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 05:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAaEEJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Jan 2023 23:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAaEEI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Jan 2023 23:04:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5F44113CB;
        Mon, 30 Jan 2023 20:04:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0AC1713;
        Mon, 30 Jan 2023 20:04:49 -0800 (PST)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 648883F64C;
        Mon, 30 Jan 2023 20:04:05 -0800 (PST)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [PATCH 1/2] efi: libstub: Fix the retriving of supported rutime services
Date:   Tue, 31 Jan 2023 04:03:54 +0000
Message-Id: <20230131040355.3116-2-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131040355.3116-1-justin.he@arm.com>
References: <20230131040355.3116-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If retrieving UEFI configuration table is failed, the supported runtime
services mask should be regarded as 0 instead of EFI_RT_SUPPORTED_ALL.
Otherwise efi_novamap might be incorrectly assigned to "false" on the
Ampere Emag server.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/firmware/efi/libstub/efi-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 2955c1ac6a36..f24b5436729c 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -111,6 +111,8 @@ static u32 get_supported_rt_services(void)
 	rt_prop_table = get_efi_config_table(EFI_RT_PROPERTIES_TABLE_GUID);
 	if (rt_prop_table)
 		supported &= rt_prop_table->runtime_services_supported;
+	else
+		supported = 0;
 
 	return supported;
 }
-- 
2.25.1

