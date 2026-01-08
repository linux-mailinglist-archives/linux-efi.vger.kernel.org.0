Return-Path: <linux-efi+bounces-5959-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26530D02A98
	for <lists+linux-efi@lfdr.de>; Thu, 08 Jan 2026 13:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF4FF3014D15
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jan 2026 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F04AA349;
	Thu,  8 Jan 2026 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds7h8aNG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB94AA356;
	Thu,  8 Jan 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872137; cv=none; b=H+ovyWEt+VPmpj35b1cEyjBmwt4XDmTS/5yjCBKl3xKjsQntpxpPOexICEojpNnRRps7fl7U1+FspBz2bmlvBNxZz/FCxJFlJDRwq8wL7kbBoDVaAqIoF+ZP5d76A/9v/RWrg1NL7eAPTx3SfBSBePYeSC9Jv8bawEJuV2j2HQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872137; c=relaxed/simple;
	bh=UsLabrNWxxt0g8jgL/ao4xZ1pvqAdssx0fpURxqyV/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkdaShYxXwiI4Kml1duvQ8BJ2kur0bbJfRtfF6l1uO08VNIjNa/jcvJSkqp5fhnhcLxOQDf4mLrvKvdF1uE8OXtV00A19xwOORarnxNkxasyugM8WFt46pjHnui7b2/pt+pa1+C+nbBPSdbxk8UNUtaf6/TuUbLE6nGvZc+tdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds7h8aNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AF2C116C6;
	Thu,  8 Jan 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767872136;
	bh=UsLabrNWxxt0g8jgL/ao4xZ1pvqAdssx0fpURxqyV/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ds7h8aNGUtynDJd1T9e/SEpaWg3OB/3N4AT/40HuDCCMCkKXTkjBOftGUZaAEaQU8
	 HDVJ8ByRvKf/KirtpMTvOVGhFIauUYVEPOoBL83ovLMsGvqICbl+htLZs5gk94jWd2
	 RsozKaQdGSI1p+mex9ukCYROSQYeRTBVzLf7OWMJKxdxZCQB84Hin+hcok0vK1ksgn
	 Js/VbE5BQrHkrtlSWU972pxxVTof7CKiO+Pcsp4b26b2BgnHcJepEB1fNNPDvJxlv/
	 tGMU3U1DlVsM9dWzfuKU/v4kNvahQcdiiTh3by5tmWpgyX4J0UukLmW7JZBKo4V54r
	 X9Y2ODk5CnM3Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vdoIg-000000033yG-0Bue;
	Thu, 08 Jan 2026 12:35:34 +0100
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
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 3/4] apei/ghes: ensure that won't go past CPER allocated record
Date: Thu,  8 Jan 2026 12:35:05 +0100
Message-ID: <4e70310a816577fabf37d94ed36cde4ad62b1e0a.1767871950.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767871950.git.mchehab+huawei@kernel.org>
References: <cover.1767871950.git.mchehab+huawei@kernel.org>
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

    Unable to handle kernel paging request at virtual address fff00000f9b40000
    Mem abort info:
      ESR = 0x0000000096000007
      EC = 0x25: DABT (current EL), IL = 32 bits
      SET = 0, FnV = 0
      EA = 0, S1PTW = 0
      FSC = 0x07: level 3 translation fault
    Data abort info:
      ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
    swapper pgtable: 4k pages, 52-bit VAs, pgdp=000000008ba16000
    [fff00000f9b40000] pgd=180000013ffff403, p4d=180000013fffe403, pud=180000013f85b403, pmd=180000013f68d403, pte=0000000000000000
    Internal error: Oops: 0000000096000007 [#1]  SMP
    Modules linked in:
    CPU: 0 UID: 0 PID: 303 Comm: kworker/0:1 Not tainted 6.19.0-rc1-00002-gda407d200220 #34 PREEMPT
    Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
    Workqueue: kacpi_notify acpi_os_execute_deferred
    pstate: 214020c5 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
    pc : hex_dump_to_buffer+0x30c/0x4a0
    lr : hex_dump_to_buffer+0x328/0x4a0
    sp : ffff800080e13880
    x29: ffff800080e13880 x28: ffffac9aba86f6a8 x27: 0000000000000083
    x26: fff00000f9b3fffc x25: 0000000000000004 x24: 0000000000000004
    x23: ffff800080e13905 x22: 0000000000000010 x21: 0000000000000083
    x20: 0000000000000001 x19: 0000000000000008 x18: 0000000000000010
    x17: 0000000000000001 x16: 00000007c7f20fec x15: 0000000000000020
    x14: 0000000000000008 x13: 0000000000081020 x12: 0000000000000008
    x11: ffff800080e13905 x10: ffff800080e13988 x9 : 0000000000000000
    x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000020
    x5 : 0000000000000030 x4 : 00000000fffffffe x3 : 0000000000000000
    x2 : ffffac9aba78c1c8 x1 : ffffac9aba76d0a8 x0 : 0000000000000008
    Call trace:
     hex_dump_to_buffer+0x30c/0x4a0 (P)
     print_hex_dump+0xac/0x170
     cper_estatus_print_section+0x90c/0x968
     cper_estatus_print+0xf0/0x158
     __ghes_print_estatus+0xa0/0x148
     ghes_proc+0x1bc/0x220
     ghes_notify_hed+0x5c/0xb8
     notifier_call_chain+0x78/0x148
     blocking_notifier_call_chain+0x4c/0x80
     acpi_hed_notify+0x28/0x40
     acpi_ev_notify_dispatch+0x50/0x80
     acpi_os_execute_deferred+0x24/0x48
     process_one_work+0x15c/0x3b0
     worker_thread+0x2d0/0x400
     kthread+0x148/0x228
     ret_from_fork+0x10/0x20
    Code: 6b14033f 540001ad a94707e2 f100029f (b8747b44)
    ---[ end trace 0000000000000000 ]---

Prevent that by taking the actual allocated are into account when
checking for CPER length.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


