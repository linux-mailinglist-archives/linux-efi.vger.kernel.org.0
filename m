Return-Path: <linux-efi+bounces-5808-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AF6CA7E2F
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7023331B9710
	for <lists+linux-efi@lfdr.de>; Fri,  5 Dec 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4D31771B;
	Fri,  5 Dec 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDm0fIA2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4531B804
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930451; cv=none; b=rDJviV80a2ot8ndjXFVWWFRXouFpj3lvTBXqEupNSxby6nDpU0qgEu2kRDGkEyCXGQwzCFHgTuinEIq0N51Q9MAxggcWlrVQK1AmDaQeOwfdg3DuoKOSvZ/PtvFi2AVsMLogJkEo4QuzrCNb9G7qx4CPJTZKqjWa9qiAwvMN3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930451; c=relaxed/simple;
	bh=oPauTJAG0OsWliK/cuBiP4xMOV9W2mwGaanMw+u+3AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYsyUdRx61qZ4/yC3aZJ7+t5kWuKyEALe9zoIL9ScoGN0eA8rpbOu8L6BFmT5cvQulhTwPgjtzs/rRIA8lKJsPT2gK7KB3WDTGw3vqG5xjS6sNTzaASs/I4xTFZgF86iaIVBXJNDkvgqRl8eW0wXzlYy7DOahTpjiBQhzpMxlao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDm0fIA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428EC16AAE
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764930450;
	bh=oPauTJAG0OsWliK/cuBiP4xMOV9W2mwGaanMw+u+3AM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lDm0fIA2toaOm0B38aNrrWUF75e8+ayVn433D+bKNsTNzaJWCAxDvPhKXoj3tU51+
	 UH1NUjOhfr+68beJUEFE4KlM/90nBzdRS6ubdxuIDesrcxpQP3n9nlIjZ6W54VQJuf
	 LRXn1BXL+MU0rKcooPP+lHwb5WfVaFElGos5nYrMgGHCugA+pBOp1vFWCtA++70fYC
	 h8wG6dGE8/bJGVWxat7YogOQDyKn0qnlLjZrpc6Tp9eI/ekl+2XZ70zNcoR/F5l1u0
	 Uvk79iYTxIvkqaSuxylklemiQ0+dTjALiTXSuX1KDejQ3QI5D6bXA+nB0c3f0EX+Js
	 J7Ki0s945wVSA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5957c929a5eso2487660e87.1
        for <linux-efi@vger.kernel.org>; Fri, 05 Dec 2025 02:27:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgBrDYnbPzmiN9JPnT9TGe/GMVrk0pqzGxwlLK0gHscZg/OARy8FSujXDK31YSQs9oXg1mGgDrxtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGx/h9rlUT8EArBFfiqafY5H2iH056H/f3Z0RFKRRX3ifXl277
	hPxYk0YoB4+Xi7biZvv/43U+/II9vQdB2M+/pVW6XLgd3PrPvFXpGzjaxCk3i7HWZH53v9iNeHl
	26P7sV4qf5XfqpLvkrYRnuUsb6e8PtLo=
X-Google-Smtp-Source: AGHT+IExVT1yOlGN0G+2BrpmdQ9LrBNgxUY/CEw5mm2rznkgOAyUF+Tjlv9ZEX/HIU/eRjaEpkrnYqt85TpEFZaAt30=
X-Received: by 2002:a05:6512:3e15:b0:597:d49f:2150 with SMTP id
 2adb3069b0e04-597d6683774mr2143831e87.7.1764930448866; Fri, 05 Dec 2025
 02:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203042850.14210-1-val@packett.cool> <CAC_iWjKHO3BGdaK=8a1A3Ps3U5Cqt2urJqL8PPfGcaqsMw1Qgg@mail.gmail.com>
 <2294ac5b-6977-4f46-964e-b3a30b88efbd@packett.cool>
In-Reply-To: <2294ac5b-6977-4f46-964e-b3a30b88efbd@packett.cool>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 5 Dec 2025 11:27:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHCkrnKkFDbvJPS_ykdG_xic=OcvS7hXXwY6XT8oiqkEA@mail.gmail.com>
X-Gm-Features: AWmQ_bmtsCwW-DJ7vzQlmEwHvCkcpLJ3440ExRb1YsnkPG1ouda4ILX9IC9myAs
Message-ID: <CAMj1kXHCkrnKkFDbvJPS_ykdG_xic=OcvS7hXXwY6XT8oiqkEA@mail.gmail.com>
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops
To: Val Packett <val@packett.cool>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Dec 2025 at 21:57, Val Packett <val@packett.cool> wrote:
>
>
> On 12/4/25 6:49 AM, Ilias Apalodimas wrote:
> > Hi Val,
> >
> > On Wed, 3 Dec 2025 at 06:29, Val Packett <val@packett.cool> wrote:
> >> On some platforms, EFI variable services only become available when an
> >> appropriate TEE driver is initialized such as qseecom, gsmi or stmm.
> >>
> >> This would work fine when efi_pstore was built as a module and loaded
> >> late by userspace, but with CONFIG_EFI_VARS_PSTORE=y this driver would
> >> quit due to non-writable efivars before the necessary driver had any
> >> chance to load.
> > The problem, at least for OP-TEE/StMM, is that writing the variables
> > to an RPMB depends on a userspace application If CONFIG_RPMB is not
> > selected. We have no guarantees that the app will still be alive.
> > I don't know how gsmi or qseecom deal with writing variables. We can
> > probably allow it for StMM if CONFIG_RPMB is enabled, but we'll have
> > the right trigger to do so.
>
> qseecom/uefisecapp does not have any userspace requirements and works
> fine with efi_pstore.
>
> I don't think complicating efi_pstore with extra logic about which ops
> are fine would be worth it..
>
> Either way, it currently *already* tries to use whatever ops that have
> been registered if it's loaded late as a module by systemd! The only
> thing this patch changes is the CONFIG_EFI_VARS_PSTORE=y case.
>

OP-TEE/StMM's implementation of tee_set_variable_nonblocking() just
returns EFI_UNSUPPORTED, and so in practice, EFI pstore doesn't work
at all there. I think this is fine, although it would be better to be
upfront about this, and not expose the pstore FS at all in this case.
And once we can provide an implementation (based on CONFIG_RPMB), it
would be good to wire that up correctly as well.

> +static int efivars_pstore_init(void)
> +{
> +       if (pstore_disable)
> +               return 0;
> +
> +       blocking_notifier_chain_register(&efivar_ops_nh,
> +                                       &efivars_pstore_ops_notifier_block);
> +
> +       return efivars_pstore_setup();
> +}
> +

Better to do the registration last, so there is no way
efivars_pstore_setup() might ever race with itself.

