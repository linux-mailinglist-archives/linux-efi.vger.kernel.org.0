Return-Path: <linux-efi+bounces-6042-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB61Idglemlk3QEAu9opvQ
	(envelope-from <linux-efi+bounces-6042-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:06:00 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 310EDA3807
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 442573077510
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B8350A0A;
	Wed, 28 Jan 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOkLgXRr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4358364E9D
	for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612363; cv=none; b=GI+lYs0WymDKZT2tCGrLikuHZ2kBM8p8XMq9zdyJ0yYveJfPPRTf7VowkQA8erDA5woO5WEJjTrKgEiom4e+s3mnS0Z4FVb92EeSQf+lGpAZ0ntgP3wta8jkRc/g2+O51lEcYNf/1OdZZcZgHtnucgiNbMqWT1P3BH06SsYYtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612363; c=relaxed/simple;
	bh=shI3m5HW3zUOkgaJnc9JS64xYY2D3nRhnNuumTaEZy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnrb3oxwAYvoWuIOZLugWfJGngS9YxErPRthPUpFWZyiVNqs+9WRexcH4QBG+UPuIhmB3RKj2zEzGrTjPOW52xQdWYMy+P5hqvDYouONKCcz4n9jAvn8PDp/Sb22QDVG0cw4ZQAIhhcHUlJGPNmqx3K0vttuF2rjpFM5x4YPAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOkLgXRr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso50605765ad.1
        for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769612361; x=1770217161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGJMSx3RqPnXMSF3iMxugpnUOfI/BDwqereywSHSzkk=;
        b=nOkLgXRrNdKUYduO4d8YqBkojOq5MrukBoxGZGSn7whCvi8JFdp+lDdhbEigAlYcqF
         QBCGufuoMHXtalEY342S3Be4BpCk8NnVuTmoj7LsLi6uZB3SN69pkqFcL1g0ZY9NbDaV
         hjwN1f2QylCV1wVH4ENXTEly1yAWzT4ViugQR5RNUjLWPx0sbYOuPPkh/erywgwbkZsr
         RIENiKN4BRNNUXvb4ODRK8Y2qlJAFeCdcEpmoOAUxJsknl82Y/sqjm1d3TtX+yUPI8bN
         f85Skk6ETZZyHPqit5p4pKS3nsdZ40ioCNs6ZRxHOpH2oZGu3njKbw4wdvmLHSIDyJba
         +Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769612361; x=1770217161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGJMSx3RqPnXMSF3iMxugpnUOfI/BDwqereywSHSzkk=;
        b=VwktDDUPsTtN8ixutP9g6sJuL2lsv0oK3rsqfLlskBLpDyqqjZNjlCUFxmOqqusdhq
         s+/xLDh/Tzz8e1ObQpQwweh5HkL4bA+xXK1rdsuV0FNHwNfylK/A79+I6o/eKN6Q9eQo
         6d1GGu2V+CXwh2okLYeYB6ydANkouSCQ9XscrdsTAslwWe84HZPKuoFRDXVOK+liMAet
         fcvmG9fgjnShInJda2uHklxN9JIGO1uX5hzbKoQ9t21C0lhqtxBHNYmYFhv3sYtcmXx6
         JjX/VyrO/M+iJ7yb0X/TBdzTS+QdmkHQHTDz++tUtqFeL8xS8t4B6ONCG2lZ55mYEYa9
         V7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXUXEhPzNEvKM0Ll8t3l4bk1bxdWiM7JSq/XT2MNtvwa9htgEddukolKcsJ/xlx78ioLIoPRhx8nrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGZNVfWRJXH+HBcHEV0WGUacgINuSCrQSYdnwz1vAyk3ZRBCz
	aZAu60HYQXiu/IVm7kPAVy0Gck19tcHqmEcFjibaiIv2LO1E+iDI3nE=
X-Gm-Gg: AZuq6aJM7OCdL5Isq9eZlALR/1AUSQ/nHOC3RUxSSpeWEccc1athYVp8V5dQgzX2dWU
	riFibbzhL41mLC+DXhg0ENq6XHaoY/+TdUpuymYZNnIERFiQ0c5SXHJ9i46IytmfgAdwYevzTMS
	ZXaWx2JnGKrE9jA/KnyWo7dc6jYmQR3g3hU3qzigEA+kvE02D3gjyQ4n6h6SxF2P3jgwiOopOCA
	oK2AK0ElDwDGqlo86W68Rxx5IBXXbPf4aMa78texgNC2F7exekEmFpMAB23XwVsiaFKiHUKYwRx
	g64iJxviQL0sjafOemdUO7vgZDvDVtL7CH9qbez3L7oPFj4Su/2esecjctMwVb01oVlP7q5Fut1
	bzS029dODGYZXpQrTfuxvJqtDlVO10agSvNt4KhONVgcfpyqY7gpGegAoaGe7+VaA7glFYWSV3Q
	IdLxtaLVZYQMyF7sBjZ37N0ZQ=
X-Received: by 2002:a17:903:4410:b0:296:2b7a:90cd with SMTP id d9443c01a7336-2a870db7c28mr53750585ad.32.1769612360659;
        Wed, 28 Jan 2026 06:59:20 -0800 (PST)
Received: from at.. ([171.61.161.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm25820235ad.79.2026.01.28.06.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:59:20 -0800 (PST)
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
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Francesco Pompo <francescopompo2@gmail.com>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] efi/libstub: enable apple-set-os for all apple devices
Date: Wed, 28 Jan 2026 14:58:37 +0000
Message-ID: <20260128145855.1071-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,intel.com,ursulin.net,ffwll.ch,redhat.com,suse.de,alien8.de,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-6042-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 310EDA3807
X-Rspamd-Action: no action

Make apple-set-os run on all macs, as
apple-set-os is needed to use eGPUs and iGPU.

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


