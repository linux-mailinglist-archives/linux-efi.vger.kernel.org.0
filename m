Return-Path: <linux-efi+bounces-1372-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE592A0D8
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 13:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D7D1F21CC4
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 11:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD47D3F4;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqnjomc/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46A79B99;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437554; cv=none; b=Ge8UloQQxdPN7YESdkNrCgSW4B43ehlMSVbXEHjst/Go5KIC9EFxe7e3w1em8UvEA+DFWq/K/8gbqplpuX/83mqLqfsZTYbdgwzMYM71O0rR/XZp4bKquUtr++KraQbA6Fdohfdt9iecmSaylpcWzr4Ow6U0dp5e8W1UJdYHYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437554; c=relaxed/simple;
	bh=JWDF3uYI/wZ37tgeaDZgy9qmXzyOCRUzF9V3nIAkQKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moceSbInNBpgSXTW7NEwEfODNlCxmYZ4v1v0LFh566sH6YPjEaXtAEn6WcR7PhI2rHTm7+26eVqhkDVvgs/NjLyynTyafnEtcxLpormoc9sRWiqKyxvdfP10c6fY+qKuFchLeNgtqF8WMvjkj9mfnd2uwzXJMAgf1mZAQ5GBvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqnjomc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B2BC4AF0E;
	Mon,  8 Jul 2024 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437554;
	bh=JWDF3uYI/wZ37tgeaDZgy9qmXzyOCRUzF9V3nIAkQKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqnjomc/HoOLZmpDetAlgAqPTNWzFNB5H6+GGvWxjZC09QQmeFEdWsmuZNS5P9og0
	 9usjO/l0OkjCZq5vy6mjtNI0X0pzy+bGlAfmosepEfwfQhvJRJQhMzLyYnGqwbrXLf
	 azKPZQbACKqpyruGDAFMJbYGvl5/DBFhqc5T3SZUNQfahLZ8b0+s8hX0wGWog2ESVP
	 l5Vrc3YvLIue6Yc8+Hjm/9VRWRIEDZcN8+tSmg97gKsy3lXXt2223+DqeSCelrhRs0
	 mBv4yZoGTWtwXCBL4mk8YD37kdBDVVWIFV1fHyH1/lXTM0Ssy0+KaJq4Y26Z7cFFds
	 ShvBgtTqDvApA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sQmOl-00000001SQZ-2GDO;
	Mon, 08 Jul 2024 13:19:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"Ard Biesheuvel" <ardb@kernel.org>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Len Brown" <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 1/6] RAS: ACPI: APEI: add conditional compilation to ARM error report functions
Date: Mon,  8 Jul 2024 13:18:10 +0200
Message-ID: <f520f2529bb27d452a2dee762b6968939df42f45.1720436039.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

From: Daniel Ferguson <danielf@os.amperecomputing.com>

This prevents the unnecessary inclusion of ARM specific RAS error
handling routines in non-ARM platforms.

[mchehab: avoid unneeded ifdefs and fix coding style issues]
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/apei/ghes.c | 13 ++++++-------
 drivers/ras/ras.c        |  2 ++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..2589a3536d91 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -529,11 +529,12 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				     int sev, bool sync)
 {
+	bool queued = false;
+#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
-	bool queued = false;
 	int sec_sev, i;
 	char *p;
 
@@ -570,7 +571,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				    error_type);
 		p += err_info->length;
 	}
-
+#endif
 	return queued;
 }
 
@@ -773,11 +774,9 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..5d94ab79c8c3 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -54,7 +54,9 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	trace_arm_event(err);
+#endif
 }
 
 static int __init ras_init(void)
-- 
2.45.2


