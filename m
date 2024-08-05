Return-Path: <linux-efi+bounces-1530-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A52947B4D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5798B28207C
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF1C159571;
	Mon,  5 Aug 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAfZaQZ0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C2158DD1;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862446; cv=none; b=P+VjyZqcrtW93kD1hQMaBXouR6UvAUJLxebiaAgDUC/W1KfXF9OiVDmeH6Ieq/3N+xfM+To8ivVP1c7ddOP0l1Gpgu4g0fgF3mFAPMU9p4764R1qipHc8HBmjbHzjnli3bGTN3lUVA2Y02XCyn8+a4FK9I6Dvb1vReSF0gZNEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862446; c=relaxed/simple;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTyHMTkLossnehHq3tORcwtBCag8MJ1DHheZCPtVpqLMMVNPIP7B6lioRIwipR1bB68/f2kErsudvM1vHPkLGkeaX6V6fHUHjy5Vq6ZH/wDzcwh6xocU3W2sAj3XOkE2o3taBojmZoaBA5Ks4oXsNZ6NsZ7ZZZR6WqY40dWofW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAfZaQZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC34EC4AF11;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862445;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAfZaQZ0Vn5qzLckjGPsL9rotdZ8LlyXljJ7tOpY0KqBYNt0oh5bbQrERNwE6Z/Q7
	 CmJiLpmZOsXWEbiXeuSVnHe6leWry6LueQgigkGH8JoLPv+k7hHgCAYOJrSMtFlnXD
	 /k3QkYTNCaOouZC/HDX0mxZifUfMAOGtYQhT/o/JEIH+Tb4cxVoY2EMA0gp9boxr8i
	 pJUjS1Jmj9VCJC2LCgRCe2kXFC99YBE2hkZjOLhlulhDepncGyok7PaeI+sSUbPTEe
	 BSijIxjXCezi2717N6f5XEBsFVauvAUzH2bA5F0rPQ003GYPknnF1x85Drb3LKpCs0
	 09adocDCXnxUw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1saxDv-0000000CyYj-3fBo;
	Mon, 05 Aug 2024 14:54:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/5] efi/cper: Adjust infopfx size to accept an extra space
Date: Mon,  5 Aug 2024 14:53:33 +0200
Message-ID: <a195912b70770982e099c5bd8ae9162c21eb7f72.1722861911.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722861911.git.mchehab+huawei@kernel.org>
References: <cover.1722861911.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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


