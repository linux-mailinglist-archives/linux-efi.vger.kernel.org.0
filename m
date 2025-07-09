Return-Path: <linux-efi+bounces-4262-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1AAFF546
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 01:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F60547FD4
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 23:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB1262FF5;
	Wed,  9 Jul 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2ptSw3Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DD25F97E;
	Wed,  9 Jul 2025 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102885; cv=none; b=C+zLC631L5++vJr2SvycLQJR93iveaAilN07gk+gR3fWIus3hTqGe5/f8aEPZT57sKKqx4BKGG3P9VLKOWywZtf8r6olBbnIJTxCCzV9KDVoOTeCwXVKaebnCqlwhMCnuFv3sbBOt70vRDP3LE9B9rYq8elJiToqDtr6y9A9dxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102885; c=relaxed/simple;
	bh=U6hkilTY+kcQBVwtX5w7FZM3TYBRLU4tcKO0rz3aQyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyOdEitGbvKz/WcO5LG/g6B3gUa+RWInSQ5k9w85/3nIekJ9OS2auRWH+WohJXDTr7Eh5PiEMNq8btHhlpyOZBkR4xYharbrT+OO5n3Xik3nz8Xbm+mJajyTSYC9H07eycrEEOiz4qa/FgZQiDyhwA3FxNcEbbrCAEDsfudQW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2ptSw3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E56C4CEEF;
	Wed,  9 Jul 2025 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752102885;
	bh=U6hkilTY+kcQBVwtX5w7FZM3TYBRLU4tcKO0rz3aQyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j2ptSw3QmEZyCPaGLmFnV1gLVCfwSVApFFyHgtzYe2JtR2QrMFTcUJgWFztqs3bhX
	 rR0pRxEV8YVkHdJAZsE+gjKhsepi/k6hWLXBw7L+65NzmlwO32e0GlJKATdipDf2Zq
	 Ket0iQCqaSxlGnTpjFWIhUCNY9llSDw0VeP6sF2aYWw1Ai+B/pJNTg9nR6hnl5NEv/
	 uF/Y3awwwsM8IBi+sc2rxZrC//weymwbp65ARSzpamm+pxPITYffkFU5YCrP2lX0nL
	 1+dnqm/L8ssXSqt9TSOBO7WcYHLCx/mWinGLuSwXqvT9ZLBywBlffkSl/k3SEsaVw5
	 yIt1ahhGt5WDw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5550dca1241so332915e87.0;
        Wed, 09 Jul 2025 16:14:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr60MZFL3cSP+hcJvkig3k4kR4//1W7hSqAUweJL/Gf0x5dkd+clN75w6zJoCp/RJWUXSbIiaqOYw=@vger.kernel.org, AJvYcCX7aybfbvZVU9zdWWPTANcDAbAdezDlrh2TD3ckzQQ2pVR4KDmOJqYqYpQLitb/w2KXUhkGl4uvfrbARc/z@vger.kernel.org
X-Gm-Message-State: AOJu0YwuypF+EXo85A4qe7Q5QmHFZBiOLCyBRVQ0A292dFV+r9ILHx4x
	EdaJKazJ6yPwM6rdy8/1WRRWVRuTgYy99bvJYk7ZDP3/SKqhopfB7IdhT9N0YAR/pohVkbhVdl1
	ClPqYUs8Otel9bBX4ST0gF9Pox8M8lWA=
X-Google-Smtp-Source: AGHT+IHlpfZ2cTZvvxeO3QEicqir+rzdQ9BBQ+VgBN4VigkX2VElmupxy1ONvrrdAcLWXUxoqsNlWePBsqKjtdHhNF4=
X-Received: by 2002:a05:6512:3a91:b0:553:653f:1b21 with SMTP id
 2adb3069b0e04-559000c6cbamr534593e87.37.1752102883717; Wed, 09 Jul 2025
 16:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708125624.734132-1-kraxel@redhat.com> <6edfa099-ab0c-41f6-89ea-0fd67666dd05@kernel.org>
 <2mn65slwkwmjpeilma2isw7zgabdmda4rhpqjiutwdwqno2wrh@zghymlce2fiy>
 <8621135e-445a-42dd-89e0-bf8fc3e2b6b7@kernel.org> <4cix3k4h32wozt3nxic5un7jyzfjrmqmzbzmtr3ivw5b2bz363@mw6bke7w4oaq>
 <5800c426-95fd-4a81-b979-c0bc2bc293dd@kernel.org>
In-Reply-To: <5800c426-95fd-4a81-b979-c0bc2bc293dd@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Jul 2025 09:14:30 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFvMVmxesoqaW254z85ZMRO4U+S3Cr7oyu4K-m-jiKVTg@mail.gmail.com>
X-Gm-Features: Ac12FXwpbrLehPhLTUsuXBLWMnoTdRML-ZAvyYBvg7-8VCnPBDcFaM8Uz_rPpoQ
Message-ID: <CAMj1kXFvMVmxesoqaW254z85ZMRO4U+S3Cr7oyu4K-m-jiKVTg@mail.gmail.com>
Subject: Re: [PATCH v2] efi: add ovmf debug log driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, linux-efi@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 00:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 09/07/2025 16:31, Gerd Hoffmann wrote:
> > On Wed, Jul 09, 2025 at 04:20:49PM +0200, Krzysztof Kozlowski wrote:
> >> On 09/07/2025 16:17, Gerd Hoffmann wrote:
> >>> On Wed, Jul 09, 2025 at 03:58:58PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 08/07/2025 14:56, Gerd Hoffmann wrote:
> >>>>> +MODULE_DESCRIPTION("OVMF debug log");
> >>>>> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> >>>>> +MODULE_LICENSE("GPL");
> >>>>> +MODULE_ALIAS("platform:ovmf_debug_log");
> >>>>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> >>>>> index db8c5c03d3a2..ac0a03ec3452 100644
> >>>>> --- a/drivers/firmware/efi/Kconfig
> >>>>> +++ b/drivers/firmware/efi/Kconfig
> >>>>> @@ -263,6 +263,14 @@ config EFI_COCO_SECRET
> >>>>>     virt/coco/efi_secret module to access the secrets, which in turn
> >>>>>     allows userspace programs to access the injected secrets.
> >>>>>
> >>>>> +config OVMF_DEBUG_LOG
> >>>>> + tristate "Expose OVMF firmware debug log via sysfs"
> >>>>> + depends on EFI
> >>>>> + help
> >>>>> +   Recent OVMF versions (edk2-stable202508 + newer) can write
> >>>>> +   their debug log to a memory buffer.  This driver exposes the
> >>>>> +   log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
> >>>>
> >>>> Where did you document new ABI?
> >>>
> >>> The log buffer header struct is documented in the header file for the
> >>> edk2 code:
> >>> https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Library/MemDebugLogLib.h
> >>
> >> You added a new sysfs interface. I meant documentation for this.
> >
> > The sysfs file contains the log and you can simply use
> > 'cat /sys/firmware/efi/ovmf_debug_log' to read it.
>
> Don't explain how it works to me. I did not ask how it works. I asked
> where is the new ABI documented?
>

Please drop the condescending tone, and don't make people guess at
what you are trying to say.

If you meant to say that the patch lacks an ABI description in
Documentation/ABI, then you are absolutely right, and you can just say
so.

