Return-Path: <linux-efi+bounces-5951-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BAECFF51C
	for <lists+linux-efi@lfdr.de>; Wed, 07 Jan 2026 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797CA36AFA97
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jan 2026 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9138B985;
	Wed,  7 Jan 2026 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do6/dmF2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4366375147;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804130; cv=none; b=KYXIdTZV8vPqOh2zgCzlQ2+lMrPflE+MLDD/yMySHkkP+BjCUiG/D1iCx/69Rj/xK54WxzmIRUeds5yQTCGihMS2UTxAxrrT7DF4OMm/WWp9qpTAA2+g+gG93RSV5gxrz4idhRIxvKhxj1En6QqnFjzezDyk1rtY9JVLWX+GqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804130; c=relaxed/simple;
	bh=/2sTI+ZMqBflhdzNpuA/tHH+ApzFoxDz3AuVKHALOJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geA45OU6N9qHt0Df5XAe0coNFpk1oHA0+TTYJc78luo6PVxzIbDScwiOcEbmN3hVofS/lZaVoArxlX3Gz4hPBc7g5DlpoZXbcmIUHX61VtbE5jZa+KLy3+C0ogry89CkfRFWGZcQhdkj6jtTliY91cUQG5RGXs4fHGhtofT7040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do6/dmF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19164C4CEF7;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804130;
	bh=/2sTI+ZMqBflhdzNpuA/tHH+ApzFoxDz3AuVKHALOJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do6/dmF2v9JUCIn30eVeQuTQBuGtPtuXYPohyxNpMWulIKhHXoxNcSK/R0KdNcVi8
	 9qYCyWMCmhGXSjvaUNBHYit5VRN7u7ZfKhA6bGumSfU2fWXJgwUx1H1H0xkCXk36Ks
	 izH/Ax7rjqNUPWHAbLdnkdYeMh33++M5HNxVdiCCoUMGprMCvZX7tGb3OQ/2/NOSq+
	 G7/v2auJjKQol6N+ytlzh/NZyH9IJ2Egq/TTYOptsX2ullRJThHV+F7Q0vygvYiNUa
	 Mz9KKxAJ1K40cW9hLnS0kY9K7f67y1xlWD9lZw6xjeqd+9s9Xw6HsAGhHN+mjw7Iv3
	 wCIsBzW3P6YQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vdWbo-00000001bUa-11CE;
	Wed, 07 Jan 2026 17:42:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Agrawal <ankita@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 3/4] apei/ghes: ensure that won't go past CPER allocated record
Date: Wed,  7 Jan 2026 17:41:51 +0100
Message-ID: <a6500921db6bd3f09f010ecfc1900a2faac3f6bc.1767804050.git.mchehab+huawei@kernel.org>
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

The logic at ghes_new() prevents allocating too large records, by
checking if they're bigger than GHES_ESTATUS_MAX_SIZE (currently, 64KB).
Yet, the allocation is done with the actual number of pages from the
CPER bios table location, which can be smaller.

Yet, a bad firmware could send data with a different size, which might
be bigger than the allocated memory, causing an OOPS:

