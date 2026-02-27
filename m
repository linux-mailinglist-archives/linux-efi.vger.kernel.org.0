Return-Path: <linux-efi+bounces-6235-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF8dAB/VoWlcwgQAu9opvQ
	(envelope-from <linux-efi+bounces-6235-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:32:15 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2791BB7D6
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2429B318DC74
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F9F356A3E;
	Fri, 27 Feb 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxKWXny2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72A346AC3;
	Fri, 27 Feb 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213237; cv=none; b=Bq045ZhFH4ca8oU90i6g5+HKcAQLyteSsC+hZ7iFwapNdPHKGlsLrTOKcqqu4GxqymfgfWEVXTiTbJyZ2dMy58fAGP9zM1OfKT7E5266dhQYOb5FFJt5Cl+lcaX/cLbYplRoh/Wk5Nogh7HKfJoYpe6TPIoB9NhnL/E852VmDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213237; c=relaxed/simple;
	bh=zXbg3heHcJnf2Ca4QKMj9VyTXBcTHYXmEwAj4WXaNm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxp3tn+f+7Vb75yVgEjr5idFfUralsCW6afIhlmqn8HeU8HafBSB3Y9SmmsMo39YDTmdOQVMuUCE+RHK8MN9V6puxVzdUkgoBGqry+c9jZPxaEDkqrytPdfJTZqd23cXQsAdzwiXgD9KjwzpFAErlQIny4Uu1rk6ZOWIIqyyIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxKWXny2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED80BC116C6;
	Fri, 27 Feb 2026 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772213237;
	bh=zXbg3heHcJnf2Ca4QKMj9VyTXBcTHYXmEwAj4WXaNm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxKWXny2blAaetTtiCh79m0gEIUEiuih/UucLEWnUKANdG/3PH1X25YAMUdi7GBeF
	 82DItd1D/G3vWIfNLNN2WYik1tHtg9PrtX6IECZrS45Wd4UzS4Xf21EaZkY4FFha/B
	 28QF37Y34cqstmYMYyj5UHvjaULBlbhTya0v3pftKYIp3PrnZowwedanR7QfiAFIXL
	 B3ZWoJnQi7s5/lVuRIsASqoJY10MdN6I2yckvOrZnBMxeJKprM4rrT9q/HAmc6+fsg
	 gxMUiyPDqGffTUWEyFsANH//bE910u76xwaPSzZSmjyO1t6W+/u0UzoNmKUGItp5Ue
	 6w/Iuu83WJtkg==
Date: Fri, 27 Feb 2026 07:27:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/2] workqueue: Allow to expose ordered workqueues via
 sysfs
Message-ID: <aaHT862yav5XxHMY@slm.duckdns.org>
References: <20260227170103.4042157-1-bigeasy@linutronix.de>
 <20260227170103.4042157-2-bigeasy@linutronix.de>
 <aaHQjt8bZsFLBwfh@slm.duckdns.org>
 <20260227171429.-Fwih-F3@linutronix.de>
 <98bc8bdf-e658-4018-a816-6cd75baaff9c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98bc8bdf-e658-4018-a816-6cd75baaff9c@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6235-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,lists.linux.dev,redhat.com,gmail.com,linaro.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F2791BB7D6
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 06:20:47PM +0100, Ard Biesheuvel wrote:
> 
> 
> On Fri, 27 Feb 2026, at 18:14, Sebastian Andrzej Siewior wrote:
> > On 2026-02-27 07:12:46 [-1000], Tejun Heo wrote:
> >> Acked-by: Tejun Heo <tj@kernel.org>
> > Thank.
> >
> >> I can apply this to wq/for-7.1. Would that work?
> >
> > I think you need to take both since 2/2 can't be applied independently.
> > Maybe Ard is going to give his blessing ;)
> >
> 
> iIRC I already acked v1.

Ard, do you want me to take both patches or wann pull from wq/for-7.1?

Thanks.

-- 
tejun

