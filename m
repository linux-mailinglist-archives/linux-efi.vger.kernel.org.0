Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B85F2F93
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 13:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJCL0n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 07:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJCL0m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 07:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237B2A94E
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 04:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D198261022
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 11:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F8C433B5;
        Mon,  3 Oct 2022 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796400;
        bh=naWVhxVJzgFHTYyzbP8aferDZudNO8L5WZJcvq28kz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNiDIoSRsqO6SP/YjvMUB6npIWVImtY4mWHh4pvmCWYVqDtQtuHY5bBr3jdPo2inm
         /WfRwXzUvzpvHSn/RH0owMjbn2jYGvoOcszGqXzM65/xpvJ1CLY2fs+srTkOMfQA0m
         Sl4u0VnyhkuQL3/G7xKroOexeRf06KCKag0XxURSv3xsxamdKMNHzmM7rxbviila7s
         0FIMpSBAkDd5YR34wQT5Q+v8Tg8V+HoYB7AB88iHGrBIGoj6XXykMrvBJDF6/Gqlcb
         kOGtDYhRAeA50gW7pjYE1OY7Nfrk3aZFZc7OM6CR6QSgSMD01eoC23/CcBOj+wQff7
         /mNndy+5mRPWg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [PATCH v2 3/6] efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures
Date:   Mon,  3 Oct 2022 13:26:22 +0200
Message-Id: <20221003112625.972646-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221003112625.972646-1-ardb@kernel.org>
References: <20221003112625.972646-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190; i=ardb@kernel.org; h=from:subject; bh=naWVhxVJzgFHTYyzbP8aferDZudNO8L5WZJcvq28kz8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOsbZUImNh+oNISz7kaell7P1ADDK/YsLUV10IJbU Cm3Ms7iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzrG2QAKCRDDTyI5ktmPJChlC/ 9o6m0Iy1WpuoP8dAvEJvjXUGENSrHQz1jwTqztxBAtbc7GoxtN2OD7Yo6fcYU1htSLmDa3LtV1LVp9 hzxE4shcSNXWA3qsx0Q7kv9LuimlvTR1oYqnphlO1ArYa7K6Vv1iEw538UOR3DGgXep8hlTrdQWCxu l9S4x9xdNCP5eBLDSnNEnu2RLEwFQztbYxocM2UTZvu6p5ZIrFrZ/v/JFh2hMECJluOfJ78LFVfvLr SWti8jAOjrVPsdyXhwiFGxpgqxcJenX/ugwqvO/Zovirqc/+Saao7vAabuAlj5QxmLa8timHCLfif7 HCZy2GbDBepiQhA3JqrH5ARl1H54OQT5/wEVbwca8DTLe3wpg0gfJ1LTbScvFQhloWWFhfIEYdyYUw tPEZaeKi6iKAP1MQJAXYSb5sVSl5P8d9p/VqtN13bVvy+mf/MgKXmQSL/SOHt6jtDfY8OtqUTHRGMx ZnhVe0pgimwQIeEKMm+MLR2YT26b5k0pqVz0nruFr/1uU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, the EFI_PARAVIRT flag is only used by x86, even though other
architectures also support pseudo-EFI boot, where the core kernel is
invoked directly and provided with a set of data tables that resemble
the ones constructed by the EFI stub, which never actually runs in that
case.

Let's fix this inconsistency, and always set this flag when booting dom0
via the EFI boot path. Note that Xen on x86 does not provide the EFI
memory map in this case, whereas other architectures do, so move the
associated EFI_PARAVIRT check into the x86 platform code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c      | 8 +++++---
 arch/x86/platform/efi/memmap.c   | 3 +++
 drivers/firmware/efi/fdtparams.c | 4 ++++
 drivers/firmware/efi/memmap.c    | 3 ---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 6e598bd78eef..6a6f2a585a3d 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -214,9 +214,11 @@ int __init efi_memblock_x86_reserve_range(void)
 	data.desc_size		= e->efi_memdesc_size;
 	data.desc_version	= e->efi_memdesc_version;
 
-	rv = efi_memmap_init_early(&data);
-	if (rv)
-		return rv;
+	if (!efi_enabled(EFI_PARAVIRT)) {
+		rv = efi_memmap_init_early(&data);
+		if (rv)
+			return rv;
+	}
 
 	if (add_efi_memmap || do_efi_soft_reserve())
 		do_add_efi_memmap();
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 44b886acf301..18e14ec16720 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -93,6 +93,9 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
 {
 	efi_memmap_unmap();
 
+	if (efi_enabled(EFI_PARAVIRT))
+		return 0;
+
 	return __efi_memmap_init(data);
 }
 
diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
index e901f8564ca0..0ec83ba58097 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -30,11 +30,13 @@ static __initconst const char name[][22] = {
 
 static __initconst const struct {
 	const char	path[17];
+	u8		paravirt;
 	const char	params[PARAMCOUNT][26];
 } dt_params[] = {
 	{
 #ifdef CONFIG_XEN    //  <-------17------>
 		.path = "/hypervisor/uefi",
+		.paravirt = 1,
 		.params = {
 			[SYSTAB] = "xen,uefi-system-table",
 			[MMBASE] = "xen,uefi-mmap-start",
@@ -121,6 +123,8 @@ u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
 			pr_err("Can't find property '%s' in DT!\n", pname);
 			return 0;
 		}
+		if (dt_params[i].paravirt)
+			set_bit(EFI_PARAVIRT, &efi.flags);
 		return systab;
 	}
 notfound:
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 3501d3814f22..9508082af907 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -44,9 +44,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
 
-	if (efi_enabled(EFI_PARAVIRT))
-		return 0;
-
 	phys_map = data->phys_map;
 
 	if (data->flags & EFI_MEMMAP_LATE)
-- 
2.35.1

