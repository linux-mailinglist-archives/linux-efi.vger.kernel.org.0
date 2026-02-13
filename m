Return-Path: <linux-efi+bounces-6135-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFGtArdWj2lqQQEAu9opvQ
	(envelope-from <linux-efi+bounces-6135-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 17:52:07 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1B138635
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95A8A301F489
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73372874FA;
	Fri, 13 Feb 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDN3FghG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CE1A5B84;
	Fri, 13 Feb 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001523; cv=none; b=U/vMDnOscrRFCBiiNyAJvxNu8/Ymox5c4X0f+1VolhHNSR1fHG1KrHi4Yj3uhnIWMl/gkr03KKlxaMeQsEhw74OlSl20rRZnLIRb0Gi8wZnYfbHF8Lo3Hie39FiNUpN5p1q/6UGqecwUv6gVJhTCYh9audbiBn8qydVuDTl8XrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001523; c=relaxed/simple;
	bh=tmt0q9mf3Eif4bNek/WI6L9JGV7MVeNfqQr20DcgW4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0Sk2xdCpvaFUolNYoJYvAaNM9mQ9nIupGEKQcKXRAc37MgbFyV/pEvolDUFKh+8j9NJ8/wT8+pCdmVXCO83J+hy7MKXsAXqWAUjWJOYaGgMZ/fQRyDj3WKO1i5nX1H8/7yv4c3gv9qnUzk+XXuiVNn7paHMXzFRDBNWmrC7QRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDN3FghG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879FAC116C6;
	Fri, 13 Feb 2026 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771001523;
	bh=tmt0q9mf3Eif4bNek/WI6L9JGV7MVeNfqQr20DcgW4k=;
	h=From:To:Cc:Subject:Date:From;
	b=VDN3FghGBzGvpCstzObZnkYvGpW6h1XfCazhmDBNpTi52/3cQkpWWAZwCL6pnnDx3
	 5gtDajz/trk/6lTh+6uugzuVyjiVYQcCgWhgNjSYT/TJRh6x+QDBho1cwzTE0u4iL9
	 V0a0Iejzn2UcM38OYdowDSgGPKQV63ZQ941uRAd7wgZZG0NdM9w2i10I8B2ggjU/vI
	 v+S+Zy3Jn3GjuwNm5xMHJnn27QNVgQBoLpTboN9w0rhMNGckmYrSO0y2x3uOxxoATv
	 MvHMknIXaXk/sUt5kKCN7lhMP/HNSQ9GlHZuI8/o4TWXCrOzemrpBwTIj27ca3y2bw
	 1FSzi9UGzVqeA==
From: Arnd Bergmann <arnd@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel test robot <lkp@intel.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi: export  sysfb_primary_display for EDID
Date: Fri, 13 Feb 2026 17:51:51 +0100
Message-Id: <20260213165158.1327846-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6135-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,arndb.de:email]
X-Rspamd-Queue-Id: 20C1B138635
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The sysfb_primary_display structure is now part of efi-init.c but
conditionally defined. One of the users is missing in the condition:

aarch64-linux-ld: drivers/video/fbdev/core/fbmon.o: in function `fb_firmware_edid':
fbmon.c:(.text.fb_firmware_edid+0x3c): undefined reference to `sysfb_primary_display'

Export it whenever CONFIG_FIRMWARE_EDID is set, so the fbdev core
code can use it.

Fixes: 4fcae6358871 ("sysfb: Move edid_info into sysfb_primary_display")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602111543.Do4nkY5l-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sorry for missing this earlier, I had a local fixup in my randconfig
tree but never sent it out until I stumbled over it today. The
broken commit is now merged in mainline for 7.0, and I think this one
is needed as a regression fix.
---
 drivers/firmware/efi/efi-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 9fc501fbc870..850f85f04520 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -61,7 +61,7 @@ extern __weak const efi_config_table_type_t efi_arch_tables[];
  * x86 defines its own instance of sysfb_primary_display and uses
  * it even without EFI, everything else can get them from here.
  */
-#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON))
+#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)) || defined(CONFIG_FIRMWARE_EDID)
 struct sysfb_display_info sysfb_primary_display __section(".data");
 EXPORT_SYMBOL_GPL(sysfb_primary_display);
 #endif
-- 
2.39.5


