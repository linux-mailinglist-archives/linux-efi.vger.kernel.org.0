Return-Path: <linux-efi+bounces-2528-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6AA04DE9
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 00:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572301887BAD
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4DF1F37C8;
	Tue,  7 Jan 2025 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FVEQh6DK"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2619AD48;
	Tue,  7 Jan 2025 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294001; cv=none; b=MJwA09q1Tagm+fXJx1QVJHALBgFxHCRbz0G6uT7HWsMPmo0XFXWDBrDBbGE3t6zi+5YCIjorg0EFIgVrONg51nl7XoR5uQIwgmiHf/jckTXUqUCM4pFbTLew9mZzmsBOUd/zVjQTrjEGUvdmF3wFB4kxb5DQzcsKrwmxuq1KVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294001; c=relaxed/simple;
	bh=RApKzr4uhkLoYg8X2Hl7QnpCHOmEeDth7c9X8vBvK+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qjYloG3EBKeWe6dSB0Eap2G2wfwSvRdm6NyaJHMY0nv5Q938XZm5yQvLEAl4w45rPsS1eS7djcOWe25MyDOEH8/DzoSbo+0OpJRCzeNTD2APZ2BD2dBILpel+AP3QJEMOvjQYVhLeYUqQgul2uuzNLOlN2VoU3K4FvTjVzNVyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FVEQh6DK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zPpjL/4ixNVqrRxYgtV8l3W7ne2I3km7/b5GHbiSXo8=; b=FVEQh6DKB/gK7QYBasjCMo3d1n
	LFtp7HGesNbG6c8Ggwsk+oR5kt2UeMLDs+FUfXlTFffc7DOvhXtWG5vdbRF7vOQAKA/v0dPjwr7Df
	WdH3HXMClYvjPHLu77hQtHyYu2phabiZyxz+pQjMbWvMqLK51k80eJ/bxBGgClB8BzBmgGV8EgDen
	GBwl/A7hxshrK2EmLLABXEJ4jJ2Mwdg3l0YiGaFIdRnJsvYW2h1cH8k6HvY9v6wdhCy8o+uCNFjP1
	HvEQwJk+voSBVOBZRgiVePjfidOh+0VBLLrG658+iqCa+CYJ28Z8u1ymzN81ohGNsxrzxL3oCnASK
	A9asTvUA==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVJNr-00000006ar8-3kng;
	Tue, 07 Jan 2025 23:53:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	David Rheinsberg <david@readahead.eu>,
	Hans de Goede <hdegoede@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Peter Jones <pjones@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-fbdev@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH] efi: sysfb_efi: fix W=1 warnings when EFI is not set
Date: Tue,  7 Jan 2025 15:53:09 -0800
Message-ID: <20250107235312.236247-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/firmware/efi/sysfb_efi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20250106.orig/drivers/firmware/efi/sysfb_efi.c
+++ linux-next-20250106/drivers/firmware/efi/sysfb_efi.c
@@ -91,6 +91,7 @@ void efifb_setup_from_dmi(struct screen_
 		_ret_;						\
 	})
 
+#ifdef CONFIG_EFI
 static int __init efifb_set_system(const struct dmi_system_id *id)
 {
 	struct efifb_dmi_info *info = id->driver_data;
@@ -346,7 +347,6 @@ static const struct fwnode_operations ef
 	.add_links = efifb_add_links,
 };
 
-#ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(void)

