Return-Path: <linux-efi+bounces-5809-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF6CA7471
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 11:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFDFE30D3FBE
	for <lists+linux-efi@lfdr.de>; Fri,  5 Dec 2025 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C6329E6E;
	Fri,  5 Dec 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sp7Kf1LZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AB317711
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764932215; cv=none; b=sw1bZaJESXkemjIyPOBut0i7mL94imbzFXujXRC4V1O37bD9NcAFwjXTWiZtRe0eIRtmnttLQQkgqWShB8aCcFAhg8yoJ9bPVC0cMoHj2xDuuRwan+P0ULYumnDJAyGkbKoehFrE+PI1v+1UsfkO5DM4i4BxBKd+N2qEzxTxY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764932215; c=relaxed/simple;
	bh=Ov7yg0ypr3nDwWSQYz4RmvBHB++CYo0yucGGNzJ/mv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOE2aa3oFS34OeVVYk3ms0B1cqnGs/GIUHWGNHw8FldQhMIWHuPrRUWgHNZ0c6+LLLynXpNBdpOWKnbuA11XoZpDP0vNb6RgwHRuKE5xw54g7dx4JrL3CTWuc3ezLmCG/FzZwyNsCIIncact+WBg/omZdNKwf9/CmwE+gbhsvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sp7Kf1LZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78a7af9ff1dso20361017b3.1
        for <linux-efi@vger.kernel.org>; Fri, 05 Dec 2025 02:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764932208; x=1765537008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQahQRiUvc6YbDzginiYpXMfY6XkUPwuDi6D3jYdGaU=;
        b=sp7Kf1LZMedIKcza+QTY5LU7riBleUPq5vP41OE2IVkBxVWGSD299jk0ZkMKPafG0y
         kGN87DXflO/aA4vsCRspqzPtuqR1ptLbdkpqageQ38eUriC+TvGRQanYClH/jvdwOkn5
         Mx0kmnTUPnuW4EqIl9w2k+XFKfF6/8t0VwGbGXAO5HoMN0KYBY3/0G/WWMFgSvpBOdFx
         cAvTtwgyTNwZr29tM/WO1k9+q2OwaXO8suLVoJ6Zp4dL86VGtYLFMqmbO3wPExMtoFjO
         cejAj/HtYNep0Fcrvme2h1BPShlTQUWRPC/zrqquIBelVGzIebZIFTn9jpdwHFjza9hX
         ebkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764932208; x=1765537008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQahQRiUvc6YbDzginiYpXMfY6XkUPwuDi6D3jYdGaU=;
        b=WfeYcujKQ3DXJjplPlfk7UTfvPsiKR1t++afbO0IhtrPK4YTfHNPy9/hrj7TItpvn7
         aUiYyke8jx/0QNm+yPfuSGUeq7vwStCmbY1dNUBH58CzoL/Fsi6FX8U/orlKKvHcVCgW
         twCh9RBw5/tVJnrVPXYXT4ZuNEjabx5yl5AEsXh1/zkvbIvj0URZhp3rLrT5pln9hOnM
         1wD07QxgYKsgMcl5mZBrJ6b7011q1/FUuXC3cwNXt2TI1BHjyTDSH7jZ/vmlXDF09BIo
         tx87+Pzwjs3FSLC0VQzlmWgGBcH687R+TkC7MQZvNWM3WEbvTKLE7v6ooFxD3XL0rOou
         ZiaA==
X-Forwarded-Encrypted: i=1; AJvYcCUVUyhilgpePy3nCRbJBiXJ3r3t6UPtz6gLbbSU0l3PcUDeVOZOYHQ/ezPLYsquL89lCoXhunXud0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rwe6ObFe+F7R8hysfAqlx5c7gPv5z9gtb83P3KCH0YZYByI3
	99slCmPHG7y4AO3eQgkkg9Q7KdrkWWJeWzGUMNwT3yRsCMnbaNuLnENeqmIWO8d/nmXS+ftKPXm
	l7E7N1YT32daj8OK3nS7BRblUtEp+V4JvNnX7VNM6Fg==
X-Gm-Gg: ASbGncsvK6M+smSsn8rJtp/aIyrnvpQ28/L0Gtta6nAbGOzHXkOn/kfbHe5hLBaPcGd
	HzkoSiDsUzpHgQI3VFyOMofu4p7lKSSBZxihQ80melnyB6SYttKNRKHRqFj9IW+vDIYrGlX1GjY
	quEBrW11Cjwqs7CDPX/FXBajDfLLkoZTm70GQ/H8dualIHXwiCKPd1hVAVqqmK0Rp/j+mBpqwbo
	ziWWDvNSXW8ZosjjaPAqpheVCz1shJLPNXuuPIIOWPFSIf689jcQglFsFM5ZbseHFIIL/IakObJ
	3LaMKeEl/pYtZk+Hq/l6h9kWaI18YgZRsiYEgxq/K4F7wjfzvsX3Iw+RK2Dr88YSb+JdPMeZNbM
	vlEd7jQo=
