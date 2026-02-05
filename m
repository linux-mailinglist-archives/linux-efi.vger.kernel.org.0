Return-Path: <linux-efi+bounces-6094-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL5GDboShWmc8AMAu9opvQ
	(envelope-from <linux-efi+bounces-6094-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 22:59:22 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB9F7EBC
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 22:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2606C3004623
	for <lists+linux-efi@lfdr.de>; Thu,  5 Feb 2026 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDD3346AD;
	Thu,  5 Feb 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4t6PqdQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B32334372;
	Thu,  5 Feb 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770328759; cv=none; b=UYcvLjw5alpOx0oTOBBQD8aIBpM21ZSS31pWl199NTzb4JP4o56n2fUzpyp2cU0AclvdveSwZCT+T5YsGluGTIGT3gVR+EnfVp0Gjyq3RHgM2fiRHYcwa9vMQbIaYYGr6FK/9qeoXPvc/wJrgyQhJe7RJBPlXzw3qSRwJmPNKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770328759; c=relaxed/simple;
	bh=sXaQ57x8gSeRJX5gWFkQTz7yJFcTWOilg+QmXgs9m6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1XZnRlElmFSsajE1s48nm/MJrGLE3scuFEtm+Lmir7KKiQIP8LaO+/h/SbWIuWwkXUwNljcTGjSXRJFZArdQLmYE9b94Asy5iCPoC2HdePZJoMTeKl21d7mq0dSbTzpASnk+ukjof8oVnR7hHpl+G9sPLH9uVE2iTKDr3wcgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4t6PqdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7E1C4CEF7;
	Thu,  5 Feb 2026 21:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770328759;
	bh=sXaQ57x8gSeRJX5gWFkQTz7yJFcTWOilg+QmXgs9m6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4t6PqdQ1vXDthoqYT2aAQkUlnGi8ljA64R9Lhve7Kc33R4fj7FMpuSJsF4/WYuqp
	 9dtf3OSQV9g/9mzltII93iCCWmtlqBlflaUPg6Oa3wkI/GAPFrKSQC9eAahLFrl03l
	 Ef7jOiJw1Jo5ZJvVXBua4hRYO1KP4ObKEQXIIthaTfZN+FLyq/FG3Z45JjShEpgbWT
	 Z/lxwaMKmDifVRS2Me/ubvgAbe5Ttf0sGvIoGyFJlms50q9BiSLUrAZci4hS9xNZpk
	 Tqa1UvDXFZWbhA0pSQmOsnxJZaKMnY6DKsMTVf3+A1hSTpj94mFGR/S7VO6zIIk0fm
	 lXaHa818MgHsA==
Date: Thu, 5 Feb 2026 11:59:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 1/2] workqueue: Allow to expose ordered workqueues via
 sysfs
Message-ID: <aYUStZH9dBw_xZkh@slm.duckdns.org>
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <20260205115559.1625236-2-bigeasy@linutronix.de>
 <20260205133913.538FuakM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205133913.538FuakM@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6094-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,kernel.org,linutronix.de,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: C7DB9F7EBC
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 02:39:13PM +0100, Sebastian Andrzej Siewior wrote:
> +static umode_t wq_sysfs_is_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct workqueue_struct *wq = dev_to_wq(dev);
> +
> +	/*
> +	 * Adjusting max_active breaks ordering guarantee. Changing it has no
> +	 * effect on BH worker. Limit max_active to RO in such case.
> +	 */
> +	if (wq->flags & (WQ_BH | __WQ_ORDERED))
> +		return 0444;
> +	return a->mode;
> +}
> +
> +static const struct attribute_group wq_sysfs_group = {
> +	.is_visible = wq_sysfs_is_visible,
> +	.attrs = wq_sysfs_attrs,
> +};
> +__ATTRIBUTE_GROUPS(wq_sysfs);

Yeah, this looks fine to me.

Thanks.

-- 
tejun

