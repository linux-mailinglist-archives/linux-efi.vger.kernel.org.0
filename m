Return-Path: <linux-efi+bounces-6110-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOUrD+h8jWng3AAAu9opvQ
	(envelope-from <linux-efi+bounces-6110-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 08:10:32 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963C12ADFD
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 08:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135193008D19
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CC2BE02A;
	Thu, 12 Feb 2026 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1PmCOY+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B1150997
	for <linux-efi@vger.kernel.org>; Thu, 12 Feb 2026 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880229; cv=pass; b=M+MAkn1TSPMIGxuK1FQeidVsF8BqUfwr7rMxAvLrLZny/wq9wPHfBEGn6LcPBLeVABotMEbObemhcjADg+RpsLebYxO1SEqhIw7F9743wogtlpF5yqXTBas4i+Cyk5DzSlmPKfBYhSwHnKI5jG8iQttOh1zEzWqzJG8VHeDiJqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880229; c=relaxed/simple;
	bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SclYLxLqO+QH5+c5Ewj84LpxVb4ccevrvd1PqtfPPhxnzTeb6dWar8yD2C2QIuX28B13xPUA6uLMqjK1/GuJpbBiVqYG4de/EFAnuaA6dnpd0R6gOHYdsL3RT8N6WMxwVt0CUuN8OQ0GgNe0wkFV6Qq+Q5QuimFjOYNP5X5nQpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1PmCOY+; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7964f1405a0so44909747b3.1
        for <linux-efi@vger.kernel.org>; Wed, 11 Feb 2026 23:10:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770880227; cv=none;
        d=google.com; s=arc-20240605;
        b=ANHgtJWwZuXb8AkrWap2Mtwqz7LQF90qQt10Ic/WNCgJjhU+7rdRxBCFu/ZyW81QrV
         bu32DqyiEr5CGrOLuOhBYg5TfPfLjs/e0XMB58xSq4D/aSQoCy31EAkX06qXFZFFK7i7
         ZMysNG+CAG63Eox2p3MzULcfwDJZ1VcvypE45zQv2xBBaNtzlD7CWkUSYpYeUkMJ5eMr
         lS66rUC0oX+Pi0ZKjO1q+hTLK+Gs9I/O/xSI2jSRWmETUT3jwcKULAHaS6o+fwPHfnt0
         KxmLk/W4pvTkcj0oLb5wf4kzSD76pHDQC4vR7onj78SBMWsto1Eg+F7g1XzSa8mU9eVX
         73RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
        fh=bRqWNGetuxbI4FUOAQdYYW1NiEGw9QLuB+Oa+qJ31pU=;
        b=lJvFmtK9hVFISPw+wVxFGQf3yLRkP7nLvgP/QYz27FThOf/21EFtmUkwduuimwKhhT
         6SdHUV1JnisLihCMmQ4/W1fjmnhBSDzBO60cmcmqaThIQvybpXu+iK6LogqWBAHS1jPT
         ylACxRtpcXBwYZWi+pKs+jEwtCch7qm/LctOQd7phscP8qtCVuSbJ4ApWXZ+AvCNrCG3
         THKs91EfFqB6QlLWL9hSDzJCiK2BCXDaXXPf2TswATEIGNEcpJ24lFcwB7QpYDaROAte
         Ji0xGpJXz9g7z1xlICRd5PHjK8yrQgJhdr/TeIMRD3fIL0q7MT5gUVa6JINyCduECOuO
         xW7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770880227; x=1771485027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
        b=k1PmCOY+9kdXP7faQ4Go6iMjI/8/I3gr7x9oUBDfSUVVCH67gRZNthV2+70SvaQfKV
         FNNvsQ3ewMkYIFm/a6vrkd7W1CE4eYHZ4XsN4RWs0LOUNn2OT+DgmlMIMzFvtZWof2Vt
         IUUV/Pe+V3O8HaBa9tK3D5joPHboWtRJw4IdWpk++IoPMrFHqf20kAvYgRxBmCfakUp7
         X9Sjgfc/apSuxNB5ZZVHGUjTf66KvkR5clLR7qlkzfjqBSlqXM/66CBb5m6MzKo7murc
         bPFiOs5XRJvxvFPzMDRSfOHpbvMXjoh3R7T87UbN5FcQ5nsI7xex2/buUaOOCuSJDlCq
         gSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770880227; x=1771485027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
        b=nQpS/KGZ3FwqOBCQo3x1oDYY3JLXK1Iosgvp7PvLN2J345jQ9tMEX8LOnBm0KB+FkW
         f92YZugMd+GpbLCyyuAtERKZqQT4x9+YiRH25Yn30hMAxqYwlenme+0gEmt638oF9jam
         GHrXAmGb3xD4/dpXDu2jCrpnOeMckgy0uVEb6u8m36eIKP4kVGDLxjC2fPSh6/a+hlQg
         6JHf4Egcskhri8EGqj/eGeRLKFFNFA2kQ2svT3MPCDBodYHD6iSQvLcDk1MmYZSycnRV
         GL2DmbnP4xKm8WL6A2YgzNTXZU6eM73LyyrV29tJJN2LDw2sKM/h+VVzfaQn87Ib+4FA
         lSHg==
X-Forwarded-Encrypted: i=1; AJvYcCVJQiw4Dr/vFv6h+R+87W7Jzq1LU/szhbE575R/qjhhmqaS/nGA+6gcyCmSMLkyghsKLrLaGdfl2hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WYvK5mIWI7ikb/5I43VgGnrRCGLl6uMPjsL1wzBg0havYcgn
	V599UVbwyM2u6nGcsZpOGB8W0j4vZlN4jXktP3qWxqopRDQ3TEOkMaVXnn++9BXXbGIGTIWf/Z0
	2g+KpBy7RY68a5d+sRhdl8F30E+astfr+7Vv7UtIQHA==
X-Gm-Gg: AZuq6aKbDfpTtNr4Qtwfye8iew4q2OOMtJ6PjwUzqOHdiNAKPtsBXsqbPIt61wmxb2a
	pQvJzgJFnH5CIyT1CZyfTEgMKQ5XdNQ3SVktUffpA6LTv5DqH+swDYrA/pY1p7Fbj6AeZBmYtYU
	yDdcLl7E2ynJMNA6ZFh3wJ9Yg2uSt4gRnQbor4OsAwbeW2SlOplHu+0pyZj0gRdVjfFwZc8UD6M
	1p42p5TCxybfkee+Wwu6jDib9RnaBTgiJ78pAT5y3FtpjvQ4Qjxq6YKQkMZ99/OTuqP9NMg8Zvw
	4sX42j9QE30XaBUYKAzJl0JPdry4unduLUFf6npHemsdA2ut6cVQVwXRQzM7ESpv/YLDnHtWp8S
	qfdGTorUtpbK9/aLjyAmlIJUOI31EeMx8RjosT2MfP46XsGf+AwdndLpfyRX1gNLfnouwvqE8ZB
	hgc/qHyHc7PQA4lCHbXpph5tFN2RKjO/pizoRTlYgYkyHtaZLsrPEEIn/iLW1nhQBZ6Y4fpEnSU
	SJGiaB5MsKtM6DvmfNWJhJB2Wvos1+cj00vRmrcyQ4mpMurugL2yiihc4jfj9TOxqXULXqAYPyu
	oaRKI5l2tyOfJO/wVcoxRCVDY4MCSKODV8hkNVNuzLnP
X-Received: by 2002:a05:690c:d92:b0:795:294c:fd5c with SMTP id
 00721157ae682-797377c6342mr21105127b3.54.1770880226856; Wed, 11 Feb 2026
 23:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <aYn6j_JLBENcY96V@redhat.com> <20260209155528.k7RMRPVD@linutronix.de>
In-Reply-To: <20260209155528.k7RMRPVD@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Feb 2026 09:09:51 +0200
X-Gm-Features: AZwV_QgV0EeSzgexrImustAVkDXwmMOeACoWIeW_o8NOkYjmco0xL_-FUB4iv7A
Message-ID: <CAC_iWjLt-CzTkmnVMHidnMFWkE9NPzVLo6g8FUgMu0gAUJ0KtQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6110-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lists.linux.dev,kernel.org,linutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 7963C12ADFD
X-Rspamd-Action: no action

Hi Sebastian,

Late to the party but ...

On Mon, 9 Feb 2026 at 17:55, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-02-09 12:17:35 [-0300], Luis Claudio R. Goncalves wrote:
> > Sebastian, as for the TEE feature you mentioned, is there specific test I
> > should run? Or is there any test you would like me to run in the context of
> > this change?
>
> Puh.
> If you have a TEE environment, then the EFI interface should be
> "supplied" the TEE instead the runtime-wrappers. My guess is that
> tee_get_variable() would be used instead and here the workqueue won't be
> used (I think). So that is the easy part.
>
> What I don't know is if this is a problem, i.e. is it possible to
> interrupt the secure monitor and continue in Linux before heading back
> to the secure environment or not.

In theory yes. In practice, at least for arm & OP-TEE, the
communication between the TEE and the secure-world app doing the
variable chekcs & authentication is via the MM protocol [0].
IIRC that requires to run to completion. So what happens is that you
enter OP-TEE and right before the StMM is invoked (the app that
handles EFI variables) all exceptions are masked and it must run to
completion.
The period of masking does not include writing the variables to
storage. That's handled differently and is interruptible.

> If you could check how long you end up in the next variable and RTC call
> and if the time is noticeable, do you see it in cyclictest or not.
> So if the EFI-TEE-RTC-callback takes always >1ms and you don't see this
> in cyclictest as a spike then it should be good.
>
> Sebastian
>

[0] https://documentation-service.arm.com/static/5ed11e40ca06a95ce53f905c

Cheers
/Ilias

