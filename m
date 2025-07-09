Return-Path: <linux-efi+bounces-4241-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 049A3AFE5DE
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499E41C223B1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A73259C9A;
	Wed,  9 Jul 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SR3Ptud8"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E42580F7;
	Wed,  9 Jul 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057348; cv=none; b=usfVis+p/br9O7C8kAGujXAScTh7r4b9NRb4tUFxAh0+0wL7Vvwjh1f407/NRD9lUoDAUbarEKm2jUqP9ar0vEjLqX/na0WY8dxcwJoS8/9eTG1sC3gZ9NjRxw3mmLMYNtNIIE5qVmqbhP+/LnlrhC70Vwvhm6kgRsPdGiB2ptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057348; c=relaxed/simple;
	bh=qfkCfB6k2ReP+dIuVqT1u5dDA3EHf0EsByKW+aDAnCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQGM9BucF3EAMyImoFO1lDK2+1882ejq/bqJzM/HnyCIdrZCzGXV+a7cShJBqqEy6wV8HV8Scfp1NHS4Onzicfyds7SszEhN12EHyeKovKPr8T1z8GqT6bVuo3n16TsdSVQevrpFTG+kQbc3BGguD47+UTjfufMHQ+u/sANO9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SR3Ptud8; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752057342; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=823FBAhOPxpcuDF4eE0847BhYehDui+jDc+P2yvyv4Y=;
	b=SR3Ptud8VVlfcNvgtR9d2F6ah29uZ/RtF2alFhkhoXlvaG3aQvKWpDwVW2wrDyipGeuQfDwH6BSmoXeXmuAPTqQvfrO5f5mi7x5EmtX9WMHnMt+JqQy8fgrUrdWuEnmmOLSifhuT/pzUHDqJ5+ANnBcvo5l+M98C4pIywwlJZFc=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WiXkGhQ_1752057341 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 18:35:42 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] efi:  remove the rtc-wakeup capability from default value
Date: Wed,  9 Jul 2025 18:35:41 +0800
Message-Id: <20250709103541.7268-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel selftest of rtc reported a error on an ARM server:

	RUN           rtc.alarm_alm_set ...
	rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
	rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
	alarm_alm_set: Test terminated by assertion
		 FAIL  rtc.alarm_alm_set
	not ok 5 rtc.alarm_alm_set

The root cause is, the unerlying EFI firmware doesn't support wakeup
service (get/set alarm), while it doesn't have the efi 'RT_PROP'
table either. The current code logic will claim efi supports these
runtime service capability by default, and let following 'RT_PROP'
table parsing to correct it, if that table exists.

This issue was reproduced on ARM server from another verndor, and not
reproudce on one x86 server (Icelake). All these 3 platforms don't have
'RT_PROP' tables, so they are all claimed to support alarm service,
but x86 server uses real CMOS RTC device instead rtc-efi device, and
passes the test.

So remove the wakeup/alarm capability from default value, and setup
the capability bits according to the 'RT_PROP' table parsing.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/firmware/efi/efi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e57bff702b5f..7cf35376a2f7 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -789,6 +789,17 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	/*
+	 * After bootup, the runtime_supported_mask was set to be capable of
+	 * all features, which could be kind of too optimistici. In real
+	 * world, many platforms don't support advanced RTC wakeup runtime
+	 * service, while they don't provide RT_PROPERTY table either, which
+	 * led to rtc-wakeup capability being worngly claimed.
+	 *
+	 * So remove the wakeup capbility from default value, and let the
+	 * RT_PROPERTY do the judge.
+	 */
+	efi.runtime_supported_mask &= ~EFI_RT_SUPPORTED_WAKEUP_SERVICES;
 	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
 		efi_rt_properties_table_t *tbl;
 
-- 
2.43.5


