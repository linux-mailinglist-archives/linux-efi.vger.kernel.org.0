Return-Path: <linux-efi+bounces-4097-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81299AF685C
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 04:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D398552264B
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 02:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3221D2045B6;
	Thu,  3 Jul 2025 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HavHrXb4"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8C23BE;
	Thu,  3 Jul 2025 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511290; cv=none; b=e1zHLOxOey/CUiCbyAnozN1q3bNyN0dlN43ERRuMHMF6cNjFcbL0WQir9JGS5QAXfZ+Rx0Y4D6u38PTdamnc2d/4w3ysS+QABDRJtXNiVriWgFsCLK2hKW3nB7NBGbwONp3EUfekUO7jhI/5WxnpQ4iPzv+5Wl1zkf5SllKwN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511290; c=relaxed/simple;
	bh=5WYfMc5xlqprXqGplo8TPRTwoTJcHq8cNIKht6TcDnM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=P+fFE11oKocdnxaL/c2aEnreIKi3McsCNoBGR9G3lT4RyZRXLWoKeQgXJTciZi9kHRdmwV0LgDmdVT1Lkb92VgzY45mymYZu8D7amO8P+509zwY1n38ISI4zTklloCFAMAbvhUjLZ7h3npFIMXmtoBI2WWRKRGnMuzpoEI1CgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=HavHrXb4; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=RNGiMRA7tuQYaNu
	ZL6aNqt4/FrG725yke/AkkJExntU=; b=HavHrXb4n7y1jl4SFU67iohdY9hlFac
	nVJw3fz3JqKzheZtNn87cqcdMyJYJV8cJ4F0U7r8AvffxQ0Wu2X8cTmc7ay/Rhbd
	NEo8tPF6HzazIgXBnFj/Mj6zQvcAfGlWNs/cm08EKXZDK5CjcIZGpSzzeelUnwN3
	xtxpPAMZJXiw=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHz3Iv7WVo3yJGAw--.37667S2;
	Thu, 03 Jul 2025 10:38:40 +0800 (CST)
From: yangge1116@126.com
To: ardb@kernel.org
Cc: jarkko@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org,
	jgg@ziepe.ca,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: [PATCH] efi/tpm: Fix the issue where the CC platforms event log header can't be correctly identified
Date: Thu,  3 Jul 2025 10:38:37 +0800
Message-Id: <1751510317-12152-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDHz3Iv7WVo3yJGAw--.37667S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryxCF4UKF4rtF1UXFyrZwb_yoW8Zry8p3
	ZrGrnakr95try2gr93Zw18Cw4UA395CrZrGFykKw10yr98Wr92qayjg345K3WfGrZrJFZ8
	Wa4jqr17Ca4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoKZXUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgZ-G2hl5F7-FQAAsF
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

The pcr_idx value in the Intel TDX log header is 1, causing the
function __calc_tpm2_event_size() to fail to recognize the log header,
ultimately leading to the "Failed to parse event in TPM Final Events
Log" error.

According to UEFI Spec 2.10 Section 38.4.1: For Tdx, TPM PCR 0 maps to
MRTD, so the log header uses TPM PCR 1. To successfully parse the TDX
event log header, the check for a pcr_idx value of 0 has been removed
here, and it appears that this will not affect other functionalities.

Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
Signed-off-by: Ge Yang <yangge1116@126.com>
Cc: stable@vger.kernel.org
---
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


