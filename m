Return-Path: <linux-efi+bounces-6097-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIRiHoPlhWnCHwQAu9opvQ
	(envelope-from <linux-efi+bounces-6097-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Feb 2026 13:58:43 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF394FDC98
	for <lists+linux-efi@lfdr.de>; Fri, 06 Feb 2026 13:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E72DC302D130
	for <lists+linux-efi@lfdr.de>; Fri,  6 Feb 2026 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F938377542;
	Fri,  6 Feb 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWOqyAHo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA535F8D5
	for <linux-efi@vger.kernel.org>; Fri,  6 Feb 2026 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382640; cv=none; b=G4WSCUHFSCpAGbs3kOIWlB/g1SXLzV3lDHeTm0zh3BLMDi6RA1rcO3/Fv2J4ANtTZdBLjsBoaytFd3/EHoemoqkUXJkRZcijR+aj8MFVwGb3OlGo144PnjaGLC90rZiQN39nIeqGiZq5f8fD+DnUi5t1tS4QCroE2/ZUPfg+EPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382640; c=relaxed/simple;
	bh=Gm/45C6aiyq1VubFEgZhyjA7HQmfRnDcaftZAQwtYDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwh6ZmVg5CN7JHEkS6mfOhOlGdCXFw0WcV8M0tp0p+sNp43qSJeM4UpDKHc5VwqG+o3yLXJf1RfO/WjdRwnMvxj0IssZ4FxoIX2Tp58Qirx58dFFI2pifhcM78r4S7J5+srQiKlmbfn8EyI62XXKHbGODTqsp7zhPo9xY/F1jbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWOqyAHo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7bced39cfso22297185ad.1
        for <linux-efi@vger.kernel.org>; Fri, 06 Feb 2026 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770382639; x=1770987439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Nj7rTmIxrIyoM/Zv2E7TPav3Q6NYtriqtqId7+NMO4=;
        b=YWOqyAHo5FT1cTWCmeiUcL3s80iYsRy0X6JKYQWHTuO3yGnzO9HYtu99CrIPywTpeZ
         wlaxUVbfyvqo5mnLljSlHou7F0Mgk0pCLcY+xLTuh0FTorwc+ujO9LX98Pn/3kMsyb6i
         8cO1yqWFD7ksKuCtQBME7C9//3pF2PKGlnySQ/QKKyTQ5Dn4S3hCUBH27heoV4D+Swww
         Wk1CT33aYego5MOwZNtsKi92RzaeVIwqCqnuZvI7BhRG+NNwnjVjMaRH4+fLktKexpyd
         SFKjke4g3qo831W3IXzs7t0CgM17ZmE4uwaLH8BWOySe63B0/dBsy1E7gtqXwUDp4WPx
         f2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770382639; x=1770987439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Nj7rTmIxrIyoM/Zv2E7TPav3Q6NYtriqtqId7+NMO4=;
        b=JX1ycGtmHli6W2RcnkfU/NmBAB5bK6Whk5QEf4aQm6kiutBs2Un6CyalpRXhlAwItH
         HYaGTTTxrMzoSXicykArZpELHMrxecgfMlysxFHhOqUIag+RGI8MCs/rAoN9PE1Oh/OI
         o2o1M+YSZi2OUQwsM2R67G4N551eM+LOSI8qFGZOay8NvLX1tQl7bqoSp+/F/sb2BXl3
         R/7eU36Kp2rKzuKU5J9X1+n5JNMRxIYTKsW2BFeDhINiOCGkk5APX2OKsTLyxSm11SmW
         1nHs9Uuln5YDJdbnJj1wgonDsiJFYW2hsOM3yqoM9MsaSIxNoV3nkDOGlvcFDALwFp67
         GDsg==
X-Forwarded-Encrypted: i=1; AJvYcCVdLk0xLl2nn7sdlT8fzVWmu+rUijodrbx/Vayb6axdM92dvlpvIWKNLOe+Mjkar4odEjbdGAPDIe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDSUE/3igcksdHCMrqRFDwCuK92gF0qw87n+OR+lhdoyukoUr
	e0SWObOor+ozeCd411CplZ9wQLyHD5Lu2QnzzTc4CdSp/KQoUebkQy7tFc0prpU=
X-Gm-Gg: AZuq6aIM44hvA+FxBCYL5z/u9dVTCDM19S34nK4qaR8n9Y50JBYLQWhLLEWHgpdi5BW
	IYE1eouXYzfuDd8BWEnogw25wX9Ubsm/t62EcfNK7ZR0kEo6tP8P9jC+kiCMWK8aCvABwHayien
	ATedv/NYp6KE/UlZnL63CXW1dfFYKpKsRVzscQ39RRe7JsYHQ4v307afSRTJXJRTNXLZEFvn2SK
	J8e0TUW3/anJEokTjlTrpMGsh4r4Z6BKlVZyKlda84f0g35YPkQK554EEPOpQ1wqpP1scMciRfe
	29/j2AGQ/lFtd3xqETA7clKThF7WC5/6NTZDX5msMGTzrELIx2i1eG58pVe+O1GgfSZ9czw5aTd
	Azdv2MTTZB2P2OUXvxHtzv9lUdJQ4kh4QVMeyFe+wlc9W2saAKXh+eYhdmwdImb6SHWBKxvLh4a
	IPw7Rl7ZNNCJY2pidSaNem/R20Gg==
X-Received: by 2002:a17:902:da91:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a9516cd2fbmr27802775ad.21.1770382639301;
        Fri, 06 Feb 2026 04:57:19 -0800 (PST)
Received: from at.. ([171.61.167.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a636aasm23336005ad.12.2026.02.06.04.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:57:18 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Lukas Wunner <lukas@wunner.de>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] platform/apple-gmux: use apple_brightness to save brightness to EFI
Date: Fri,  6 Feb 2026 12:56:22 +0000
Message-ID: <20260206125641.12983-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206125641.12983-1-atharvatiwarilinuxdev@gmail.com>
References: <20260206125641.12983-1-atharvatiwarilinuxdev@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[wunner.de,gmail.com,kernel.org,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6097-lists,linux-efi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-efi];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF394FDC98
X-Rspamd-Action: no action

use apple_brightness to save brightness to EFI.

(tested on iMac20,1)

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 1417e230edbd..cfb20c115eb0 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/debugfs.h>
+#include <linux/platform_data/apple-brightness.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -960,6 +961,12 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	}
 
 	gmux_init_debugfs(gmux_data);
+	if (IS_ENABLED(CONFIG_APPLE_BRIGHTNESS)) {
+		ret = apple_brightness_probe(gmux_data->bdev, &gmux_get_brightness);
+		if (ret)
+			pr_warn("Unable to Enable EFI brightness saver: %d\n", ret);
+	}
+
 	return 0;
 
 err_register_handler:
-- 
2.43.0


