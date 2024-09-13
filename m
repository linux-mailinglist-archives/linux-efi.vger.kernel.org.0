Return-Path: <linux-efi+bounces-1775-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A6F978BCC
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 01:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD07F1C24F9C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 23:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD918BBB1;
	Fri, 13 Sep 2024 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ppu8EzRu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E917BECD
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269648; cv=none; b=OeJzFHz2xrFFDo5NS2n9KXCZh46yiSwebCUFZ8mnskxu9y/eISF0mxs89W55AqyIPGaDOplta91qQTIk+/00klPCtluzelZiQUQzS0Q1yTGp+AkdSzP118NveSX3/MbJkGRbkYvzqAMtJcnsdY7wOfblKMKY25eVd423HaqmPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269648; c=relaxed/simple;
	bh=67vrryU9UsTS+odD3Hr++7bs/r/n/mJM7bxXmT5GFXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfil/HKA70NWKQF6N84lDxG7VPSZdzotgwwF4s5topE1TrvWmDX56gQ7GQ8jPTizSyaoy56Hym7DlttYMemwAlslfPLt/kCcFPGA5nTpmxmH469k0LB+KKMTD1riGFYNtN4uyAVOyzE2ETPocQPFvevzM+q1xvAnHqGXdvMAlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ppu8EzRu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45821ebb4e6so21401861cf.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726269645; x=1726874445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qmyPO2gV2TdLvoy/ahfQtBr82+inMJIdQs23EMKWKs=;
        b=ppu8EzRuBCtot/9pVwqKfojTcHOa6UFnKCl25Klu0ZXuHLPcDnDDqZdirctt1HdGv9
         zmoIXrzZlzmuv+hZ8NvAt0MlXVWKVk2nYUU9BcOZUyxv79bii28Ep43XUQ6RPTG6pyZX
         d2IiHRpx0+NWiqgB8OBwGDeY5k8slc2o3J+aPFScCQVkk29RdQbuATnhX5+O7wlHvdko
         Zd8MvixTD32fFaVU8EwAgprUZLg3UIe3Au8HEApq4MM08Vtt4UC57k79eeTLS5qQP5YU
         LqtzoG0NGxPsmrhT9JzNEk4jsQnZ8Yz3GqZdYy82g//g2QlYVJizyn9levz+l430MXkM
         aIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269645; x=1726874445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qmyPO2gV2TdLvoy/ahfQtBr82+inMJIdQs23EMKWKs=;
        b=iRbVBtaR5S0Yv4M/UXSM3Dzes+tjlgAT18f8+pMmiqlntthNUHE60aHGQMMXb1VioI
         GLg+prlXJzLJnRcSbAxEqMF4bTx87X77FmiD0Xm00T3A7gxpeNqFEGd+BevJrj2cAQyf
         7ZAW6feU0/OKn0oIx7bDzFXsumv8OAhF38/t+i4W/eJE/KcM/SvzM5Q6wua5wu3/CL1e
         R2tS9WjpvDQ7Fl88vwIom32L12HCZFoNbSzP+pO68n91CRH2mbCpQ4znMpAfa3vFxMCY
         nU9UzDRjUG8+cmWbayqsRhbAotF8DEJBitYWaF0YsZmK3LPR5JEXbPFJRmTnj6/bkqpc
         W7jw==
X-Gm-Message-State: AOJu0YyjIu87R7jETF4ebJIGwlj+8tbPfXIDOuoSDr4YUr9gPsSe2sYA
	dJ7vweTD+zXnnGnzawmQEzYxcQyl868VH07VYycIFqPypjJEka8jp6tTdBwl6tZtYUFz2s9/O0/
	S
X-Google-Smtp-Source: AGHT+IEv2T5u2KP3uo5VZTlultKi7QNfE9nP2N/YxwrZuzhrSep3tbOlZyBFH3cqwRpFuYqPrBzOSg==
X-Received: by 2002:a05:622a:1892:b0:458:4c0d:bbd0 with SMTP id d75a77b69052e-4586032a0bamr103252871cf.30.1726269645075;
        Fri, 13 Sep 2024 16:20:45 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm1245801cf.21.2024.09.13.16.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:20:44 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH v2 3/4] tpm: fix unsigned/signed mismatch errors related to __calc_tpm2_event_size
Date: Fri, 13 Sep 2024 19:19:53 -0400
Message-ID: <20240913231954.20081-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913231954.20081-1-gourry@gourry.net>
References: <20240913231954.20081-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__calc_tpm2_event_size returns 0 or a positive length, but return values
are often interpreted as ints.  Convert everything over to u32 to avoid
signed/unsigned logic errors.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/libstub/tpm.c | 6 +++---
 drivers/firmware/efi/tpm.c         | 2 +-
 include/linux/tpm_eventlog.h       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a..f194e43f00ad 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -57,7 +57,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
-	int final_events_size = 0;
+	u32 final_events_size = 0;
 
 	first_entry_addr = (unsigned long) log_location;
 
@@ -110,9 +110,9 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 	 */
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
-		int offset;
+		u32 offset;
 		void *data;
-		int event_size;
+		u32 event_size;
 		int i = final_events_table->nr_events;
 
 		data = (void *)final_events_table;
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index b0cc2cc11d7e..cdd431027065 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -19,7 +19,7 @@ EXPORT_SYMBOL(efi_tpm_final_log_size);
 static int __init tpm2_calc_event_log_size(void *data, int count, void *size_info)
 {
 	struct tcg_pcr_event2_head *header;
-	int event_size, size = 0;
+	u32 event_size, size = 0;
 
 	while (count > 0) {
 		header = data + size;
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 7d68a5cc5881..891368e82558 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -157,7 +157,7 @@ struct tcg_algorithm_info {
  * Return: size of the event on success, 0 on failure
  */
 
-static __always_inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 					 struct tcg_pcr_event *event_header,
 					 bool do_mapping)
 {
-- 
2.43.0


