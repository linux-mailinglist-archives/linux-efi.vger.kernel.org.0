Return-Path: <linux-efi+bounces-5836-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B1CB6A75
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 18:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D6830690C0
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39F318132;
	Thu, 11 Dec 2025 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gx0uqkRT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8431197E
	for <linux-efi@vger.kernel.org>; Thu, 11 Dec 2025 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473367; cv=none; b=r+lU7rDkhYD34fRTTeATUsPsmsfpxeMXoRvMjVPmbO3zW6I1WWYBtGbDs202jO/89Tz8bwJ0uMw3NkRfTQGfUovt5djTDjwOfpF2HXJxH9TSCF/mgcy6TYaU4+Zc1wpiKMjoVyySMjsWHBvKorjgx09j+2OmsrehqIMIQCdE+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473367; c=relaxed/simple;
	bh=qEDk8mMFP/XEe464QAjK/gPzKwVOi+IAVX6mgf9QBHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJqvy2kkDLvKZ38VpliAMwUIZIKQcwmAxalt0kgF9ORcBtiHIiKWatKK0fHqKPD8yWCA4V+bNIKSWK8ko76pbtYL1uExjLg7RV/9JlBi16p/EkcT2uttYG4YH8kerLouBaBc+yo3jcEd4Ecef8UP+l0hZixM2ZidFgI1w4X/QEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gx0uqkRT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso1788015e9.0
        for <linux-efi@vger.kernel.org>; Thu, 11 Dec 2025 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473363; x=1766078163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMKKApEFn5c8w14X+9lJPDLyCyjEvXThCatdwXgudow=;
        b=gx0uqkRT5M5tZE5eYvMmf/5CIsqzyGyhy4BW1kGKwvqcNfTAfU5LZDXkqdm98eHXBk
         BED55SWJ/BLUjJ0Lkzsm1wMyTDi0RUtzinbelnp++NZg4yCQ6jdMtP1Jls4Vcuq283lF
         4g0yNWF1kxRTq20+HyhPSPP1cccKMFUUMJuYJuPsZzY2XI1gOJizO6urqo8+Wq5ks3fp
         QA7KIrj11WCLw7uPSNeMkOQsNIVz0MsxMpUu5NhIepOU1E1FJ98MVc0ztKz7EoJE9A6G
         qCzQ7LAG32K70INfPGClUF/nog5Bkp6oLyySwrgtuN2DCGwBH6qhO70gYghug8kDPXzg
         vd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473363; x=1766078163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMKKApEFn5c8w14X+9lJPDLyCyjEvXThCatdwXgudow=;
        b=kOftolei+h/uQfH5k9LnJL6XeI9f+WFZGWJ2nP7fmI08qAX7S59KDtzqePb3J9ghBA
         GWlB4oO8zpROSUHu9+ZXOmiIkPbB0koqIJUSsGgDV2e8E5S/MEz57ilYSiPy/YBvwoMx
         mkTlgfZJgK8+ih2SFKbEzCEVGNgNWE/yh+UmxJQ9QTTzSvO3cf6zZ8MS++cqja0Q0xG4
         IZI0ylRUNSqWH+5GiLtryxPSIuYXc0fpLVaGn2oRSnDuALrg4VmmgEoacoWYm1yfc96T
         i61mjrPqJ71zIkc7g0kkWnXQDUUyB4iE+SXCK7KdIiqpLSP/GcSiFLDmDErp7TwujGKo
         brQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhKIchiqARhRMBqIm9/iNsAdysAlkSHsPgXexEXnF0ZAmNFv9G4Y9LQg6NAx7dF2LrGvwFmaU3k1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKbKlJQlxoQhKTZVQf5e/JAUhxlgtuNYxV4+NTDbVfVXdC+kH
	ExZxR8kva1LMlADrJvst8tOXzIoc3itZLNlr2Hwotl2/DdIoIAKPbFgTVYK24IKhbHA=
