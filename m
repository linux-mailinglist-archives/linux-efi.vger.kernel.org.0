Return-Path: <linux-efi+bounces-5051-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8884BDF914
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 18:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8D4FE54A
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449E2FE59F;
	Wed, 15 Oct 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o2yJ/xT/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y3TlpXBX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o2yJ/xT/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y3TlpXBX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAB2BDC13
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544519; cv=none; b=mB+JGkdv9NG3H7SYyMU4vx07C0MAGRbUZ6VpLBmXlbIOBT3BkOHNN/6Qq6u5nAXH/WTGAG6Vm+YfrL8SHfrVT5AGP3TEikSwJcbL5BeVe683qWFXPMf/MJQLO8/YgIs+dCNdilJU23tO7UB5i09s0WX6CG29U+xcGkThPZjljEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544519; c=relaxed/simple;
	bh=JhsOuA5z61Kk9JQnRK9gVbQ01jDd6GE0mrVP+WTwPOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRwSGchjSwr6zfKTufPAfNmzOLiMCo5CPthw9eiW5erpxaK4qAq7doB3Bggd5DKE3lcRNq/TlI/kkGwnLx940KTG+wKTM/00CsEKqzEEJNuyZXKb08ATbyIlpnHbvgxmRaL/1oAxn5AXjEwc8BADob2ezgLbPup91nAEYSxKPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o2yJ/xT/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y3TlpXBX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o2yJ/xT/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y3TlpXBX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A434121A23;
	Wed, 15 Oct 2025 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDsHzloWPnOJ16Vkpd5HNgcU6cVhWGnjIUW2zqEs0zU=;
	b=o2yJ/xT/8Fh/6LpH9PhWQCV5QOPfesPtceucm5PDxV4jo3Kpw+f+DXjubbX6VbP4aqfeEs
	q991aXjflqqhfFuP2jODTBIaYt8YUK32vYonHMjyL0gGfH0VgWo2W1CIzI+5fSTk/Rs8Xr
	iOiYYOmPRXHp3A54SuYwWO4hxhdIoP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDsHzloWPnOJ16Vkpd5HNgcU6cVhWGnjIUW2zqEs0zU=;
	b=Y3TlpXBXu6eMn/nil79+Bf05JyvtWJZDC0foP3d2OjBlNFRzibx3rmaL8vwpxQw7hHQ/9C
	qQgt/Buwty4FdCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDsHzloWPnOJ16Vkpd5HNgcU6cVhWGnjIUW2zqEs0zU=;
	b=o2yJ/xT/8Fh/6LpH9PhWQCV5QOPfesPtceucm5PDxV4jo3Kpw+f+DXjubbX6VbP4aqfeEs
	q991aXjflqqhfFuP2jODTBIaYt8YUK32vYonHMjyL0gGfH0VgWo2W1CIzI+5fSTk/Rs8Xr
	iOiYYOmPRXHp3A54SuYwWO4hxhdIoP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDsHzloWPnOJ16Vkpd5HNgcU6cVhWGnjIUW2zqEs0zU=;
	b=Y3TlpXBXu6eMn/nil79+Bf05JyvtWJZDC0foP3d2OjBlNFRzibx3rmaL8vwpxQw7hHQ/9C
	qQgt/Buwty4FdCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D68C13A42;
	Wed, 15 Oct 2025 16:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eEZVGfbG72inaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Oct 2025 16:08:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	jonathan@marek.ca,
	javierm@redhat.com
Cc: linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/5] efi/libstub: gop: Add support for reading EDID
Date: Wed, 15 Oct 2025 17:56:33 +0200
Message-ID: <20251015160816.525825-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015160816.525825-1-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Add support for EFI_EDID_DISCOVERED_PROTOCOL and EFI_EDID_ACTIVE_PROTOCOL
as defined in UEFI 2.8, sec 12.9. Define GUIDs and data structures in the
rsp header files.

In the GOP setup function, read the EDID of the primary GOP device. First
try EFI_EDID_ACTIVE_PROTOCOL, which supports user-specified EDID data. Or
else try EFI_EDID_DISCOVERED_PROTOCOL, which returns the display device's
native EDID. If no EDID could be retrieved, clear the storage.

Rename efi_setup_gop() to efi_setup_graphics() to reflect the changes
Let callers pass an optional instance of struct edid_data, if they are
interested.

While screen_info and edid_info come from the same device handle, they
should be considered indendent data. The former refers to the graphics
mode, the latter refers to the display device. GOP devices might not
provide both.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/libstub/efi-stub.c |  2 +-
 drivers/firmware/efi/libstub/efistub.h  | 31 ++++++++++++++++++++-
 drivers/firmware/efi/libstub/gop.c      | 36 ++++++++++++++++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c |  2 +-
 include/linux/efi.h                     |  2 ++
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 874f63b4a383..9cb814c5ba1b 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -56,7 +56,7 @@ static struct screen_info *setup_graphics(void)
 {
 	struct screen_info *si, tmp = {};
 
-	if (efi_setup_gop(&tmp) != EFI_SUCCESS)
+	if (efi_setup_graphics(&tmp, NULL) != EFI_SUCCESS)
 		return NULL;
 
 	si = alloc_screen_info();
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index f5ba032863a9..b2fb0c3fa721 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -34,6 +34,9 @@
 #define EFI_ALLOC_LIMIT		ULONG_MAX
 #endif
 
+struct edid_info;
+struct screen_info;
+
 extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
@@ -578,6 +581,32 @@ union efi_graphics_output_protocol {
 	} mixed_mode;
 };
 
