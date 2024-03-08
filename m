Return-Path: <linux-efi+bounces-787-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F17887611D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 10:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FECF1C2011F
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD755339B;
	Fri,  8 Mar 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFdP+NVg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3C3BBDE;
	Fri,  8 Mar 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891037; cv=none; b=PKiafuy/qEev7Xv2v/Sl7QdkVvNp58zv1bx/beY8vgbCNtjjwRvQHRONYG6M+5znb8SGqcN5rmR3S4nuuL//MS3eVj2U05lBEwK2+16n6xKFU7C5mxXZNN4hXeixM4rwsl5e/fGbSMAv9119WdU1xISJnmYk5ewhuIBxgUtyW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891037; c=relaxed/simple;
	bh=iFSnTj6Uus1PdSb0WRbCwVUsFUNuwnvl/oeiibjkzII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5f8QEiKfuWMEeYZwyIqSioqa4ZOWkoux6EIfEBju5wA0OZjCbl+R6beRc5l5E6sFL8GaSIeTDiX7sKtXbcjvtngnYL6iUvRz5ECrCNSoxQbnllgTuwfiGfZWCBfR5I7L7Hz1Ff0SQ2sIABih8H5kOCtzDnmryhmtlw1PjA8KAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFdP+NVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D58C433F1;
	Fri,  8 Mar 2024 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709891036;
	bh=iFSnTj6Uus1PdSb0WRbCwVUsFUNuwnvl/oeiibjkzII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gFdP+NVgersPjKvG4SpsfvCAKvh4aq2S8RLorn4vJytg4kwjeoZdFd/nme2mkegec
	 hNNSOJ2mJ6mYmgEr4mgfqN4ikM2SrfoeaP22GI3LTmwIpmjgoIT0fib/X8NrKV2pNQ
	 uvW6vM0D3IENAwlms2fEEsk6mUqYXXg0402m3oUIjrOVAHextEB59EspaVlSYbElOm
	 ks65dpJrtmOLEFFSksT4I8C7TGOpNxPTHGqqlsXsoJ7oBNpMw4cfBMgUkU3h9qwTtq
	 h2YmuV4Ql5qa/+1+1VAYsxP0Q/hpn1XpRijIi0Tgtkrhuql+Fr47ov84pOFBMbFOVA
	 G1T1baC45+dqA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51336ab1fb7so874383e87.1;
        Fri, 08 Mar 2024 01:43:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8phoIHjQdRhtMNH1499qSslN41RSeWtDfipnyMzdZZPlbrvrRrpLaieLpnIc5cM3/+gcj9e5Tr3A1Dvh0bxjncTaJnkvIl6vYQ20sN/w+3d1+UAFJheCYOpTCFK4E1qGU
X-Gm-Message-State: AOJu0YwWJL7nCOV0+mAnRlRc80iAkXrs5jTs6cH7zsFt+FH+AIQmd97l
	PY5z5kjC+jtZ0Sic6nVDIJwI1NSJbI2efW8VEakLyVOCqLStGrIMa5eWsd5Ld3y/J5hNSB3SpzY
	NJ3HxXXFyLMIx55T1KLwAh1iNTQM=
X-Google-Smtp-Source: AGHT+IEWYwNfROqbVQPHEdtwSzuUUCgsKdlCMHnEpw/CE0zIds21heU/y0RgaZ+jNE2ARoxThN1k+1tbUVtKJeDcS5A=
X-Received: by 2002:a19:2d04:0:b0:513:80cd:e80b with SMTP id
 k4-20020a192d04000000b0051380cde80bmr2648103lfj.29.1709891034888; Fri, 08 Mar
 2024 01:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com> <20240308085754.476197-8-ardb+git@google.com>
 <CAC_iWjJgV+wrgKUQsVYvCdvE5Qer2B-ieJC894b+wjKVhdDH8Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJgV+wrgKUQsVYvCdvE5Qer2B-ieJC894b+wjKVhdDH8Q@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Mar 2024 10:43:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFab6MqG+BZ64OSdfzcb-88-N0cwMGZ_bn3vC6NOhgCFw@mail.gmail.com>
Message-ID: <CAMj1kXFab6MqG+BZ64OSdfzcb-88-N0cwMGZ_bn3vC6NOhgCFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] efi/libstub: Use correct event size when measuring
 data into the TPM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 10:38, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ard
>
> On Fri, 8 Mar 2024 at 10:58, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Our efi_tcg2_tagged_event is not defined in the EFI spec, but it is not
> > a local invention either: it was taken from the TCG PC Client spec,
> > where it is called TCG_PCClientTaggedEvent.
> >
> > This spec also contains some guidance on how to populate it, which
> > is not being followed closely at the moment; the event size should cover
> > the TCG_PCClientTaggedEvent and its payload only, but it currently
> > covers the preceding efi_tcg2_event too, and this may result in trailing
> > garbage being measured into the TPM.
>
> I think there's a confusion here and the current code we have is correct.
> The EFI TCG spec [0] says that the tdEFI_TCG2_EVENT size is:
> "Total size of the event including the Size component, the header and the
> Event data." which obviously contradicts the definition of the tagged
> event in the PC client spec.
> But given the fact that TCG_PCClientTaggedEvent has its own size field
> I think we should use what we already have.
>
>
> [0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
> page 33
>

Fair enough.

It is rather disappointing that the TCG2 specs contradict each other,
but a quick inspection of the EDK2 implementation shows that it
follows your interpretation.

For example, in Tcg2HashLogExtendEvent()
[SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.c], we have a check

if (Event->Size < Event->Header.HeaderSize + sizeof (UINT32)) {
  return EFI_INVALID_PARAMETER;
}

which ensures that the event size covers at least the EFI_TCG2_EVENT,
which obviously implies that 'size' is expected to include it.

So please disregard this series

