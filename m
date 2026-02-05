Return-Path: <linux-efi+bounces-6089-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PfcKNiFhGl43QMAu9opvQ
	(envelope-from <linux-efi+bounces-6089-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 12:58:16 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C90F2212
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 12:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D00B9303012C
	for <lists+linux-efi@lfdr.de>; Thu,  5 Feb 2026 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10083B8D7F;
	Thu,  5 Feb 2026 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqME0oF6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CAeEvCXW"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913BB3AE6FB;
	Thu,  5 Feb 2026 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292566; cv=none; b=Gtdthi6Ft28U3YbHxmYtsbtpoAdlIcMHIENPuGt+scW2s1Q5GvGUleBpql22igBXW+NjzcCM7Oq9YWERvzqNePXATtB/krkoQ71P0c0J4Co0obdOuS4GnzWE05ZSSvwOqWZdJ0s81SjxRSm5NMJ9gDlGhuj+EoxmS+c/QImZpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292566; c=relaxed/simple;
	bh=K0oVPdjrPdDC/9Chn/246w0sWZEcnVmQbprdnwnacSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGgpro7DMYwR7rj6/cw2osoFRCeJIrc7WSPXsglWSyiO75/AU3n2DGuYdw1VExsTsbZfeCl5kzbgAae1ff4nG5ZjZ75Ls06yZtwoZG4kFxkrk1UQFxC5dJNoeLuQxX7ZvaZwDGXW/yXICVaBhnSyRz/QIJ2iObLjMNt6EAzQ8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqME0oF6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CAeEvCXW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770292564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pPRlUQacgUBd6LN1voSLSgxAAG2Fmd7r1Ys9j/nuzMI=;
	b=rqME0oF6tZ4lWSegXkL4MgCRHBHO+0VkCTfsBOM4/lN+KxAaB+EejQ/F32P1yalFQ4rhu8
	TZOW1EDt2HIhwk5ljj7YjX2KpOxhv1Z0ja3uS0N4DiNRm7GGGmSAV11imjM8vbFJqPcbHE
	gw8ZaTXSKessJNfE1QRkhAs9Spb8I1JJlJBxsgrLd628gmq9/U74YrgwPexdh6bup8OYG4
	iw1Kyao5UGEvokGcUoycgsDSS+eeqVDMZ9pd6H9ssrxrwaZfMptdt9bSvQ0byBO4AsUI5k
	PDky+F4jMbq5sLKqkn97G5CHAPAt8BIaVGm5LLUL4gV65tfaRrGfZVffG3csFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770292564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pPRlUQacgUBd6LN1voSLSgxAAG2Fmd7r1Ys9j/nuzMI=;
	b=CAeEvCXWCa2Ccm6YGo6W+808GsgvCstOodosYGWnKUAIPjGB3T0yLVaaeyQEP3VwUGRGA1
	WssXhhgG56foTACg==
To: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
Date: Thu,  5 Feb 2026 12:55:57 +0100
Message-ID: <20260205115559.1625236-1-bigeasy@linutronix.de>
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
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6089-lists,linux-efi=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23C90F2212
X-Rspamd-Action: no action

EFI runtime services are disabled on PREEMPT_RT by default which can be
overwritten on the boot command line. For native EFI, an invocation
requires to disable preemption while a call is made into EFI. The time
spent in EFI is not deterministic and depends on SW and HW of the
system.
While accessing the efi-rtc device can be avoided by using a native
driver, accessing the "variables" is important and there is no second
path.

The "runtime-wrappers" is wrapping access to the EFI callback via a
workqueue. On a SMP system one CPU could be declared as housekeeping/
not-realtime-capable and force all EFI invocation to be performed on
this CPU. This could be achieved by setting workqueue.unbound_cpus or
	/sys/devices/virtual/workqueue/cpumask

at runtime. This however will affect all workqueues and might not be
desired. With an explicit setting such as
	/sys/devices/virtual/workqueue/efi_runtime/cpumask

it looks like an official way to limit the CPUs involved here.

With this in place I was wondering if EFI_DISABLE_RUNTIME could be
lifted at runtime on SMP systems. But given the unbound_cpus option
and the auto-config based on NOHZ-full it might not be wise to add yet
another smart option here. Also it needs to be a subset of root cpumask
or it won't be effective.

There are two EFI invocations which are not covered by this
- mixed EFI
  Used on x86 with 64bit kernel but 32bit EFI. Would it work to use here
  the same workqueue mechanism?

- TEE / ARM secure monitor
  If I understand this right then TEE invokes the secure monitor which
  is preemptible. So an interrupt will interrupt and enter "normal"
  world immediately and could wake a user task. The following context
  switch will not happen because the return from interrupt path goes
  back to the secure monitor/ TEE.
  If so, or if TEE may disable interrupts from normal world, would it
  make sense to use a wrapper here, too?

Any comments or things I have missed?

Sebastian

Sebastian Andrzej Siewior (2):
  workqueue: Allow to expose ordered workqueues via sysfs
  efi: Allow to expose the workqueue via sysfs

 drivers/firmware/efi/efi.c |  2 +-
 kernel/workqueue.c         | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

--=20
2.51.0


