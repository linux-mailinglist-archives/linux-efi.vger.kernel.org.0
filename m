Return-Path: <linux-efi+bounces-916-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD87089683E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 10:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB41C20D7E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F28627D;
	Wed,  3 Apr 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/8zCn6N"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB66BB2F;
	Wed,  3 Apr 2024 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131749; cv=none; b=jVDxWVWOH+jYdDJZ+ekBjMGYGy7FDkOUJf/GwAC/VihjFeEzvmJqZ+fLENe34FZrd1b5G70JgCx2ZQeOte7wl7p+Z57oiN27HrvGaB382H0Yk8IFHUf119BQHJobQUokwtbVXH6Iu1Gdok6b52cx1bdfgDov/UTJ/NeB3qZ3gX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131749; c=relaxed/simple;
	bh=6hTjKP6WBOCL/0dZJm2MA9w9IJCqbMQSjTLYDwQEjY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q94EUFAr37AjyeGxkF9KkbZHnC23tOCqrWIu1Hc2X+bIOs1l4iGl0ZeQNnpPb++VeY6MA44lbX0BFFw9jTCQ4NQi1ohVmBHub5jlSSv+pPPsr1PlJBAQrX9QZuVRLdb7vdVBfWc6ekMN1KeqUp4gfnfX7HdmWtsZzYnU055Al+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/8zCn6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4667CC433C7;
	Wed,  3 Apr 2024 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131748;
	bh=6hTjKP6WBOCL/0dZJm2MA9w9IJCqbMQSjTLYDwQEjY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/8zCn6NLbDyqzej6+yt2TFIWP7PIg7HiHXdCQJTFoDO4X3FezNWc74lPih5w58/b
	 4SHUoSGfn3/vxivbPxIElkwdeoq/D/yQabS63yJmL6JjCYomj+IqJ3DFZENlZ3TUoa
	 rhZV2Pyvjd8OPOwzsYl/LdBV1F7oyyNXlGRJFLZGV2wt5XYnmRW1Up41u4ssWjuPb3
	 /tp3IdroXWZozQkG2q99BzZ84oIGuVuHWgl3SeB8uTqTmwLmPaYdZMOtyawfZiuHLv
	 RwBJzDy4Lvwbm11hITuga07fsnbMW3ksH+f5fhy9szvFEMoA7d2dH6ANDpkRERrh44
	 pkPXTIlCQDMhQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH 10/34] efi: sysfb: don't build when EFI is disabled
Date: Wed,  3 Apr 2024 10:06:28 +0200
Message-Id: <20240403080702.3509288-11-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With 'make W=1', there is a warning when EFI is turned off but sysfb_efi
still gets built:

drivers/firmware/efi/sysfb_efi.c:188:35: error: unused variable 'efifb_dmi_system_table' [-Werror,-Wunused-const-variable]
static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
                                  ^
drivers/firmware/efi/sysfb_efi.c:238:35: error: unused variable 'efifb_dmi_swap_width_height' [-Werror,-Wunused-const-variable]
static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
                                  ^
drivers/firmware/efi/sysfb_efi.c:297:28: error: unused function 'find_pci_overlap_node' [-Werror,-Wunused-function]
static struct device_node *find_pci_overlap_node(void)

There was an earlier patch to address the duplicate function definitions, but
that missed how we should not be building this file in the first place.

Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/efi/Makefile    | 3 ++-
 drivers/firmware/efi/sysfb_efi.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index a2d0009560d0..3baf80d8cf81 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -30,7 +30,8 @@ obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
 
-obj-$(CONFIG_SYSFB)			+= sysfb_efi.o
+sysfb-$(CONFIG_SYSFB)			+= sysfb_efi.o
+obj-$(CONFIG_EFI)			+= $(sysfb-y)
 
 arm-obj-$(CONFIG_EFI)			:= efi-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index cc807ed35aed..a8c982475f6b 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -346,7 +346,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 	.add_links = efifb_add_links,
 };
 
-#ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(void)
@@ -372,4 +371,3 @@ __init void sysfb_set_efifb_fwnode(struct platform_device *pd)
 		pd->dev.fwnode = &efifb_fwnode;
 	}
 }
-#endif
-- 
2.39.2


