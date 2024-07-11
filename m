Return-Path: <linux-efi+bounces-1416-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFF92E022
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE6D28356D
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957212C482;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6p/fCI1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4D79CC;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679469; cv=none; b=GgEyQfWxfS5OoHnGBvHyKgVRfw5/y+6S70f5yKiq0A6/TbRLrdQ55RDlNnPXJTFqv91V7lQ3IGzw4JR1szZSaqN3TC5lKT3ag/IYfmET0t2Eh+2vkPaYDU1KxA5vOLd8YFfp4egH/Et4X2eNOoyS30aYbqNGACafQ6C5mNhft+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679469; c=relaxed/simple;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChSr/osEPT+EY0Cvst0Gu2ylDZ0Wxp81W+ionW9PP8agGym6Eiec67NZCM7bhLQkxnAXLoPY3f5jX2O9SQy4k7FFpIELJTFLYQmLeRDZcpMXe9IOizdzfBb181WwLOPdrIUYh4By4wd4G5nBbrChd5eYQ9U35YkkFpYwmtoFHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6p/fCI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E607C4AF0B;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720679469;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6p/fCI1Xwjdz9VtJR5h0uLoLArpORl2wmbBdel2djAHQ5xla9ppGAZs6asRBdN+R
	 BJRECSj7KTS1v6zaB11YhhnxNY9CKax3VeLz34/lM+crMM5pMRg+R7OF3UORAaOdUT
	 Xl4mceFzcjqz9X2rHhLBFm/qx4qJYIIydUjQqmKOK0CpXIRXXSSvVZyRyUfhbMpwl7
	 yyBB4qQ7sIO7Tg/DMEpr6uwA2YKY4GVRTgLjrst/MMKd+OpLHBQiYJHLSJpR1gdNm9
	 5RD5vwYWyu2+eymXAJ3CPA9lmaUFoQYqJqy9yy7Bq5aTFG1yAdmTvqfY3viwDzOch4
	 99fSeYtMJ9nDQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sRnKc-00000002b5U-1F3c;
	Thu, 11 Jul 2024 08:31:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Ard Biesheuvel" <ardb@kernel.org>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Len Brown" <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] efi/cper: Adjust infopfx size to accept an extra space
Date: Thu, 11 Jul 2024 08:28:53 +0200
Message-ID: <11aa9d2944bdc9b21ce7af7599bef431ccce508e.1720679234.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720679234.git.mchehab+huawei@kernel.org>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Compiling with W=1 with werror enabled produces an error:

drivers/firmware/efi/cper-arm.c: In function ‘cper_print_proc_arm’:
drivers/firmware/efi/cper-arm.c:298:64: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  298 |                         snprintf(infopfx, sizeof(infopfx), "%s ", newpfx);
      |                                                                ^
drivers/firmware/efi/cper-arm.c:298:25: note: ‘snprintf’ output between 2 and 65 bytes into a destination of size 64
  298 |                         snprintf(infopfx, sizeof(infopfx), "%s ", newpfx);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As the logic there adds an space at the end of infopx buffer.
Add an extra space to avoid such warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/firmware/efi/cper-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index fa9c1c3bf168..eb7ee6af55f2 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -240,7 +240,7 @@ void cper_print_proc_arm(const char *pfx,
 	int i, len, max_ctx_type;
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
-	char newpfx[64], infopfx[64];
+	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
-- 
2.45.2


