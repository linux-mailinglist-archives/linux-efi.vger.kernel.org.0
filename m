Return-Path: <linux-efi+bounces-5845-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B70BCCBEA75
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 16:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CCD30FFE40
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DFC33E377;
	Mon, 15 Dec 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oJn9TuUY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070933DEF5
	for <linux-efi@vger.kernel.org>; Mon, 15 Dec 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808274; cv=none; b=MXA1raEBeeLbLyKwu9sWLdoBWcj6D+mBJcdGhLL5h8pxCjMFbnVsd/VAK8XK7KHQsg14bVwI4JKeA9to6BkIL8D2dHiHQK6zjOjubARriSjqUM5s0HQm5MdJuKG+3ZmTTsS8tYraHW3UdqV8fLsv7th9EP+BojuKmSpXVcrzJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808274; c=relaxed/simple;
	bh=yB7VDr3EZSkvb6JHyGDNmAwFJZy2w/A1L0P7+9qGdqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP2EPorTAuY8f1YobzgmJyXTFKKtYSH2PPymvwuwH/W2WKn7PiiZaRt8yAyyD026RDkBTyxRmpvCLkGeqrGJNyi3OEudwSn0Ppu8GquWE8RT2LUH2cEvppRW0xElLjBaargWcDj/2c5N9pjqgrlttu/z5Z5BKb3bfqFJ6ZWKy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oJn9TuUY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b735b7326e5so544518666b.0
        for <linux-efi@vger.kernel.org>; Mon, 15 Dec 2025 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808267; x=1766413067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lBoMkq+p5dQ2OsBBFnXVtnCRh4ggCKmjrfxDYkmgHo=;
        b=oJn9TuUYHuV/h15zxGm9nrzTyVYAzpC6DVX/zZz2DvFGXlted0QQPdoYVVsn8gsNP1
         aueIOLnTlxBfW8RjLbJkA7NKEvZtbAn3fgLQQiP/zo+0gGPhNmo9nkR0heQEB0VMtx7K
         RhqcJBicT3Sx0AQNuXgRn9pwZgjFHOuvI0zkHxmMw/bhe3/5EWRZxS1wiHMDRXPlQ1ca
         dQERPuPA6k5Hq90URDuP6Cj5ytnvqrEUiIKn2pubi3ShmBA3w5t8BxhlsLzv8XpzErW/
         N/CCLOycAu9e08Tqu3zzuB3Rcz5rm5/HP55295CLxUw5fyrH0t5KxbZ1pw7L0B8aLXBW
         Lzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808267; x=1766413067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lBoMkq+p5dQ2OsBBFnXVtnCRh4ggCKmjrfxDYkmgHo=;
        b=Rc2U9+/DBXPE7gXDAmeaH6yX48zaj8Q5zyYITF52QsUZo7R9CC5a0JTLNfAFTqoqg5
         1wth5ibRIwivX6y2+lSOlbcHI9wsCHroafo+ymd3yKTDLQ77WcYi7xwATP7kVINV7kIx
         GopymIqQuZ3JuosreEFB49Pm6p36H0RpPppYW5ijWgYjHOH2Tt7kIOZM1cUWZzT60+bp
         ue0LADSPpXH8yGAyLUtfGOABi+X1zbvXR2o3QGgqNrQ2nTm12KJEb8319e2gwlqm0IND
         YE4rS9j9mLamnKpjmxfJJ9oQW9lixF8w9dVcTtFieBZPQOhDUavELRtenrFlGxF7DsO1
         N84Q==
X-Gm-Message-State: AOJu0Yw0nV7FfamPzoQbue1QQBqWrUsQeqVQAVC3H89+BP59a1aoErE4
	e5RNHs+WrRtU2HmAWMjaRoctoFHacYkpEw7W6JbJ4XvxzWWsVP4l4UcXbSDVXxmBgA0=
