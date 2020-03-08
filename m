Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631BE17D287
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgCHIKZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgCHIKZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:25 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC542187F;
        Sun,  8 Mar 2020 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655025;
        bh=wsZayJivl+Akw8OakDrwAN3vwWAPvujymInCavCuQqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mt5TpUcrHB1R5ntTmUdJIdouQL/WhWHlDI1TDuSSjpl2Y1Qoc75tnU6OE3d95R1J2
         7Mapx9ZXM7jEptZRNkJemj/1AUHP0lLs62cFwQqiSKTAQVfcfJRrCo2xmFSIpj5ZST
         R9pVPFljjL02gPTyVXJOdUTVGKlFrInAOl9c7Ang=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 22/28] efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux
Date:   Sun,  8 Mar 2020 09:08:53 +0100
Message-Id: <20200308080859.21568-23-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

drivers/firmware/efi/libstub/Makefile builds a static library, which
is not linked into the main vmlinux target in the ordinary way [arm64],
or at all [ARM, x86].

Since commit 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects
reliably"), any Makefile using lib-y generates lib-ksyms.o which is
linked into vmlinux.

In this case, the following garbage object is linked into vmlinux.

  drivers/firmware/efi/libstub/lib-ksyms.o

We do not want to follow the default linking rules for static libraries
built under libstub/ so using subdir-y instead of obj-y is the correct
way to descend into this directory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20200305055047.6097-1-masahiroy@kernel.org
[ardb: update commit log to clarify that arm64 deviates in this respect]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 317a05cd388b..7a216984552b 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
-obj-$(CONFIG_EFI_STUB)			+= libstub/
+subdir-$(CONFIG_EFI_STUB)		+= libstub
 obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_map.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
-- 
2.17.1

