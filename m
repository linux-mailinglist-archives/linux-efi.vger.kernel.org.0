Return-Path: <linux-efi+bounces-6083-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGP6OiKlgWktIQMAu9opvQ
	(envelope-from <linux-efi+bounces-6083-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 08:34:58 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D524D5C44
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 08:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF1B3060BC0
	for <lists+linux-efi@lfdr.de>; Tue,  3 Feb 2026 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09390219E8;
	Tue,  3 Feb 2026 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq6A933Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11532F5308
	for <linux-efi@vger.kernel.org>; Tue,  3 Feb 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103927; cv=none; b=lxSiyhrTnEJ51d0m/HtzHQMdaXTa1sCpekVMxkpbuqmljMNKpe4KhuSLmo9cC9TDyWa9NB33GP4iYOiFXeF4MZy+jF3PF3/4hXm+/bdcHtRkuhF6lXCMduydAKV9FT95GqX/ZJ0KRXFsEhBOEDVqeKl7eL0LOjwsab/W9Vhfd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103927; c=relaxed/simple;
	bh=xXupZXAM6QZKJNhqNV6zl2uEPkwZY8nUmIDSy+c9mVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSEhgvZJE09wEIttu5JwotP0rZc4NP03jiqqYSCxqRRXG6W1TnBBYTfKx2OTHuhVWEit5O+7qna9n2DF/QgqGNHcJw0ovATgNL1u98GSqIIXA0CJdXZLL8dn94No2O1ezR8Nms5lPkP0+PlYKbKIhubC96KrqN4CxiT0qgu0Tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq6A933Q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7bced39cfso56144515ad.1
        for <linux-efi@vger.kernel.org>; Mon, 02 Feb 2026 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770103926; x=1770708726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVbsoeLJUH+6Qu+riey08jBhyxYlZrCyG0lFJ2fnhgw=;
        b=Mq6A933QWy9188NxzRoibEO7Ip+ChFvowfSLbQq0qC3vSA+NyjT5SUr7WJsStStdZV
         aIPz4e4ll4uzKBUpHQOWQRxXwvT4DMYg5Rx40E7e6yJd3a58j1wMoydpiNSNb47u9QGi
         9Yvbb/OvQPnw+6yUF1X3RNMDrdAfsbQrrj35BZKZKXWZ8nrlyiqgvzjeVYPs9pw32sjs
         8eaCjwj9KU2ggR7/l5maPH6noCmNuy/VOvHWCSxHAf7tEiFdyxrj6DKLPv/Z+8PMYTcG
         gH/63bn9cDs+isT+gIl4fqqpzH2qH095g6FdArNU/OTW7Pg9QCKoDPWaj797qSTafSoG
         3RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770103926; x=1770708726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVbsoeLJUH+6Qu+riey08jBhyxYlZrCyG0lFJ2fnhgw=;
        b=kse7u4ydwSUU56IYoNlnaWNshJKdrFGfeuL929m4mdxM76G0PAL8TfAeanqHdurDXu
         rkMC7usSovDa2Xi2eoaRWY7b0blWpgSMHTr7SM3/gOiPyj7i+kVbRpDcpJrwwituvEOj
         JFUrdEPqHyIZIqzH/0EABx1dkO0SYY2bOdoDj0okRTK1DiWfIA7gYFwSxLXFE6auyptR
         52aufcXE8dHbZkYoyN172yqKgPcSg/tcCGsJxXvIDzuCKd2Ji/DXVIzrKjmnkykYL2Dm
         bN9YZ2iu5pwUZFjfHNgIxAU11z2ds6I1otmEV3u9b+qbbUxRew9UQL5qvOdx7Vek67Nr
         0Gjw==
X-Forwarded-Encrypted: i=1; AJvYcCWvKrNQRV1uVMb+90NRkDT69ZHRFpUg0JQbQIjiFEtoRm+ziVhgDGEWT25Eu3XfBfqlWuyMwRCOGg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycG7+JPull5lrWeWONEunAm37sE+6l6FUYyx6U4EvOZTxg/myI
	urwbIfW0AE0GiNMDd2sXzYhmJr4t+bfjdElO1Xnj+hQw0akFfsUo5lQ=
X-Gm-Gg: AZuq6aKXjoqSqUr28oPtRTyIM1bPgMP2gLli+cejrtXOflurw7j5x0ZZQidyQvJIgdZ
	kgfkhPW4whr1erhOYrdlqbvHKDjk7i9lwA0jj8HY+c0uggxHqBVCqHZhPKjbTQZPksgKFKeD1N/
	W2OJhvis4PM2dM+rR781mYNka1Mmaa56jQ3rsDYQXKrZawXHWJ7uK9XJGcvPwmCgQ9YDPWjX5nA
	hVsu+PS7UPPtta8c7/IolWa+5ytRM0cyT6hgquR9jR2XFZU+rTiuKIFgxiENChbyYHLnoWrK4NG
	WP/e58bIdPpbTDoQ0fN0CiJPX/9E7dXN4D6pLTtclQEzK0Ba/OlqgZT+WFOx4Rh6aT6knz/jKZU
	zljnFGyZS//6EhoML4waquMFLpYjQP6NdtnMa60RDYIFyBOYg9Xaz/CgfDCXgdA2wVNCB5dnB6Y
	dbtApGW1P+KDQtFJ8=
X-Received: by 2002:a17:902:e996:b0:295:9b73:b15c with SMTP id d9443c01a7336-2a8d9a57c7emr96695715ad.42.1770103925941;
        Mon, 02 Feb 2026 23:32:05 -0800 (PST)
Received: from at.. ([171.61.163.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8dc225534sm108280865ad.68.2026.02.02.23.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 23:32:05 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
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
	Ingo Molnar <mingo@kernel.org>,
	Francesco Pompo <francescopompo2@gmail.com>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/2] drm/i915/display: Disable display for iMac's
Date: Tue,  3 Feb 2026 07:31:18 +0000
Message-ID: <20260203073130.1111-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203073130.1111-1-atharvatiwarilinuxdev@gmail.com>
References: <20260203073130.1111-1-atharvatiwarilinuxdev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-6083-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,linux.intel.com,ursulin.net,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 4D524D5C44
X-Rspamd-Action: no action

Disable display on iMacs, as they can't do link training
on the internal display.

(tested on iMac20,1)

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
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