X-Gm-Gg: AY/fxX6bwoOw6ynI7Bh7+AQ/9J3iFcwhT+7uXq56Z8SLB2rLuwayEZRPDErvbqioLUa
	rCx8gjO5tCnl7j7ATgx7e3542Di+JCEjo7cjrJSUFBXZJblm8ny9wNmrcc3DMLXw5Gwv7GwS52J
	wWNF633M1LlwUw+LNUO/RcdGIPTI591+czoYic5Uf0rhUGu1JoBTkrfYKmtPmD3YEQ936pcauzv
	IOuYMljohfKfBy4t5Tr+SzhvCPEVt7KddLAHhl7VKCYTJ55fyZvq39vUYNVEKiTEbeX3nA2qoE1
	5cqifvpDXBMCTpfGO66ThSx39O2SBm+XpRHXaRVjozABbSRUs6OBaG7iz1CIjXN1JHACTUv1eqL
	+PYTnlfai7aU5bDe1L3KW7MajuJ5Pj5bNhoaMsPSpbrfU0KAIkaIor+ye3EcMcyHXg+e0uC1UIn
	ADJeY2BfLeJALb6R1bz7de7EG6dop8GO38y6381BwB6l/gR3cZZE5lEoVv3rETlCQHfDtK
X-Google-Smtp-Source: AGHT+IEwhpzpbutxcSFXZMLWPGgvdTBRCn78tGwOj7IZhNrS+hZ8IxpcNZHWAUSqv1MI4HUnh3hlrQ==
X-Received: by 2002:a17:907:dab:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b7d217ed7d2mr1308406266b.16.1765808266933;
        Mon, 15 Dec 2025 06:17:46 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7fbd7a55dfsm554177066b.25.2025.12.15.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:46 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] efi: stmm: Make use of module_tee_client_driver()
Date: Mon, 15 Dec 2025 15:16:38 +0100
Message-ID:  <6a56ee61e485703d548e9e44d53b2920b4e43ca6.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=yB7VDr3EZSkvb6JHyGDNmAwFJZy2w/A1L0P7+9qGdqk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhgZ97MgwPHXb+Xx9vet2pJx/fRw7XXThLnp 2crAvT8GvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYYAAKCRCPgPtYfRL+ ToTlCACS5iflL8JzBfIHFC4dd9QU1VLCJ23/o3MwueoTbG3c0T+3+Ab5eAFzodoVurAYliob5pu dCvIygjW7D5m9ySrn4/XgKkHiY54AGvSbmsSNrVesGd4oFJGf3Nbo3TsaUZZWYnmY0+ypytx3sC jYoNu+MOi8Cr8BnQTHvWqdqh3lzQzJ8TOJIedFd0Wdh/LeHfoC6mf8mhe6wrufJ5R6QAS3sVl5y 1KnEG5sqI8XvYvgx261qZIjrxPtBeaWahLjOKNLFkGpC7HWMfBbAVP8nVWNbNXWRUZ3IVjMiJlW 5seuM+gr+TKUjwts24xtV5LeZbaCTzjo6uZIsnOl+ujpHHdr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Reduce boilerplate by using the newly introduced module_tee_client_driver().
That takes care of assigning the driver's bus, so the explicit assigning
in this driver can be dropped.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index 65c0fe1ba275..5903811858b6 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -584,24 +584,12 @@ static struct tee_client_driver tee_stmm_efi_driver = {
 	.id_table	= tee_stmm_efi_id_table,
 	.driver		= {
 		.name		= "tee-stmm-efi",
-		.bus		= &tee_bus_type,
 		.probe		= tee_stmm_efi_probe,
 		.remove		= tee_stmm_efi_remove,
 	},
 };
 
-static int __init tee_stmm_efi_mod_init(void)
-{
-	return driver_register(&tee_stmm_efi_driver.driver);
-}
-
-static void __exit tee_stmm_efi_mod_exit(void)
-{
-	driver_unregister(&tee_stmm_efi_driver.driver);
-}
-
-module_init(tee_stmm_efi_mod_init);
-module_exit(tee_stmm_efi_mod_exit);
+module_tee_client_driver(tee_stmm_efi_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
-- 
2.47.3