X-Google-Smtp-Source: AGHT+IG9RARTMf4RSz2WFcFmcrYKgXhZPIEZeeNx+kyoB20x22+KeInni7By5nbHXnrOQYnf508R6NaotmZFDr6rk9M=
X-Received: by 2002:a05:690c:4d02:b0:77d:fbf5:8dad with SMTP id
 00721157ae682-78c0bf39a8emr81294297b3.24.1764932208214; Fri, 05 Dec 2025
 02:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203042850.14210-1-val@packett.cool> <CAC_iWjKHO3BGdaK=8a1A3Ps3U5Cqt2urJqL8PPfGcaqsMw1Qgg@mail.gmail.com>
 <2294ac5b-6977-4f46-964e-b3a30b88efbd@packett.cool> <CAMj1kXHCkrnKkFDbvJPS_ykdG_xic=OcvS7hXXwY6XT8oiqkEA@mail.gmail.com>
In-Reply-To: <CAMj1kXHCkrnKkFDbvJPS_ykdG_xic=OcvS7hXXwY6XT8oiqkEA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Dec 2025 12:56:12 +0200
X-Gm-Features: AWmQ_bkb0nEb2MtA_wVpY3LaBKNkDtKFts9WL2ND-_vY3_Llf9Xn5UfFvKW6Gic
Message-ID: <CAC_iWjJ5DZLP_mzFOVTETPqVyG9C8NTXwLmx_b7JrcXAVaf2cQ@mail.gmail.com>
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Val Packett <val@packett.cool>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 12:27, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 4 Dec 2025 at 21:57, Val Packett <val@packett.cool> wrote:
> >
> >
> > On 12/4/25 6:49 AM, Ilias Apalodimas wrote:
> > > Hi Val,
> > >
> > > On Wed, 3 Dec 2025 at 06:29, Val Packett <val@packett.cool> wrote:
> > >> On some platforms, EFI variable services only become available when an
> > >> appropriate TEE driver is initialized such as qseecom, gsmi or stmm.
> > >>
> > >> This would work fine when efi_pstore was built as a module and loaded
> > >> late by userspace, but with CONFIG_EFI_VARS_PSTORE=y this driver would
> > >> quit due to non-writable efivars before the necessary driver had any
> > >> chance to load.
> > > The problem, at least for OP-TEE/StMM, is that writing the variables
> > > to an RPMB depends on a userspace application If CONFIG_RPMB is not
> > > selected. We have no guarantees that the app will still be alive.
> > > I don't know how gsmi or qseecom deal with writing variables. We can
> > > probably allow it for StMM if CONFIG_RPMB is enabled, but we'll have
> > > the right trigger to do so.
> >
> > qseecom/uefisecapp does not have any userspace requirements and works
> > fine with efi_pstore.
> >
> > I don't think complicating efi_pstore with extra logic about which ops
> > are fine would be worth it..
> >
> > Either way, it currently *already* tries to use whatever ops that have
> > been registered if it's loaded late as a module by systemd! The only
> > thing this patch changes is the CONFIG_EFI_VARS_PSTORE=y case.
> >
>
> OP-TEE/StMM's implementation of tee_set_variable_nonblocking() just
> returns EFI_UNSUPPORTED,

Yes that's a limitation imposed by Arm MM iirc.

> and so in practice, EFI pstore doesn't work at all there.

Exactly. It's been a while, but I vaguely remember that in v1 we had
pstore explicitly disabled from the Kconfig. But distros tend to use
it, so we ended up doing it like this, so they can enable the feature.

> I think this is fine, although it would be better to be
> upfront about this, and not expose the pstore FS at all in this case.
> And once we can provide an implementation (based on CONFIG_RPMB), it
> would be good to wire that up correctly as well.

I'll see if i can find hardware and time to test it. In theory we
should be find if the writes are wired up via the kernel and not
userspace.
If they are we can just define tee_set_variable_nonblocking() to a
working function if that Kconfig is selected.


Cheers
/Ilias
>
> > +static int efivars_pstore_init(void)
> > +{
> > +       if (pstore_disable)
> > +               return 0;
> > +
> > +       blocking_notifier_chain_register(&efivar_ops_nh,
> > +                                       &efivars_pstore_ops_notifier_block);
> > +
> > +       return efivars_pstore_setup();
> > +}
> > +
>
> Better to do the registration last, so there is no way
> efivars_pstore_setup() might ever race with itself.

