Return-Path: <linux-efi+bounces-5103-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62FBFFE50
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0497E1A606CF
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677D2F39AB;
	Thu, 23 Oct 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="e+xmSc6p"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097552F5A28;
	Thu, 23 Oct 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207800; cv=none; b=aKD4NdyGDv8Vs7irJ8bXArgSGK0u73KWfnt/NQ8yFk0y+3K5cOWKFZwwBrW8jivJ7liuJtmhTcnpVp20f886APhnZmk5joTZbVDFByzXcl5KQoix/5b5tHa0pg8fb7O9ViYqzKSWew4R3dgBbjdmF2JeH7W2abbCikurLOagc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207800; c=relaxed/simple;
	bh=H15MGilINUfkYiEn/AYzaZ8bF9e2evKnMaqmUevzPoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClikjV8tFbYn1P4wxXYxTzaagp+kR9clv7JFtqqwCY/Rf81e9B+xzpzQpghth5AOIlV9/EJRLJJD4pD6R0t7UZsCVZC6YcWAb3RCSSqRhHhQ2fI7piVudyFdODJQC2FR98gfq0l4BtEH2Z9+rRTDkJIV1qBooJ10HvlpzBtyfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=e+xmSc6p; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761207714;
	bh=nuVu2NCjXz8jJvEP5g+aU1zoPZ/sRqG0jqru7JqmYI4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=e+xmSc6ppvLF3/VKA+x5CEzBloM18OPAaSzq1JM6JYle0QY+bpB4hFL/8qtZPjJkP
	 3zFqizfiytQW3t2bHiagDpphH1tgPAhvdg5giOMIBsvOTKvpHmObTCjjQNlWasHFbE
	 trdg0jf79LRHBKN4YeqLH8AvDCJ774I2ZXvw7QH4=
X-QQ-mid: esmtpsz17t1761207696ta4c5843b
X-QQ-Originating-IP: 3/MQeF6QIz9mC8m2fmz4QH6lhabTcyDLi834ZS1yOiU=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 16:21:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15809968397798270910
EX-QQ-RecipientCnt: 6
From: Qiang Ma <maqianga@uniontech.com>
To: ardb@kernel.org,
	linux@armlinux.org.uk
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
Date: Thu, 23 Oct 2025 16:21:28 +0800
Message-Id: <20251023082129.75612-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MQPu5pFEJFN4FC2AxXnYnFS0c+i/12zWXtVC++pynRPaul1YR/aSHjog
	V7wYG4Siaxxh7IHCvFd7INhHxNBkEVl6i0RkcProFRYetQH4jx4iYgxdhzh4hau4zF6W4MV
	/PMTVrmrsyy2qhbmWVB8eawBF0dNlJea7YL0im+V9UbYAv3ugz2jA/kTl5sapKOOskoQ8NP
	2SIfKt9+7pixdG3ABms/7sU+PpK6ea2H3D3LQZp7W6/qRouLXAZ+edRjWQDrkw9vREmSEUd
	u1O4Xdc6Z6FjqdxcbrGvjs1fPfY3eAoX9m4B7nWPL7/ib8niEIowmDhddjgGQICmMuExSZD
	FFWQMpTqKNFZ+W3aTY2IA0Es1Bt8XM4OE2l9ROzSYUnMmEdWcoMFkuNfss/Y1KE6rYw1jIk
	16eg3m9gc0ICARdYuihrjZgzpRqVrH74ff9OfnO+y5eNsjkphOtFrjAS/JBJNYyThL8fmtw
	zpxKGDiGkzCtmf2G/1t+NO0uVTA8qmnMziVmhpWwW9Y7o8DxspGd16kCQZH/KruUDAEVTRc
	TPlfvnpTAwprWTRw2XAhz/JmD1FeBYuhDlhCC27AmdKbhMYNNrtkZiB4UYRLuQGhBUhC7OT
	Xwg8Ix8DZ3OdSLiwBq4co/5g1kMb05yms4uq78vhddo4fTLHQtHW9QNxIdNiqelNLYewX2v
	qy3iNJOqTKRJyGLxp+Te9QPP66Ubc6I/SnbH8ArJPWkMreinIpekdF7XTsw//6b3eIYk4KY
	Ki/QQUtY36mf7QJqTkUxIEMHV3odno3zZ+VYZO1w/N34CkLKHOlLhIiAP5mehmVyoik8tP7
	H2RdADQc+3qfjWb/1xakxB4EJSpoGKsQHvt0pkVJ4tQYXp5EUSdF7Uhv6Sn4Dk2luTmn5rJ
	SwMG87Z1pdvAYfvsnK455/3I05I/eqe2c30pBi0XrpZNeogWjLpeSBpilhvPxpoFmZHMR+U
	OY5D77ze5MMWHEbADzbOE834SHnyUkICIaab5awVLmqVzVGEwlq7nYrdr7zIVQnu39HKFQS
	jPBeoB+Cpqx7M9zauRSO6xwPwx90q69ucKdEbNFg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

In the efi_virtmap_init(), permission settings have been applied:

static bool __init efi_virtmap_init(void)
{
	...
	for_each_efi_memory_desc(md)
		...
                efi_create_mapping(&efi_mm, md);
	...
	efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions);
	...
}

Therefore, there is no need to apply it again in the efi_create_mapping().

Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Runtime Services regions")

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/arm/kernel/efi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index 6f9ec7d28a71..d2fca20d912e 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -70,11 +70,6 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 
 	create_mapping_late(mm, &desc, true);
 
-	/*
-	 * If stricter permissions were specified, apply them now.
-	 */
-	if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
-		return efi_set_mapping_permissions(mm, md, false);
 	return 0;
 }
 
-- 
2.20.1


