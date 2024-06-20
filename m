Return-Path: <linux-efi+bounces-1257-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9C91106F
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9501B1F22908
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7231BD8EE;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACl5tPnt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622531B4C3D;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906515; cv=none; b=cYWn8WUx0rxN3WFPRGAW3W/3Hfp4ATwjU2pazrHTWM6HDc+9JuB7nL0hHGeADJDltlLAE6dQlhrWmGFhldH78E9uGwV2nMVQc2KRlQ5PH9QkXsqsrP070X/ZYaggnpPpElQyl2a9mpky17og9cmCcakFnfRgUwtx11+CKo8v6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906515; c=relaxed/simple;
	bh=RMYZrT95nApMxsG7y6LLT3Z2HeuOH/cK6XfnlqABCbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeIVfhRdY6lkFtgG9jOjUYDclyOBXjAldgbcvziWJgJOybRyZHZgQoYZ2dl0xU5XSgZyeC1R8SUXzZ3PkhUkJ7Xck7WF1PyriighWETQAf6uNEIwk5wpBqfEw4TB2kcklRHY7LhCMoiE9DiIJEEWWgflby7lajfulujh09Ys2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACl5tPnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD06C4AF07;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906515;
	bh=RMYZrT95nApMxsG7y6LLT3Z2HeuOH/cK6XfnlqABCbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACl5tPntUOAMvhb3Wa2wWXsBJIL7DH7NNRcjUO9dEq0twiuwyL0ZrRdp95iWA6MR2
	 LSlQ0XMFAfETA5bqERl1jwx1QSlLIGfQm2UBIs1sk1yQ3ttFbH1bdDiY9xmvzaMeTz
	 kkC06dSLZokTiJcHgObwWjgTC/8hXq3QOlFsdpLJyxDuNWBM8tBQoVd6jJ9ZosxxTj
	 NmLsXB/a/yZioAkcFiBoUk6kQWKuc3RbZwt+ptsecut+u5lu0PKzAoKP6Fdo5rvJce
	 n9SxwdqjalM3MuI5gVOSoKlB3Vg0W6LP5Aygifd82eQYin1ugjHF4OSpuoyU/l95wH
	 OMI5QhiNeiiPQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sKM6a-00000006MRi-0wMY;
	Thu, 20 Jun 2024 20:01:52 +0200
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
Subject: [PATCH v4 1/3] efi/cper: Adjust infopfx size to accept an extra space
Date: Thu, 20 Jun 2024 20:01:44 +0200
Message-ID: <a8cfcd9e9827770de748db7be44362a98c957642.1718906288.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718906288.git.mchehab+huawei@kernel.org>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
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


