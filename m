Return-Path: <linux-efi+bounces-5274-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180CC230C9
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 03:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FE01887247
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB330AAC1;
	Fri, 31 Oct 2025 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lEtZsil+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226F220698;
	Fri, 31 Oct 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878719; cv=none; b=sc/COWymh8as9Rw4CVM8e8WpJSlh4/PQOA87zge0+QQJ88uGJoIssU+6ukjuatcO0fEVfLyeo8u58DPSFdQ9Tza6Hmzr0FUK4FiSIH9xBR31Ggbnguud1txCypz5VbIU6PuTNzG+L8anGb2BJaumAQl2Xi2zV6JtPza5iMSkWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878719; c=relaxed/simple;
	bh=mGIfPx3TK2mVjuKeuduli9zM8vPdpqX+k4noXzdYy5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r6bpn+LZcC597wXaUSe2374Yf7Jp4SJR6ehvQksLcaQD1uO8ndhAKKIFmv6KqsDQdP87no9slx4qI17qOR/f9GzZi6al8zq7WDiwv/X+puzIdEQg/ApyY8B7sXriYHcLOnRFmUz6/l24l3GNC+4yLfHeh7e+dseXzXJ2KtiTG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lEtZsil+; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761878656;
	bh=frwsj15DgVxVMJ8KO7DoMvHVFee+Jhsr1xRKxDB+3cw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lEtZsil+X93z2NhcgnwSxRVCvVDA+r9JHfER1EUitRp44zbZRvAU3iOImQ+NoUI8X
	 0OobxANNDI7SEJMvbHKEdZCd2JoYSVwvPFkM25x3Oy5N2FljDFbxGSrwgkXFHURw0r
	 WI25hinCahtrUcW9sTEFG+OwHuhuRQ49hspF4lcs=
X-QQ-mid: zesmtpsz2t1761878650t811abe2e
X-QQ-Originating-IP: 6sh+ThAW+eQ59N+O6BU1he7uvP2VizEbUxZD6p44FpY=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 10:44:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1469372003017503645
EX-QQ-RecipientCnt: 9
From: Qiang Ma <maqianga@uniontech.com>
To: ardb@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] efi/riscv: Remove the useless failure return message print
Date: Fri, 31 Oct 2025 10:43:28 +0800
Message-Id: <20251031024328.735161-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M7nxhb6mzyWmhLP0LYDlObH120Gmy+iY54Hfc8Ze186KgxhUBnwR49jO
	PWIf5GLYUKJTEcoOv8rby8+TjtW9ZKTL65qyZar7qHUPfYW9LToiFecsBNVOToJbM9qbHAQ
	cBXNuaDChAB3nUorAHeI/5zdNu2YeIVw0dg3TE4HYHJc1FWSV/Fa0A11cjpJb2UhkFB6L8G
	3m6DyUzqWEtL7p58kvIWskHdaGmza0a8cct8MYs0xBqWFNvRk1aucuiTDCBseyuty4U5wNV
	SBzw9xrVboWkQAydng19hZ18ZPWij/ftTo7t8jXqLwoDZAMgIU4gDR7RgaSAoKuvJft0tJ1
	9c20YLCzoAb1megViOwaauWji4EBOnTTanOTCcsvx8eiFQ1diCXU66FvtTQTB2tfxIZzPE3
	vXJnKBDwnl/BB1dnORMs+kVRGrI0Z7XWaXQtgaTUNRu9o+9o04i/aO541c3JNi3tNLSmVai
	C3pJ/nouBSnkae8Ui1IEnCO8ZyoXtAChg0PFb25+UhBCE+u7GpNOhML9TKhWuoWbsPPSsxy
	+3nDSYMF0lBKV9BZTXxjy4PM/w+1a3zsGPze5C/rhWcXGvPqEejEKeZTAKSAYXjoifO47c+
	n+7WC7l4VFKsbx+EPdBzYFvL7P72TW2AWyEChQeCvfAgoLLfVGN+n8Tfz7j1cSF8tmuj4Zp
	ajVL4A3lT5fzXTHlbOVuJLE7ptb3j616wDGdHp8C8AfTrm5BYP415Ztf/KAv4wvx74Yqq+b
	JMtRtFqASV/XuIdWhe1lG+MUtYV0p4XRudYFwc5ZEcSoAwOzdhfXIMwCndCTC3AWDypDVpk
	AeUpcJWnNp6Qz7zA+ZXIiLT0Mvf9SviwzXTExJfrkiCcTTfrsqHu7ynp7P04FuvtoU4XtvH
	6DDZso8gjwxTQxOOE0nW7j4E7+yXNdNOC1GPdScRDlPkw6AAX8/8gKTMaDHqD0xdUO0k1ic
	g9qvhpx551t+AtjY7Ot2wh7TbEVLb+xXnVLoGFmiMQ2JHK1tiuA9QbqRgqnurX9GwQwmRD6
	6s7fh+ALythYypYIO9B/lP+CV5rv6H1w++d6ydvw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

In the efi_create_mapping() in arch/riscv/kernel/efi.c,
the return value is always 0, and this debug message
is unnecessary. So, remove it.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/firmware/efi/riscv-runtime.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index fa71cd898120..4a2588358be2 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -36,20 +36,12 @@ static bool __init efi_virtmap_init(void)
 	init_new_context(NULL, &efi_mm);
 
 	for_each_efi_memory_desc(md) {
-		phys_addr_t phys = md->phys_addr;
-		int ret;
-
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
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


