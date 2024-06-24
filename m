Return-Path: <linux-efi+bounces-1286-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21848914615
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 11:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EE51C203B9
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C41304AA;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSOfEdae"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABDA2C95;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220790; cv=none; b=bjirFwS+tigke7ugxTlyuM28ROM48L7e8GNZ1jOxXQ0Jc4lds6v392S4fOn0FUbEzwkftDDvz0GUyg8vjEwUiY9zRVWKhh35/WyfbzFrXh7ZjQ3Cg+uNmQ34FN2j9TtWscmQ/NgxCi0DMjmbKiyaJosiD8T1+ZQqdmTaUU7lDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220790; c=relaxed/simple;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aG9kZcpI12kkFV4EG8g2apUx3HcZDzdeH2ybDsp8CPuUnCZDCRJMK4kDR4YKX9uq4RdbvvjQFRN/LFzgS8h2Fb8eKKt+EXNfbBL6e3/txaIltEYsDGMr3FgZnoyFvgq0jImc9o5cm/0oRhw29chHMtMb1Nv40UhRwjzckGHkJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSOfEdae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060F8C32781;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220790;
	bh=LayJjNlHt7RdDKs2eSpJizuqfyzjoPSkSmmLznNH6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSOfEdaeKFIRCtOcdsfBo0VpFuDm9gEnDpyYbJbvxYqEsZOshyZwigQbbgx7fkDyo
	 R15v3iGvG2UY8qSObyAJFfabsuSv47Hc8VKPSVQlL9LAxuG0gQr5Gu15h09vmIEJqT
	 ehbqkKCy3EluS20YRYIWsZTF+h59YrGBzR5pjPkd2YIdl/C2meL9fEW85CnB4EBTY1
	 jVLSCrgP1drLQKynDf+1UPZ4Ah/WAsEWbKcy6Jq0lXpn81py2ENpCgywt5zLglGTZY
	 zrEr5Dw1CiQMAVbw8e+JsyUT36QxJF2NvppmGEbQj5INFACjDIzDh3cQqOBekt0ZBi
	 gGNpyPEw+f6XA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sLfrX-000000085bf-1gZ6;
	Mon, 24 Jun 2024 11:19:47 +0200
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
Subject: [PATCH v5 1/4] efi/cper: Adjust infopfx size to accept an extra space
Date: Mon, 24 Jun 2024 11:19:18 +0200
Message-ID: <665a5626bea1c13538fef09d2120343eeae04553.1719219886.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719219886.git.mchehab+huawei@kernel.org>
References: <cover.1719219886.git.mchehab+huawei@kernel.org>
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


