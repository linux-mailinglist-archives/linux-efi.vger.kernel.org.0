Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27913978C
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAMRXS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgAMRXN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:13 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658BD21739;
        Mon, 13 Jan 2020 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936193;
        bh=cg/rGZ6nIeh2leUh4xr8p6ii7cYV/TifdRIjaYF2Fp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOq5LAOWRIl553Q0Gav37/vxEKieAlUyNkbOx99PyI0fxTK78htNEUC7HOlIxWAW2
         18+UcwM6DGRz4ARZTzyiJ6kGqUHjdHuI+EKQv+HE7OrrWaJCIJyDVI9DadtEAFk33Y
         H01skN+HlgG5l6BhSLDqv2DnoOeVRmZdIwJFi7rs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 03/13] efi/libstub/x86: fix unused-variable warning
Date:   Mon, 13 Jan 2020 18:22:35 +0100
Message-Id: <20200113172245.27925-4-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only users of these got removed, so they also need to be
removed to avoid warnings:

arch/x86/boot/compressed/eboot.c: In function 'setup_efi_pci':
arch/x86/boot/compressed/eboot.c:117:16: error: unused variable 'nr_pci' [-Werror=unused-variable]
  unsigned long nr_pci;
                ^~~~~~
arch/x86/boot/compressed/eboot.c: In function 'setup_uga':
arch/x86/boot/compressed/eboot.c:244:16: error: unused variable 'nr_ugas' [-Werror=unused-variable]
  unsigned long nr_ugas;
                ^~~~~~~

Fixes: 2732ea0d5c0a ("efi/libstub: Use a helper to iterate over a EFI handle array")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index ab3a40283db7..82e26d0ff075 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -118,7 +118,6 @@ static void setup_efi_pci(struct boot_params *params)
 	void **pci_handle = NULL;
 	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
 	unsigned long size = 0;
-	unsigned long nr_pci;
 	struct setup_data *data;
 	efi_handle_t h;
 	int i;
@@ -245,7 +244,6 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	u32 width, height;
 	void **uga_handle = NULL;
 	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	unsigned long nr_ugas;
 	efi_handle_t handle;
 	int i;
 
-- 
2.20.1

