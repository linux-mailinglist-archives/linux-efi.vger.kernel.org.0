Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613EA4EC8A6
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348363AbiC3Po1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348361AbiC3Po0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD334B91
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 012E561562
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C69C340F2;
        Wed, 30 Mar 2022 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654960;
        bh=iX0Rj2iCJkNigKrUwgpSQHOCUux2R+JAh6rETtOOk80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAt519OGKKlHFSAvGBJsakM3TUiZyFZHQvq6AiXlRGI3emTsfWMM5reF2s4voymSQ
         /e2XwO6rtQZR6vgT2jOH+7k90wD/I7u0hrJA7QBnDwMh6t9f5UbkgJTR0/8nKTU/Of
         3Lx5KjqEUKooo51HJzAxkbkg1/Senada/+LJUMwAmGHWxHzwCcfKRM0OtMeItj5LmV
         NVlRYCzbqc8mglaHjmD3Vlrn+KWcjq7NterMehNghhO5+ASPDQPR3SgIYDo7JPbDrd
         3mix/omLMkUaLeeUvUETdTrea6OEGDc67xSbiDQ6lvV22sVyjI9BcTXnQb8jKd39EO
         9bO0f0O5FQDFg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 15/18] arm64: lds: move idmap_pg_dir out of .rodata
Date:   Wed, 30 Mar 2022 17:42:02 +0200
Message-Id: <20220330154205.2483167-16-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; h=from:subject; bh=iX0Rj2iCJkNigKrUwgpSQHOCUux2R+JAh6rETtOOk80=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpHslUvi3THUV2q/rluhKlo/8jbI/WIJWe7S3gR OuhxZ+KJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6RwAKCRDDTyI5ktmPJAdxC/ 0Z8oTyxDlocoO5MkJ++fqTdE+UTagr09e3u7FOvGhCoZzFp6heaO0p1dQJCqcRUvt/Lgeq7/yhET93 6yYWYNY9a4gQix4zPLDK+F1ucf0X2av6Qr3qHL7+8s4n6y3ta/f/e3uagB4hEwAfx/0iHGKD6odTdv RWqHWeJkWzod1GVcoBCOaWg96bA1AXHjzvpMtyyRuZz4T5TMjI8b4p0rxrXcfA7PKM8f0OYrYdnf2n rItoyOoZ378bG3vTdWdUEs20t29JT1lDqkYCBRcLN5Sga2+5Oa/ECDwoQSbH4FJJ8u2H/KYBDgraEB PBM/8V0Htyyw6ITiEIPX/KXsl0TSXghFIxVWcE5t7i/cy+dNIsG5VEXqX/NbUAwNcBA8Joo1/OzgOJ ecKq8cSTc/jNsFH9TEBXwjcSvXgc20cwXBR020EUfKiO0nRB4izqHr8lJg2B6nL8A9H1xFEXWShkoc qxRWFdVICv0UKBWkfHfWkR9EY+mtVWpqEdyVxL+jABLlw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

After future changes, the ID map may be set up by the boot entry code
with the MMU and caches enabled, which means we will reuse the identity
map set up by the firmware. This means that memory we describe as
read-only in the PE/COFF header may not be writable, preventing us from
creating the new identity map if the root level is located in such a
region.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index edaf0faf766f..2231ccba45f7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -194,10 +194,6 @@ SECTIONS
 
 	HYPERVISOR_DATA_SECTIONS
 
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-	idmap_pg_end = .;
-
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir = .;
 	. += PAGE_SIZE;
@@ -291,6 +287,11 @@ SECTIONS
 		__mmuoff_data_end = .;
 	}
 
+	. = ALIGN(PAGE_SIZE);
+	idmap_pg_dir = .;
+	. += IDMAP_DIR_SIZE;
+	idmap_pg_end = .;
+
 	PECOFF_EDATA_PADDING
 	__pecoff_data_rawsize = ABSOLUTE(. - __initdata_begin);
 	_edata = .;
-- 
2.30.2

