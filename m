Return-Path: <linux-efi+bounces-6092-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC+9HmSehGmI3wMAu9opvQ
	(envelope-from <linux-efi+bounces-6092-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 14:43:00 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF298F372C
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 14:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCD73305AF12
	for <lists+linux-efi@lfdr.de>; Thu,  5 Feb 2026 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D45233722;
	Thu,  5 Feb 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UfmRY0Ro";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhalQcwl"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE622FE0E;
	Thu,  5 Feb 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298757; cv=none; b=IR5tadDC01EP5blxh6m3PAFUL+Zzofkb6X2Wx3cXKsCoJCG3KPNDoTJYPajONjMwSN3Kj/DDoZ0TbF2R6k0hBgYbkD+p8CFnAfPEQcSCgK6G3KRgdVJP7AjdiO1bNY6/lPUp2AzCcSVdS35BiDkYmcbsR4rPrM9YtkkeigGw4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298757; c=relaxed/simple;
	bh=6CsAIiuyYc00x77dXx4ScIateCoMcbTTrI0L+Akksig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC3YmkVB29vMoDNLfzPZK/jSZnKFI5V2w6+j+XOgj0ZB7wmh2rZeHnVcsWX9Xr+huIleGeD1iy/UhGx0L+CNpmHeD8cdCGZwLZAwGSObrnZ9M7Zejgldyhv0epkiUKMgvQ/4j5uWr8tCyvUiQ39AbdSBcTRIJrQUO0+Buoa6jCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UfmRY0Ro; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhalQcwl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Feb 2026 14:39:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770298755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iI9QRXVrM7uSTSrnn2cfxBV05Er4hA7TWJScgu7Qpwk=;
	b=UfmRY0RoLp0uVJ8wmbDAStyHr8Fdzo1MLQTPTfAfaDKa0X25H4ojivUPsC5YjKbgAwu+EJ
	exWOxumtc5rMecooprSjoCdCaHyR8z+W/la1JLIQPFEuB8f3RqtpS7rptZw1LIUoUPamme
	5xNaCbO5TFaa1fGlzjd/y8sDUVA+iqSsNECPKK8veNcdYCExckz+yBDZZ8JN7TCYBTLD0N
	0icLOjmfS8aGbgfn0E1857uFCb26CExAFXYcCn7yExBSHIq4OvkiPLkUtMh7RN/i0SlVBQ
	9v0s96UErrNJTAw5A7d/ts49C0xZUVyKXjB0rz0Yr7Xiar+g7iF5FpG3Iclfcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770298755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iI9QRXVrM7uSTSrnn2cfxBV05Er4hA7TWJScgu7Qpwk=;
	b=PhalQcwlYWKEOezPFjXCg75I6bz5u5bPLDdrwcMz8joZ/BpwglNge3raVtgKuz0qkb1dsw
	f0dg/g1JtNtizICw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 1/2] workqueue: Allow to expose ordered workqueues via
 sysfs
Message-ID: <20260205133913.538FuakM@linutronix.de>
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <20260205115559.1625236-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205115559.1625236-2-bigeasy@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-6092-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF298F372C
X-Rspamd-Action: no action

On 2026-02-05 12:55:58 [+0100], To linux-efi@vger.kernel.org wrote:
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7097,6 +7097,13 @@ static ssize_t max_active_store(struct device *dev,
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	int val;
>  
> +	/*
> +	 * Adjusting max_active breaks ordering guarantee. Changing it has no
> +	 * effect on BH worker.
> +	 */
> +	if (wq->flags & (WQ_BH | __WQ_ORDERED))
> +		return -EACCES;
> +
>  	if (sscanf(buf, "%d", &val) != 1 || val <= 0)
>  		return -EINVAL;

I have been informed that instead of this -EACCES I could do the
following and exposing only the max_active (and per_cpu) attribute as
RO instead.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 625ee8cc47f40..793b59ce99edb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7097,13 +7097,6 @@ static ssize_t max_active_store(struct device *dev,
 	struct workqueue_struct *wq = dev_to_wq(dev);
 	int val;
 
-	/*
-	 * Adjusting max_active breaks ordering guarantee. Changing it has no
-	 * effect on BH worker.
-	 */
-	if (wq->flags & (WQ_BH | __WQ_ORDERED))
-		return -EACCES;
-
 	if (sscanf(buf, "%d", &val) != 1 || val <= 0)
 		return -EINVAL;
 
@@ -7117,7 +7110,26 @@ static struct attribute *wq_sysfs_attrs[] = {
 	&dev_attr_max_active.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(wq_sysfs);
+
+static umode_t wq_sysfs_is_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct workqueue_struct *wq = dev_to_wq(dev);
+
+	/*
+	 * Adjusting max_active breaks ordering guarantee. Changing it has no
+	 * effect on BH worker. Limit max_active to RO in such case.
+	 */
+	if (wq->flags & (WQ_BH | __WQ_ORDERED))
+		return 0444;
+	return a->mode;
+}
+
+static const struct attribute_group wq_sysfs_group = {
+	.is_visible = wq_sysfs_is_visible,
+	.attrs = wq_sysfs_attrs,
+};
+__ATTRIBUTE_GROUPS(wq_sysfs);
 
 static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)