X-Gm-Gg: AY/fxX7W+91+EG3HbOKQ4tqAbyhyeuxzd6cK4RW5wCk+9dZT3YmNp8MUsJmHfi1QDL4
	/5e6PF4x4qZYamF5fdVzjhhhLIJfzkB2XpUVcVnEsET0aVvmtl6RQSj1RpQpc8zHUQOu8KXBEez
	RnuFCurkCodukNx1HfElAoAdgSO8zEZYevT2IcBI1W0wqbQ0iv2ag7GFXHsxscAC9QNQ490gEOW
	nTJzZwp6uu5k5ko1/fFuKK61svmfjrmlpZ/Gte1DJLw6XEPANU8PWUFja2OWxFbnVI4J1geFqfY
	wqZQv1uRfnuOahN2K9ALqsoGRckzOhthDt2SivWzc9qONgpOKtQdyBxnwTJFZG+aB0F01J1VlFE
	YciuoMA25cMz7G/RJZ74k6gKSB8cRFctZl6WhRu3vUxZkKoSChfYMf52wyNVyBLCtN7+CKCkTvt
	h1W0589DQ0dhF/pXXebDM6ShDw/tLd0xRf+o5K/tkxEZbA1gjMKUxUGwwevBdK4MoOUBMgq3VKq
	/w=
X-Google-Smtp-Source: AGHT+IHR5wjI76zu9sSNjB/TR53h9qMqGGV22PiW6Sdd0Ha2DeU4S6wSatCpyfSEE7httE0vZDzqrQ==
X-Received: by 2002:a7b:c8c8:0:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-47a89ecc772mr21399785e9.11.1765473363525;
        Thu, 11 Dec 2025 09:16:03 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89da4756sm47522465e9.6.2025.12.11.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:03 -0800 (PST)
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
Subject: [PATCH v1 09/17] efi: stmm: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:03 +0100
Message-ID:  <9e3d9ab0f7987f313237b51911865f0cccae8eb5.1765472125.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qEDk8mMFP/XEe464QAjK/gPzKwVOi+IAVX6mgf9QBHw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwrs/+p/EDhPyVo0hsuMP6NMvstZvfqWF6GI tijtgKig1OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8KwAKCRCPgPtYfRL+ TsBoB/wNEFSwNDkrKKSZy5aBqOoPmgOHHGWeulZsknyP3eoMH8etCfP7O5OsQJHFzYBTbcaeW6u ullpwQB4VirhqNZF9P+gKDCKywT9I9jIWFaS7dkKKzEQ1YCt0H4nGxR094WM6gq4PAUWPdnjGzY LC1E95XggFZrSmDz+c4c61Ifzcg7EpDMDlkoaDDSz8D5QHMKZG/uGMMQAujC5kP8C0yREbR+diO ZGXnzGlKJr+qOIIXYrnvnZLxZJFd8X9AaDf16BFDO7erlIo8VpODXbUJkxIT3/VgPeZx3SWUTql a9O+gvtyLIm9AgLef3J5+UoIw4BpKfDQAJByZVX6gOhes9a2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee bus got dedicated callbacks for probe and remove.
Make use of these. This fixes a runtime warning about the driver needing
to be converted to the bus methods.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index 5903811858b6..7b04dd649629 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -520,8 +520,9 @@ static void tee_stmm_restore_efivars_generic_ops(void)
 	efivars_generic_ops_register();
 }
 
-static int tee_stmm_efi_probe(struct device *dev)
+static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
 {
+	struct device *dev = &tee_dev->dev;
 	struct tee_ioctl_open_session_arg sess_arg;
 	efi_status_t ret;
 	int rc;
@@ -571,21 +572,19 @@ static int tee_stmm_efi_probe(struct device *dev)
 	return 0;
 }
 
-static int tee_stmm_efi_remove(struct device *dev)
+static void tee_stmm_efi_remove(struct tee_client_device *dev)
 {
 	tee_stmm_restore_efivars_generic_ops();
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
 
 static struct tee_client_driver tee_stmm_efi_driver = {
 	.id_table	= tee_stmm_efi_id_table,
+	.probe		= tee_stmm_efi_probe,
+	.remove		= tee_stmm_efi_remove,
 	.driver		= {
 		.name		= "tee-stmm-efi",
-		.probe		= tee_stmm_efi_probe,
-		.remove		= tee_stmm_efi_remove,
 	},
 };
 
-- 
2.47.3


