Return-Path: <linux-efi+bounces-6276-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCEZIeHDrmn2IgIAu9opvQ
	(envelope-from <linux-efi+bounces-6276-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:58:09 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EEA2394E3
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E64303011E
	for <lists+linux-efi@lfdr.de>; Mon,  9 Mar 2026 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8F3750D7;
	Mon,  9 Mar 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3k9nljz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903832D3ED1
	for <linux-efi@vger.kernel.org>; Mon,  9 Mar 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060813; cv=none; b=GCPvAbvtZbC/P12Xf6S8x1u0rRc7v4nWMgp3sJkWDkX2OQC45f/J8ZqkOSuqudLlQoKMe5spZXRDK75Lw+RPbw1H3aWsGoH/itO22SSuzhKRqt1deSSXWjsTuxrXM7bCEEK2sSavb/1SP1M9OKDZu6RKQ1WAIa357xSXIvcYohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060813; c=relaxed/simple;
	bh=7EqVpQkt26QiWz81CscLpDIuKnX7gfanW6HqlSkXLgs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XgAin229Yh88F7rhQ2BYB3Zmx6/RDmAtyT+7Bbru+0dJzFwX1tuMkT9CIrKLbUIhkHXPAnKEq6/Du02vvxBelCFMn/ZgGj7smVfy7j6YLHQnxhoWqP+/MwQsr2xaalwAJlf5A5OuRBpqyxa4r3iDzm28w+EzEPZcNXmhoKqWUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3k9nljz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4853b0af42aso8702305e9.0
        for <linux-efi@vger.kernel.org>; Mon, 09 Mar 2026 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773060810; x=1773665610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TdoaE+nzJ4hFueZVOc/L48ogt+WxC2wNBFWpqmzF04M=;
        b=P3k9nljzrXL4rkTQQCN42+CMv9VIdNim53rZJlngNN1y3ampe3MELsycnYg5cdojBL
         Vfh119VA53PE2AbRORvME2IEJvighkE3vhxuz23XHAQ3LAAogOtCGwF7YlwoERxkSYQp
         4mKvampRUihrkCuTm3+1Q7K3jHWsnulyG8AjOkmkzQjOVmbUBoUieWct2GhtBBElIHs+
         esOvGV+rGQDUMPO+RYxcO9ez6bVCNUSDb1eti/WTp+SK1hOc/tg8JdSIgtDzj963fEC3
         iCcTpLr3R4Z6gzGpDvuXYlWxZCxD2vE+RPjOMKaQo+rlj55q88FYrvq9syhPZuEsvymc
         zcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060810; x=1773665610;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdoaE+nzJ4hFueZVOc/L48ogt+WxC2wNBFWpqmzF04M=;
        b=FfaRIunD3OrBRdVkeodcCiPU0XRbnpJeQa/iK8krmUTvn0E8/ZvunRvGuRKUYQQf+Z
         UXtqipplAr5Pr62RmO6N5PyYghyfOdM3VGTQo+vyJV+tjE2KblXLrtp0NuAtV/9jPxjO
         /5d7LhNPHOaFOQ8RQHVR5IEI4gvlj5UWdAWV2nxtWvzQSfa4BBWNgnvP6iBiR0nnRzHa
         4mm+L9sg7613uO5QhWW3R8YYNNC8GcHfSZMywoUYFhtECkU4Xi6huwBkq4JbNm76GWKL
         4C+VZH5gSOX1vit8Po2rRtY3OEDdQlnDYMvWICXFFPPrn7i0GsPNJXYKDE4kIkB9T7o4
         d7Ow==
X-Gm-Message-State: AOJu0YxR77EdHWXd1bh3t0fPWCl1WaOJru8qHPPkmIH3Tk/JQNVkrqAY
	PBWCq1uN+Rt9nefPE6rgYiVzjQ+TSAClIf6THppXU9FtPIzw+CDi2p+Vttf2eN4tP8Os6B8AkX2
	b6uQiAXVUeHNi7MQAgNhYMo5F9NtIejf1OJc7NFuT0mqVPHKUTultXRtN7xMYf4ei10fiC0EQ9n
	7pY8C63TlAPGPd0zeYdxAZYthhhYyMIw==
X-Received: from wmbb17.prod.google.com ([2002:a05:600c:5891:b0:485:40d2:1eb1])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3f06:b0:485:3c66:e21d
 with SMTP id 5b1f17b1804b1-4853c66e362mr39220945e9.2.1773060809736; Mon, 09
 Mar 2026 05:53:29 -0700 (PDT)
Date: Mon,  9 Mar 2026 13:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=ardb@kernel.org;
 h=from:subject; bh=2pPnRKd6I956bXrDx1KWPp980f+hQ8p+rNGDgOgK4HA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPdoSOi+0P2XM7ZlSSy86qm1JpF+iev/fz2ar7dJU2Vt
 OQDdidudJSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJTKti+J/cz3dz4uEvXB9U
 ylXmqc7zj76torTVrJFtns+z8OORwkcYGRZsEKtNeenalLpKkc3f1qy406m76sW7NR4NKTsvn0v ZwwsA
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309125324.1876754-2-ardb+git@google.com>
Subject: [PATCH] efi: Drop unused efi_range_is_wc() function
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E8EEA2394E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-6276-lists,linux-efi=lfdr.de,git];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.967];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

efi_range_is_wc() has no callers, so remove it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 664898d09ff5..72e76ec54641 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -832,27 +832,6 @@ extern int __init parse_efi_signature_list(
 	const void *data, size_t size,
 	efi_element_handler_t (*get_handler_for_guid)(const efi_guid_t *));
 
-/**
- * efi_range_is_wc - check the WC bit on an address range
- * @start: starting kvirt address
- * @len: length of range
- *
- * Consult the EFI memory map and make sure it's ok to set this range WC.
- * Returns true or false.
- */
-static inline int efi_range_is_wc(unsigned long start, unsigned long len)
-{
-	unsigned long i;
-
-	for (i = 0; i < len; i += (1UL << EFI_PAGE_SHIFT)) {
-		unsigned long paddr = __pa(start + i);
-		if (!(efi_mem_attributes(paddr) & EFI_MEMORY_WC))
-			return 0;
-	}
-	/* The range checked out */
-	return 1;
-}
-
 /*
  * We play games with efi_enabled so that the compiler will, if
  * possible, remove EFI-related code altogether.
-- 
2.53.0.473.g4a7958ca14-goog


