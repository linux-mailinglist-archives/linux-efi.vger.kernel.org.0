Return-Path: <linux-efi+bounces-2199-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EAC9D8B03
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8771A28BB01
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9E1B87CA;
	Mon, 25 Nov 2024 17:08:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8F0178378;
	Mon, 25 Nov 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554489; cv=none; b=lIYzDMcNZE4g7VS8qPHPW2WfHyhMFYYxScvMv+0wA5R1hY8fy+LjXRVdSBXiAsBBSQ2VluRk/Ybx8CNoxzjw1CSZPI89/ad0hg3oa4FaIw5jPBbB3NJfYGcC2M8S7XAQ4vDk0243YmVDe3x3njFpEmgmsqZJbz6a0ICV1uWxidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554489; c=relaxed/simple;
	bh=3424XrNDWhSLfI4E6rsmyT346jVplrmlMEDJwjEtPJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1/YaVaM2r6D/Qp8ppl8zyQU0REeWAJkRxa+cjzoLfgvMVSqUgvxYBegHrVjJIXuWwRYyQVom5HlyvBeZM5rHYCzzRwWaDI6/uzSmFYISPtRz9VS9/NmjN0Ddjv9n4yVVM+75VT34URo4v7Oqu5NISkZUBx/08HKPD63s+EeHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA8C201B;
	Mon, 25 Nov 2024 09:08:37 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C30793F58B;
	Mon, 25 Nov 2024 09:08:05 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: ardb@kernel.org,
	broonie@kernel.org,
	sami.mujawar@arm.com,
	sudeep.holla@arm.com,
	pierre.gondois@arm.com,
	hagarhem@amazon.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with force
Date: Mon, 25 Nov 2024 17:07:58 +0000
Message-Id: <20241125170758.518943-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125170758.518943-1-yeoreum.yun@arm.com>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
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
 drivers/firmware/efi/libstub/fdt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 6a337f1f8787..27291ef7c773 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -231,6 +231,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	struct exit_boot_struct priv;
 	unsigned long fdt_addr = 0;
 	unsigned long fdt_size = 0;
+	bool acpi_force = false;
+

 	if (!efi_novamap) {
 		status = efi_alloc_virtmap(&priv.runtime_map, &desc_size,
@@ -241,13 +243,17 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		}
 	}

+	if (strstr(cmdline_ptr, "acpi=force"))
+		acpi_force = true;
+
 	/*
 	 * Unauthenticated device tree data is a security hazard, so ignore
 	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
 	 * boot is enabled if we can't determine its state.
 	 */
 	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
-	    efi_get_secureboot() != efi_secureboot_mode_disabled) {
+	    efi_get_secureboot() != efi_secureboot_mode_disabled ||
+			acpi_force) {
 		if (strstr(cmdline_ptr, "dtb="))
 			efi_err("Ignoring DTB from command line.\n");
 	} else {
@@ -261,7 +267,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,

 	if (fdt_addr) {
 		efi_info("Using DTB from command line\n");
-	} else {
+	} else if (!acpi_force) {
 		/* Look for a device tree configuration table entry. */
 		fdt_addr = (uintptr_t)get_fdt(&fdt_size);
 		if (fdt_addr)
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


