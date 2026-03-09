Return-Path: <linux-efi+bounces-6278-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO2BHP4Gr2knLwIAu9opvQ
	(envelope-from <linux-efi+bounces-6278-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 18:44:30 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A523DCAB
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCB5301BCE7
	for <lists+linux-efi@lfdr.de>; Mon,  9 Mar 2026 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AE3AA1A2;
	Mon,  9 Mar 2026 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="qwsZrsel"
X-Original-To: linux-efi@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC82EF64F;
	Mon,  9 Mar 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078216; cv=none; b=nNa2n8Zweib7ZqacU2pkQZfx1VPojGBXAxq1zYHhLfkfok0gv1TEhZocHKTBV5hCFFy8aMzhNTPxiOEbN7QqfZPVm3+9UzlO2M+WxycmYtrdhBiO3C+MuGIeZBvTjTjRanTw2YBd6m54HMEGwGUu7MI1BxEIwLledPihj4hRSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078216; c=relaxed/simple;
	bh=7Sj1iSTUhoRSRPuDr9EzsB8nZdJbghJUkg9B9xemI+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pdza90pL1iXN/pmbOav/fzASBZ/bQstDwlykSqU7KCKZhcO12yu4sUG7q3Bx/bShYTTNUbcXHMRttC1fltoC2urUXCxtfdLsOI6Tg6EMM7RMA2YkeZqdk1yh+SVaCLLfWwwZUsJwcZRgJJ50SKkervTB/f7ACQSdO3H/8A6UvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=qwsZrsel; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=GvGfRqYcavTLyQIRtp+fA8Lrpkkq2d1kPOMV+6xEVDU=; b=qwsZrselhL842Y
	TXbYB5khIfBhDO8kYK1kdl7IKo4tGTw/L2rcwUrS5StRhutQkqz+Zo9mQQvvN2lPw283YHxW+6IFJ
	LeryYNfU0oYFb62Qcr0yiqjGM3etkY8zOvPMKzR/dPS4X+w5pjELO2bkk8MwGGTbtAcB8KNqTio/y
	URNgOtpHigJSsfzW+x2Vag/ss2+awepCu+Dft6lAjem7cyBfsRX7MRC47AkjaD0Ad7XkyscBMfCeZ
	RnjUEKBQH0y+bDhOpofMJI7nJeIKYQln7VrFfaGPh+33Vh8s+lTvNmnFLVlZKKAFllf1XJJGWwwB5
	s11VtM2x9INdwSTcJ1JA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vze7S-005mPv-GM; Mon, 09 Mar 2026 17:10:14 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vze7S-0000000CCwk-1bIa;
	Mon, 09 Mar 2026 17:10:14 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: ardb@kernel.org,
	linux-efi@vger.kernel.org
Cc: ilias.apalodimas@linaro.org,
	linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] efi: libstub: fix type of fdt 32 and 64bit variables
Date: Mon,  9 Mar 2026 17:10:12 +0000
Message-Id: <20260309171012.2909693-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Rspamd-Queue-Id: B39A523DCAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[codethink.co.uk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codethink.co.uk:s=imap4-20230908];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6278-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.dooks@codethink.co.uk,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[codethink.co.uk:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,codethink.co.uk:dkim,codethink.co.uk:email,codethink.co.uk:mid]
X-Rspamd-Action: no action

In update_fdt_memmap() an update_fdt() the fdt values should be
of the fd32_t and fdt64_t types. Make the relevant changes to
remove the following sparse warnings:

drivers/firmware/efi/libstub/fdt.c:97:19: warning: incorrect type in assignment (different base types)
drivers/firmware/efi/libstub/fdt.c:97:19:    expected unsigned long long [usertype] fdt_val64
drivers/firmware/efi/libstub/fdt.c:97:19:    got restricted __be64 [usertype]
drivers/firmware/efi/libstub/fdt.c:157:19: warning: incorrect type in assignment (different base types)
drivers/firmware/efi/libstub/fdt.c:157:19:    expected unsigned long long [usertype] fdt_val64
drivers/firmware/efi/libstub/fdt.c:157:19:    got restricted __be64 [usertype]
drivers/firmware/efi/libstub/fdt.c:163:19: warning: incorrect type in assignment (different base types)
drivers/firmware/efi/libstub/fdt.c:163:19:    expected unsigned int [usertype] fdt_val32
drivers/firmware/efi/libstub/fdt.c:163:19:    got restricted __be32 [usertype]
drivers/firmware/efi/libstub/fdt.c:169:19: warning: incorrect type in assignment (different base types)
drivers/firmware/efi/libstub/fdt.c:169:19:    expected unsigned int [addressable] [usertype] fdt_val32
drivers/firmware/efi/libstub/fdt.c:169:19:    got restricted __be32 [usertype]
drivers/firmware/efi/libstub/fdt.c:175:19: warning: incorrect type in assignment (different base types)
drivers/firmware/efi/libstub/fdt.c:175:19:    expected unsigned int [addressable] [usertype] fdt_val32
drivers/firmware/efi/libstub/fdt.c:175:19:    got restricted __be32 [usertype]

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/firmware/efi/libstub/fdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 6a337f1f8787..23b3543d3041 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -32,8 +32,8 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 {
 	int node, num_rsv;
 	int status;
-	u32 fdt_val32;
-	u64 fdt_val64;
+	fdt32_t fdt_val32;
+	fdt64_t fdt_val64;
 
 	/* Do some checks on provided FDT, if it exists: */
 	if (orig_fdt) {
@@ -100,13 +100,13 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 	if (status)
 		goto fdt_set_fail;
 
-	fdt_val64 = U64_MAX; /* placeholder */
+	fdt_val64 = cpu_to_fdt64(U64_MAX); /* placeholder */
 
 	status = fdt_setprop_var(fdt, node, "linux,uefi-mmap-start", fdt_val64);
 	if (status)
 		goto fdt_set_fail;
 
-	fdt_val32 = U32_MAX; /* placeholder */
+	fdt_val32 = cpu_to_fdt32(U32_MAX); /* placeholder */
 
 	status = fdt_setprop_var(fdt, node, "linux,uefi-mmap-size", fdt_val32);
 	if (status)
@@ -147,8 +147,8 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
 {
 	int node = fdt_path_offset(fdt, "/chosen");
-	u64 fdt_val64;
-	u32 fdt_val32;
+	fdt64_t fdt_val64;
+	fdt32_t fdt_val32;
 	int err;
 
 	if (node < 0)
-- 
2.37.2.352.g3c44437643


