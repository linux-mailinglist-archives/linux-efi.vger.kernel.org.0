Return-Path: <linux-efi+bounces-5835-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C05CB6A54
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7640D302C8EC
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6212F3161AB;
	Thu, 11 Dec 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y/pO/xiI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D53316197
	for <linux-efi@vger.kernel.org>; Thu, 11 Dec 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473366; cv=none; b=p3TEXrkciURtD7C2uMCcfvEtr76kSsXRv3AZ03OVKjG+utG51OHg/AdOS6GdwoWK+CeGSFnovNN4B80FOrikbI2X1tTOn3QyihRnQTlMvpcthc3+3ZBotypEugmcFj/7JqwIhSuji5QLHk/r4gFSKB4U/OW2GSvSXt7Hh8BBx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473366; c=relaxed/simple;
	bh=kVl/h/+w7Wr0R904x5vNxSBa3qE7VLiGeImjLkLbd5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNfRg1swIE3o5iCRk9FVMJ13dn5v2dJBuhtokYNoHROW6gkcHiJ3OJSIvg11bhC+BlM+eMH5D6gLrmBlJ769UmcooS3CYrFLiVa+Iz4IG92zc8219vLRq4Z5Cd8dq6qEt0iikGlGGl3UjQQx00LWhRXuDmbylFHMicm5RXf/aoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y/pO/xiI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47118259fd8so4286405e9.3
        for <linux-efi@vger.kernel.org>; Thu, 11 Dec 2025 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473362; x=1766078162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a4wMDZK2ViUHeY8ITMBosr5lNb7hmzarN7W0g0+DF8=;
        b=y/pO/xiIbUTK3/+Pu9NPKYogkm+aMNqXlfdtz+V2TgwAg+X6Ygr0UZ1aC/4U/EPz6H
         aKBxu8g5bJ9E3u9uR/bXsgZn1LKIyOrtyZjgOIl7Aectczbo1CZ1hHK+jdBfTEQxp0l2
         AIcKE2sPXiZSwD0RnC0aYBez8xEpw41l5mpbItONSMi3lHqMPeHfmXEf+PZfVv3CLm3w
         P5fFFQPySgJScg5a+4n9pKx6fVckaciHbcWyD+ZHc8VTYcks23PJ+q1hXJFgfObaoF6L
         fTA2yJ9lfyiphuu3Vjgmn/rPElA8dllIOODAVsuIAK+5poObyYQXT1sNsIYgnDmV74ze
         Sd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473362; x=1766078162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5a4wMDZK2ViUHeY8ITMBosr5lNb7hmzarN7W0g0+DF8=;
        b=Tm2wf+Lzlo2r3ncxXXwFauiTS7xcYu+vI9mF1IfChGFZ+jRx4jJGE21RHfGRikUVGU
         2j4q1CguPvbFqJ3OSzoOizgukgTKXRbsAQdMTAO+a5o3GsQneBbe5H2mjfgYFizWVyxT
         TGDsoWOwaXcRl+C+tA2bgf3moj1Wp9kd6//FgjQPLFYMK/gEweRzznvvevByms+kqc1q
         lpjecowhZVytvehvUNUhuzV5yppjvJujgsU9h0PnKyTIOdp8YrelS2OKClLGJUeuZZkU
         GKhNYMHAzufVlmEkra50wp3PuJeBvzAjHHnq+9HxXYrubEI5Y3AjDYY7odCD1RddU/SS
         oplg==
X-Forwarded-Encrypted: i=1; AJvYcCVcLZKuHrmdTpJ0YEe2ZtcXgdi9Cisehvc5Tper1Mngs6hJv0AIjHU9+ZQqIg0qfZaLVmI0hOKNIU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DxkEFumx1LGq9YOUMddB2cnBschj5yklrhN0+5TZsO8jMgbC
	9PxDNdHm9IEjX2bXHNK12M9O+ek1GWJ8SDKx7hhGyauP8YUTGuZXoopKN88TdlF/1/U=
X-Gm-Gg: AY/fxX5FiNNechzAlVfkPpah5AygQHzUP2sOhb/TosZ6rT4UdtMY7Ha0SowBhfw/9Yj
	JnERleATatmWeRqJIdpwG8KCezqNlrqQC9+lrOSWv4ynXWhRDdXhhNtCF+s8Sd1vcm7KE4XTLES
	/zKspzAJsTb8hx2310KIngwZkMuxzqtw64GgR323XmK3Yba58xobYUVoo6WLb9c5sZ0JssnezMH
	1pBnPcVyh4xQJkKS0Xr7oS67cI0WYWMUE1JR6VbTpmFtSKdGvxJ5uISOgI/w6b+UW5ma34awOej
	LFA2AB4ry9P5/VPZIKAid+PwvpTLWt7mI3ZfDb/Dk7ZfIBuYiMjwEyFRdbqW2a+xJNy5DDVRYk6
	o7IHkq832wxPS1ZKeVjrXW91Cy6S45/N/dMNteBotulzIV70NDpCl+grlyx7jcSAh+ofnfXj0YB
	xo2KN0jy1PFQY9umVzim8TVET7DDsU/LMUBjT1Wj2X+PbRsCXXmXL90ttIHTv1hUawkwUl+bSOz
	I4=
X-Google-Smtp-Source: AGHT+IE+X9wMDaoG4Q+goEXvBdmDRMpx3iuUbrVTqUSpfRdjag7tAC9TsJa1xQ5gBIFCyk9gG0Z+Bw==
X-Received: by 2002:a05:600c:4705:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47a8377b8bemr79943275e9.10.1765473362428;
        Thu, 11 Dec 2025 09:16:02 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a8be549d0sm37688665e9.1.2025.12.11.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:02 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Cc: op-tee@lists.trustedfirmware.org,
	linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/17] efi: stmm: Make use of module_tee_client_driver()
Date: Thu, 11 Dec 2025 18:15:02 +0100
Message-ID:  <0896270bc530d1e3b7fbcf5f7e168172dcc05d1e.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=kVl/h/+w7Wr0R904x5vNxSBa3qE7VLiGeImjLkLbd5E=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkyrPxrp7FaL9OXe8ilvWtXDYnnXyuCubaF9/dc/qQ+s2 AX+fO/tZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiS5TY/+dkhfWruk/vtTP0 cL2huff2Oa1DFz4+fvn+Z02QTsTZFcapRusUt3/LZol+FL1N4tx5WUnjj0vO9YtIlius3v/mkau lmEV/hrqgQ5Bo9+Z7c/u0D25JeHz1OU9of+bCC5nxDBrThLKXqna/lbZUSpX+yui1/4fwgVXZpg Vy73eFanE1iS53SWH2/Xa2N0e57UTUw1naEuIVizpdPt++cObS6W8dZyOy/66SXC7sfGmugYKp0 zdbqaeB3W3zTn2K/Z5UGl1h4r6npf6chcnpkA1NKuf+rPvXYhTp+7Q5N+XH7YzNOYd8rGv0i3Pz Fj5qvefCb/9NnHHpBEeFpB98fzf/7Jqp5mXXdlSnzIgPAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Reduce boilerplate by using the newly introduced module_tee_client_driver().
That takes care of assigning the driver's bus, so the explicit assigning
in this driver can be dropped.

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


