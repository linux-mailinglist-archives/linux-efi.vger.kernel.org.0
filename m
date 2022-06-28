Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9455E3CD
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbiF1Mx4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiF1Mx4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 08:53:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79AAC2ED50;
        Tue, 28 Jun 2022 05:53:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79522153B;
        Tue, 28 Jun 2022 05:53:55 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 159073F5A1;
        Tue, 28 Jun 2022 05:53:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/4] ACPI: PRM: Change handler_addr type to void pointer
Date:   Tue, 28 Jun 2022 13:53:43 +0100
Message-Id: <20220628125346.693304-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220628125346.693304-1-sudeep.holla@arm.com>
References: <20220628125346.693304-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

handler_addr is a virtial address passed to efi_call_virt_pointer.
While x86 currently type cast it into the pointer in it's arch specific
arch_efi_call_virt() implementation, ARM64 is restrictive for right
reasons.

Convert the handler_addr type from u64 to void pointer.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/prmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 4d3a219c67f8..998101cf16e4 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -53,7 +53,7 @@ static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
 	guid_t guid;
-	u64 handler_addr;
+	void *handler_addr;
 	u64 static_data_buffer_addr;
 	u64 acpi_param_buffer_addr;
 
@@ -148,7 +148,7 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
-		th->handler_addr = efi_pa_va_lookup(handler_info->handler_address);
+		th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
 		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
 		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
-- 
2.37.0

