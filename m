Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3293606879
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 20:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTSye (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 14:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJTSyc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 14:54:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A461901F
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 11:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBF25B828A0
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 18:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CBCC433C1;
        Thu, 20 Oct 2022 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666292067;
        bh=0/MaXp45ryHiJsNnBKNWLbOLpQE1nGFjd2WJrJUji1k=;
        h=From:To:Cc:Subject:Date:From;
        b=DRYNYz93pem/5syVgNcqdZ0Dd24vxYLpwVDoYXWJqU48neuaPmxJMBTtTxq6Bf7Fi
         Ir/qDCa5eWvmK8XVNZ4NjpJdDHsxULig7A+54UjfIcc4ISQcGqCi+Et5V1voXr8YIL
         NGzni32Yx18BPIVREQKeHxNoYVziKj9JmL+D7q84sfQqvyxASxr6bYhVWoexrtIhAp
         tsk7iZe9WXTVfj/fP81PkT0xWLpBVu3Gc5+qWeILp4nh1y0IYzWcIwkJRBuWtjS2v/
         HHuJ1+0tGAZ3/jhAc8rS6Yo1NZdRJ70rSbPJke1htZXgaB0TuIynyEdYgk71ADpFaV
         Hx0ObKH9N0KSg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: runtime: Don't assume virtual mappings are missing if VA == PA == 0
Date:   Thu, 20 Oct 2022 20:54:16 +0200
Message-Id: <20221020185416.1953242-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=ardb@kernel.org; h=from:subject; bh=0/MaXp45ryHiJsNnBKNWLbOLpQE1nGFjd2WJrJUji1k=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjUZlXgOzMletgwPdTnwxaoqoyAx7M/2AEIkZgB51C b6CFsMmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1GZVwAKCRDDTyI5ktmPJHofC/ 97VFm8dzPFlwKdbuGGspud4s8HJ9gm+2hw/GUcp9xYw/Bmni9NYNqUILJ3CEDY7tEXnolXEI3c8V5Q XsNUtWuCF01WVJvaKb/xn88T2jr3j0d4+1pAsxZhXA7+JRPH3mkhrcH0CkPYCwq4+NgHOYl+wthJSX qqQ14C3mWsmYjvHJFCgg8uNI2wwqSkijmOa0Yc9eNtGQgZu6JxKREe5+l8iEEgVhfXZ7kh+WLvLA16 f/GaT3VozqrMlTcrgdhfm5OBtkncGylRqgW8oMJFlsoHsrqQkadVFXJL0yLzvrriTm+bcNy410q8Ap CaifrXyGTY1qFj0SsKhghrbSDNYoL60rdMJZFBQlVnNrHt+yPEzFrh2YlemE5a4v428cj1jnzNpIVD d05VIOK/yjZB2EtGrYPDusVY5yhXKa+1s/HGZn22mf/a4voMXbfDuEXm3stsI/PL6xzzw3HqHwKzu7 LrxVEgFfDyHiSFc6qAJ6OuSSgvCp3XX5iWvbGnDzskgn4=
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

The generic EFI stub can be instructed to avoid SetVirtualAddressMap(),
and simply run with the firmware's 1:1 mapping. In this case, it
populates the virtual address fields of the runtime regions in the
memory map with the physical address of each region, so that the mapping
code has to be none the wiser. Only if SetVirtualAddressMap() fails, the
virtual addresses are wiped and the kernel code knows that the regions
cannot be mapped.

However, wiping amounts to setting it to zero, and if a runtime region
happens to live at physical address 0, its valid 1:1 mapped virtual
address could be mistaken for a wiped field, resulting on loss of access
to the EFI services at runtime.

So let's only assume that VA == 0 means 'no runtime services' if the
region in question does not live at PA 0x0.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/arm-runtime.c   | 2 +-
 drivers/firmware/efi/riscv-runtime.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 3359ae2adf24..e99a2ba0cf24 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -63,7 +63,7 @@ static bool __init efi_virtmap_init(void)
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
-		if (md->virt_addr == 0)
+		if (md->phys_addr != 0 && md->virt_addr == 0)
 			return false;
 
 		ret = efi_create_mapping(&efi_mm, md);
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index d28e715d2bcc..3fac921c7402 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -41,7 +41,7 @@ static bool __init efi_virtmap_init(void)
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
-		if (md->virt_addr == 0)
+		if (md->phys_addr != 0 && md->virt_addr == 0)
 			return false;
 
 		ret = efi_create_mapping(&efi_mm, md);
-- 
2.35.1

