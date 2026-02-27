Return-Path: <linux-efi+bounces-6237-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O8lJFjtoWmJxQQAu9opvQ
	(envelope-from <linux-efi+bounces-6237-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 20:15:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024E1BC8F0
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07B730B12D7
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23963A9D93;
	Fri, 27 Feb 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJpeJoyz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD454394474;
	Fri, 27 Feb 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219443; cv=none; b=nGiVkfIA/5TXK3J3SrmGLmieNiNVZzkgDQDCSHEIjypeHzbPFbtIqH3s/i+mBBlVQ4hQW4USIHRO8HihZXFRq3am//grqrebJ9BEC0n5b4kG2ugQXJNuTMI7SI94JAefp+YDdhXbyakOEtnl8qtCk1GA0pOzTyFGtdjpEz09iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219443; c=relaxed/simple;
	bh=no8ClgnPhSmyP7h6Q8Hxwcc/HuHz9H7LCKYKMsyTPgo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lV66/sZy2M6KmNQ7zCyAR1gmY5usj9DAUt7zB3EgSIkKaHvFAfm0iEiEIdMFLO7mr3BIU/gtMurg4yCUoiwSB54524bo0PA85xn5wRaX/WVNZBpb3l7l7gbxp6AR/bF+1o0nxp6igh7ndYfMQoQkJkqIXC8L1IxQYw1p3nEtEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJpeJoyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E5CC116C6;
	Fri, 27 Feb 2026 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772219443;
	bh=no8ClgnPhSmyP7h6Q8Hxwcc/HuHz9H7LCKYKMsyTPgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lJpeJoyzwi/+1bnBG1ozfGLN5R3I/rN4o9G5JfNMn0hlXH0OLr2R/YOXNrG4NE7qT
	 7p9a60EevUKUSt1yAXbw9tn1ofsu29a4tcq+ReIhsFQAP7TvdcR26R/ApwdyhGHtT4
	 Ob6QQriZzmC+qox5hDn67QnbYMDpGewq+oX3/rUVukl36qRxdgHso6Nw2o2ecT6JLk
	 sUZmoDVvO7t6t+Qx+ZS7+S9i9HrIRWwWNeNjX1dAqbNz84tnnLa8Njsq4M8GIT6dbm
	 JAH0GymSSiP2t0ZO0KYgYfCxhwdUGhwgtnlerBufvqQ6k1UAXUzhOErLPtUFdGOPSF
	 sgaBmVKByRsEQ==
Date: Fri, 27 Feb 2026 09:10:42 -1000
Message-ID: <39a8d1c273f773460e4e972b047ee67c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 John Ogness <john.ogness@linutronix.de>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/2] efi: Expose the runtime-services workqueue
 via sysfs
In-Reply-To: <20260227170103.4042157-1-bigeasy@linutronix.de>
References: <20260227170103.4042157-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6237-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,kernel.org,linutronix.de,gmail.com,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-efi@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5024E1BC8F0
X-Rspamd-Action: no action

Applied to wq/for-7.1.

Thanks.

--
tejun

