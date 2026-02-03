Return-Path: <linux-efi+bounces-6082-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFzPFASlgWnuIAMAu9opvQ
	(envelope-from <linux-efi+bounces-6082-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 08:34:28 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C01D5C34
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 08:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4A0305DB2C
	for <lists+linux-efi@lfdr.de>; Tue,  3 Feb 2026 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BBA2DF144;
	Tue,  3 Feb 2026 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTZl3tR6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF52EFDA2
	for <linux-efi@vger.kernel.org>; Tue,  3 Feb 2026 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103919; cv=none; b=WAGHvVNvRBrc6yzDKwtVvySwf1UhjTaUXPOX7ACO86pJ2T/nhLJcGbwxTI/t6s4ziSRJN8SUKHeSlKMu5+VXfSjRqnyS0Jt8eUnc0ealWbpw6dNz0qfM4X6iW0HStSyM/gi4ztDq57AH3yB7IykmldeVlc3Ey0/s+dDxGmicPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103919; c=relaxed/simple;
	bh=JPmSucsEIJvnITlI+6E+ViaITfqKP7DT7Hn0utPJy/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDTf6G4UM7Wh64eM6ivECsouD1kaBehAGU07Y1YE/IbqQbjc23DPMJDDie+UtDNnZkuqTQPO1zGr+XUE829k1N7AIhV11JYjjPeaq9yJdYEjnGxT02krZIUxdm6f4HW63WnFZMsEFQYa2ZQ2oCAx6Oqbw/FvCNRAx5kcZS8Fshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTZl3tR6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a871c8b171so31416395ad.3
        for <linux-efi@vger.kernel.org>; Mon, 02 Feb 2026 23:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770103917; x=1770708717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuaUAhd1+lDG6wBrbXZqMO2C5ILHdpZJbCQrItpX1Ck=;
        b=BTZl3tR6H/BiWoJ8JsiGKxwAoyyqN3TMtSGC83glNLtXrtkP1/kGDmkW0Qa0Fi4GAN
         qhhVHwepC2bwuWOCjOKJthOe7cSTx40h7lLQ06t3alDjRgWiEfZXjewnzXvmGlszYabP
         CLKB7s246tKz/hh9UA9Fmiwhm2ifVYcuKEoo9N34/gtbnG1FS3o6n0EGrbXqekzX1s4r
         1GwfZUsvPdwgfBYZ+v/XnyHNx6QbZPsYP8kWxCRcBLm9NLIKLx4OakuZlXmksgSwP+7v
         XSSAFJhXz3EFYSuX5PTx7BQPTVYP/94bjbixWRlDor38qWgfJO3lXfSFhTjR7BlK5l7W
         0UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770103917; x=1770708717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JuaUAhd1+lDG6wBrbXZqMO2C5ILHdpZJbCQrItpX1Ck=;
        b=KjPD9J+64slDYlWcFB0Ky6BxnoYuDSfNvsWzydAx9KQgQhR37b1fa2iRANRW4J/kZV
         KIIVyINl6F8KYKWvDdalNx1SlY4Ya6DqUfoS1j5P0P0ogJTYCcuNAQXw3C3xwpeIhFoq
         ZE9Z5XHTUbhdcypGz2ORD7Pfd+mGJltcz0rPsPWoj0iIa4gY+YB0fbO15MRXNRiYaknJ
         OOZ/Qyap5HJzIC0XVzv0Fce17DaQd01m1MaIFc7U0Nsed5pM3SY5ic0IWQBQByYjfAHB
         kQzwi9lb758bYH6iTvQcTBbEoMp74JK+rxU/sJAk3HoigEYWPQLpYt8lMG3Toojkmc6V
         3YhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmmLA1eg9oA0EOl3RkFrHna4V6TCaal71t2/MtKZNdam4HFvq1eJGjGYVFukb9jtu4PBf3VbjFblI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6VTCdhuOG+hVxwHLNMGV0ONKXMOetzSXZzSjCrAkUHxxNBbL
	xz79WV0RpPaMTMwY+jel08KulmQ63HxZSMeXUPMazVhikqcUau9DgDA=
X-Gm-Gg: AZuq6aLsYANPHfeCaSn75HTzFyFlb97wFmDRhcOKOHnMaCM7oDzZp9RfOTNlDXnC3xi
	2aKomj+vy3+FXP3sEVfj/43qnQB2Uua98kVvAVUe6Jfo+XQcPL8DabpjOVrWxL4kiy4xYC09+ZD
	1zHsQwVpnEShgu9WFgaLT8mrMS7c7bidwsnWWg9LATJGtT/7O+s645vDQBGwsOvz/rT8HV9X1bl
	LhlQFiVFhtUGywmil96WNOOVrnjeCv7dRxIZB/DAJGSMImBeN58u7Ff2RQ+GqTk8qfbonRWhfTy
	yz0IB4deAdU9xOPMdNQk4e5HGr+6Dr7PM8SfJvEKYzrGfdXnh1JfmFyTfHQF9727GPY0Zo2EW4G
	5thSiXt787Y55T2+VoHwDpEaHP1v/gr+ro2J8vZxTPebI8BsGVq6rUT1oXbf6f4b+XL16ybHPDs
	xZ0GNNMHdBAJVM4ECHW+sCl8+9Zw==
X-Received: by 2002:a17:903:1ac8:b0:2a0:d728:2e79 with SMTP id d9443c01a7336-2a8d7ed9bcbmr138418055ad.16.1770103917493;
        Mon, 02 Feb 2026 23:31:57 -0800 (PST)
Received: from at.. ([171.61.163.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8dc225534sm108280865ad.68.2026.02.02.23.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 23:31:57 -0800 (PST)
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
	Lenny Szubowicz <lszubowi@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Francesco Pompo <francescopompo2@gmail.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/2] efi/libstub: Enable apple-set-os for most apple devices
Date: Tue,  3 Feb 2026 07:31:17 +0000
Message-ID: <20260203073130.1111-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203073130.1111-1-atharvatiwarilinuxdev@gmail.com>
References: <20260203073130.1111-1-atharvatiwarilinuxdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,intel.com,ursulin.net,ffwll.ch,redhat.com,suse.de,alien8.de,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-6082-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: E4C01D5C34
X-Rspamd-Action: no action

Enable apple-set-os on Apple Mac systems by default.

Exclude MacBook6,2 and MacBookAir7,2, as enabling apple-set-os on
these models causes regressions.

(tested on iMac20,1)

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cef32e2c82d8..532a713adef5 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -303,15 +303,9 @@ static const struct efi_smbios_record *get_table_record(u8 type)
 
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
+	static const char disabled_product_matches[][14] = {
+		"MacBookPro6,2",
+		"MacBookPro7,2",
 	};
 	const struct efi_smbios_type1_record *record;
 	const u8 *product;
@@ -325,12 +319,12 @@ static bool apple_match_product_name(void)
 	if (!product)
 		return false;
 
-	for (int i = 0; i < ARRAY_SIZE(type1_product_matches); i++) {
-		if (!strcmp(product, type1_product_matches[i]))
-			return true;
+	for (int i = 0; i < ARRAY_SIZE(disabled_product_matches); i++) {
+		if (!strcmp(product, disabled_product_matches[i]))
+			return false;
 	}
 
-	return false;
+	return true;
 }
 
 static void apple_set_os(void)
-- 
2.43.0


