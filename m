Return-Path: <linux-efi+bounces-2745-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72624A28F9A
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 15:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62033A9A65
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C7155747;
	Wed,  5 Feb 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pN/jtu/i"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EC14A088;
	Wed,  5 Feb 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765548; cv=none; b=Vle5LTFt/LilEEDSX1UoDG9Qa01bSTUZ0EHopbFfU/xKZkeQswVEwGY1byEqstDarK/aE6XG0AbimBQa4Gs+wTkrE2PYEUdQVtc87Youj7czuPqyYfKcWUV5aRydpjo4RYy80vGxjrk8S7hopAPWEIHPALYIY7XpjGJvQmSqoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765548; c=relaxed/simple;
	bh=rdBayyIqClqn3YDOp73mHJxCK+7YHwhsrxLB5hBfjvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEPD2I0WgLL5aUN3tA+zAZcDpwkf6x2SR7hSWOpALys2nMyXXA/U5nnvV1195mnnPqIygTiF39mU7hH2b2f6o9KX4wx9aGrUKwIbW2pdqVd3RM+7PpvKdjJNixkMXKRGXnxQbP4phR4kSLJxpND9AfVPIhu9a1vLwy6LdYGZdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pN/jtu/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E8FC4CED1;
	Wed,  5 Feb 2025 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765548;
	bh=rdBayyIqClqn3YDOp73mHJxCK+7YHwhsrxLB5hBfjvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pN/jtu/iReUKZyiqTbiu+JRJDzGgnbO70J7P3ABgGNgq6wHZmeYoiEbzQC0h2+kUk
	 WosCq+1UxFXD2clFpruKpjpNYxeXXHsqW20fzjWZxch6FL7jOcMdSmk9dZvT2kJoxo
	 D3YX8oKMF+8fG4wy6Gc2RCGm+MMZszLq64J6+okg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	David Rheinsberg <david@readahead.eu>,
	Hans de Goede <hdegoede@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Peter Jones <pjones@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-fbdev@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 277/393] efi: sysfb_efi: fix W=1 warnings when EFI is not set
Date: Wed,  5 Feb 2025 14:43:16 +0100
Message-ID: <20250205134430.908148811@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 19fdc68aa7b90b1d3d600e873a3e050a39e7663d ]

A build with W=1 fails because there are code and data that are not
needed or used when CONFIG_EFI is not set. Move the "#ifdef CONFIG_EFI"
block to earlier in the source file so that the unused code/data are
not built.

drivers/firmware/efi/sysfb_efi.c:345:39: warning: ‘efifb_fwnode_ops’ defined but not used [-Wunused-const-variable=]
  345 | static const struct fwnode_operations efifb_fwnode_ops = {
      |                                       ^~~~~~~~~~~~~~~~
drivers/firmware/efi/sysfb_efi.c:238:35: warning: ‘efifb_dmi_swap_width_height’ defined but not used [-Wunused-const-variable=]
  238 | static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/efi/sysfb_efi.c:188:35: warning: ‘efifb_dmi_system_table’ defined but not used [-Wunused-const-variable=]
  188 | static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
      |                                   ^~~~~~~~~~~~~~~~~~~~~~

Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501071933.20nlmJJt-lkp@intel.com/
Cc: David Rheinsberg <david@readahead.eu>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/sysfb_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 456d0e5eaf78b..f479680299838 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -91,6 +91,7 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 		_ret_;						\
 	})
 
+#ifdef CONFIG_EFI
 static int __init efifb_set_system(const struct dmi_system_id *id)
 {
 	struct efifb_dmi_info *info = id->driver_data;
@@ -346,7 +347,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 	.add_links = efifb_add_links,
 };
 
-#ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(void)
-- 
2.39.5




