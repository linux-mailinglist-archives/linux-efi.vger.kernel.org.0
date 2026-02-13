Return-Path: <linux-efi+bounces-6121-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKYuHLzEjmnCEgEAu9opvQ
	(envelope-from <linux-efi+bounces-6121-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 07:29:16 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB09133404
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 07:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CA143031AD9
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2D26560B;
	Fri, 13 Feb 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKJoiJZs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393B2517A5
	for <linux-efi@vger.kernel.org>; Fri, 13 Feb 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770964150; cv=pass; b=n4QmMx0R5Fn5cNOwtxJfZ1UyOYUVV3frqfnUEUeaL+vsUfATGXXGMPqHPJbxjZqxQv4voG5iMbjOxicVVlgln7VTxEbjqGd98g9vfQDBrX1sV4Pgjc40gAqIFeBxvWU6SAAwgaUiM3druPiuzpY4ldCBG4qT/3SYCSK5iLJUyTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770964150; c=relaxed/simple;
	bh=XWIo7Hql1rN4HTTpvN2E3D+/ne/cOcRvwlJjqBedbgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqtCcsPYeHjzyaFuX22aKlLCynMroro4mEYxGloyYUZU0UMI5QKhgS17ATQYDKbljoEaw2/139fgUK82w4wpVwO+5t+78m7g86bG7ay1bOjNISM4sVu4Sg4ODlSvNV53b2Hej+Bd12NVo1yDGFeT5vLL1FmqTadqeF6RhTAIm8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qKJoiJZs; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ae5f0777dso610681d50.3
        for <linux-efi@vger.kernel.org>; Thu, 12 Feb 2026 22:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770964147; cv=none;
        d=google.com; s=arc-20240605;
        b=lWCKFXJYbE9u2PliWOrAxKSXNqXBJiburJHBwlAGqWatYEVV0Powr7M7DD1GN1CumV
         rjk3UssCv5VyiMAJO+ODvJL6WwZor/zyd/OPj7IeT4rw3hcStzT0lFpyuAVbltHXv+OD
         Apdk6VG5/BUo7rSdujzq+PMU98YkkyegRzqv3NbaD/gBO1n4svthf/dZZwdFKpCk9L7h
         Se0XeXu5Sph0Vdw927bvh4mUrJtXpJVF3pt3T7F+1rW+SCVuACqyWst9pvzGTBUyVFj+
         MU+AbD1VVAlwI7M7/ah6sQpi95vMFXWO6z7SvSRIHN9UZYwMXQw0Y0/SI2e+5ZXq8cI2
         GdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tQVFLn5cPaqooiNQTL+EbKOr/AUzqPPLp1PwWo0P8HE=;
        fh=GQGBEtOejw4Zzx1hQ+I6e4MazTUAycG+T1npRn/mo2Y=;
        b=YBO3dGOCGrZt5BIBcZe5wEelg53EdLEwhzRjwcVaYIoLN/prhsLE65pM+LP6TcWLeo
         qdl26FoWDvw/e11mvuH4GLRk1BROWZc9h4bgUG1576oa6Q3n/ycDR/W3Sjr3Ko9idTuM
         aucEvBJ/sBWxSAAvWYX5+l4BC8AeFQXSi01MrtnAAG/t+nfvCDlF2E4ntzXqDHwSAIVC
         GRdTURPCqBI8fo3dXOFEu8/aoXtgpVuTPZ3LoESceO+Z7HHS6y7gTojoDIwSJE38dS93
         TvsjOiWuqd9hL5Ldi4vfnmYOD3peyE57Z2iBZFer4DzgP5gTCM675KHESa9XiKUztNtO
         KEdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770964147; x=1771568947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVFLn5cPaqooiNQTL+EbKOr/AUzqPPLp1PwWo0P8HE=;
        b=qKJoiJZsfTu/a5IrekSs8g3aKsrvMkZ3V0iRkD/0Gc4OD4Mx3ckeOe+X0GCLVKhA4N
         yjl8bh7El03ei+sNOyfY9c36+xtJRiop+X/4MmN7AjBXzmKrk+vf/23Xya9pYs14Ydlv
         J2YhDB7mt9t7xiTj7KtprReYKEjN3bxVMHv6JFo9id5hwUiYCLmmrUU/JJNYiUky6QaN
         12/JWWTVhkuRk4pw6o5Co5JsyeJY1xUyz0TLkbfV/7sZtUBbapsb8T8F0CAtHMihYf6C
         ZxKG0GGJHCFfH7Te46cIq77cO4BWEx6u6uRVtg9bF6dLMyj/DAgdyP6/kyZuIHNYTC5h
         y/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770964147; x=1771568947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQVFLn5cPaqooiNQTL+EbKOr/AUzqPPLp1PwWo0P8HE=;
        b=ad5MyQEkK0INQPGkZoxiNh71HeFpRLG7qpEkQ651fw0r2/6JQuEq83f9KzhIbL4VJk
         zToTS8ilCirBhu0L8+N+7SjRAO0RdDv9iBV8ZAt6s5yWCZOwUILyasJ8GR112Nf1cDMK
         uJp1QfhkBVTzIfdXErMXgV+nvgM/O9L+pYGhNUlwJHBug30NnnKPJV66fYDJAe5ktRA0
         YMHjOc3WvXyA4eMJB1V2KRnQY7QIsdicjcx6x4L2Rriq4HnZQIE3amKvkIR76CFqmPwR
         zLgtWwZ/hvECXbLAVJHcTQtU6x1/IYop02CRgTkgtwDalPGJtpnZbHFfmNxOWs73pCaC
         bhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOP5ufz0lr1t2lH/mrVRoi4lGVLTDRBX6SydImoPIthTkH7AymyJ2cco0hE6x3QDoI5oXQX0vn1sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/4eykxAQ4W9gLhYUAL4B7XCT0s46lTuDu6vXkLfgWED/1JDC
	ftdsA1hjpPHjVRXbSbsvlKX42Nu+JEmithqDyvy4Z3gt9yFVG6fGJnjhZK0hX6kdnToeBK0+Ruh
	OSlLI4+aK36z87f+exkbFNzlAUX2IkgXNuUDzU2UnwQ==
X-Gm-Gg: AZuq6aI6W/pXBhqsuJGMxuP2nCWxOVS6o5rQwhqG3LvtMRtlSISzSuyKbBonAfy7scZ
	zhX1T4enxddwhU/blg/Rk6YQrs7S3D52teWLaw774FsFceaptTSibgAZecBeaiLKqWu30eGpnVn
	3MQ85Vp1GG2LlmARxqqCqOKrWqW90I9DWZvfopiUqmw78LAXE0yMXFh0AHC8TyTy4UHv1lRv0s1
	vcKjSTufQblgljs4RnGZXFlnbEA58r0O7k6T4UQGCJH+eZv7QqgnwbRXwvpduX9o1No1TT1fl9e
	RkAQM7xTzeRYrzV/B4U8OH/W0O2B8eG2oa7mSHtOs1ZeNjZBzR4xDqT43WW7qv7SC4vW2fT+t30
	65r84sbcuFq6Ts+MSn0OZYYrYG8jQD1kDEXx8miCrLdP4G3BcdB7Fjyjh2zH9RqaQc8XmZerzaW
	53f7DOGr9iJiTk9Ja/eVeqXv2IcnqxiqqHCS23XB2sYulrADxYw8WowPJ7+PXOR/WI8tMtdFygt
	JuELL8ciTGKptYmDfO3JhukCB+mavmVEEt5ALz7LMmDwlQ62uqObsnz7VV+osZ2gbbnY7xVfV1M
	4qsrCNe9zOQo8KNN4AQcx0zewoL+//1yGRHBaJ4gboBN
X-Received: by 2002:a05:690c:4d89:b0:794:ef94:1222 with SMTP id
 00721157ae682-797a0cd07e3mr12753437b3.55.1770964147537; Thu, 12 Feb 2026
 22:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <aYn6j_JLBENcY96V@redhat.com> <20260209155528.k7RMRPVD@linutronix.de>
 <CAC_iWjLt-CzTkmnVMHidnMFWkE9NPzVLo6g8FUgMu0gAUJ0KtQ@mail.gmail.com> <20260212162041.acU_rljT@linutronix.de>
In-Reply-To: <20260212162041.acU_rljT@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 08:28:31 +0200
X-Gm-Features: AZwV_QhwAzoy29uRON-C54jYvitJkKlgh7E9kmWTIvcPHuioNdqkhk0IAgKbCXA
Message-ID: <CAC_iWjJL3Ng=+QH2pBCLskE1aiSJJJM1Db8JU+UGNdKsrLYhZQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6121-lists,linux-efi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,arm.com:url]
X-Rspamd-Queue-Id: CFB09133404
X-Rspamd-Action: no action

