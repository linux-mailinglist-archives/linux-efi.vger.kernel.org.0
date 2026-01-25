Return-Path: <linux-efi+bounces-6033-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGetCPNfdWkAEwEAu9opvQ
	(envelope-from <linux-efi+bounces-6033-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 25 Jan 2026 01:12:35 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E47F526
	for <lists+linux-efi@lfdr.de>; Sun, 25 Jan 2026 01:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2CBD300AB0F
	for <lists+linux-efi@lfdr.de>; Sun, 25 Jan 2026 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E641397;
	Sun, 25 Jan 2026 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq3+0GR9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F93FCC
	for <linux-efi@vger.kernel.org>; Sun, 25 Jan 2026 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769299933; cv=none; b=Bkojnv3985N+U+ThefSLtj6pv4/352Qj3HJv/4oLScIgdmhco7yiYdze1e4Ks+jZ6pYf9E+DqT6doufDoFkQlc3aQGmTHE2E7Tf6rEGMq25igdZSF7NS8oF0o5gxwxF46Qjrt7fGWbLfsE1nSqi0g0Wu94AFb2hmTtPsMs1OpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769299933; c=relaxed/simple;
	bh=fCYm2mJdIDY27MruXBMpBpQ7iyQT6fjsIMPyFW+T4x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s75/TlHf6a/LcIeAoaPxZ54U5v41YVH9JM71N9DO5xY0keAm0K+qZTMNezBCrxlh4ZaqbG24HAsCVEggTU77fE9/uGNOiLUPodk1Agd1DxmOuUr5w087koVjv+fnmNPB5OFm8Iz0sRcQGTO8ExyLVQhnvlz6XY5OJQzdI5jmwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq3+0GR9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823210d1d8eso780351b3a.1
        for <linux-efi@vger.kernel.org>; Sat, 24 Jan 2026 16:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769299931; x=1769904731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al/HNzlL8sxMxMZcOP9VatI2C0Emnla0lc07B+7h3yk=;
        b=Jq3+0GR9NmAm9DX+7zBBVcYfDom6eMYpQRCY8gnTzKqhfYQTNdu/6BfWfZi4CPf7gm
         QbbbkGXgnFauqbUJJGM+9v5rb52UOuVBsesSzqESQU7ibv1KtZTkAEWvcPUnQbzWlrzo
         MfNsppEoSGzU2d8ywLvB5lRXUnz8Ok4eDgkQOFtIpLPmBjybm+b+kruM1HAU96b+TyzE
         MnlF5N9DEvFsrVdI9yOqN9sOp+zIdFRI9PHO61vWulgZ6mMLZNU6c9M0XoEW6C70dgKd
         ngHGR4DLU1meNIVJ+Uy5vA36+dpv5QiUXO7YP05iycnP06U6cXVEbmdRlxAEkR2365xK
         EiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769299931; x=1769904731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Al/HNzlL8sxMxMZcOP9VatI2C0Emnla0lc07B+7h3yk=;
        b=P1HugC6UIdE3JAEnGlSQLMd2LJro+FrcZPGt/oxBXju57Pen70GCOrTzPc6lw4yLzl
         lF8rCPYjV/fRWw2XSfbnFUkjMPcz+LbDipMduIhL48tmNtMUE9jxt7ZX04s+Lo1XqsVL
         JcV1v16As66DymML5dL+ntvkHf/sX8jOKdcjQPcFLAr329kwDSrnL0+7LDRUL6eDK+tV
         JHUPJlGtUs+x9zxtXfKSAol+Femai55WZwvKPkHmXYqphpApKFukbpXG4LmhPWDQIEEJ
         wuYnLJS8p2c4vh/ioJenOPXo6IPTxOHn1/TcfVOA83+Xt/4jocdkcQTTA0p31agDea5m
         5ZLA==
X-Forwarded-Encrypted: i=1; AJvYcCUuELVvZVQyHYgrniKqiuMiLDFm5xtXYgAAxDWM5W3aDLnjiwzIYnH5ybYfQIZ9kH8iRK+pbrex66o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoh58jrEedZKTSXBqaHXXuyZcggVH/qPziCkyGIoXcS3/nYwP2
	mwfvy065cAVpn3qrQXI6WuQy0s383xBp3+oMLrDZZID8/3QNbd5e1z4=
X-Gm-Gg: AZuq6aL6BnV3dovuO4lALKir/ZtunC8tJiujDl04CBG1jCuGGRQSFMubeZChkY2zxJV
	YPDaEo9pQOIVRkFHlD8ZU+Jxrnc22x/1MQRA9PkE0VkKpWP/IsoFsq1uc38Wu0PMFLMJQuhLNMg
	VvEdW4CdUE4ZlNQ2FbipYx13jHI0YM+ABonhCFlOHCCh9rLHtNQMMEUwyincll8sfeM1A3GBCWR
	4zMCSH5P0mCf5U2rlJrIAYJXXxWFOG/hi3RCqvqVJOSKm4cBoDoCt+nX8fm8rSqIHzGziYhS7Jj
	xO/qO3zOC8R3ufkFgni44vmN080W+nCfNSLde4Zriz7hlSG3D0Y9VLSWT4cPjlS/3sVvWibNjMp
	NT0pUHdEBpwqwkU59f3+TlCiVfYlP6VCqaoJvkmqqBlsG69bUAc0sjZ/PTJ5dzL/7rZx9EzWB53
	qhbZjlbs/ffMQQ3Gv+585pvid0Nw==
X-Received: by 2002:a05:6a00:418c:b0:81f:3d13:e070 with SMTP id d2e1a72fcca58-823411df004mr215116b3a.12.1769299931419;
        Sat, 24 Jan 2026 16:12:11 -0800 (PST)
Received: from at.. ([171.61.161.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876e5d0sm5608273b3a.61.2026.01.24.16.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 16:12:11 -0800 (PST)
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
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ingo Molnar <mingo@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Francesco Pompo <francescopompo2@gmail.com>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] efi/libstub: Enable apple-set-os for all Apple Devices
Date: Sun, 25 Jan 2026 00:11:00 +0000
Message-ID: <20260125001111.1269-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125001111.1269-1-atharvatiwarilinuxdev@gmail.com>
References: <20260125001111.1269-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,intel.com,ursulin.net,ffwll.ch,redhat.com,suse.de,alien8.de,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-6033-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B0E47F526
X-Rspamd-Action: no action

Enable apple-set-os on all macs, as
apple-set-os is needed to use eGPUs and the iGPU.

(tested on iMac20,1)

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cef32e2c82d8..60e1a41bfe5f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -303,32 +303,20 @@ static const struct efi_smbios_record *get_table_record(u8 type)
 
 static bool apple_match_product_name(void)
 {
-	static const char type1_product_matches[][15] = {
-		"MacBookPro11,3",
-		"MacBookPro11,5",
-		"MacBookPro13,3",
-		"MacBookPro14,3",
-		"MacBookPro15,1",
-		"MacBookPro15,3",
-		"MacBookPro16,1",
-		"MacBookPro16,4",
-	};
 	const struct efi_smbios_type1_record *record;
-	const u8 *product;
+	const u8 *vendor;
 
 	record = (struct efi_smbios_type1_record *)
 			(efi_get_smbios_record(1) ?: get_table_record(1));
 	if (!record)
 		return false;
 
-	product = efi_get_smbios_string(record, product_name);
-	if (!product)
+	vendor = efi_get_smbios_string(record, manufacturer);
+	if (!vendor)
 		return false;
 
-	for (int i = 0; i < ARRAY_SIZE(type1_product_matches); i++) {
-		if (!strcmp(product, type1_product_matches[i]))
-			return true;
-	}
+	if (!strcmp(vendor, "Apple Inc."))
+		return true;
 
 	return false;
 }
-- 
2.43.0


