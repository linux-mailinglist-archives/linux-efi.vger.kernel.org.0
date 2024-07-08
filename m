Return-Path: <linux-efi+bounces-1376-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594992A0E4
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04656283041
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4CB7E766;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7WLQ8y3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8F7D071;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437554; cv=none; b=e016QIZA/AeCOhB4K8l+7ZytiOppgatTcaLcdW48cGPDxZpoIFkTcfwkLFTjzxR/t1PTcvmJQyV27KEYR5Payi/as5pyaMuPV027S9QXfheGVlYHF56Pw2Qvn+nlqFn45uf7FJl9uTOvBIoh7neh+jCwhMs4ASh6SWWUJQaliqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437554; c=relaxed/simple;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKaFZb7nPaCJ2bK0us17fIg1MPn/jMhVkTTS4/JiP8eQlof9s7IrlAQPRz3RULfq+NRU3aSrsTwEK2By7h9j5/YN4pgsG4MijxxSB78jY7qAZnEwsuowsip1z/VgNec6jEcPd6eWFSF57jkpPNrkH3OwnaRZDm0Jz2+mo5OItSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7WLQ8y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C582C4AF0D;
	Mon,  8 Jul 2024 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437554;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7WLQ8y3V6z35YgPXrUddX2093d7ag6CcVlwWEHIs93bLNTIMgKtd9532Co8hkIMf
	 tFEIfalAYtwVOSydYXrinjxrIIM3jecLhvqVseWPYVXpCvQcJe1UkBb1WGRtSFNM3a
	 gKXoBHKoBmiON4k+MVvnvUlEfydjlpdAKqOBwVxQVj0XnsOymexP3/cdSkHapNW51i
	 PG15i0P8XQxQtpVjXE1sz4vMvUb1f8i5A//Qwlezy9Y55Ka6J9qiw8Uq7OnQ0EfOTr
	 MQiJnGxKHTKptsT1ecl6Ad9/+vhIIbV3rh6hShZtGmzCHo5GZCIjSvssjEXAc86hlQ
	 zV0cmHSkatvyQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sQmOl-00000001SQf-2UoA;
	Mon, 08 Jul 2024 13:19:11 +0200
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
Subject: [PATCH 3/6] efi/cper: Adjust infopfx size to accept an extra space
Date: Mon,  8 Jul 2024 13:18:12 +0200
Message-ID: <020925baf424b46adc350c14584f4ef609613c5d.1720436039.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
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


