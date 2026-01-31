Return-Path: <linux-efi+bounces-6063-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBkQEnNVfWn9RQIAu9opvQ
	(envelope-from <linux-efi+bounces-6063-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 02:05:55 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1462BFD7B
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 02:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FB6A3004F09
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 01:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC731B810;
	Sat, 31 Jan 2026 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HllqAs+/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FE3191D6
	for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821549; cv=pass; b=dLVf72vxaJFG4weOM21rh/9wMZZ5wQJvoLz1+0wOWki1MY879aonllMrTIq4PQnWg5RlrcHGT0LHYRv4qcPUF+B3ZTTIznGx/iJgUZemF9+6thUQr069ybgIu088yVE97ynLJ0BTZ5ftcjDzxjjNSQlTbRvPrLXGXGSSeoc6MiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821549; c=relaxed/simple;
	bh=xauAVDrNEqxXuQQDfkuXjcLzA9iR5d/8KDCLj8SlAUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDltHPvMioGoQDdjwGqQvGWchvZkN/V8ydBjc7aNjWscTi97C5s3IpgsADXDD7Wns9A3KGgsOGGilDyaiDM22JepMNZ7jDkN4QyzjyO2R2qF7cZF8SyP5gvwWE5UfJ6PoxegRDIU6It4DKZ9Ne3Q14bfyRKsz+9tbe2o7I8Vzuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HllqAs+/; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b872f1c31f1so350379166b.0
        for <linux-efi@vger.kernel.org>; Fri, 30 Jan 2026 17:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769821546; cv=none;
        d=google.com; s=arc-20240605;
        b=FBAWoQ5GjurnGIfpKUpQfHuHA/YC78BAqSmjApFmIrSKckYZKsjuOhQ9QPvwBU3CRA
         BM22qrcoHSs9S8NZ0W2DH3vWETcA5/MAx2oO1GmBIXcs7cUOABuVrT+EEteLOJ0EKafm
         /L8GMSrbGGq5g6ubj9Fp6LDL3jvjASYhXRN5S22NAcyO18+xAjCfOVq3QuYKqBB/wPcJ
         MwLkEPr3t5gjrezHUDurI24sAwjQ6KYpMZrlPdMDFB6EjZKj1+kZt0kZUpfZtVBm2tRU
         mk01CqdHP07iNT8LSApy0N87vbGYltxLz/j6kE/HTO4T/LpHNn3D4Md7SIkZeE86H0T2
         vK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        fh=+VpeXNDrRlAEpSvuItVMwW5h8JMAjqri5JTWtALzeAE=;
        b=hVKZ9LCYqPElNgXj9KUmrfkBOeicPG9lCt7smWc6x431j/9tf108gRiZrS6O4BZWDa
         yGiN4nHkx1HgABR2FxfE1RoWuvo8wJteCXSjMV57pvBHb/iqrfwW0KJQ27h4rvUl5qRa
         m3tp4qfmJ3cInUiey5xUt2rLQSJOFnn1sXnqJdtHsd/x4849bsh6UltQPYwpWFcayecK
         NPqOddRMIys+vOmg5tQu/Ubni3A37pet+5YnkZLwyZW+yHc2W7BkWC5mI3gM0/leRlKa
         aib+EKJsz1ja9vHkAUVPRF2WOH4BgcEi4+4hZsg+HwiymHWnGQlaZpiw3RaLHqiqQo3d
         x+Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769821546; x=1770426346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=HllqAs+/IWHE2+kQ9ii8b5Gtko1h7Ik70Pwl45FY+prbj2XSVoNyELK+flYSa2NQo8
         EXfzD6mw0oX/ZlcIu3rfD3gSpUvxACQGYIH/Tl36lScTzSqGPf7KX8gtg3w/jdI+zaqh
         b70RFAKtyAAsDtS1eh60MRioJEW4g53yrxfS3kn8JvPA1T8gyDJ3TbalXssoUOVJkQbB
         jvGjJObfMMQbMdMBdGn+zwg4BMNPdymUx9VX9d4oC/MnBUwn5iYrXwM6DX/OcGYm3wZH
         /zCPYr3iPl0vH84xBlQRUFtR3PnsqszdSt7W3HzHNo81Di8s17L3tMFO2MgvOo+9Qs0Y
         at9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769821546; x=1770426346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=Uldr87tDsi+VLK9XwftDfNd3I5QLqZ9XfTGMlExoR5ZpOrfSvtv3vV8HTlTieijNNg
         rXSw0hgKMDic6EL2ZIpYsApfyOK2LIMuP91oRHe3ulqYgUY/uNnitWh8TEaLi2sl8Sol
         sd20oqYqj5vURGiAmrSFm65Zel0py8bIGVkbCTXtzsdkthGXsD2899KlLzEhL6x2755J
         rB/cjSV1RhAECQ700+SnaHtfdTPLMyRylyHKr+B/PizTrp2UHcOMMOpYuaNLTLx8oFks
         FrrTC6gOwUq8iteyfvUNFw7rIVvRIp55U8k3YPMgOkzuLpP+Dxj8WSH6xTriJOVERs1v
         sLEg==
X-Forwarded-Encrypted: i=1; AJvYcCX2MmwqJMSbigtnHa6HzU86g4XeHDmGyoBXzq31PjbnYh65VE7ja1aUXR+Moo4ADZw4rQsu7emEIR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0pfJu2OyBYufj2J8JXxgGimRb3TlYcu4Bk4OkbjrkCha7eOf
	3504Ru40wt95ohHf7XKH14SM6yhvR7eozZIUptXnrmzYQgvWOGotcZpQWkxGjiyCfl50Ox3D4Zg
	DhdQci/UNXyXdo8FsncKngJh1uL8tAFqRJTGHAluT
X-Gm-Gg: AZuq6aJnN7g89xtVZhTlYcHB+stvimsxRPcgeoQuqou1aaQc6D3FsQcZzoXoujq/uqF
	H8GXNmo8rFLUrnA5dDapP3195l7kObah6jWTkoXMAPsS6Uj11EeS/po/oscb9FSENxcUWki7zZK
	Ch2NrMwom1kEUXzSNnWJWNOnvJvgIjS8fofsZNMrbg+X1oBnhyagQ0J/fM99PcdWKu7h3W0TqlW
	B5oVSode4g9KiRDR3xwcW/71rGJKu63yka8Aak59iZ2Ru4uqQ8Yc+QP1yQXKfvhWaykMp8RMzEN
	6Yw=
X-Received: by 2002:a17:907:3e0d:b0:b87:322d:a8bc with SMTP id
 a640c23a62f3a-b8dff696c0fmr254282166b.31.1769821545900; Fri, 30 Jan 2026
 17:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 17:05:34 -0800
X-Gm-Features: AZwV_Qi-TVApb-UR_yhUuzDZcqy8acCYfKVdTsorIhJOL99wmGwpM0Som40uK5A
Message-ID: <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6063-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Queue-Id: E1462BFD7B
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 3:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> So we have something that does O_NDELAY opens of ep0 *and* does not retry=
 on
> EAGAIN?
>
> How lovely...  Could you slap
>         WARN_ON(ret =3D=3D -EAGAIN);
> right before that
>         if (ret < 0)
>                 return ret;

Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs with
this addition.

> in there and see which process is doing that?  Regression is a regression=
,
> odd userland or not, but I would like to see what is that userland actual=
ly
> trying to do there.
>
> *grumble*
>
> IMO at that point we have two problems - one is how to avoid a revert of =
the
> tail of tree-in-dcache series, another is how to deal with quite real
> preexisting bugs in functionfs.
>
> Another thing to try (not as a suggestion of a fix, just an attempt to fi=
gure
> out how badly would the things break): in current mainline replace that
>         ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK)
> in ffs_ep0_open() with
>         ffs_mutex_lock(&ffs->mutex, false)
> and see how badly do the things regress for userland.  Again, I'm not say=
ing
> that this is a fix - just trying to get some sense of what's the userland
> is doing.

Ergo this didn't make a difference either.