[13095.899926] Unable to handle kernel paging request at virtual address fff00000f9b40000
[13095.899961] Mem abort info:
[13095.900017]   ESR = 0x0000000096000007
[13095.900088]   EC = 0x25: DABT (current EL), IL = 32 bits
[13095.900156]   SET = 0, FnV = 0
[13095.900181]   EA = 0, S1PTW = 0
[13095.900211]   FSC = 0x07: level 3 translation fault
[13095.900255] Data abort info:
[13095.900421]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[13095.900486]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[13095.900525]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[13095.900713] swapper pgtable: 4k pages, 52-bit VAs, pgdp=000000008ba16000
[13095.900752] [fff00000f9b40000] pgd=180000013ffff403, p4d=180000013fffe403, pud=180000013f85b403, pmd=180000013f68d403, pte=0000000000000000
[13095.901312] Internal error: Oops: 0000000096000007 [#1]  SMP
[13095.901659] Modules linked in:
[13095.902201] CPU: 0 UID: 0 PID: 303 Comm: kworker/0:1 Not tainted 6.19.0-rc1-00002-gda407d200220 #34 PREEMPT
[13095.902461] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
[13095.902719] Workqueue: kacpi_notify acpi_os_execute_deferred
[13095.903778] pstate: 214020c5 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[13095.903892] pc : hex_dump_to_buffer+0x30c/0x4a0
[13095.904146] lr : hex_dump_to_buffer+0x328/0x4a0
[13095.904204] sp : ffff800080e13880
[13095.904291] x29: ffff800080e13880 x28: ffffac9aba86f6a8 x27: 0000000000000083
[13095.904704] x26: fff00000f9b3fffc x25: 0000000000000004 x24: 0000000000000004
[13095.905335] x23: ffff800080e13905 x22: 0000000000000010 x21: 0000000000000083
[13095.905483] x20: 0000000000000001 x19: 0000000000000008 x18: 0000000000000010
[13095.905617] x17: 0000000000000001 x16: 00000007c7f20fec x15: 0000000000000020
[13095.905850] x14: 0000000000000008 x13: 0000000000081020 x12: 0000000000000008
[13095.906175] x11: ffff800080e13905 x10: ffff800080e13988 x9 : 0000000000000000
[13095.906733] x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000020
[13095.907197] x5 : 0000000000000030 x4 : 00000000fffffffe x3 : 0000000000000000
[13095.907623] x2 : ffffac9aba78c1c8 x1 : ffffac9aba76d0a8 x0 : 0000000000000008
[13095.908284] Call trace:
[13095.908866]  hex_dump_to_buffer+0x30c/0x4a0 (P)
[13095.909135]  print_hex_dump+0xac/0x170
[13095.909179]  cper_estatus_print_section+0x90c/0x968
[13095.909336]  cper_estatus_print+0xf0/0x158
[13095.909348]  __ghes_print_estatus+0xa0/0x148
[13095.909656]  ghes_proc+0x1bc/0x220
[13095.909883]  ghes_notify_hed+0x5c/0xb8
[13095.909957]  notifier_call_chain+0x78/0x148
[13095.910180]  blocking_notifier_call_chain+0x4c/0x80
[13095.910246]  acpi_hed_notify+0x28/0x40
[13095.910558]  acpi_ev_notify_dispatch+0x50/0x80
[13095.910576]  acpi_os_execute_deferred+0x24/0x48
[13095.911161]  process_one_work+0x15c/0x3b0
[13095.911326]  worker_thread+0x2d0/0x400
[13095.911775]  kthread+0x148/0x228
[13095.912082]  ret_from_fork+0x10/0x20
[13095.912687] Code: 6b14033f 540001ad a94707e2 f100029f (b8747b44)
[13095.914085] ---[ end trace 0000000000000000 ]---

Prevent that by taking the actual allocated are into account when
checking for CPER length.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/apei/ghes.c | 6 +++++-
 include/acpi/ghes.h      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fc3f8aed99d5..77ea7a5b761f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -29,6 +29,7 @@
 #include <linux/cper.h>
 #include <linux/cleanup.h>
 #include <linux/platform_device.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
@@ -294,6 +295,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		error_block_length = GHES_ESTATUS_MAX_SIZE;
 	}
 	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
+	ghes->estatus_length = error_block_length;
 	if (!ghes->estatus) {
 		rc = -ENOMEM;
 		goto err_unmap_status_addr;
@@ -365,13 +367,15 @@ static int __ghes_check_estatus(struct ghes *ghes,
 				struct acpi_hest_generic_status *estatus)
 {
 	u32 len = cper_estatus_len(estatus);
+	u32 max_len = min(ghes->generic->error_block_length,
+			  ghes->estatus_length);
 
 	if (len < sizeof(*estatus)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
 		return -EIO;
 	}
 
-	if (len > ghes->generic->error_block_length) {
+	if (!len || len > max_len) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
 		return -EIO;
 	}
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ebd21b05fe6e..93db60da5934 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -21,6 +21,7 @@ struct ghes {
 		struct acpi_hest_generic_v2 *generic_v2;
 	};
 	struct acpi_hest_generic_status *estatus;
+	unsigned int estatus_length;
 	unsigned long flags;
 	union {
 		struct list_head list;
-- 
2.52.0


