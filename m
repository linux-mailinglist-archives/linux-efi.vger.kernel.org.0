Return-Path: <linux-efi+bounces-6233-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAw8GqTRoWkfwgQAu9opvQ
	(envelope-from <linux-efi+bounces-6233-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:17:24 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B2B1BB4F4
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927E13033890
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092ED361640;
	Fri, 27 Feb 2026 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RaIuikwM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0MpFwEX"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48D361DDF;
	Fri, 27 Feb 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212477; cv=none; b=Dh1gahmTYSDhgUJzeBBAVnTJ9YC4Dlr7isVuickfE97vX3scGwYcHmMEeE68eqOAel9VZKUJrfFQfC02VbYy52IJblu/STLKTopeYQS3asSP1nYslFMOFh9WHzSEY+z6SyZs3sogTVUrnQMMYdopAZ8obGkkY6yf7g2Ka4aAzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212477; c=relaxed/simple;
	bh=Nq3e5rr9eqP4frKaVBR1bUzIcrN1fo3dmGe77WArFgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTSTA0D1cN5zDk+1691OWoAIezdWRoVig7v5BN8HtD1GOzI5Sj01NoermypJCQR3V/IVIYtDBvmt4C9KqfHLVv8salxl4PHTBLpUIox951cb/fIpqDcwpbCosoMmVucC5CEEeUzl41DhL6hPxhpmQY86Q++LuDm1FYMh6JRhedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RaIuikwM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0MpFwEX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Feb 2026 18:14:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772212470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nq3e5rr9eqP4frKaVBR1bUzIcrN1fo3dmGe77WArFgw=;
	b=RaIuikwMWgHZ/FeytgRzQ1DqPBy6vmwawbRVGiKQ86wFPAK2JM01GjI0393COhe1a5YCEj
	70AlpUw83sd0GSKwT/wbLTq5WPMYP4pwlIkGsFzQ6go6aFKwsxPJ2KC7Bh59Goid8BMAlT
	XArushhFyD/1Biw3XPr3RUVLpGImr7JuwZj7VZUrCbx+Ce52mYcCWOW+OJ7AdsvwA9BwYj
	W+TVfovRe8DqvXxEUnxeSXQU5NP0n6YYOBjS/g7Ym/TtcxCz6FyTUvk5i1paQSIIUP7ScM
	ZmvRlID6Kqn0c+17sUJTJ+vkhDxwhqi1mvDL7csR9+i4vYcRtE5mFiJcB9+L4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772212470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nq3e5rr9eqP4frKaVBR1bUzIcrN1fo3dmGe77WArFgw=;
	b=D0MpFwEX1l36OSYhxDLXfFqjKpfX/1UJq1ZMQ8Kwl6bJeg3Ql1w5Fmo15qC77yZIE0l6ex
	avGuuwL/Ms3XAEAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/2] workqueue: Allow to expose ordered workqueues via
 sysfs
Message-ID: <20260227171429.-Fwih-F3@linutronix.de>
References: <20260227170103.4042157-1-bigeasy@linutronix.de>
 <20260227170103.4042157-2-bigeasy@linutronix.de>
 <aaHQjt8bZsFLBwfh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaHQjt8bZsFLBwfh@slm.duckdns.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,kernel.org,linutronix.de,gmail.com,linaro.org];
	TAGGED_FROM(0.00)[bounces-6233-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8B2B1BB4F4
X-Rspamd-Action: no action

On 2026-02-27 07:12:46 [-1000], Tejun Heo wrote:
> Acked-by: Tejun Heo <tj@kernel.org>
Thank.

> I can apply this to wq/for-7.1. Would that work?

I think you need to take both since 2/2 can't be applied independently.
Maybe Ard is going to give his blessing ;)

> Thanks.

Sebastian

