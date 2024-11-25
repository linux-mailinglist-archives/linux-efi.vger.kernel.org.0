Return-Path: <linux-efi+bounces-2195-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B813E9D89D4
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5815EB4457B
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767AE1B218B;
	Mon, 25 Nov 2024 14:59:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75971B392F;
	Mon, 25 Nov 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546740; cv=none; b=Ev1mGYkwIL86RxhZX3h0cCu3YJdsFNvKVpkMuYaidkFH7N8ztvrPxFTEbL7zd2ZxNrCUJHkLCVoskMrJ5MOsHFLTfI2ntin9v74Q9YzN761IwTTbdq+MEwByoDd/mJM5VioLNDrb05VhjYt21bqmAlJVsZNhyXBTQNcGvZtb4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546740; c=relaxed/simple;
	bh=EnxfkDi1o451pXgC0VJbjAxUeFNMF5XcVW/NFN0caOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPb7aDN5X8+0HvUijtTScnpNfEUZQN0ycMjeGbVxf9nEcP8yNNYhShH9VvaySpxrljmrq4NBkDBFPxl2mtxnWLHSLNqarlqAnSVrf5EfUvVR0slzvprnfVMWnZS1sA7+D08Xi9LNn4tx/FMKFFhQAM5l0K2FyowjlJMoOMOOEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 404C3201B;
	Mon, 25 Nov 2024 06:59:28 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E27E13F66E;
	Mon, 25 Nov 2024 06:58:55 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	sudeep.holla@arm.com,
	guohanjun@huawei.com,
	gshan@redhat.com,
	prarit@redhat.com,
	Jonathan.Cameron@huawei.com,
	dwmw@amazon.co.uk,
	ardb@kernel.org,
	hagarhem@amazon.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 2/2] efi/fdt: ignore dtb when acpi option is used with force
Date: Mon, 25 Nov 2024 14:58:48 +0000
Message-Id: <20241125145848.506347-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125145848.506347-1-yeoreum.yun@arm.com>
References: <20241125145848.506347-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since acpi=force doesn't use dt fallback, it's meaningless to load dt
from comaand line option or from configuration table.
Skip loading dt when acpi=force option is used.
otherwise it could produce unnecessary error message
while scanning dt if passed dt's format is invalid.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/firmware/efi/libstub/fdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 6a337f1f8787..04a054393d87 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -251,11 +251,13 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		if (strstr(cmdline_ptr, "dtb="))
 			efi_err("Ignoring DTB from command line.\n");
 	} else {
-		status = efi_load_dtb(image, &fdt_addr, &fdt_size);
+		if (!strstr(cmdline_ptr, "acpi=force")) {
+			status = efi_load_dtb(image, &fdt_addr, &fdt_size);
 
-		if (status != EFI_SUCCESS && status != EFI_NOT_READY) {
-			efi_err("Failed to load device tree!\n");
-			goto fail;
+			if (status != EFI_SUCCESS && status != EFI_NOT_READY) {
+				efi_err("Failed to load device tree!\n");
+				goto fail;
+			}
 		}
 	}
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


