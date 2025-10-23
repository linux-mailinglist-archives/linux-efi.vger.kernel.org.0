Return-Path: <linux-efi+bounces-5104-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2218BFFE5F
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0BA44FA434
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F42FDC28;
	Thu, 23 Oct 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="l2TUuhMm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3F3002BB;
	Thu, 23 Oct 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207810; cv=none; b=r3jLUnhzeKSnpkiXWBWw8HyOUc/y4m9e06sV1nGEC7wG0t8Q2wZZEWUMoup8htxA8AqjX4U+S2RSmk5LCjB3Sqyk/Sbjj6++XTNGvO+47JvRn8UtUW4wQwcgj1UB+pNiVhiwlEwAE4APhvslx2Csf6tBdKd9vC7FhxXkEFnSf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207810; c=relaxed/simple;
	bh=v0M+YSnxkgvRtoMvqCVVkzehsdPEfV4jIca8cUpLxn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=midCmvm6ujUHytiFmlruqxXQhn/QPYHYItPcFmfV0sinmGXAnMuuNdWncRZbGWAVINmlEq4SpUL6yDvS6GMrpMkpnk5b2k7Q6pGLQ5MRXtDItZQk7XH5RqxkS3WOze0YUt8OAM1AZB4JAwVmAfA30OZWI9q1U2e/8svcw218llQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=l2TUuhMm; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761207725;
	bh=/ryGCoaa5Mw0tnHL+6AJfKDs1HN3Csc9peumNiIny3k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=l2TUuhMmJbcJDZfe+YXV3qhuj3YMlFIm9wf1gkEkNm+MXN+ItPw137za40aRFoDoP
	 5vG8sQD6fk4DGFhYOOsuA0WefhSY3EkvKLqcJKaHYjTdl9GwgQsBw2kPID/FcbV1Lr
	 R8d4qA6zoND/p4l83O66Pf2Pqiom4lvPM5/VuIqQ=
X-QQ-mid: esmtpsz17t1761207709t44688b9d
X-QQ-Originating-IP: x+i7FOkwA4c7J7VYbfCrjqnVkzs0wKgBvPuewy/Lez0=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 16:21:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7804790617074854445
EX-QQ-RecipientCnt: 6
From: Qiang Ma <maqianga@uniontech.com>
To: ardb@kernel.org,
	linux@armlinux.org.uk
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH 2/2] efi/arm*: Remove the useless failure return message print
Date: Thu, 23 Oct 2025 16:21:29 +0800
Message-Id: <20251023082129.75612-2-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251023082129.75612-1-maqianga@uniontech.com>
References: <20251023082129.75612-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MgRpQMLhR5LwNsRitc7y1SqH4bnZ3sJ504yZfnKpqJam2871zjeOMTrD
	7Br6iWKlNcaEraKyvyY8uYPq6KW605LVT72hrSTb2CgeuwFiW3mI6OaCeacx3fDLfBY5uzg
	qWzVynzPFdRt2zQorAmjMR4p8mZiK1lXZrkhDtI/TxCyq6KvqKrGAKvFXmQjMDc0Q77gMap
	pLQtwkppYGrn9xvnw6Fcpim+93vhTTML4Fb1WUSpQLu3EiaSgIVtBvq3opHejg+8WbPjHlr
	FYUgc1e86MFcKVjDsCRDlI97az6K8AcTmGPX5mIwmOlyMKtihDPgZUq377SePYoAvF0YHrF
	uCMWspyG4r5USmvfMSVot4UUGhca9bihFLffHNFFXpLT0lhWnMCCYs+INhWj8MY4Eq1W4aN
	PjMMzkqQ8KJZ67LGHkMPkN8X8ASPqUTNgWGCtNWKEI+2AfKcI/7TiGUYxfbOGCr5K8q4ORr
	j5bcWLb/Ca+yU91G0XRFkXjA22gKSxroem3gOTkJ3wxD35ZcH4SpZrXuJ31si50smWhjSTZ
	ppUZVign68nnNf9R8Np3XRX9tKtHMUSAXgIWSJTMr5n0/daG2IvtV2jGwM44EVRY+xa2zpy
	rNvC/CxKp8zvSjIY6L2+c0C3QV1ZQtjBVp5j86PUqXPJhOsABNh0Stbd8QgbJSQwRS5+ZDx
	QCCvYM53ZRINVtXhoFFo3xdVGMGt5dwjaFtD5hNf0dOU1K2A/c9rBbF8hSaNUSj5OgTUyp8
	KNKkfveap58uhZrApCNc0KxRP1fv34x6evKVuiZNBCHbcuWIQTTpTmg1hm+VJgk4MxK93vK
	vLQf7QWKFs7vdaTzJm7q0XJZPNqYdWXLZIx3KHSYm5nNrO1ZdhtC7s3QENAOVVnB2jkrZU8
	cfOtvyQII6FEl4l2cu6IuYYo9icT/aJXUP6HwoOGfUzzl/AfhsOtRPDA3Zpv6xPFuCafWMl
	Wuu9ls9FUXtdhUWCeWorqiJYzLl0pLvL72sgg/+0Mw1dszAKpgf9VkI4fl22aauxwdDMT1a
	QE40UH96RKD0BmjS5oMl7Eji72doK8x1M1pzRPVp2GPEW3wIPhjE80YOJ19DY=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

In the efi_create_mapping() in arch/arm*/kernel/efi.c,
the return value is always 0, and this debug message
is unnecessary. So, remove it.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/firmware/efi/arm-runtime.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83092d93f36a..ca27fbfaff5c 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -66,12 +66,7 @@ static bool __init efi_virtmap_init(void)
 		if (md->virt_addr == U64_MAX)
 			return false;
 
-		ret = efi_create_mapping(&efi_mm, md);
-		if (ret) {
-			pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
-				&phys, ret);
-			return false;
-		}
+		efi_create_mapping(&efi_mm, md);
 	}
 
 	if (efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions))
-- 
2.20.1


