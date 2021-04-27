Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51136C5C4
	for <lists+linux-efi@lfdr.de>; Tue, 27 Apr 2021 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhD0MHu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Apr 2021 08:07:50 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36697 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhD0MHt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Apr 2021 08:07:49 -0400
Received: by mail-lf1-f51.google.com with SMTP id n138so93456955lfa.3;
        Tue, 27 Apr 2021 05:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJxVncGS6U+aW2CwWEyoK+WV9nu3WxeKlSv9zlz4jhY=;
        b=NA8LH8xroKv34BoyPdLLJ3W8TrlBScMeazqbOr8CtMDlk/KJgYc6T60ntvA9gOYvHj
         smMRzykGYhUdZSElciOlA+OVmGQW5b6MfZt/F+5/E9fEwOzSH89plQeZ2fRKjWl3qX9E
         RBNzmIMsTaoAY17OAmZLTIreGq2b9z8dUqf+WSvjdWd8rV2B7XpuPLaESC7iZsXdBRSi
         u+mfFx4SQNyL0YHO9B/4/emOkMVq1BMjvfcNtb4mw9z5YDlO/40JlSA7FJeqHhAL9hE0
         kAp4yd5put2tjCij87pOfBZrY8LzlOPnH4NQtxVUoHJc+TWtMGeBoaTKrh7qMUQv/7bO
         1dMw==
X-Gm-Message-State: AOAM533S9N2VpBNoGqNQk70vPb6ir+yuX3aZgRjxSxJ/S52A10OnPAku
        XfF5kBMhKHNUlMfRGDhoNlL35tVnjbk+eDa4pR0=
X-Google-Smtp-Source: ABdhPJxQ0kxFGDW6SKs/ZkAuW3qrdumsGa+YE/HoO2jF89zCZ/AFVyqy0UdLvMZnvlj+iY/cKI8Sig==
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr17431918lfg.655.1619525223175;
        Tue, 27 Apr 2021 05:07:03 -0700 (PDT)
Received: from arei.office.basealt.ru ([2a0c:88c0:1:813:96c6:91ff:fe6b:6650])
        by smtp.gmail.com with ESMTPSA id h12sm376351ljh.21.2021.04.27.05.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:07:02 -0700 (PDT)
From:   Nikita Ermakov <arei@altlinux.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nikita Ermakov <arei@altlinux.org>
Subject: [PATCH] RISC-V: Relocate the kernel relative to a DRAM base.
Date:   Tue, 27 Apr 2021 15:06:07 +0300
Message-Id: <20210427120607.2646166-1-arei@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Try to get the base of the DRAM from a DTB to use it as a lowest address
in physical memory to relocate the kernel. If it is not possible to
obtain the base from a /memory node of the DTB let's make an assumption
that the DRAM base at the beginning of the memory.

Signed-off-by: Nikita Ermakov <arei@altlinux.org>
---
 drivers/firmware/efi/libstub/riscv-stub.c | 39 ++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 380e4e251399..1b5944276e1a 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -46,6 +46,39 @@ static u32 get_boot_hartid_from_fdt(void)
 	return fdt32_to_cpu(*prop);
 }
 
+static unsigned long get_dram_base_from_fdt(void)
+{
+	const void *fdt;
+	int node, len;
+	const fdt32_t *addr_cells;
+	const void *prop;
+
+	fdt = get_efi_config_table(DEVICE_TREE_GUID);
+	if (!fdt)
+		return ULONG_MAX;
+
+	node = fdt_path_offset(fdt, "/");
+	if (node < 0)
+		return ULONG_MAX;
+
+	addr_cells = fdt_getprop((void *)fdt, node, "#address-cells", &len);
+	if (!addr_cells)
+		return ULONG_MAX;
+
+	node = fdt_path_offset(fdt, "/memory");
+	if (node < 0)
+		return ULONG_MAX;
+
+	prop = fdt_getprop((void *)fdt, node, "reg", &len);
+	if (!prop)
+		return ULONG_MAX;
+
+	if (fdt32_to_cpu(*addr_cells) > 1)
+		return fdt64_to_cpu(*((fdt64_t *)prop));
+	else
+		return fdt32_to_cpu(*((fdt32_t *)prop));
+}
+
 efi_status_t check_platform_features(void)
 {
 	hartid = get_boot_hartid_from_fdt();
@@ -97,7 +130,11 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 * lowest possible memory region as long as the address and size meets
 	 * the alignment constraints.
 	 */
-	preferred_addr = MIN_KIMG_ALIGN;
+	preferred_addr = get_dram_base_from_fdt();
+	if (preferred_addr == ULONG_MAX)
+		preferred_addr = MIN_KIMG_ALIGN;
+	else
+		preferred_addr += MIN_KIMG_ALIGN;
 	status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
 				     preferred_addr, MIN_KIMG_ALIGN, 0x0);
 
-- 
2.29.3

