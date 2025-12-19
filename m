Return-Path: <linux-efi+bounces-5907-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B3CCF6CD
	for <lists+linux-efi@lfdr.de>; Fri, 19 Dec 2025 11:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F77E3013796
	for <lists+linux-efi@lfdr.de>; Fri, 19 Dec 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125E2FE057;
	Fri, 19 Dec 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRM2m+J7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB82F6928;
	Fri, 19 Dec 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140866; cv=none; b=CxyOdZLxDyPaThwuRSN/QRxl2P1FPp3FunC8reN1Aa0RH1K9Sq/eK5IKlPgqy6PnQij1Cqoumgtp8HoqVbhetxqJfgL2S42GTAELGckbEkVRJ6RrwZUtDl00leWLHbcWMw+635RmPb2i3TecGpGV0F3xuC0NQoeqUZrWIMDQfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140866; c=relaxed/simple;
	bh=pjJIBdeGr/2HUnvT1qt1BXIGueYL8pPwlvX7pDcJC/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKJsJ78K3TyVQs3iB/FhVldtjKr2xINdT5U2q+mRqKfIqdiB/MbG9hcfcRNNCf/ZlwiPPayDSpdf1q0kP0LRmQLqVrlDhSXUpQSqVo0XyU6oWLgN84o8uCS8TxWQX12/8XlfCMs5gOrLpNTrJBcz1LwecSkxpwUf+4shm84d7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRM2m+J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8278C116D0;
	Fri, 19 Dec 2025 10:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140865;
	bh=pjJIBdeGr/2HUnvT1qt1BXIGueYL8pPwlvX7pDcJC/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRM2m+J7tNKKhZU5aJNvPmNCyHID+lL07a06UMgrbLNP3BMBGSiby8ntNjUhNPv9V
	 b30CI8suXkOQbrIFpJduqwF6ULwwJmyEnGQA1hU7NuDGJXkhD0F4bF7vvFcyQ2+0BZ
	 LHo3JOPpSoJrDbR/a6ROMvImUkOrr/+aXFaxOofz1vHBBhaK8kSRb3U/UZBZwZdj9O
	 VhN6OTLLoKITfV8kiCYCBhRahq9KfxkSK1OdbCdeM9X9maxBgLUj8DTJJ/u6yQQ911
	 ++tTcbHBzuGCQM9JzXtyfQMjfJF2FIdgLH/q6D3UEtKyHh+gI367VScwbalbO//z+k
	 LnjgTTRtwDfYg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vWXux-00000005ktu-45Mz;
	Fri, 19 Dec 2025 11:41:03 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Ard Biesheuvel" <ardb@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Jiang" <dave.jiang@intel.com>,
	"Fan Ni" <fan.ni@samsung.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>,
	"Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] efi/cper: don't go past the ARM processor CPER record buffer
Date: Fri, 19 Dec 2025 11:40:44 +0100
Message-ID: <da407d200220221ec2ed48bb213a51893131c2c7.1766140788.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766140788.git.mchehab+huawei@kernel.org>
References: <cover.1766140788.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There's a logic inside ghes/cper to detect if the section_length
is too small, but it doesn't detect if it is too big.

Currently, if the firmware receives an ARM processor CPER record
stating that a section length is big, kernel will blindly trust
section_length, producing a very long dump. For instance, a 67
bytes record with ERR_INFO_NUM set 46198 and section length
set to 854918320 would dump a lot of data going a way past the
firmware memory-mapped area.

Fix it by adding a logic to prevent it to go past the buffer
if ERR_INFO_NUM is too big, making it report instead:

	[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
	[Hardware Error]: event severity: recoverable
	[Hardware Error]:  Error 0, type: recoverable
	[Hardware Error]:   section_type: ARM processor error
	[Hardware Error]:   MIDR: 0xff304b2f8476870a
	[Hardware Error]:   section length: 854918320, CPER size: 67
	[Hardware Error]:   section length is too big
	[Hardware Error]:   firmware-generated error record is incorrect
	[Hardware Error]:   ERR_INFO_NUM is 46198

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/firmware/efi/cper-arm.c | 12 ++++++++----
 drivers/firmware/efi/cper.c     |  3 ++-
 include/linux/cper.h            |  3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index 76542a53e202..b21cb1232d82 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -226,7 +226,8 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 }
 
 void cper_print_proc_arm(const char *pfx,
-			 const struct cper_sec_proc_arm *proc)
+			 const struct cper_sec_proc_arm *proc,
+			 u32 length)
 {
 	int i, len, max_ctx_type;
 	struct cper_arm_err_info *err_info;
@@ -238,9 +239,12 @@ void cper_print_proc_arm(const char *pfx,
 
 	len = proc->section_length - (sizeof(*proc) +
 		proc->err_info_num * (sizeof(*err_info)));
-	if (len < 0) {
-		printk("%ssection length: %d\n", pfx, proc->section_length);
-		printk("%ssection length is too small\n", pfx);
+
+	if (len < 0 || proc->section_length > length) {
+		printk("%ssection length: %d, CPER size: %d\n",
+		       pfx, proc->section_length, length);
+		printk("%ssection length is too %s\n", pfx,
+		       (len < 0) ? "small" : "big");
 		printk("%sfirmware-generated error record is incorrect\n", pfx);
 		printk("%sERR_INFO_NUM is %d\n", pfx, proc->err_info_num);
 		return;
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 0232bd040f61..88fc0293f876 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -659,7 +659,8 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 
 		printk("%ssection_type: ARM processor error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*arm_err))
-			cper_print_proc_arm(newpfx, arm_err);
+			cper_print_proc_arm(newpfx, arm_err,
+					    gdata->error_data_length);
 		else
 			goto err_section_too_small;
 #endif
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 5b1236d8c65b..440b35e459e5 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -595,7 +595,8 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *,
 const char *cper_mem_err_unpack(struct trace_seq *,
 				struct cper_mem_err_compact *);
 void cper_print_proc_arm(const char *pfx,
-			 const struct cper_sec_proc_arm *proc);
+			 const struct cper_sec_proc_arm *proc,
+			 u32 length);
 void cper_print_proc_ia(const char *pfx,
 			const struct cper_sec_proc_ia *proc);
 int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
-- 
2.52.0


