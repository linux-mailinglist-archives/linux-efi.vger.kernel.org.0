Return-Path: <linux-efi+bounces-6177-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mETZISQblmntaAIAu9opvQ
	(envelope-from <linux-efi+bounces-6177-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 21:03:48 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B31594E8
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 21:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B9630125D5
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD10342160;
	Wed, 18 Feb 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="OpxqkiwA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697E2E542A
	for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445022; cv=pass; b=uzJwSeC34RIxpbGYICp6miIaZYh7trHsPHpvNb5qGw9O7X3z4XQXOlOb8PB88rNTUZcrAjkyWkbZyu5EGevQCxkVVs/TvpplZi34mMhdVbafHtCsBet5gOH0ssP8Js45y9/yGIhVlH1yCHoGP+1vfDOx5jeGHi7VytNfOXlJkgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445022; c=relaxed/simple;
	bh=A9RFDZyZgqlQJkBPPEH0bt0olncW7jJuhWCZ9JoO/s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mp75ljHIVJ52kEn7xS68wE5JuBqwirY9lm+I/3qZ1BGa/6l9tFhr3vanCf/oefOT6jFPxTZ+cjo+CpKPHPU4C+SsFqMQeuOWeaa4St3xHR3gOz4E6/sig+KGCwA3XSpr/T3nUgnGF3AHpQRFC+nQ0s6GpqoBw/p1zqujbSMeiv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=OpxqkiwA; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e64657f0cso289947e87.2
        for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 12:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771445020; cv=none;
        d=google.com; s=arc-20240605;
        b=T1PpvWgT6E6amJJreD1qUYJYJ6Qw56356l45rTiiVkAVAS3n9ADlnpWeiPy5daytTr
         CJO7VCZ2xxs+UAUAQZyT3IS97KjK6K2rYV/82Ir+vebUQQc7ZwYe0vQYZbNK76HBvDcz
         lf/MDWUztS3QsID4TwJ9ZpHZcvjF7w/qg2yWd2lCEXqqpKtnkhbqEiSPjGXvTbjVGx36
         2OzlYKsa6QljjvHkO9YjH67N1SQH+A0ImYeQcKIYMwOyMtg0UXKD8Cr3PJP2fQ1mQBOL
         d5rsg9YPK56BEXFdjWUgnj2jvXSfUbQnHHERt7BKFxQIG+AUbIeleevxnJUbfeJRMCHy
         pm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        fh=93WbfcW+NWJ4UslQ1euoMmwThoSqeqCT0TfmzbUbUG4=;
        b=SrJnpikznDhLwJXqaUlelJRIWyyCTfAh+kpkP2d9d+FUmICHgW1RqQd0iCM/50PscF
         4eMR00RYDxms8akZtd1+ZdAUNnzwqvkSWaPGsJRdeA2LIFIM5lmP4Hn6VpuHRpcfOAjB
         n0zPp0LSWjB0GWbRQFzwlxb+PKvbDXSq+y4P5T4y88vXDaUpFc4f2gu0a8NjHisgfZiZ
         LXMG+5uIivfKeYZWTjMKdfk2Gozk9PCfuygE4NErj+/CxpqTfsha0EC54xCjU5zHCm1d
         UdFstYrS7r0PVmCB1uA+71D9aBQBC4qIv7d1YJFaYXeDcLfWpWqqtdjivi7JGI+V53Yv
         bpVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771445020; x=1772049820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        b=OpxqkiwAUUWIfdMsKeV4jtOeUyJ54S5Q3gIl6IWomGB28pWLQ43/VZ2PPrPiJLFn6l
         geHXyDnsYHJCBuvKcKva6n0DQffN04OwxU/4M7eC72DW8P+FW9TGf76yQTqVcGZ39RB9
         xSDwuctxDlLpZnWMrM5/OMqLl4fuqhU/Np7zLrUC/rK+nDca8x9sisN+VjggnR/U1YVf
         BBaMNVWeYHdlS8zYxYiGoqtDsVTeqXx6Ku5JCJYMqYMej/Cvi+xikyOHdKCyULiuHfKS
         +s/YQnj8cyCckPBiCdB4cJhUF50hvTz95aJYnjMKO+epQEN4w6GWsNcRW1q7xuJ1RV2C
         VEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445020; x=1772049820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        b=j+ekmxQqnEJ1BvYsWPUv7/4nAvD/5HEvyMqQL0R+wFJLvySr5s0EcdHc4okBXiVNmh
         QFNcn6RJLe8ayOuYuKgcXLpfNiMkkzf98JgYhwhTA07D/cYhkWv7kMiSy9vKadvi9nl/
         gZpx0FHZHQy98duu99igh85gjxyAQEDFiOK6ryigzJgjQffUxDV4TvWpUXmqGwYUbBgm
         j0s/gLm86j1chuKKTWsDgDHDPsRUzXkKzu5QwULMxWjcfD6OlHqrJYmO8l4+YTUqJP34
         DLGVJ9I0V1H8QjGbuQEnZVxQnNYglXh1wAwPWevYm3s2tDC7cxCfKKxg/pcGiLGx1apM
         JVKw==
X-Forwarded-Encrypted: i=1; AJvYcCXkec4lzTNe34Xeq/mQL26a8vhjrXfujz2CdisjvK596Bqm/RtRpfJTRRzJtyue+ZfoDvk/TD46rno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbq3zAz4T5E3Gz4BMnp62fu+/l41IRlIqUJhFKrsrrwz7enQA/
	FoKEi1lLhLT07BL9VKUB8f0w406C2pchz44/6tennLGZTwSWlUqyogrcAzjmFf+nSTbwnCZ93FY
	uvRpJIeq5vGMoYIhAj5ayE4jFK90CjgXqeefAXvL2
X-Gm-Gg: AZuq6aKJbktWPNsEXTINAfINuSAIXdaFd3AsKvFV2xhYiP+BYWEAWBShZITGRW6EdF3
	oC7L9G3hzCClBIX9taDyQ6Z3eEo4NAluP1OlicRHJYALjfGUazHrCSQOOBFH4Mw639BOIv8hjM5
	FX23H9dYDfs3HNa1ih8+mZap3v5XwjJO5+cCqJQ4hGCBJUji+nrICuDn+gLJtbcwDRuZNVSg8nE
	+sFRT587VWv/TChwJQsfwtcnomzogtWZaNvVQfAH4Jeyp1z1tQHBfEKNeR9d9J1YHniL3UG+I/u
	LVjAN64I8LtefJo=
X-Received: by 2002:a05:6512:3992:b0:59f:6edb:b7ea with SMTP id
 2adb3069b0e04-59f6edbb86bmr4081097e87.42.1771445019417; Wed, 18 Feb 2026
 12:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
In-Reply-To: <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 12:03:27 -0800
X-Gm-Features: AaiRm50K0AfYUHogK4D4rjv3z3w5Xga5sdt_IpbZg6dO6uXxKWdtAoPp16KXxJI
Message-ID: <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6177-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[apertussolutions.com,oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,redhat.com,alien8.de,zytor.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital-net.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D93B31594E8
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > On 2/9/26 09:04, Ard Biesheuvel wrote:
> ...
> >> Surprisingly, even when doing a secure launch, the EFI runtime service=
s still work happily, which means (AIUI) that code that was excluded from t=
he D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RTM e=
ntirely in the case some exploit is hidden in the EFI runtime code? Should =
we measure the contents of EfiRuntimeServicesCode regions too?
> >
> > Yes, in fact in the early days I specifically stated that we should
> > provide for the ability to measure the RS blocks. Particularly if you
> > are not in an environment where you can isolate the calls to RS from th=
e
> > TCB. While the RS can pose runtime corruption risks, the larger concern
> > is integrating the D-RTM validation of the Intel System Resources
> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the Intel
> > System Security Report (ISSR). Within the ISSR is a list of memory
> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's acces=
s
> > when running. This allows a kernel to restrict what access a SMI handle=
r
> > are able to reach, thus allowing them to be removed from the TCB when
> > the appropriate guards are put in place.
> >
> > If you are interested in understanding these further, Satoshi Tanda has
> > probably the best technical explanation without Intel market speak.
> >
> > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> >
>
> Thanks, I'll take a look at those.
>
> But would it be better to disable the runtime services by default when do=
ing a secure launch? PREEMPT_RT already does the same.

So I have a possible way to disable EFI runtime service without losing
the ability to write EFI vars.  We come up with a simple file format
to store deferred EFI var updates and we come up with a place to put
it so that we find it early-ish in boot the next time around.  (This
could be done via integration with systemd-boot or shim some other
boot loader or it could actually be part of the kernel.)  And then,
instead of writing variables directly, we write them to the deferred
list and then update them on reboot (before TXT launch, etc).  [0]
This would be a distincly nontrivial project and would not work for
all configurations.

As a maybe less painful option, we could disable EFI runtime services
but have a root-writable thing in sysfs that (a) turns them back on
but (b) first extends a PCR to say that they're turned back on.

(Or someone could try running runtime services at CPL3...)

[0] I have thought for years that Intel and AMD should do this on
their end, too.  Keep the sensitive part of SMI flash entirely locked
after boot and, instead of using magic SMM stuff to validate that
write attempts have the appropriate permissions and signatures, queue
them up as deferred upates and validate the signatures on the next
boot before locking flash.

