Return-Path: <linux-efi+bounces-4605-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62386B346B9
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3E202417
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E72FFDD2;
	Mon, 25 Aug 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="c711gE2+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92635965
	for <linux-efi@vger.kernel.org>; Mon, 25 Aug 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138045; cv=none; b=Rz8fiCWZDSi5egq0vvBPLUDl92JdktwFpG/tS0QBgUaIs+VmbCvPUcewbirL6fuhfK8rikoEsnBQKVWF8y3vsIyBT387okbnOfi68iznn4a801pamBZt0/VeRT+HoiY8I7hvtvP3oZMPS6vnYiSf7UHVf1PQemJRgktvaf04qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138045; c=relaxed/simple;
	bh=afEhyXcerRxJ2pUFrVuQ80HLCcLlpdreIpO7q+Efovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8YtXcLxHMjHllPN9O6ZUyrRgFSruEnhFBRG7/qndh+8mDwGfGLyaOBApDvmmY8eDsBVRFQsv1Ah2+3/m+LxcqILX4VzCUQ8QbMwEm51uTCkTZQNXut8O9/ZiLD8AOLRaDmJs9xQLMh9veFdwozm5bR7+gGURkYONfxJCEiR5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=c711gE2+; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250825160714777ffac40f5057ca9c
        for <linux-efi@vger.kernel.org>;
        Mon, 25 Aug 2025 18:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9B4yx0Y9gMLMy4+y7N4u4X2Mzh1VO2RHXLHiQLJZ9As=;
 b=c711gE2+yk5VvuqNyfW5+c93AyfEngpAFlCfSD+E+ScuDPwn3hmycBW4iCYp0zruY2NDgR
 nv9RDpwfMdm1kAdbkbK/liXhxAdYHMr8YY2GhfiZxU80J2YziGW/qSgYc8tR4/PObW6KOPew
 +RcCq5RfN//bNAZvobQG46cSdVDNMOPcPFxO1uMAasYCIZhokQcW9crie6+VUaculL1NVes9
 Ek+YCHNYBOmxH9l2+FwMK+6vOVdbsgRivrLpeo+HT5+Wu/sypnSjzROevetCKGNNmisiA2oY
 c2F8tvO48r1etP7vs5Y22gtuwGBFkewB6kt+sNeAHZWeDnC7YYMYg+kQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v3 4/4] efi: stmm: Drop unneeded null pointer check
Date: Mon, 25 Aug 2025 18:07:13 +0200
Message-ID: <b273210fea6dfe139ee5457f3769afd535c184e5.1756138033.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756138033.git.jan.kiszka@siemens.com>
References: <cover.1756138033.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The API documenation of setup_mm_hdr does not mention that dptr can be
NULL, this is a local function, and no caller passes NULL. So drop the
unneeded check.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index c2bc8467b099..65c0fe1ba275 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -185,8 +185,7 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func)
 
 	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
 	var_hdr->function = func;
-	if (dptr)
-		*dptr = comm_buf;
+	*dptr = comm_buf;
 
 	return var_hdr->data;
 }
-- 
2.43.0


