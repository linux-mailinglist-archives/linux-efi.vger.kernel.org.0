Return-Path: <linux-efi+bounces-4273-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0770AFFC98
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB43A5AED
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365028C878;
	Thu, 10 Jul 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XBjU60O1"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79E28373;
	Thu, 10 Jul 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136919; cv=none; b=q0x6l1sBt8ODLnn8D1Pvsfb9dOEy8Pw+g0hk/tSOW57VepMGaa3mBJokWnDdTCDyqwI41RzNDN3qe4aVbNduT53l+JFgpJMNfOU8ZfE6vgFQKFIsvzQyCfkcBoZt3DN7+CfbHTpWNA67HZVxZBEnf7JI4eJGMuyXMx+UFMDocBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136919; c=relaxed/simple;
	bh=AA4Ywq7KY2+V+Zzfmm2hAUDAzJGZoYY6D0W4ynbHcw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KfuwNbsP31XJE8l9L3PAgACdhOdOLczLmveQEIUcb+Nm4kNu9hWGond/wGFfKAHCOzPf7dzJeRClOhnNpuOFcS6uO+IENYq6Iyi6hbu6L2oyWCaWYMNaTSm3OR0557j5XG3indivfgKVF9tDXGXZvXTlE/te/2+7iwgDQ9XhyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XBjU60O1; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752136912; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fOwodtsOCTSdpblsnNXl1eGkH4855D/djDIb5y7d688=;
	b=XBjU60O1NQtFt26U9eHzOtoAYVLIkxfwY410KaOr43MU9GPnsOmsprKGIexVnY5AqMIjzjhvrWbc68+dIeMdDmHbvfDIfItcCT0viZt0+p8g3jNo4a+E3ccKLxrLsWMrdpxiTI9WLi3MgP0LU4NnH5v2EPZ8me2NfwN45P0brzE=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WicApMn_1752136911 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 16:41:52 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] rtc: efi: Add runtime check for the wakeup service capability
Date: Thu, 10 Jul 2025 16:41:51 +0800
Message-Id: <20250710084151.55003-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel selftest of rtc reported a error on an ARM server which
use rtc-efi device:

	RUN           rtc.alarm_alm_set ...
	rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
	rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
	alarm_alm_set: Test terminated by assertion
		 FAIL  rtc.alarm_alm_set
	not ok 5 rtc.alarm_alm_set

The root cause is, the underlying EFI firmware doesn't support wakeup
service (get/set alarm), while it doesn't have the EFI RT_PROP table
either. As Ard Biesheuvel clarified [1], this breaks the UEFI spec,
which requires EFI firmware to provide a 'RT_PROP' table if it doesn't
support all runtime services (Section 4.6.2, UEFI spec 2.10).

This issue was also reproduced on ARM server from another vendor, which
doesn't have RT_PROP table either. This means, in real world, there are
quite some platforms having this issue, that it doesn't support wakeup
service while not providing a correct RT_PROP table, which makes it
wrongly claimed to support it.

Add a runtime check for the wakeup service to detect and correct this
kind of cases.

[1]. https://lore.kernel.org/lkml/CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com/

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/rtc/rtc-efi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index fa8bf82df948..8d1b9bde6f66 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -259,6 +259,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	struct rtc_device *rtc;
 	efi_time_t eft;
 	efi_time_cap_t cap;
+	efi_bool_t enabled, pending;
 
 	/* First check if the RTC is usable */
 	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
@@ -272,7 +273,8 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 
 	rtc->ops = &efi_rtc_ops;
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES) &&
+		efi.get_wakeup_time(&enabled, &pending, &eft) == EFI_SUCCESS)
 		set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
 	else
 		clear_bit(RTC_FEATURE_ALARM, rtc->features);
-- 
2.39.5 (Apple Git-154)


