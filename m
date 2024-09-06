Return-Path: <linux-efi+bounces-1675-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7C96FCBE
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 22:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1843F2812B9
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C51E1A3D;
	Fri,  6 Sep 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hoe5lUD0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6D1DC751
	for <linux-efi@vger.kernel.org>; Fri,  6 Sep 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654508; cv=none; b=h8qCsginsValUpILl9+IR+NxRRXfMQKp8oFq1aHn+tWd+N/0GYHXCvfhwik7KQkz60qp18DiRdTpPi67IoxO5/BvU9VRVAJVR8cU1gkZ6bma+LC9PKyCRHo//5th5oBs0qbqU8WmqzLFYb0vLGfk1yXOnzVgfFZOOQjSXmgy5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654508; c=relaxed/simple;
	bh=5DrUFp6j6wXIZ4N7IoF/p+lmyHVDI6Endn0V+tYMssw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2DN8CwTWO4XCpY7syxAnVm0Pkf1rjBwr36JU7lvxfsi/qHnzlLPkQNUCCpRJj96BJHaC9K4UI0wwWPGsZ5WwTtolLA1xdeMuP5YWxpwZCORQ3bAeHq8K1mGVjV5T+G5VceWrYVcPczt2a0pr/wiPL7NHU/wuTCffnCYGxBopSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hoe5lUD0; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-49bc7387371so767494137.2
        for <linux-efi@vger.kernel.org>; Fri, 06 Sep 2024 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654506; x=1726259306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cldmkf1vC0Pr0XJbmfuzeqw9dySvEdpYki9ytzXFT1c=;
        b=hoe5lUD06sTs9lhXKb8zXNrCVWpueOhUQSQM/zmDvbfE5KPoGnTsu65pnYQD88Eyu6
         +MMBKB//Fv3dEU6IazKRdMw8FGUe0S0YKa0wuT3xZG4bl/FxMMVnA3FSGKFh1tvdA+rc
         XZr8ZUP3f7fWYTgArm+WWlkX3s7F7JrTBpKl8TaYtUuyNTVMyxcB+nn229KjH8Q9FpYO
         xErpBpmXvh+xwxnUZE8mP2TcSJH8Khb8bXCkXhvLeQBcizDwtFJBmc8vPzXDF3S+JHV6
         XgE8PiwWo/M810iIfNhqyW3EBRLz2o/h2MuHYGC3wdPVFfoxVi4lRmGxbUKddUXkB6Wx
         KFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654506; x=1726259306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cldmkf1vC0Pr0XJbmfuzeqw9dySvEdpYki9ytzXFT1c=;
        b=HAxRqVYCSzWUpxEPPSWNOpSs5O2sDN5Y0MRGXJh/DMZJ6yjAGmHRb9TSOFhIdvm2iI
         0Y9+XVwGF3iyIL9z2WN2SxTYP8ilFwn5zTI1B4IW3Jhetj7PUkPKM/NRjShlHzAGim2P
         /T8OO3nhAQAtM9zSmmulffJBcDGsHzVDtLMOmtUfq4lxLnhnY8oIOvvh93qbUpRIEBWI
         m2hOtV93C3pKkLMIUSAAmkwhRgGZ1s1G5Hr6GeZa+Raq/e2eAebUPvnUwXNWsfn7iMbJ
         P/HuRz/dRFKulbJmcz5jU+opRXb0JCE0YsuByYrKEduHC9CMefamlMr0U57tDHAWkHqu
         sVDg==
X-Gm-Message-State: AOJu0Yw2g7T0W9ZxbildA+LRFXFbOBVLSGyFE8uCMlJQZ/PuQIcUvoCd
	19XmOzCleL1xhx9Fiaazt8+iH/+NvJ77WVaugg4HIZ943m1p++LSqMXVylaRBy5kFQuVP9sOJX2
	f
X-Google-Smtp-Source: AGHT+IGTLRBA/MYnsSvHU5PnGiuRmzazXBamsUEm4o4g0ut4x8zSLeqiqZGlvBZ9w4nkz5c9KxFqEw==
X-Received: by 2002:a05:6102:1609:b0:492:a11f:a87a with SMTP id ada2fe7eead31-49bedd008admr158299137.25.1725654505650;
        Fri, 06 Sep 2024 13:28:25 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:25 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 5/6] tpm: fix unsigned/signed mismatch errors related to __calc_tpm2_event_size
Date: Fri,  6 Sep 2024 16:27:44 -0400
Message-ID: <20240906202745.11159-6-gourry@gourry.net>
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
index 192914e04e0f..4f9f0e049a7a 100644
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
index 9a080887a3e0..7673cf8e53d6 100644
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


