Return-Path: <linux-efi+bounces-4294-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A8AB02909
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 04:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D823BCAC3
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 02:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F91E231F;
	Sat, 12 Jul 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ch5VHhy7"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA8FC0A;
	Sat, 12 Jul 2025 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752289030; cv=none; b=LMFfdLVK7h1xmsfDY4o6/uG+fSES763p78gpw4VzZIjoecY3pLFygCIKZe9mr7p9VmYJUF7cG2/KEtYnVmtq7D17LmbWJjFdBno5A4nN7pP7jVdY/gqqfRj9DBRQ/l6Jtr5SuxOELF2XPKgQwI+0n/UG72otGqhAHu062ufHnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752289030; c=relaxed/simple;
	bh=xkRT+MKqY2lxuf2RMCf7CR4wiTn0R99YsJH5XvbqmSM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LPiuNaY0JxWtpHMUhSgLhinoIX3bwPwsfvpDvpGVy4PQ4sTRH06e0WiVlZWXqxXesd5OLEEQC3DJIxePWFJJobRXB7kLgVW9WNQflGUu2tCU/ZIrY7tSQzXpiWs/duWVrReX3kgzr6uG6h8goWwW7SHyvNpd+/OBvDDQUEOX4BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ch5VHhy7; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=Za3cjth64BNH1hv
	Ar12ByH0LmdnFuA9JqyZKzsn78Zg=; b=ch5VHhy7I8GtsVixbHBOoTRylQ4d+Qm
	S02WImx43a0FTCAxjZQzrh7qJpYLFgmWa+BpPRiYCygqMJ2Km5CVkckg3w3gA9Ht
	iivzWx+TgpVYB4RjNhBfMUYjWSXJVcPEyrU08z/BAMnofLqh1mL9akvlAJNMRLtA
	pUeoAaLjlevI=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD371vOznFohUW8AA--.19498S2;
	Sat, 12 Jul 2025 10:56:15 +0800 (CST)
From: yangge1116@126.com
To: ardb@kernel.org
Cc: jarkko@kernel.org,
	James.Bottomley@HansenPartnership.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org,
	jgg@ziepe.ca,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: [PATCH V5] efi/tpm: Fix the issue where the CC platforms event log header can't be correctly identified
Date: Sat, 12 Jul 2025 10:55:50 +0800
Message-Id: <1752288950-21813-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wD371vOznFohUW8AA--.19498S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryxCF4UKF4rtF1UXFyrZwb_yoW8Kr48pF
	17GrnYy3s8Kr1293s3Aw18Cw45A3yrKa9rGFykGw10yr98WryIqa4j93W5Kas3GrWDAa98
	Wa47tr17Aa4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoGQDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWByHG2hw-41n0wAEsC
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

From: Ge Yang <yangge1116@126.com>

Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
for CC platforms") reuses TPM2 support code for the CC platforms, when
launching a TDX virtual machine with coco measurement enabled, the
following error log is generated:

[Firmware Bug]: Failed to parse event in TPM Final Events Log

Call Trace:
efi_config_parse_tables()
  efi_tpm_eventlog_init()
    tpm2_calc_event_log_size()
      __calc_tpm2_event_size()

The pcr_idx value in the Intel TDX log header is 1, causing the function
__calc_tpm2_event_size() to fail to recognize the log header, ultimately
leading to the "Failed to parse event in TPM Final Events Log" error.

According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM PCR
0 maps to MRTD, so the log header uses TPM PCR 1 instead. To successfully
parse the TDX event log header, the check for a pcr_idx value of 0 must
be skipped. There's no danger of this causing problems because we check
for the TCG_SPECID_SIG signature as the next thing.

Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
Signed-off-by: Ge Yang <yangge1116@126.com>
Cc: stable@vger.kernel.org
---
V5:
- remove the pcr_index check without adding any replacement checks suggested by James and Sathyanarayanan 

V4:
- remove cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) suggested by Ard 

V3:
- fix build error

V2:
- limit the fix for CC only suggested by Jarkko and Sathyanarayanan 

 include/linux/tpm_eventlog.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 891368e..05c0ae5 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -202,8 +202,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
 	event_type = event->event_type;
 
 	/* Verify that it's the log header */
-	if (event_header->pcr_idx != 0 ||
-	    event_header->event_type != NO_ACTION ||
+	if (event_header->event_type != NO_ACTION ||
 	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
 		size = 0;
 		goto out;
-- 
2.7.4


