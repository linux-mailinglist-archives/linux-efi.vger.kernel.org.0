Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A05F226E
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 11:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJBJ45 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJBJ44 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 05:56:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA222409F
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 02:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D1BBB80D1A
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 09:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030F7C433D6;
        Sun,  2 Oct 2022 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664704613;
        bh=i9J/bhcOyc3uNnBq9NxPgkx0ZJaejS+t55ZIN9kwhto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZZQATYJk3ivDIqSahLAWOXxDG540XSQg4SOZtKoDcInYHh5WAIvtQ708cDyde62y
         qFcJoIpjQKJhjdEr2eKLrqneN9dxTRKeluZC1+osIcRdGYu6bpOar8CPXS63b7QZ0I
         +t3NvNXP6iJNDe9PTzQMhuatCVpMQNvX0WmZcZiifFHPenOOUfGYFr5Pm4vaJE5xaX
         tiqgBusQE4dcXX+IK74AtS1ovjH6syVgbox8r0Aoh44N36UvpuyCEsT0/GwjDuaTsg
         hoAxaFqgIJOVnDfMXTxZWzPMVwxzpsrzfQg5J17/FA+QnqhkMIYJmMJlEuemLiYTU/
         sTEBGyK60tsYg==
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
Subject: [RFC PATCH 5/5] efi: esrt: Omit region sanity check when no memory map is available
Date:   Sun,  2 Oct 2022 11:56:26 +0200
Message-Id: <20221002095626.484279-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221002095626.484279-1-ardb@kernel.org>
References: <20221002095626.484279-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3849; i=ardb@kernel.org; h=from:subject; bh=i9J/bhcOyc3uNnBq9NxPgkx0ZJaejS+t55ZIN9kwhto=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOWBG4cz437cHlvB5hCAVDNcjf0OGuWo2clK4E5EB xJGhzOeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzlgRgAKCRDDTyI5ktmPJGICDA CiILORMzCoGuRyx58JurLNRhBnK5oQH+9xzw8gRRd+Vz3g6c3EKvPNk1k5x/NyZiqptY5b/6kkST0z L3hL8qwjhwFvSm+hK8lb11IHTiOu5W3BLWF4tN3i1+n/y4mJo0NtJUAFwMt1dVCJH31hZFqNAJ8NQ/ svEJL86U6S+8AQbXU/v1TMcjV7C4Bf3uPyjg7L6HaCBwiREnJ8QlZ06QYWieJ4VZQUnS2l7eV6Z30f dlpPBhWgtaarwosLJ8Hd/FOw0nudZB3/c0Pma8xBvF58WeRddf/URLRL/KZ3OEwWcwddlmZdz4jHZa 6SI8cTLmCQpjeEvYZ8FJVyTQoI6El+Pt94uuWwnQIcpQjqeQD4/20RKdAxmOseZfoWRajOLTBeJgdH ppCdmUvll+/kB0Kl2bY+2FWH8d2E1jcLHeqXrFGUFZeP1eNzkJsiGE7f3iF2vXdIq5T65oGQGMTU+Q YCpsZXqv93o6Ztb2Cid6MB1cAtrtmds7CWvHCe2Je4z1k=
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

In order to permit the ESRT to be used when doing pseudo-EFI boot
without a EFI memory map, e.g., when booting inside a Xen dom0 on x86,
make the sanity checks optional based on whether the memory map is
available.

If additional validation is needed, it is up to the Xen EFI glue code to
implement this in its xen_efi_config_table_is_valid() helper, or provide
a EFI memory map like it does on other architectures.

Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/quirks.c |  3 +
 drivers/firmware/efi/esrt.c    | 61 +++++++++++---------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b0b848d6933a..9307be2f4afa 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -250,6 +250,9 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	if (efi_mem_desc_lookup(addr, &md) ||
 	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 2a2f52b017e7..adb31fba45ae 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -243,40 +243,45 @@ void __init efi_esrt_init(void)
 	void *va;
 	struct efi_system_resource_table tmpesrt;
 	size_t size, max, entry_size, entries_size;
-	efi_memory_desc_t md;
-	int rc;
+	bool reserve_esrt;
 	phys_addr_t end;
 
-	if (!efi_enabled(EFI_MEMMAP))
-		return;
-
 	pr_debug("esrt-init: loading.\n");
 	if (!esrt_table_exists())
 		return;
 
-	rc = efi_mem_desc_lookup(efi.esrt, &md);
-	if (rc < 0 ||
-	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
-	     md.type != EFI_BOOT_SERVICES_DATA &&
-	     md.type != EFI_RUNTIME_SERVICES_DATA)) {
-		pr_warn("ESRT header is not in the memory map.\n");
-		return;
-	}
+	size = sizeof(*esrt);
+	if (efi_enabled(EFI_MEMMAP)) {
+		efi_memory_desc_t md;
+		int rc;
+
+		rc = efi_mem_desc_lookup(efi.esrt, &md);
+		if (rc < 0 ||
+		    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
+		     md.type != EFI_BOOT_SERVICES_DATA &&
+		     md.type != EFI_RUNTIME_SERVICES_DATA)) {
+			pr_warn("ESRT header is not in the memory map.\n");
+			return;
+		}
 
-	max = efi_mem_desc_end(&md);
-	if (max < efi.esrt) {
-		pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
-		       (void *)efi.esrt, (void *)max);
-		return;
-	}
+		reserve_esrt = (md.type == EFI_BOOT_SERVICES_DATA);
+		max = efi_mem_desc_end(&md);
+		if (max < efi.esrt) {
+			pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
+			       (void *)efi.esrt, (void *)max);
+			return;
+		}
 
-	size = sizeof(*esrt);
-	max -= efi.esrt;
+		max -= efi.esrt;
 
-	if (max < size) {
-		pr_err("ESRT header doesn't fit on single memory map entry. (size: %zu max: %zu)\n",
-		       size, max);
-		return;
+		if (max < size) {
+			pr_err("ESRT header doesn't fit on single memory map entry. (size: %zu max: %zu)\n",
+			       size, max);
+			return;
+		}
+	} else {
+		reserve_esrt = true;
+		max = SIZE_MAX;
 	}
 
 	va = early_memremap(efi.esrt, size);
@@ -332,9 +337,11 @@ void __init efi_esrt_init(void)
 	esrt_data_size = size;
 
 	end = esrt_data + size;
-	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
-	if (md.type == EFI_BOOT_SERVICES_DATA)
+	if (reserve_esrt) {
+		pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data,
+			&end);
 		efi_mem_reserve(esrt_data, esrt_data_size);
+	}
 
 	pr_debug("esrt-init: loaded.\n");
 }
-- 
2.35.1

