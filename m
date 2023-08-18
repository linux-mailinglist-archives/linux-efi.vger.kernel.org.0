Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5EA780B3E
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376715AbjHRLiV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376708AbjHRLiG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A52112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D891263F2E
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC3FC433C7;
        Fri, 18 Aug 2023 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358684;
        bh=aTNkd9tJBUR27+EUWkFHx594koq8HrLGzC3YyVAbhZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CE+f9y1xSfOEZyDSfi3bJFZa9a5dPkU/mkoxOjiQSsHVV/iD0+tnTvdUgsDI4tUVg
         LTNf4uVWhepFDx4GKx1Z/nuZzqIQhCNd7ard7Y8+zerHKjinxciAkkkrIS1jNaHqXz
         TNAhokc0iiHskJ1a2l681hb3LEyycChnooV088HEN6XP73JHFdQKCVA58xo/Ean6kI
         Ki5e3apkotca7iBY0B0QdVu1LYRqZgnIDefT9TGs6lBHUDY6msp1Acnf8LUgaTUPBW
         4LFsYVmZoaTYJgnvMy45Nh8RdBHDqe+vWQBEIvVSX3WHqWYeMBSXe+zpFJkXoHv4aZ
         SvPa8tQ8JglFg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 09/11] efi/runtime-wrappers: Clean up white space and add __init annotation
Date:   Fri, 18 Aug 2023 13:37:22 +0200
Message-Id: <20230818113724.368492-10-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3096; i=ardb@kernel.org; h=from:subject; bh=aTNkd9tJBUR27+EUWkFHx594koq8HrLGzC3YyVAbhZQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++Cc/wXzm4Jr+t7L6/D2z7vJZWR3lkGg9GsC+7amE8 Tn/SJWOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGn4owMO+4fCEo08f6tL/pr zofJ+kmXmCsDGb+aHfoy+V/yd1arywz/NI+2bfbOtGj2qu5699S+kdlBX5A7XP837/aTGXu9wlU YAQ==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some cosmetic changes as well as a missing __init annotation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 41 +++++++++-----------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 71d3c70f0705e1b9..dfec5969dbaba417 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -437,9 +437,8 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 }
 
 static efi_status_t
-virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
-				  u32 attr, unsigned long data_size,
-				  void *data)
+virt_efi_set_variable_nb(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
+			 unsigned long data_size, void *data)
 {
 	efi_status_t status;
 
@@ -472,10 +471,8 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 }
 
 static efi_status_t
-virt_efi_query_variable_info_nonblocking(u32 attr,
-					 u64 *storage_space,
-					 u64 *remaining_space,
-					 u64 *max_variable_size)
+virt_efi_query_variable_info_nb(u32 attr, u64 *storage_space,
+				u64 *remaining_space, u64 *max_variable_size)
 {
 	efi_status_t status;
 
@@ -557,22 +554,22 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 	return status;
 }
 
-void efi_native_runtime_setup(void)
+void __init efi_native_runtime_setup(void)
 {
-	efi.get_time = virt_efi_get_time;
-	efi.set_time = virt_efi_set_time;
-	efi.get_wakeup_time = virt_efi_get_wakeup_time;
-	efi.set_wakeup_time = virt_efi_set_wakeup_time;
-	efi.get_variable = virt_efi_get_variable;
-	efi.get_next_variable = virt_efi_get_next_variable;
-	efi.set_variable = virt_efi_set_variable;
-	efi.set_variable_nonblocking = virt_efi_set_variable_nonblocking;
-	efi.get_next_high_mono_count = virt_efi_get_next_high_mono_count;
-	efi.reset_system = virt_efi_reset_system;
-	efi.query_variable_info = virt_efi_query_variable_info;
-	efi.query_variable_info_nonblocking = virt_efi_query_variable_info_nonblocking;
-	efi.update_capsule = virt_efi_update_capsule;
-	efi.query_capsule_caps = virt_efi_query_capsule_caps;
+	efi.get_time			    = virt_efi_get_time;
+	efi.set_time			    = virt_efi_set_time;
+	efi.get_wakeup_time		    = virt_efi_get_wakeup_time;
+	efi.set_wakeup_time		    = virt_efi_set_wakeup_time;
+	efi.get_variable		    = virt_efi_get_variable;
+	efi.get_next_variable		    = virt_efi_get_next_variable;
+	efi.set_variable		    = virt_efi_set_variable;
+	efi.set_variable_nonblocking	    = virt_efi_set_variable_nb;
+	efi.get_next_high_mono_count	    = virt_efi_get_next_high_mono_count;
+	efi.reset_system 		    = virt_efi_reset_system;
+	efi.query_variable_info		    = virt_efi_query_variable_info;
+	efi.query_variable_info_nonblocking = virt_efi_query_variable_info_nb;
+	efi.update_capsule		    = virt_efi_update_capsule;
+	efi.query_capsule_caps		    = virt_efi_query_capsule_caps;
 }
 
 #ifdef CONFIG_ACPI_PRMT
-- 
2.39.2

