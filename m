Return-Path: <linux-efi+bounces-4729-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E89B52C8C
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 11:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE8816495C
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6092E7BD2;
	Thu, 11 Sep 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="K5wbMNCS"
X-Original-To: linux-efi@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26342DF71E;
	Thu, 11 Sep 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581394; cv=none; b=S1beHMVbiEzfNq1H3VG5nQQU1aGBUdK+52g7oG1lSuYDQ90F/96K9HaWAjrY/6+pMxP84b4nmycekRqTjBkV4ySM0fTseNKCKmXcnHPGTA1anz+XMDGiwm2dcYFFYd+TUsaEf2bMvYnLPP2XfdqVNhBiioZwoYSPM97VTPuATh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581394; c=relaxed/simple;
	bh=honVF5w84sXw1+R3SRU2KmpnQUYYfchCxoFIz+cJ2e8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eS6JJrzkWM8dae7sf7GzB1yEhlsTfdAU4CgF7sM2jfFOmgKwzqE2whyMaRwhJuA7s008ZNhZuytBvG7Z3Y+ZLY34jT4gt/SSUoAGAQrNh2f+Sf7ydEq8l1jrMqPpH55oSynWMjcZ2H2LgXMq9anx53QWFBpP5cTB5sP3q79C9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=K5wbMNCS; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 3DDC5C0042;
	Thu, 11 Sep 2025 12:03:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 3DDC5C0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1757581381; bh=h+KJg+lwYvHMkq3CR418XShWacGciYLhVefqR7QfMks=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=K5wbMNCSIaKg/ToI8KnaIekd9qIr08+ImCK7GRRLxg0Od9jKRN3P9MWAle6zQxQXF
	 KJFNEMNZKSA+oRrybeZmd9CCgppE36rW5QxrqhkX3jN5Pz/CHbCsweYeSr1daWTZqA
	 /PCEySlf3ln90wLwrxOWmck356wfjquhruMDVvT9Grj49JychKKjF5irtryIZgCw8o
	 5xFeUOwbz7z4P7IXaXNi3910APUWC0rGGDU9Ij4qMzoDEyH2FJD9M6rHmXOUzshDqu
	 0RwmIEk7po+qR3DXVul5gLr1Qgm5NFfBF9PwR6QgEGaRabuQ3k7lv4INt5l4gkPVCG
	 N+eLv/J+rL5Rw==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 12:03:00 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Sep 2025 12:02:59 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Ingo Molnar
	<mingo@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 1/1] efi: capsule-loader: Use proper type when allocating cap_info->phys
Date: Thu, 11 Sep 2025 12:02:37 +0300
Message-ID: <20250911090241.357151-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 66 0.3.66 fc5dda3b6b70d34b3701db39319eece2aeb510fb, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196179 [Sep 11 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/11 07:23:00 #27808108
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

When allocating memory for cap_info->phys in __efi_capsule_setup_info(),
sizeof(phys_addr_t *) is used instead of sizeof(phys_addr_t), which may
differ in some cases.
It's a similar issue to CVE-2024-27413.

Thus, use the correct type.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f24c4d478013 ("efi/capsule-loader: Reinstate virtual capsule mapping")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 drivers/firmware/efi/capsule-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 0c17bdd388e1..bbddeb6a0955 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -67,7 +67,7 @@ int __efi_capsule_setup_info(struct capsule_info *cap_info)
 	cap_info->pages = temp_page;
 
 	temp_page = krealloc(cap_info->phys,
-			     pages_needed * sizeof(phys_addr_t *),
+			     pages_needed * sizeof(phys_addr_t),
 			     GFP_KERNEL | __GFP_ZERO);
 	if (!temp_page)
 		return -ENOMEM;
-- 
2.39.5


