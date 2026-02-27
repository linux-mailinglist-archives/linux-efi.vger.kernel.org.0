Return-Path: <linux-efi+bounces-6230-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH/lDIrPoWn3wQQAu9opvQ
	(envelope-from <linux-efi+bounces-6230-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:08:26 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0ED1BB396
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7490630EEDFF
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353D135CB64;
	Fri, 27 Feb 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GSwGN+41";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVfhfQr8"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593135A39F;
	Fri, 27 Feb 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211671; cv=none; b=KVYAgcJvbirjPn6vmVtXG16ijvCDhBu6jMPigFcVsz3ULluy4y0ijB/7tuMvOCcv4CyypU/QhoCq+n6Lf9hb+P9/CGss8RAFYE3B+0T708Hwo/TB4Z6Gf9Zt9BW1QJ9HR9ldSGfFr00uFUHUDMlvtBsPj22kNGz5xjDhvmhVhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211671; c=relaxed/simple;
	bh=1cjoIDiqLFttBjFaCvVhjgWaa8GFJ/AZ1WWKyZUjN3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYyNFbm0IAN4sVKzcyHRMCdvr/zwXRF4yMUxIueLmCCokkUJ8nQ+gxwTQT82MzqVcDr83IFq0jp/wfhBQu9ALBi9wV6zeTORZpCaiWo9Y3ruOahereAmySsKxMujgIHQ265E/j5uyajUsNTmgpC1cXyGxUf3LHQLsKbeOGFlCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GSwGN+41; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVfhfQr8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772211668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOq5V4/dwverftSI+2e+3Cqh4irrH3bkTVizH8crF4U=;
	b=GSwGN+41eVc362HWs+g02Ef5kzye1jRNkZXJGDY7MfKWVc2qArkwCpFJ90aRZdUGZ4Lfk0
	NQZoW7MJpSLKtAscrcc+QG00VjUGKkS/Xc1ETMfgbKqFoB2GHZqbpdj1cmUjJuQ8nD900P
	tFQnKqBtxlFmQ2Imuuf4X2z3IJy6fBywywRB4EJ+cWf1ecGBe4tMiNtNHVkNhbm4C9WJhl
	jUnReFtm/5ERReVp3IBYvKHJEehWq8DcITTMi9bZHHqPlnZnlcFpyVgtxWU6jbYw+nTDBX
	xa8Jv5KXKl9H60sA923Ab7ZAwVqS6t84hpY8Aagn+zbz/gblR97sWqH01o1sWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772211668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOq5V4/dwverftSI+2e+3Cqh4irrH3bkTVizH8crF4U=;
	b=dVfhfQr8605EhTgyzWVqj5uvifvBdgVRkCG14gfim0k92nLxY7DMdf5M7gHiFEgTHNeQ7I
	W36Q9NO10oF4moAA==
To: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/2] efi: Allow to expose the workqueue via sysfs
Date: Fri, 27 Feb 2026 18:01:03 +0100
Message-ID: <20260227170103.4042157-3-bigeasy@linutronix.de>
In-Reply-To: <20260227170103.4042157-1-bigeasy@linutronix.de>
References: <20260227170103.4042157-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linutronix.de,gmail.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6230-lists,linux-efi=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB0ED1BB396
X-Rspamd-Action: no action

Exposing the efi_rts_wq workqueue via sysfs provides an easy mechanism
to restrict EFI firmware invocation to certain CPU(s).
This can be used to restrict EFI invocations to specific CPUs while
allowing other workqueue to use the remaning CPUs.

Expose the workqueue via sysfs. Change the name to efi_runtime which is
what will be visible under sysfs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index b2fb92a4bbd11..3dab284a7754d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -423,7 +423,7 @@ static int __init efisubsys_init(void)
 		 * ordered workqueue (which creates only one execution context)
 		 * should suffice for all our needs.
 		 */
-		efi_rts_wq =3D alloc_ordered_workqueue("efi_rts_wq", 0);
+		efi_rts_wq =3D alloc_ordered_workqueue("efi_runtime", WQ_SYSFS);
 		if (!efi_rts_wq) {
 			pr_err("Creating efi_rts_wq failed, EFI runtime services disabled.\n");
 			clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
--=20
2.51.0


