Return-Path: <linux-efi+bounces-5846-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1ACBE454
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1745830011A6
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AE33EAF5;
	Mon, 15 Dec 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j0UM5/yw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF133A007
	for <linux-efi@vger.kernel.org>; Mon, 15 Dec 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808275; cv=none; b=jmEzFXUtHIKh990GVspJ69Cra3LTrPEg47E3QQhMsKVEjqFfzTzQsdA+OpOMpOQqwThtb1Ct0zP3n08u7F4gPJe2Et9FbARqC3XUxHUgo+CWf4iXoAM/YJEH/cYebXC130kGcV6nwqZMmH+CRD1I1W/89BNZgi6LmmDZI1WDegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808275; c=relaxed/simple;
	bh=U2aCK4CwX4oX996AKQXtxl/fnEvZCMh7YIAYyx6fXTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hphY2NpN6Zw3tGFjiQSuGzC4k3HnWujX6uTaY6KqlYgT8IJNl839MXXUUZArfnaeiQ29C17Sn57PFFZW3kOh8WhVI6geZSJpOG4kVjpdTKAv8omXY/8fIcBR9+iFHZBnZFkctOkeFeV8d5zbK+nyNp9pkRPJ1kghsXrkmLG9Ql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j0UM5/yw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64979bee42aso5173394a12.0
        for <linux-efi@vger.kernel.org>; Mon, 15 Dec 2025 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808269; x=1766413069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtA7J2/qth5t0PM6hBWIeoPmBTb33drrrwinTXvOw1g=;
        b=j0UM5/yw00OlOhh0eXxdyC51JfQloSwgi2Jhgfdm32iWXPTnMac2PGa4jn5PYqg5C+
         8KJdK1HBykP8Dpb0IFdVaS0G5h1kvy+W493UpNTJFm5ye7EsWx5+KitjDkNDmbLuoiVV
         HYbECGjtCZtQpvrTuMOaYmYTbHdeFD37jurzrYU1M6ol7EZqjxriXC3fEHqG7fuf2hvO
         7SCbOMcdR1541ap8U8X63vmV4yo2aA7l9Hnte+eI5yBkt72AZtyJ38mxtJ5vQVhehotW
         mRRRwNEOL6vfaO419bOKya1PLZMneCvGq4UJiMD/xgYLN/MpDEhrc3wYJ0qaaXOVnjS0
         Ir1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808269; x=1766413069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jtA7J2/qth5t0PM6hBWIeoPmBTb33drrrwinTXvOw1g=;
        b=LbKXJF0b8e1sqqu3LGasLH9MrLbIhWdxBqrhb9QiqAL5ofSC1bDj8AZg2959lcl5nA
         bBsyPfGo6oKqlVIz7LUA7N0LsOkEunqetZyMrZJxVlmLGt+rP8a7R4DDl5ucRD0itjYd
         r+pCSJtvT8xIxGw1V3mKlUkx+4wj+1FU6sd3bAbygtI4Ej3CLI49Pnhvy891w1B6d8ZV
         lSJKzuqeKXj+8rUWvPs4+o4wXfsKmlgNxSDASzw8aSuYhoJLYvJ1l9bAq5Tad9Xv2gS0
         BCpk0D2HicF/QvfTM52mlJ9zPbHj9lnZkogEttYZ5BHAb8yDv9TekLDr2rnA5fgKSv39
         5qDA==
X-Gm-Message-State: AOJu0YwXlZkc4MjvWpxnUYIZb1Lpt0q7lhAzHAfsUHfpX3X1sUe5mm9t
	B3llog4fVhgD+CB8BQIz82y0k/qhtTAWhQdBH7VdHgwbO8nHD22iDGAS55474P9KqOY=
X-Gm-Gg: AY/fxX6RDNXagQoPE9ApQQwnf9ICRxnEInKLbnvd0DiaC8MkuBVUG6xeJjahpcqJ9/6
	sehcTxQi001z0/ZhzA4H73DtF9Bn5+0hmRyPPj7Cr9MkJni9dI3MR19NAXyJlks5PVzTZ8Ylevt
	oyRLwO9Fy7IEdK6qrllT2VDaX6UYpYJV7lDx9o66NRowzkKbbpE3AwIZH6ldwUXbPkAWopSsSFB
	NbXSbEvIO+WpvGGxbVZOmhuKOdeJW9ZwsBk+fjgNKcHgS+B+WhrhhpU51NDVTyaFr+zI0teUzvg
	aLRZET3A1DFtGNw0g7KYMkNt1/5ovIGKc8qbEdBNK0/De/4Ft36JiD62T1YdFDuwoErCV6EWpTj
	Lc94iLNVThd43r1xBbQfDrNJ9LZGB9QBNsnUhzPBQvJ1iQctXYeo6lsFprr8Rjs5BWFoUxgwx1L
	gW5Q9xZnZwvxT2LQqyTkcJuDE7ep3v/gb0jCZj3JEl0KHiojBp2UG/4K7nDA==
X-Google-Smtp-Source: AGHT+IFv/1u5W9CnoFiaYoPlvVQjDIdpfyxbrw8ig3P6eLn1uHC5BYn5sqa+mcQbAnC/+TOxgPrUcw==
X-Received: by 2002:a05:6402:2747:b0:640:abd5:863d with SMTP id 4fb4d7f45d1cf-6499b1c2a09mr11674219a12.20.1765808268604;
        Mon, 15 Dec 2025 06:17:48 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6498210ed32sm13548630a12.29.2025.12.15.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:48 -0800 (PST)
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
Subject: [PATCH v2 09/17] efi: stmm: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:39 +0100
Message-ID:  <b70ad65c88a82cf56c93cf17cf326213f8273e37.1765791463.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=U2aCK4CwX4oX996AKQXtxl/fnEvZCMh7YIAYyx6fXTo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhiuTDaNseAt3EsBljDKzQwacM+pSRuQiPAQ arTLi9z4TCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYYgAKCRCPgPtYfRL+ TnPbB/93KOuWIwDOJ283H+/wb1IIrgxqlC+DspRkdayu/Cjo2Z3TLbCwKyVMa5P6gZTnCDpH9Si 8rY5VZw8XaCqtqlLyVXjKit0WM5xeWDSRTlO+Q9WpokHiBxGfYIyP6YwTr+uo5OUlZshddxiDMz 2SQfGZcAHDksHjUDaPeVnlK7IUY6b0gcAmXFtPxNMEs4g1V8A58bIiOWqeAH6qjmW/P1Cxu7xac jYyR+lv+iCEhcIfMPVN9z2+RE8RmB7GbwgvuIPvs3GJJEULWKqdkcmdpkMlwQ48qO2LpQPvrvw2 Iu45H6xt8WaFrlDiRp+l+5sICtpI1uY89HTZulc2m2fYD7tb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee bus got dedicated callbacks for probe and remove.
Make use of these. This fixes a runtime warning about the driver needing
to be converted to the bus methods.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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


