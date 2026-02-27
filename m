Return-Path: <linux-efi+bounces-6231-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sINUHe/NoWn3wQQAu9opvQ
	(envelope-from <linux-efi+bounces-6231-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:01:35 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A71BB246
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EE253010911
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E793603FE;
	Fri, 27 Feb 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufQKFHiW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K3HkD5Og"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F83596E3;
	Fri, 27 Feb 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211671; cv=none; b=kNh6Wtfzp36jDRX2BErxB2cLlojRP4QwgDA+gql2QNCRmdBxr5O41TSKfgKx1c9MESuopy/X/XlJfMszuUGvFB5mJdrx7zIYI/e1k48SrISzJckcO4Uhps9ED1uYAhbyThwSQx6psoZqPE5/aBBPJR/3hDLdxQbrSTi42x/trEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211671; c=relaxed/simple;
	bh=JahL2tOGcgic3e0Bs7zgdPhXJKZeV7/BSGnhuhVA2w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dLTGXpnQkDKvRS3a8BxNNF7l0eYllvgjg9EwFWO9CK51GhGRfLn3fgY93Q5WV98yWWDQD51XaqK8QTvXA3thRTPVp6mZ/hqJUF6NnCBF7g74TeFsQIcVUKuNe1+iMGw7WRXVLOQzFXF2DYPdE5Ro3H6GThhijJvwdH1v6objX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufQKFHiW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K3HkD5Og; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772211667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sUQDovDnjtjrQEYpPSXKCbaD70SmTedmAp/MkQu7vNM=;
	b=ufQKFHiWEviBxtHlFCcoFGk/eG6nLaUlcAtMbIEUHk0dyJ5gsjhOstxvY8XTr/v9mXKQzb
	TlMORPAJuJv8elGWlVdqdgA/4QUvwCwa5S2V+9tc4bhPXZZDLabSWbNKYMiYy0aS3xr8v5
	chfSkkhuwwCMTVGkF/s1AJs4vz1CNddzGuzncCrYQxvWVg+gTO752/cV21LaXa3rsMLhCh
	5aUcnK0j1PzqP7Ng/S1IBi9q5OScHkXpDC8GpX5oanI/Owlc/3U/rPegypU+JiM03eXNE6
	anWu9zdJt9hE1ptShmWSLVgtPS2K+bX25VEBKbWdmR+eVPKOzJ10v8DctGQUqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772211667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sUQDovDnjtjrQEYpPSXKCbaD70SmTedmAp/MkQu7vNM=;
	b=K3HkD5Ogf/Stcoto+VC8DRYtjTFchuOs5ca6Go/IAYBQoUw2kArgABh0m0MsuFP98VMlDH
	fzmAwUKp2xdcdhBA==
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
Subject: [PATCH v2 0/2] efi: Expose the runtime-services workqueue via sysfs
Date: Fri, 27 Feb 2026 18:01:01 +0100
Message-ID: <20260227170103.4042157-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6231-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linutronix.de,gmail.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F0A71BB246
X-Rspamd-Action: no action

EFI runtime services are disabled on PREEMPT_RT by default which can be
overwritten on the boot command line. For native EFI, an invocation
requires to disable preemption an x86 while a call is made into EFI.
Even if it does not (as it is the case on arm64) the EFI function can
disable interrupts. This makes the time spent in EFI is not
deterministic.
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

v1=E2=80=A6v2: https://lore.kernel.org/all/20260205115559.1625236-1-bigeasy=
@linutronix.de/
  - For BH and WQ_ORDERED worker make the max_active RO.

Sebastian Andrzej Siewior (2):
  workqueue: Allow to expose ordered workqueues via sysfs
  efi: Allow to expose the workqueue via sysfs

 drivers/firmware/efi/efi.c |  2 +-
 kernel/workqueue.c         | 28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 9 deletions(-)

--=20
2.51.0


