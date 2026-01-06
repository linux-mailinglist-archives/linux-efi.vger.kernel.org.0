Return-Path: <linux-efi+bounces-5942-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46A1CF7AAC
	for <lists+linux-efi@lfdr.de>; Tue, 06 Jan 2026 11:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60585300C5E4
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jan 2026 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730E30DEC0;
	Tue,  6 Jan 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K80Cixn4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BA1E515;
	Tue,  6 Jan 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693710; cv=none; b=ProMaKI6OhJBtS9H6V4rWvxFgsU4JF2eSeWexTTGaleWQV/Bxv+JoJhye8h3t7jkoM4QqYU4aDIEv0AsmILmChSsGLqpuQ7y2JPk2grxzspolfz78LSC6R7uzE6D53JFv9UF6Caa3HG1ToyfVylZQ5BZUF0KCcm8nK6k/q4NuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693710; c=relaxed/simple;
	bh=q8mFlp+bD20oQpXP27iO1F9y1ja315WcWvYnI369uAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a543JSlu3NLui6ma0uP5KQVjCPI2+ncXJkeuajiIAQSY+D9/H8yldMa1EoOlKpXwVmyoSYHiGIuz8CUgCApiI0bQ6TVnIU/KLTL9e8Oe54cekQ7mzsY4wd9a9vU20EJsVDNJgpkJugG9JBOpkp2yetNVPkDtFj/VyZFiaonrMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K80Cixn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B58C4AF0B;
	Tue,  6 Jan 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767693709;
	bh=q8mFlp+bD20oQpXP27iO1F9y1ja315WcWvYnI369uAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K80Cixn4Z56wRQcOua2QaSeVwjW3wZE0rlkSujXYt6MTjHJ42MVFqeIL/JWVZd2YN
	 jftXumqi6maBTzIEHtnGInc5Wiu7mLAFozv28LIIu18XQqIL0TPWDCK9BF02t2Y1tm
	 M+hmneU/DvRg8lnN6FBY7KFqQM4nFtZd/YvpAJW+VJIUxpWqTErS+Hds+DOVaG9cgm
	 Hc8FGwXVWHMR+bdaDbXPvxoN9X3+JhNAaGTnvAsrwTm1SydfJE38sRsu5joQRhGcHK
	 JnMb4UxRG32YP3nYNGOO5WmVPWxG4HIBOu/EBa+ou6Ro511u1ho8PHACwxwBGEhqe7
	 5Zt8AVdzIV9sA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vd3sq-000000008ZU-0DvN;
	Tue, 06 Jan 2026 11:01:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] efi/cper: don't dump the entire memory region
Date: Tue,  6 Jan 2026 11:01:38 +0100
Message-ID: <b61e02066490e64543db9564f1a97c2a0113dea5.1767693532.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767693532.git.mchehab+huawei@kernel.org>
References: <cover.1767693532.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The current logic at cper_print_fw_err() doesn't check if the
error record length is big enough to handle offset. On a bad firmware,
if the ofset is above the actual record, length -= offset will
underflow, making it dump the entire memory.

The end result can be:

- the logic taking a lot of time dumping large regions of memory;
- data disclosure due to the memory dumps;
- an OOPS, if it tries to dump an unmapped memory region.

Fix it by checking if the section length is too small before doing
a hex dump.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/firmware/efi/cper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 88fc0293f876..0e938fc5ccb1 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -560,6 +560,11 @@ static void cper_print_fw_err(const char *pfx,
 	} else {
 		offset = sizeof(*fw_err);
 	}
+	if (offset > length) {
+		printk("%s""error section length is too small: offset=%d, length=%d\n",
+		       pfx, offset, length);
+		return;
+	}
 
 	buf += offset;
 	length -= offset;
-- 
2.52.0


