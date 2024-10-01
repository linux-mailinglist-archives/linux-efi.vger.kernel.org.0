Return-Path: <linux-efi+bounces-1860-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8DA98B2AC
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 05:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0CF1F21DE7
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B1171E69;
	Tue,  1 Oct 2024 03:20:43 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552A24211;
	Tue,  1 Oct 2024 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727752843; cv=none; b=ibCGysEJ7BIzbuXXys6nMqxw755ABy3LxJe5MJUQZ9KoTN7tF+RtCRVjtgbr6PwS0PaqisGgQzT7Ob3r+MOK0xMu40Y/6ta1bHvnj0YNW2UFjR86Rc9/7n4ATnqiF6cxvPiL4taI7FOO/IshXxTBmD53N51Rad96AXWXRHWwxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727752843; c=relaxed/simple;
	bh=p7OHM1nbg/aKAZsH49mg1d+8854HCwiiW0Huzc1pSrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FomG223v4KPi5yV1+fWJDim2ZdPHsW6hVJRXKNwiRzrE8Jl1drvu1Bx4KQLQbzOYuy7oBHA1VnJ6cYLHBcc13FGr41ezswdBF+iXddeP5JnD4SNnYwAshjqMB+MNaeha766XQKsX47EdfDWlq8woKaPomqMu2B1xm7Ffg0QTmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63BB9367;
	Mon, 30 Sep 2024 20:21:10 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B36A63F587;
	Mon, 30 Sep 2024 20:20:40 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-efi@vger.kernel.org
Cc: ardb@kernel.org,
	bp@alien8.de,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
Date: Mon, 30 Sep 2024 22:20:28 -0500
Message-ID: <20241001032028.483199-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the initrd is only measured if it can be loaded using the
INITRD_MEDIA_GUID, if we are loading it from a path provided via the
command line it is never measured. Lets move the check down a couple
lines so the measurement happens independent of the source.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815f..555f84287f0b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	status = efi_load_initrd_dev_path(&initrd, hard_limit);
 	if (status == EFI_SUCCESS) {
 		efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-		if (initrd.size > 0 &&
-		    efi_measure_tagged_event(initrd.base, initrd.size,
-					     EFISTUB_EVT_INITRD) == EFI_SUCCESS)
-			efi_info("Measured initrd data into PCR 9\n");
 	} else if (status == EFI_NOT_FOUND) {
 		status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
 						 hard_limit);
@@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	if (status != EFI_SUCCESS)
 		goto failed;
 
+	if (initrd.size > 0 &&
+	    efi_measure_tagged_event(initrd.base, initrd.size,
+				     EFISTUB_EVT_INITRD) == EFI_SUCCESS)
+		efi_info("Measured initrd data into PCR 9\n");
+
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(initrd),
 			     (void **)&tbl);
 	if (status != EFI_SUCCESS)
-- 
2.46.1