Hi Sebastian,

On Thu, 12 Feb 2026 at 18:20, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-02-12 09:09:51 [+0200], Ilias Apalodimas wrote:
> > Hi Sebastian,
> Hi Ilias,
>
> > Late to the party but ...
>
> glad to have you.
>
> > On Mon, 9 Feb 2026 at 17:55, Sebastian Andrzej Siewior
> > > What I don't know is if this is a problem, i.e. is it possible to
> > > interrupt the secure monitor and continue in Linux before heading back
> > > to the secure environment or not.
> >
> > In theory yes. In practice, at least for arm & OP-TEE, the
> > communication between the TEE and the secure-world app doing the
> > variable chekcs & authentication is via the MM protocol [0].
> > IIRC that requires to run to completion. So what happens is that you
> > enter OP-TEE and right before the StMM is invoked (the app that
> > handles EFI variables) all exceptions are masked and it must run to
> > completion.
> > The period of masking does not include writing the variables to
> > storage. That's handled differently and is interruptible.
>
> There it RTC and variables which is the most common thing. If you can
> somehow outsource variable read/ write then fine but I guess you need to
> wait somehow to ensure the data is written. Anyway.
>

Yes the variables are processed with exceptions disabled, but the
actual writing to the RPMB runs as OP-TEE RPCs(remote procedure calls)
which can be interrupted.

> That referenced document describes the protocol but not the
> implementation of how communication works. What I found is that most
> interfaces in the TEE world end up either in "SMCCC_1_2 hvc" or
> "SMCCC_1_2 smc". The smc command in terms of arguments is described in
>         https://documentation-service.arm.com/static/5f8ea482f86e16515cdbe3c6
>
> but it does not say if the interrupts are masked.

It's a bit cryptic indeed. It doesn't specifically mandate it, but the
chapter 2 introduction says
"A description of how MM services can be invoked asynchronously is
beyond the scope of this specification". So we tend to keep them
disabled. But as i said I am pretty sure keeping them enabled, if
needed, won't break anything.

> I would assume that it
> transfers the execution control to the secure monitor which is then
> entered with disabled interrupts similar to an exception on the linux
> side. In that case it would mandate a workqueue kind of solution so it
> can be pinned to a CPU.

We enter OP-TEE with exceptions is enabled. It's only when we enter
the S-EL0 application that processes the variables we mask exceptions
[0].

>
> The only exception here seems to be the amdtee driver
> (psp_tee_process_cmd()) which sends a command and waits for an answer.
>
> Sebastian

[0] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/stmm_sp.c#L124

Regards
/Ilias

