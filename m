Return-Path: <linux-efi+bounces-6232-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOSNLjfRoWkfwgQAu9opvQ
	(envelope-from <linux-efi+bounces-6232-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:15:35 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28971BB4C7
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1C7303010F
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3235B636;
	Fri, 27 Feb 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfxHXcqw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F183542CF;
	Fri, 27 Feb 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212367; cv=none; b=qtWTXaKsmL1L0KuTmGjJBMH4eZ6XxA97oDIQE4ChpsBOA7k7mLIONL/S1bcuEHajmLCbWxOwOPXvsoXZ6Ydq67KtOS49EHriRz10sNe1TYM7euxtVOdoJOStguAtLKR95mqrrKyHNxVZD14zWo6tlXE7mnWWEoU4dfnyTn4tdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212367; c=relaxed/simple;
	bh=ZbvJgWVD+qFpuybrYYpMcarmcj1QcMZlioEjh2Nuf8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUOfTeTmeQdXGK5bim7ZZj8v+VKen+QOPnb3fzgattrBewqi7g1CXPUTOEkwR7mCkF3/wCiNwTeStRKWNMZUyldDPDOZu9uC3/D02Q8JHsso/c4tdAC3Zki7fJYgiiQ6Mhyz7/Bz4Ur4KrbX2yN3+LR6lM/RcUHUSvSL75/PB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfxHXcqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236AAC19421;
	Fri, 27 Feb 2026 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212367;
	bh=ZbvJgWVD+qFpuybrYYpMcarmcj1QcMZlioEjh2Nuf8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfxHXcqw6SE7e0vBq0NRyN6jWBLgU8cD/KgBnJbqjqS8RWsLOuAs13TNIwTviJPfi
	 RileBChTh9um+qj6838aXp+wWGyIEaP2s6/DENawcwQ5NpZ3UuJjvxbLsSofFluw6A
	 0CNZi8HO5NzCklAsEI4tgD0TWK7pzQhugwr8vt1/J1Y8n1lzHut7GlLfK1OtzN8x/W
	 EGvcsXeP1x8716A+PFXfaFuRMj/mssPZyCY0gCmJkqHhF8CScZ9t4NaMjWqSPVpr/T
	 7WLqzM+c1kLK7nyKh6LD1lar/EPYaLLgrS0qwQ1qmPxzp6JP9V8tykHS5v8TPjujjO
	 XJlfFXjKMn5kw==
Date: Fri, 27 Feb 2026 07:12:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/2] workqueue: Allow to expose ordered workqueues via
 sysfs
Message-ID: <aaHQjt8bZsFLBwfh@slm.duckdns.org>
References: <20260227170103.4042157-1-bigeasy@linutronix.de>
 <20260227170103.4042157-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227170103.4042157-2-bigeasy@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6232-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,kernel.org,linutronix.de,gmail.com,linaro.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,slm.duckdns.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F28971BB4C7
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 06:01:02PM +0100, Sebastian Andrzej Siewior wrote:
> Ordered workqueues are not exposed via sysfs because the 'max_active'
> attribute changes the number actives worker. More than one active worker
> can break ordering guarantees.
> 
> This can be avoided by forbidding writes the file for ordered
> workqueues. Exposing it via sysfs allows to alter other attributes such
> as the cpumask on which CPU the worker can run.
> 
> The 'max_active' value shouldn't be changed for BH worker because the
> core never spawns additional worker and the worker itself can not be
> preempted. So this make no sense.
> 
> Allow to expose ordered workqueues via sysfs if requested and forbid
> changing 'max_active' value for ordered and BH worker.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Tejun Heo <tj@kernel.org>

I can apply this to wq/for-7.1. Would that work?

Thanks.

-- 
tejun

