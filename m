Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38A960148C
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJQRRn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJQRRl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505171989
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E982B819A6
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDA8C433D6;
        Mon, 17 Oct 2022 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027058;
        bh=vAxXAt5sVvGpdOkIojEwnjD4KDvIXGdjuMGayLsmYgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2JW0bGf1XjP79YXjvDYiMwcmN1pIFr+x+HkAXM2thy3cSWtr5YKvK3SVkhqn0tcH
         poek4xTpSPCyqh5vm+ZVi0KS/MopkrraQsBFLav2i1IEaMrdDKp5ZvI0iW5+VPbdB2
         0+fI6CGgdjt/2nB0A0hUHLB8yJtGhj0I8+Zv7jie2I9eBPTlvrgkmq3ef+Z4on9emY
         uInPnr6ODeLf39UUpQMdw0Mmf2zA+jmV9ZNCD2Iq4LcDEcIT5UXeYrW9wEhFD8Bs8H
         aWEWonK+bt0ehVTuYst+8YqTz98J4V/xebvx4Gz6ZNOpIyRfpPl/EucCoORNsTl5DE
         4Xt6GqnV/dyBg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 06/21] efi: libstub: Drop handling of EFI properties table
Date:   Mon, 17 Oct 2022 19:16:45 +0200
Message-Id: <20221017171700.3736890-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=ardb@kernel.org; h=from:subject; bh=vAxXAt5sVvGpdOkIojEwnjD4KDvIXGdjuMGayLsmYgA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3yuVpXhgvmTGxrTsoZ5KkfsX5qUG7zdwzzkpQE 3gbkMZGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N8gAKCRDDTyI5ktmPJJVqC/ 9pUolnxY/1swJ6XvvdvNjBolYY3UYf+saOrOcvt6gLXS7IH7fOoylovlB8JaQHa/2bJx1fI4t48MwD oAKY9tFO0NVCdYS4Z3zuc4SAHdj/WDFDuTWmaWnqZFU8ZscQsy0wwoJo7+RYzxI9VOLcsLApknW2zZ xovx4omcqQESHzqJkXe7MsJW4ZX4AY8+P3yQYdSBe2TyzgPyHstEz+oiUyo17C+clcT+mP12a/Gsit 1ljnXo2RDNedyiuB5SfqOWZC2uSsykNDTdOCd9sjA+Th2jigsk/j9EVUPpWUNDEsrYDS50l3Y5eADh DxSr6P5U5wf6n1dAGByGst3DxrAfDt9bDf/8k19vUlJwxrnWpr4fj8Pl0kcGKmZbLRljRMjfYJRfTF SKo7b1kCwB898es4NraIoNXVxGWdBdZY2J3ZRBTIBmH+YrZAR1kMbwM1jPw/DQKXWJ4GZQSuKKmu/C o02BH9YTrhnL5ckoe1nYq1PZqk0l0LokGYSw5yCAgsyFU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI properties table was a short lived experiment that never saw the
light of day on non-x86 (if at all) so let's drop the handling of it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 0ebfa2d9628a..b55d1009d4c8 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -126,7 +126,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	unsigned long reserve_addr = 0;
 	unsigned long reserve_size = 0;
 	struct screen_info *si;
-	efi_properties_table_t *prop_tbl;
 
 	efi_system_table = sys_table_arg;
 
@@ -205,18 +204,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	efi_random_get_seed();
 
-	/*
-	 * If the NX PE data feature is enabled in the properties table, we
-	 * should take care not to create a virtual mapping that changes the
-	 * relative placement of runtime services code and data regions, as
-	 * they may belong to the same PE/COFF executable image in memory.
-	 * The easiest way to achieve that is to simply use a 1:1 mapping.
-	 */
-	prop_tbl = get_efi_config_table(EFI_PROPERTIES_TABLE_GUID);
-	flat_va_mapping |= prop_tbl &&
-			   (prop_tbl->memory_protection_attribute &
-			   EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA);
-
 	/* force efi_novamap if SetVirtualAddressMap() is unsupported */
 	efi_novamap |= !(get_supported_rt_services() &
 			 EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP);
-- 
2.35.1

