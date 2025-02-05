Return-Path: <linux-efi+bounces-2747-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707BA29354
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A9F3AFE49
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C426818B477;
	Wed,  5 Feb 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DwvmshoX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485F376;
	Wed,  5 Feb 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767640; cv=none; b=PFxug31mVWtI8RoE2b1EwRj+1p+LI8recql8TixJqoPNKDHHWmkEcHYJxplgZ2fFoV5gs5XLZCK6Qyt8eYEw2Jfq9EuuYqOqZu1mYXJWbaIuZ3QxzlrHqZuF87Oe6xgBLNkXPcVx5kai/pCsC5pyL8NiOb/ZcCjiYmbEHKKyz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767640; c=relaxed/simple;
	bh=SSxV7Twdz4JEXudo3L1T7WHvOJsEzhKZmXm3KNFOwjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW4tXpnTVd1kFPuzoAyTGfSiRrPB8DljvuR4Ci9FIrE9bt9kb00MERxFHAwkGg7ur38WyJ7XgREFKDUA+Mzb/TB38GvUso72O8J6r1nm1kjOMRoZplJGsQK9iW6/oDOMywjGxtuG4UrpLoI3k+1npmDBEpqbMhuMqQFbBPNIMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DwvmshoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCDAC4CED1;
	Wed,  5 Feb 2025 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767640;
	bh=SSxV7Twdz4JEXudo3L1T7WHvOJsEzhKZmXm3KNFOwjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwvmshoX1NeWKSyAXdMAcRLhoT3piakurE5gYnNuUgHxS5aHmtWEUwrEoPtK+R8kn
	 Dkcqk3OiN/UhkGONLzacgkL3YxGVEAtkE2GSxH9P7KzN1rNOK8YVpP5fXzPEGtDtzm
	 Lptotf5OscH9+20PUhvHOQmj0YaGst5dct3VDyCU=
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
Subject: [PATCH 6.13 432/623] efi: sysfb_efi: fix W=1 warnings when EFI is not set
Date: Wed,  5 Feb 2025 14:42:54 +0100
Message-ID: <20250205134512.748971645@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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
index cc807ed35aedf..1e509595ac034 100644
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




