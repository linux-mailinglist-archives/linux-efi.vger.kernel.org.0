Return-Path: <linux-efi+bounces-5953-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB21CFF0BB
	for <lists+linux-efi@lfdr.de>; Wed, 07 Jan 2026 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E0734508CF
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jan 2026 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FA389DF2;
	Wed,  7 Jan 2026 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGlCjgnk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC83775C5;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804131; cv=none; b=jbq4qtnga8e5eoYnrKhAp50u9b6h4qApmstdA3Zp5N9lrkGNMamWmFh0Od0nNToXhgg5Yp6s3jEAAtLfj0fjqDZAR/pzW9NBZZjCStgLeF/0oQdubePcQw4Nf7wwcDyRykdgZQ0HPVh5xPBsEma2h4no7isSt7mRegWLb9QwwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804131; c=relaxed/simple;
	bh=3Avwk9ah4fvsu5pW2Hk/IxHeMU3rEwQMuWdy8ZlvDv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsLL74LP2fSw6ebzTZvPqD09I64NYUqlZt6YMZfmhmgy17N/58PBeP/QwxJU4rfvpQtj02usCVGMPmoi8pF1NR2yHvwn0EBtwOsNxnZ6j4xULg3CQa8CpETWXuXvKo3Gpe65Thqz5fskBPZ8Y/1YzG/kIl+/lH35xuexiHokdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGlCjgnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6B8C19424;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804130;
	bh=3Avwk9ah4fvsu5pW2Hk/IxHeMU3rEwQMuWdy8ZlvDv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGlCjgnkUlSettDBESFYBaNmqrNjBAaZYHMqVTdHXB9TOnuylmrnim8gt2DlzuACq
	 cLNRb3k+ZgJb3uiBYy5bcicEfumLsuLBHI+GadZ0E4Umv2yIqIDdZleOQ+OzbxSJbd
	 SC2uJQUeusKeYxUvuoaarBML0vdwmvMCc/vh67YcjP7MDbKSXeXSlDwMh8sRE6DI/c
	 Zwv0yP6kht2fmf776mM1KH+ydl7KwBs5cqV6eWEyys2Uc1Y63546C3Q7X0jpgGYb0B
	 eCsGe00jvgPOEbsOvcZhPaLXzT2AJy3MadwZNQBGGSvdi1MOLVZoW6ReDTFV0fgoUM
	 KqCZmryORP67A==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vdWbo-00000001bUW-0tY9;
	Wed, 07 Jan 2026 17:42:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5 2/4] efi/cper: don't go past the ARM processor CPER record buffer
Date: Wed,  7 Jan 2026 17:41:50 +0100
Message-ID: <41cd9f6b3ace3cdff7a5e864890849e4b1c58b63.1767804050.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767804050.git.mchehab+huawei@kernel.org>
References: <cover.1767804050.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


