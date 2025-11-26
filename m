Return-Path: <linux-efi+bounces-5692-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E276FC8A893
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B58134EB885
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F2F3090D7;
	Wed, 26 Nov 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhZCWF2U"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D79308F33;
	Wed, 26 Nov 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169554; cv=none; b=UziGZq4hXlWJU5cUDgWgbQqcOnIktYT9P5QnmwiRGYP4fMIHArIoO9slWMGdGkyMQpm3fA6hEjV/MVOd9VMwN1TwF3bmqUOO11yz66M2Yv4vn9LQuUo7a9D6PtQ5vNSmpZM2uzh1Ce4nkeQOqxKAKA+QeIryKgJe5a48sYL+XIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169554; c=relaxed/simple;
	bh=yDmc0KkHB9MrGSqJbRBKHH3aD0kUU3XAZAaRb9UpBZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAqJ7SWuyivfkLf9YG9hRWbRNjmi8E2mZkrhcw5PtnW2umdRkoy1WB4NRbQEYLn8ibKCT8DtBLi+8OUKEGhVOx11/NdjRNVyWOmd/SMMX8FW79JaZxv/DI9z769wCfidpGrSpogYfGjNrqXblUB+DOGJ8iyP1RV3yOwhN1ZTJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhZCWF2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA5FC4CEF7;
	Wed, 26 Nov 2025 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764169554;
	bh=yDmc0KkHB9MrGSqJbRBKHH3aD0kUU3XAZAaRb9UpBZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhZCWF2UZYdsx21O52l+J6cOSik0H8XblVwQ6pvvMgJLY56P+14bSPJK4HITF8QOo
	 3vZXqZ9o+2A5PIuhs/l0a3g8YXzpB2a5geTTKJsZiXkG8+sWUYxEblEHdN0/GU9OGH
	 0HoLfJhleK7J+wO0rs/oNLowJzFo0qGEjbulLsk6QsUUlpp4dUEH4xT6Ew8a/cI3Mn
	 9Lh9ypH+IM6szGfYf4O8L51vz8SwZfgF6Go/H3+IiqjgaDdYIYM6lHraVHruh41ocX
	 SmS4aBiWXR07cFgv+y2fJHQnUiQpM8eMm1QjrdIZz0VodkCFKBFcuvMhNaCe0P0hRy
	 w2kYjiOIlKlpg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vOH5c-00000003nvq-1r9L;
	Wed, 26 Nov 2025 16:05:52 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Ard Biesheuvel" <ardb@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Breno Leitao" <leitao@debian.org>,
	"Dave Jiang" <dave.jiang@intel.com>,
	"Hanjun Guo" <guohanjun@huawei.com>,
	"Ira Weiny" <ira.weiny@intel.com>,
	"Jason Tian" <jason@os.amperecomputing.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Len Brown" <lenb@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>,
	"Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>,
	"Tony Luck" <tony.luck@intel.com>,
	"pengdonglin" <pengdonglin@xiaomi.com>,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] apei/ghes: don't go past the ARM processor CPER record buffer
Date: Wed, 26 Nov 2025 16:05:45 +0100
Message-ID: <7a97a0a51c2841b715cde1ee0c92df2765e5d0db.1764169337.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764169337.git.mchehab+huawei@kernel.org>
References: <cover.1764169337.git.mchehab+huawei@kernel.org>
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
like:

  00000000  01 c2 bf 6e 76 b4 94 d7 b0 04 f5 32 e3 5e 89 23   ...nv......2.^.#
  00000010  f6 4f 40 31 fd 70 3f 7c 0a 87 76 84 2f 4b 30 ff   .O@1.p?|..v./K0.
  00000020  24 20 71 0d c0 92 4b 0f ae 9b 94 9d 78 8a 7f 6b   $ q...K.....x..k
  00000030  89 2f 10 8a 6a bf f4 01 96 12 b0 90 b3 9a 08 33   ./..j..........3
  00000040  0d 01 61                                          ..a

It would produce a very long record, going past the buffer, as,
in the above record, ERR_INFO_NUM is set to 46198.

Fix it by adding a logic to prevent it to go past the buffer
if ERR_INFO_NUM is too big, reporting instead:

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
 drivers/acpi/apei/ghes.c        | 13 +++++++++++++
 drivers/firmware/efi/cper-arm.c | 14 +++++++++-----
 drivers/firmware/efi/cper.c     |  3 ++-
 include/linux/cper.h            |  3 ++-
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 56107aa00274..8b90b6f3e866 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -557,6 +557,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	int length = gdata->error_data_length;
 	char error_type[120];
 	bool queued = false;
 	int sec_sev, i;
@@ -568,7 +569,12 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		return false;
 
 	p = (char *)(err + 1);
+	length -= sizeof(err);
+
 	for (i = 0; i < err->err_info_num; i++) {
+		if (length <= 0)
+			break;
+
 		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
 		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
 		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
@@ -580,10 +586,17 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
+			length -= err_info->length;
+			if (length < 0)
+				break;
 			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
+
 			continue;
 		}
+		length -= err_info->length;
+			if (length < 0)
+				break;
 
 		cper_bits_to_str(error_type, sizeof(error_type),
 				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index 76542a53e202..6fe26abc9c11 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -226,9 +226,10 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 }
 
 void cper_print_proc_arm(const char *pfx,
-			 const struct cper_sec_proc_arm *proc)
+			 const struct cper_sec_proc_arm *proc,
+			 u32 length)
 {
-	int i, len, max_ctx_type;
+	int len, i, max_ctx_type;
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
 	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
@@ -238,9 +239,12 @@ void cper_print_proc_arm(const char *pfx,
 
 	len = proc->section_length - (sizeof(*proc) +
 		proc->err_info_num * (sizeof(*err_info)));
-	if (len < 0) {
-		printk("%ssection length: %d\n", pfx, proc->section_length);
-		printk("%ssection length is too small\n", pfx);
+
+	if (len < 0 || len > length) {
+		printk("%ssection length: %d, CPER size: %d\n",
+		       pfx, proc->section_length, length);
+		printk("%ssection length is too %s\n", pfx,
+		       (len > length) ? "big" : "small");
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


