Return-Path: <linux-efi+bounces-1673-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532A96FCBB
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A65DB270D4
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE11DA631;
	Fri,  6 Sep 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CUgMNPLR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818641DB952
	for <linux-efi@vger.kernel.org>; Fri,  6 Sep 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654506; cv=none; b=UQDZs9i/W9JgQEj/wbVIXpMFE5lXNm6/rACTvgMZ8TKB72zA6+9JrbGGG+270ZJVvoSSTB/j0jQKirVwN/cs7GrYUaTSgelmZLHiQBoTTFA6RCZD46Ldxvf3oapDFmZ1yRrft/WQG2UAx7d8JoAcvlVaBsDYXAl9HRF5bOg0j2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654506; c=relaxed/simple;
	bh=E3uOxF1ZH/iR4ucEQmsFO/keFaNTqRqQ7i07DVck9j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwRmWeo8+RttJMU+CVORtL5GvJpUt8SaAMaao4wHXV8wvIq6GTHjww2tTTO6L8uchTNpVz9+4tWY+jj2MWC54/XdzK8fvDW7yKUFXzS0Qf/JTI92r8bHS2NJVDi3JyIjfDKCO7mdiBDC7Ve7s8b5pOwK40+d8fp+DC96wfDzfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CUgMNPLR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a8134aefe8so166865885a.2
        for <linux-efi@vger.kernel.org>; Fri, 06 Sep 2024 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654503; x=1726259303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnAfWEx/aiVhm89Fpzc3fk7i/4x7q8oY7L/gONXGmMI=;
        b=CUgMNPLRvex5vKPhRtEPkNwsuf+vBVuMMpH51OIEwSU3fZ4XEXKXytK5ROwGKs5/R/
         NgJ1eibl2+lbAdw3ysyPLSFhlTWpwLhP6cXIjYG4gjRD5hSYHzgwzk0Tb691w85957tH
         fQVD1NJkvJD+RH6p401AOCIFdrgbHKnBrXqm/zy8ySff3sxz6j38y6iMx25wwasIfpeG
         DXCU6sK6iqTIFO6zCjla8iG3bcw3img+k/NyY9WYyRvxi/oQMAGmDxDhabiiiIbEAeLv
         Vnbt1tYWFYFJkznlTPmauYKZjazdFAFDd6tysJ6Imzh/YU4rGkikJYDGq1Nr8Gak4xVY
         vJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654503; x=1726259303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnAfWEx/aiVhm89Fpzc3fk7i/4x7q8oY7L/gONXGmMI=;
        b=gwxw+nqaZycGg5MRiJveWx1UwXNRO9EP15AdCTYgse+KLtcTTn5hM8jW4PDSmFroOc
         hjUsx92mRZCkkYz+xsJilhW9xfEjaDEQmYC61rh5AF82GrBuJQCOFoS53zLJGVMEekXO
         eK1eRSu/qgmE3ScAuveIzNXNp3qcSFpGviwp/R81vt9kS1m9DoEpcb/wiRenY8H0WhDA
         Y0RK7OJ9q8MyHa9xWDJJn0YOU1+Gx142Jt6DvZKv9N5zX09hRtm966Lf1JHJqq+Xxp2E
         UEknT2XEY/YfB3PNHS1ezlI7o+y1hlkhwEwN0yvgmyZ+qyiCYnktGOc1p/obyfimxzwR
         qYVw==
X-Gm-Message-State: AOJu0YxpF8E7rvDQTz/EVcKb/lqef+AnKskCD/4c3Auyp3dNbJGQHKrC
	P83AmxnkDuxumqmKzTqk56182HJdCSmeSXYzB2gKq2ua87cS5Fqp+euWj01Kg1yfLToa8DH4uOA
	K
X-Google-Smtp-Source: AGHT+IGNKUXGcQEHZ7PXWPlir8YbvSOsbPfUe2vpAa/Zk++V48k/OP1Q/5znMUllsHdgKaBBuRjP6A==
X-Received: by 2002:a05:620a:4490:b0:7a3:6dd9:efbb with SMTP id af79cd13be357-7a997339e8bmr471752785a.33.1725654503233;
        Fri, 06 Sep 2024 13:28:23 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:22 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 3/6] libstub,tpm: provide indication of failure when getting event log
Date: Fri,  6 Sep 2024 16:27:42 -0400
Message-ID: <20240906202745.11159-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906202745.11159-1-gourry@gourry.net>
References: <20240906202745.11159-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If get_event_log fails, at least provide an indicator of this failure
to assist debugging later failures that attempt to interact with it.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/libstub/tpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a..192914e04e0f 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -185,8 +185,10 @@ void efi_retrieve_eventlog(void)
 			get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
 	}
 
-	if (status != EFI_SUCCESS || !log_location)
+	if (status != EFI_SUCCESS || !log_location) {
+		efi_err("TPM unable to provide Event Log\n");
 		return;
+	}
 
 	efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
 				   truncated, final_events_table);
-- 
2.43.0