+typedef union efi_edid_discovered_protocol efi_edid_discovered_protocol_t;
+
+union efi_edid_discovered_protocol {
+	struct {
+		u32 size_of_edid;
+		u8 *edid;
+	};
+	struct {
+		u32 size_of_edid;
+		u32 edid;
+	} mixed_mode;
+};
+
+typedef union efi_edid_active_protocol efi_edid_active_protocol_t;
+
+union efi_edid_active_protocol {
+	struct {
+		u32 size_of_edid;
+		u8 *edid;
+	};
+	struct {
+		u32 size_of_edid;
+		u32 edid;
+	} mixed_mode;
+};
+
 typedef union {
 	struct {
 		u32			revision;
@@ -1085,7 +1114,7 @@ efi_status_t efi_parse_options(char const *cmdline);
 
 void efi_parse_option_graphics(char *option);
 
-efi_status_t efi_setup_gop(struct screen_info *si);
+efi_status_t efi_setup_graphics(struct screen_info *si, struct edid_info *edid);
 
 efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  const efi_char16_t *optstr,
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 02459ef0f18c..72d74436a7a4 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
+#include <video/edid.h>
 
 #include "efistub.h"
 
@@ -413,6 +414,14 @@ static void setup_screen_info(struct screen_info *si, const efi_graphics_output_
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 }
 
+static void setup_edid_info(struct edid_info *edid, u32 gop_size_of_edid, u8 *gop_edid)
+{
+	if (!gop_edid || gop_size_of_edid < 128)
+		memset(edid->dummy, 0, sizeof(edid->dummy));
+	else
+		memcpy(edid->dummy, gop_edid, min(gop_size_of_edid, sizeof(edid->dummy)));
+}
+
 static efi_handle_t find_handle_with_primary_gop(unsigned long num, const efi_handle_t handles[],
 						 efi_graphics_output_protocol_t **found_gop)
 {
@@ -469,7 +478,7 @@ static efi_handle_t find_handle_with_primary_gop(unsigned long num, const efi_ha
 	return first_gop_handle;
 }
 
-efi_status_t efi_setup_gop(struct screen_info *si)
+efi_status_t efi_setup_graphics(struct screen_info *si, struct edid_info *edid)
 {
 	efi_handle_t *handles __free(efi_pool) = NULL;
 	efi_handle_t handle;
@@ -494,5 +503,30 @@ efi_status_t efi_setup_gop(struct screen_info *si)
 	if (si)
 		setup_screen_info(si, gop);
 
+	/* Display EDID for primary GOP */
+	if (edid) {
+		efi_edid_discovered_protocol_t *discovered_edid;
+		efi_edid_active_protocol_t *active_edid;
+		u32 gop_size_of_edid = 0;
+		u8 *gop_edid = NULL;
+
+		status = efi_bs_call(handle_protocol, handle, &EFI_EDID_ACTIVE_PROTOCOL_GUID,
+				     (void **)&active_edid);
+		if (status == EFI_SUCCESS) {
+			gop_size_of_edid = active_edid->size_of_edid;
+			gop_edid = active_edid->edid;
+		} else {
+			status = efi_bs_call(handle_protocol, handle,
+					     &EFI_EDID_DISCOVERED_PROTOCOL_GUID,
+					     (void **)&discovered_edid);
+			if (status == EFI_SUCCESS) {
+				gop_size_of_edid = discovered_edid->size_of_edid;
+				gop_edid = discovered_edid->edid;
+			}
+		}
+
+		setup_edid_info(edid, gop_size_of_edid, gop_edid);
+	}
+
 	return EFI_SUCCESS;
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 761121a77f9e..b68dbfd1cb87 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -389,7 +389,7 @@ static void setup_graphics(struct boot_params *boot_params)
 {
 	struct screen_info *si = memset(&boot_params->screen_info, 0, sizeof(*si));
 
-	efi_setup_gop(si);
+	efi_setup_graphics(si, NULL);
 }
 
 static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 544498c89ced..11e267492efd 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -373,6 +373,8 @@ void efi_native_runtime_setup(void);
 #define EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID	EFI_GUID(0x8b843e20, 0x8132, 0x4852,  0x90, 0xcc, 0x55, 0x1a, 0x4e, 0x4a, 0x7f, 0x1c)
 #define EFI_DEVICE_PATH_FROM_TEXT_PROTOCOL_GUID	EFI_GUID(0x05c99a21, 0xc70f, 0x4ad2,  0x8a, 0x5f, 0x35, 0xdf, 0x33, 0x43, 0xf5, 0x1e)
 #define EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID	EFI_GUID(0x9042a9de, 0x23dc, 0x4a38,  0x96, 0xfb, 0x7a, 0xde, 0xd0, 0x80, 0x51, 0x6a)
+#define EFI_EDID_DISCOVERED_PROTOCOL_GUID	EFI_GUID(0x1c0c34f6, 0xd380, 0x41fa,  0xa0, 0x49, 0x8a, 0xd0, 0x6c, 0x1a, 0x66, 0xaa)
+#define EFI_EDID_ACTIVE_PROTOCOL_GUID		EFI_GUID(0xbd8c1056, 0x9f36, 0x44ec,  0x92, 0xa8, 0xa6, 0x33, 0x7f, 0x81, 0x79, 0x86)
 #define EFI_PCI_IO_PROTOCOL_GUID		EFI_GUID(0x4cf5b200, 0x68b8, 0x4ca5,  0x9e, 0xec, 0xb2, 0x3e, 0x3f, 0x50, 0x02, 0x9a)
 #define EFI_FILE_INFO_ID			EFI_GUID(0x09576e92, 0x6d3f, 0x11d2,  0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_SYSTEM_RESOURCE_TABLE_GUID		EFI_GUID(0xb122a263, 0x3661, 0x4f68,  0x99, 0x29, 0x78, 0xf8, 0xb0, 0xd6, 0x21, 0x80)
-- 
2.51.0


