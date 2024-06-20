Return-Path: <linux-efi+bounces-1252-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D2290FDDC
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 09:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43830B212DB
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2E4EB2B;
	Thu, 20 Jun 2024 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE25zTHQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710E4502E;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868863; cv=none; b=hEP33tDuhWZQHKfEu5v/hS9QrX3Ok0KrbYlqKgYvXy3vXPdIQ3qhQzL4mW5gcLvSGWtpNe8Wcjyp0+uPEhsdtqcoMe3YNsa4UMlzCZtUIwSPZBHcgq40EQeZps/PTUv42udrwoCU2A5JyHsiij0uZqICDzm+Z5H8g/Y1YPMu7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868863; c=relaxed/simple;
	bh=RMYZrT95nApMxsG7y6LLT3Z2HeuOH/cK6XfnlqABCbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2tIKeN8518yJQLF8lNDgdBuqaTGvim5HBU6b8Y+tG8d4Z/ZNwIObJX/wYhnN/ToQ1kbkq7cCNBXKSwZiXlFYx6qMliQe73m80XBkTtsdtFEUCXFBG5Cw8sO8JOwlMF0FHCu6wJHT/er7dO6rtRNJzxZyno1AYKtvaGoe6f2D28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE25zTHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAAAC2BD10;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718868863;
	bh=RMYZrT95nApMxsG7y6LLT3Z2HeuOH/cK6XfnlqABCbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FE25zTHQi4ytQKbeZMcrPyKDIkmSCxWXkdHSz5nhoD+NRAOUeXHh2buaVpW6QyL4y
	 gjyMs6csXBjTOtozo9VL5o5bNvsyheSbSym43QD0IiEXcep9cVcFMd5p72UqeL0ikP
	 SpLoteCfqEWefBWarw/72v1dzhvULaEdpSRuQRD5SV+yEE0O1VsALy2Pfe+S/IitWt
	 pMqDxsKQaSkwEJxYWaOel5iFQwnCusLPv+ryZumD/dbt0+MAlWWYVZQK4BHDxdknOR
	 7KCf9URhptR6CFaajeKqfajZJFOV34kYbB3VnJFiZel+iJW8+mFuBFbzfv7HR3SV5n
	 ymOLbXpH3SFSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sKCJI-00000003c03-3Q0c;
	Thu, 20 Jun 2024 09:34:20 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	"Tony Luck" <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] efi/cper: Adjust infopfx size to accept an extra space
Date: Thu, 20 Jun 2024 09:34:12 +0200
Message-ID: <a8cfcd9e9827770de748db7be44362a98c957642.1718868693.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718868693.git.mchehab+huawei@kernel.org>
References: <cover.1718868693.git.mchehab+huawei@kernel.org>
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
---
 drivers/firmware/efi/cper-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index fa9c1c3bf168..d9bbcea0adf4 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -240,7 +240,7 @@ void cper_print_proc_arm(const char *pfx,
 	int i, len, max_ctx_type;
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
-	char newpfx[64], infopfx[64];
+	char newpfx[64], infopfx[65];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
-- 
2.45.2


