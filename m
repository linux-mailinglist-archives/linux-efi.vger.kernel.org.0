Return-Path: <linux-efi+bounces-4297-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D744B0292B
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 05:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164654A2B0C
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 03:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB771E5B7A;
	Sat, 12 Jul 2025 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fENIcC70"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A4C1B95B;
	Sat, 12 Jul 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752291684; cv=none; b=nyz2i1FJNFNhV4q+Ta7TxzhDUhIFPnKryJ4o1cU20vC7Ys9Hb0gRvje/qjv2Vcof2mxrPoX2pSZp3hYOqBGUpcRoTu0keDA8ntSyZz1dtig76d87jyUJ54nHYJMzwdusb+NmIjke2p6g4CkNpURjZ+SkUOL7qzpolDP+5m6/Vt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752291684; c=relaxed/simple;
	bh=gE/8JUvGtNdOETekl43BDZmmXp8+/VN9DF8Job0bELM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=P0BxWOCkI6Qt2J/PtPFuvisZaqb8BNB571+rvmtxPaViK30/A0Bam493XpvsPCRMMsVaqRL1uFrgw+PLh1W5MwPVosUbxNdSMm+6tH9ivycHyQtM/PytRnhADsIAAePMaMfyjw+Xv0pusCkoCJwQKJy/yCJ6zNRYlQAR7c1ST18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=fENIcC70; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=8t7OohShBC0pqB1
	JRi7AhEL4nwregm6rK5n5ue/Gx3c=; b=fENIcC70FMtsHbXYy2gcEahN4Y+mJgQ
	rayMHH6MPVi+tLifgJxfkUJZHbn1feuu4cyIPTFwi3CIo0E5SLsPIp79Cp0IAapa
	4e4P6owTr8e/+B++GxL0OrXRPJSF654HLxGHKPkkVz4u2F204WXRyK4iUenXfGye
	wlrsh+JfR19g=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3z_eR1XFoYnt8AA--.35976S2;
	Sat, 12 Jul 2025 11:25:06 +0800 (CST)
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
Subject: [PATCH V6] efi/tpm: Fix the issue where the CC platforms event log header can't be correctly identified
Date: Sat, 12 Jul 2025 11:24:45 +0800
Message-Id: <1752290685-22164-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wD3z_eR1XFoYnt8AA--.35976S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryxCF4UKF4rtF1UXFyrZwb_yoW8uw48pF
	9rGrnYy3s5Kry29r93Awn2yw47A393KFWDGFWDWw1Yyr98WF92qa4j9a45G3Z3GrsrKa98
	Wa4Utr17Ca4jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYhFxUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWAqIG2hx1OkMxAAAst
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

Intel misread the spec and wrongly sets pcrIndex to 1 in the header and
since they did this, we fear others might, so we're relaxing the header
check. There's no danger of this causing problems because we check for
the TCG_SPECID_SIG signature as the next thing.

Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
Signed-off-by: Ge Yang <yangge1116@126.com>
Cc: stable@vger.kernel.org
---

V6:
- improve commit message suggested by James 

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


