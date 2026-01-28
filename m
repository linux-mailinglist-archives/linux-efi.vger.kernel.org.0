Return-Path: <linux-efi+bounces-6043-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMXOON4lemlk3QEAu9opvQ
	(envelope-from <linux-efi+bounces-6043-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:06:06 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54471A3815
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C83E30AC64C
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71A361DDF;
	Wed, 28 Jan 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5hbWPw/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478D2F25E2
	for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612370; cv=none; b=Da4uz4dtqQgIrDXOQSMmMjNl4D+56ukVjxgZJE5HImTzci9wJZIH5ytlXJXEGmLYdPqAqZOXeaXVRbv7lLGQuoFu+wHijOdiw9L9xKYYFLZ98qEO9txje3PYiAzHZS3rIqC5iiqS9PH7sUSV/pcTCn5SweyKab4ug4ZyS8E4PXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612370; c=relaxed/simple;
	bh=XEpzoWGNMHcqtb/EIFRdGrXPkXPqm8L5EZte7iDbRp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSsZwHT7SaltBPSeDIBGWIuubtVPfrKNwRmCvLjkEY5tiR2NBrl3hjvYascqRTy41I43xQ3DeSOpDMd/xpD9cL4G9289FX+3+1X1yXxEn76fVGXspYbscLkbQgzd/AXV+z/SL4EuBRmlS3tghbDVonTQxPDiQjo5br5pdutYd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5hbWPw/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a76f90872cso36699585ad.3
        for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769612369; x=1770217169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXyZBm2HT5a2syRm7I8O8JEOj9+5Hm8S0vVHV9UIr+Q=;
        b=Z5hbWPw/vEnF8xiqlhvG3G/HHfGT3HkRz3ZbWVIFLZkgTIocVINxW7I/vwmty0n1Cs
         8ioFsX9tyxbx/lxW+53IX/QyOxVNkoKlThGO22Tuj3lph7Tbdm8T8HwL7aySkJB/mL1a
         NCazhbizFG9M/EaD0bSwwQM7hxlks5HfEHrhQg2Q2WdQUIu6dK/1GSPlTBwdfijoHVzA
         W5cG9tzZPXViAJDf2NpvhTfCMFGs0MyrWdZlM2Am4WXz7EJSIOeyBWMpyiqlgWZfhZXC
         D44CDgXCW0HxpferPMXi37MeD7VLh2TeDG2QFfd4XusI01T6KYXABPaFSgxoyapyLPt9
         wl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769612369; x=1770217169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aXyZBm2HT5a2syRm7I8O8JEOj9+5Hm8S0vVHV9UIr+Q=;
        b=c2JZrPSygrFHDpyXk7gE5acy+LPMt3Vz71b4zgSjuZ2GEIrjKU42ysiQFHWQf68Pjx
         NjukkbEuQXF0rwCaTGLaQ7n4ExpSpKnaFrXFppaJUtDKvL/a1sAQ/TuxZNqWOvl3pp1q
         d5zIM58z49a1VZuTdYFkoPpJsfPXRU9ChE17cHhjaqH1SoPyF54yjapRkxa39SyByTt5
         WO9GocjcXPyqXPjzEn+mlRjgD0ysisKy2/XSuNBaL1HTxK2cuqe6Bknr6ooQr6GBrzwe
         c+mbKZi8BMDA+6MP/HVT+HOo7u1vzwC7Fry7s2wdVp7CePLZF3bvh6VRhlezAYk8dbd5
         QdZw==
X-Forwarded-Encrypted: i=1; AJvYcCVfLWMkwkXemE6McMWJVU0KUyiZR/N5cHbDW9ToIN7ByVugmpTWcF+LwXFi2/Teg0QfDaPbmhHvipE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdK2QmUJC9tWXnrGQTX398UQOpdz+sOzp8hYuCh6xZh5QWn6t+
	fbl1FDxs5OVEoMvyA0Wtpd79/mj3NeqJsUOm3XEFl1o34oSeD6xCexQ=
X-Gm-Gg: AZuq6aL9eU7hMVcF7mpTdGjdrDE94dk2gl7xWVlZsEBq3tzl9bpss78j6m5bb+CnICP
	Ak8bWZ3q0iqxxaSPQM/uevkKDzjI+Mael4XUpsX4Gp5sqvP35mjKoHS+HWK8yWAhMMrzZNu/7qQ
	0SiAa17/RZzK7Wur9R+lL49oQWUGbIedovs+LfMl+HzX7TyBuLUs1RCV3MO7hKJ3vdUG2y0zufo
	85BT49ZQeydDCs+md1S5eKZDsrEWjJJL6ENPobdpDUJbAHHSRzuUwHzLN72AZu//Sw10H8+RL7o
	IAJ9ykb5VXsUuYMzlRiIJG7uXIAMXxRUtW+nRtsrOu0xbiGNhfcl9G60JKt9JuEtzJiUC4jT0GN
	9bDDR79nw82+RYUk52DVspjSD0qqUP3EQap/PM2pL6KSb/hf3xYLgjdO+CGclX+9cO0DIDDWY+Q
	4UGprLpCQcPX0q
X-Received: by 2002:a17:902:ce0d:b0:2a7:d7b8:7661 with SMTP id d9443c01a7336-2a870d536c7mr48989305ad.4.1769612368925;
        Wed, 28 Jan 2026 06:59:28 -0800 (PST)
Received: from at.. ([171.61.161.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm25820235ad.79.2026.01.28.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:59:28 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	Francesco Pompo <francescopompo2@gmail.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/i915/display: Disable display for iMac's
Date: Wed, 28 Jan 2026 14:58:38 +0000
Message-ID: <20260128145855.1071-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6043-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,intel.com,ursulin.net,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54471A3815
X-Rspamd-Action: no action

Disable display on iMacs, as they can't do link training
on the internal display.

(tested on iMac20,1)

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 .../gpu/drm/i915/display/intel_display_device.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 1170afaa8680..b1fec1018d7e 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -3,6 +3,7 @@
  * Copyright © 2023 Intel Corporation
  */
 
+#include <linux/dmi.h>
 #include <linux/pci.h>
 
 #include <drm/drm_color_mgmt.h>
@@ -1435,7 +1436,18 @@ static bool has_no_display(struct pci_dev *pdev)
 		{}
 	};
 
-	return pci_match_id(ids, pdev);
+	static const struct dmi_system_id dmi_ids[] = {
+		{
+			.ident = "Apple Inc. iMac",
+			.matches = {
+				DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "iMac"),
+			}
+		},
+		{}
+	};
+
+	return pci_match_id(ids, pdev) || dmi_check_system(dmi_ids);
 }
 
 #define INTEL_DISPLAY_DEVICE(_id, _desc) { .devid = (_id), .desc = (_desc) }
-- 
2.43.0


