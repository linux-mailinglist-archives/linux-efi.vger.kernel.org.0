Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A1D5B185
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2019 22:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfF3Ugx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jun 2019 16:36:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33474 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfF3Ugw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jun 2019 16:36:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so9508147qkc.0;
        Sun, 30 Jun 2019 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StYKnXypXDaNaX52nN9jVP9VolfDF5eTNSV4sKsYdNo=;
        b=M5YzlCM7sZ7t6Ve1AiiXyULjkmLIbFjo9sO9b9FRNY409L/mHrGKx1FzO5c4lhLgBZ
         TdNvoZ//n6uDY4yHMu8qpw8HEmgJ+k9tvZbCSYcXR1hRvKeWlGjaxxVmmsTaw/Ah5Jta
         QW7RuKYv53B+pt6XWvAqtVJrjIcgOQIh6D5k0HhSbMJvjHpKnb7XFy0+y5Vn8ORjdKHS
         l8cIPPGb4xKCVl1XXeGvLjawptesNngCnBK3nD5nZ0xmfNsaW4lNx4KqqOTFS1RF4sno
         kaal7JJ7sFroRfvY2pny5HmStncnKE7DmZg3WPWQUwoPCGKi3rJWs/LlrcBXFfBQ4d33
         57IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StYKnXypXDaNaX52nN9jVP9VolfDF5eTNSV4sKsYdNo=;
        b=e1NC488A3tVtj1P+/JV2DlPCBvLU18EWXuUzO049MDdwqjv6YrIkkHK+ae4ogcJnc+
         AZaWeJUGYAr5fO3Ky16n8Z/Xm6OfumiMfn4bzfjASqpOvhgJm0BsQkBKunnuOygA0RFX
         xgNGMMSuiBgY4JX4F1HEQBmEOH36JWIoezgV1DYBD86/+ZUI6FxFcMbzPfUZSi0TBAqG
         2vd5XACT0SdkAdOLJboh59acQ3vF1SOs+5dTJsYPYaHQWK9V9U+ShQzXaJ3oPkvnVtjj
         LsJTKIxULNolOMgZe69x39SLXcGrfNFYcJ+6oM3yX/p9zX05A8bB5PR3LavefBk/tHw5
         rGNg==
X-Gm-Message-State: APjAAAV8LPYPpd/HbhfPEiy7pci6ovYgMYtaOCIQXQq4W3mkAXoKD0UE
        7W9DHSSRPR+87iiCMSvWEgU=
X-Google-Smtp-Source: APXvYqxXYbfD7yFwsEz+jE2N/G7xl1mla7Ol0HLh8IFTwUjqsgfF8qe2/PhUmuHvmACYXofc01f/Cg==
X-Received: by 2002:a37:bf07:: with SMTP id p7mr15452759qkf.315.1561927011188;
        Sun, 30 Jun 2019 13:36:51 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id c192sm4014942qkg.33.2019.06.30.13.36.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 13:36:50 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] efi/libstub: detect panel-id
Date:   Sun, 30 Jun 2019 13:36:06 -0700
Message-Id: <20190630203614.5290-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630203614.5290-1-robdclark@gmail.com>
References: <20190630203614.5290-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

On snapdragon aarch64 laptops, a 'UEFIDisplayInfo' variable is provided
to communicate some information about the display.  Crutially it has the
panel-id, so the appropriate panel driver can be selected.  Read this
out and stash in /chosen/panel-id so that display driver can use it to
pick the appropriate panel.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 49 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h  |  2 +
 drivers/firmware/efi/libstub/fdt.c      |  9 +++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 04e6ecd72cd9..999813252e0d 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -69,6 +69,53 @@ static struct screen_info *setup_graphics(efi_system_table_t *sys_table_arg)
 	return si;
 }
 
+/*
+ * We (at least currently) don't care about most of the fields, just
+ * panel_id:
+ */
+struct mdp_disp_info {
+	u32 version_info;
+	u32 pad0[9];
+	u32 panel_id;
+	u32 pad1[17];
+};
+
+#define MDP_DISP_INFO_VERSION_MAGIC 0xaa
+
+static void get_panel_id(efi_system_table_t *sys_table_arg,
+			 unsigned long fdt_addr)
+{
+	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
+	efi_status_t status;
+	struct mdp_disp_info *disp_info;
+	unsigned long size = 0;
+
+	status = efi_call_runtime(get_variable, L"UEFIDisplayInfo",
+				  &gop_proto, NULL, &size, NULL);
+	if (status == EFI_NOT_FOUND)
+		return;
+
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size,
+				(void **)&disp_info);
+	if (status != EFI_SUCCESS)
+		return;
+
+	status = efi_call_runtime(get_variable, L"UEFIDisplayInfo",
+				  &gop_proto, NULL, &size, disp_info);
+	if (status != EFI_SUCCESS)
+		goto cleanup;
+
+	if ((disp_info->version_info >> 16) != MDP_DISP_INFO_VERSION_MAGIC)
+		goto cleanup;
+
+	efi_printk(sys_table_arg, "found a panel-id!\n");
+
+	set_chosen_panel_id(fdt_addr, disp_info->panel_id);
+
+cleanup:
+	efi_call_early(free_pool, disp_info);
+}
+
 void install_memreserve_table(efi_system_table_t *sys_table_arg)
 {
 	struct linux_efi_memreserve *rsv;
@@ -229,6 +276,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 	if (!fdt_addr)
 		pr_efi(sys_table, "Generating empty DTB\n");
 
+	get_panel_id(sys_table, fdt_addr);
+
 	status = handle_cmdline_files(sys_table, image, cmdline_ptr, "initrd=",
 				      efi_get_max_initrd_addr(dram_base,
 							      *image_addr),
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 1b1dfcaa6fb9..8832cb9a7a40 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -39,6 +39,8 @@ void efi_char16_printk(efi_system_table_t *, efi_char16_t *);
 
 unsigned long get_dram_base(efi_system_table_t *sys_table_arg);
 
+void set_chosen_panel_id(unsigned long fdt_addr, unsigned panel_id);
+
 efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 					    void *handle,
 					    unsigned long *new_fdt_addr,
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 5440ba17a1c5..cb6ea160a40a 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -200,6 +200,15 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
 	return EFI_SUCCESS;
 }
 
+void set_chosen_panel_id(unsigned long fdt_addr, unsigned panel_id)
+{
+	void *fdt = (void *)fdt_addr;
+	int node = fdt_subnode_offset(fdt, 0, "chosen");
+	u32 fdt_val32 = cpu_to_fdt32(panel_id);
+
+	fdt_setprop_var(fdt, node, "panel-id", fdt_val32);
+}
+
 #ifndef EFI_FDT_ALIGN
 # define EFI_FDT_ALIGN EFI_PAGE_SIZE
 #endif
-- 
2.20.1

