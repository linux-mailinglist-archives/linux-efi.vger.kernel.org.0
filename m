Return-Path: <linux-efi+bounces-2070-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0D9B6D0C
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 20:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945171C2036D
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 19:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263621D0E03;
	Wed, 30 Oct 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrspVtxc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD11CFEB0;
	Wed, 30 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317395; cv=none; b=jy9df+qLiA2gXBuMf7KHKdD+rzwHH6qkSEeYAPRr984cxvPKXIqPjeBJwy347BRuhM9BWPLxxCERSWLVZsBDCv5c8AvayzWw4wBy3pYHNBMtpe0o8XVmQjqybfQxQ5kLOI9x0vOWetNeMG5VfjXfHLcfS9ydWXJYBPx2ss6sGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317395; c=relaxed/simple;
	bh=S/8f/svQwtc3ttjndR66kZ+IeK+o+RZWRYVbwNGk2zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUlFTz+2Pccfp3LpGVVNMCx20lc+W0bUZzt33oRUyPGjbQLaBBArpiv6sBNYSqEDHIryCRMrHhoJydeD9EqEYr17vviHxePGKKxDbK5qbiEGZwkax2h62nGX/cUVxP7cD1F6mAD3kn05L1JDFGPwaIAVdkd+9utuOnovoQ00M54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrspVtxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A275C4CED3;
	Wed, 30 Oct 2024 19:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730317394;
	bh=S/8f/svQwtc3ttjndR66kZ+IeK+o+RZWRYVbwNGk2zw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qrspVtxcSFjC4GsFuPgycBhygvYjeoRmE42utunbGEr1FgKLLsRadQtwV59sUVRYl
	 4XvjTWXuLTNzBL5VWzaDGT08+KmTOfkxXU3JB917uuqD/AGp0Fw4EMJkpTZouXvX2C
	 KcviWrDndhkVyuAqKfaDW9kt9GJ4bQxDgP4rm2MT3B3cdzdnC+sduJ0D7KXvqe8ieH
	 p5SezR9s6N8psWhQKj8c64Ac39s5ErG7AgPCFIkOWBMzfI4YSeLjlFPBtgkDBQMkjE
	 HttOwzl+lMxkL18NWSWvlOsJ8MfcSOLojZYVWSVPsAzwhYYnIyuwtLiSWnWrfjitNQ
	 8opm0OoHtQ/Sw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so1520531fa.0;
        Wed, 30 Oct 2024 12:43:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKHZcLprlr8/MT+RhL0eRVsBVkpbFJ8C2REi7NZ7j9gAgly4P6Fuix7VgvPmn4fDGgfQmUqE2Q@vger.kernel.org, AJvYcCWpCq+TaKs70zbbhN4OH1/sBnaeibkuHsbROZljE2wmOad/sa6qwtPxH1jRA0Ozw3Xb68l+ebHsOs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwMPfSpZhqo+MWWGQa36SRjv+nT+51M/OJt5P7rVwj6mq+U/C
	B8fbUPuADpwnkjjuZ/VPsu4xpX79ZjhLp+/FQ7kADbELQXN5zJihNDyjrNoCHyEp+2TNLYRqSdl
	V6yVE7oIUe1FgA+bJFjYl01VLiA0=
X-Google-Smtp-Source: AGHT+IGQ64FurlERG4cfcirG//LhB9wVC/DhHSjDHdYVZ5JLpFkzc1kIKzqqhpGu0woNb/Hkwyl6hv/1jzJj0kbHyG4=
X-Received: by 2002:a05:651c:550:b0:2fa:c913:936 with SMTP id
 38308e7fff4ca-2fcbdf61bfcmr86034501fa.1.1730317392793; Wed, 30 Oct 2024
 12:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912155159.1951792-2-ardb+git@google.com> <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org> <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com> <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
 <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com> <ZyJ6QHc9FetDckqo@PC2K9PVX.TheFacebook.com>
In-Reply-To: <ZyJ6QHc9FetDckqo@PC2K9PVX.TheFacebook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 30 Oct 2024 20:43:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXERg=g_G37uax7U6Pf_Umx_Tt9vABJoFHjXYAVaJ8AwPw@mail.gmail.com>
Message-ID: <CAMj1kXERg=g_G37uax7U6Pf_Umx_Tt9vABJoFHjXYAVaJ8AwPw@mail.gmail.com>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Gregory Price <gourry@gourry.net>
Cc: Usama Arif <usamaarif642@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 19:26, Gregory Price <gourry@gourry.net> wrote:
>
> On Wed, Oct 30, 2024 at 05:13:14PM +0000, Usama Arif wrote:
> >
> >
> > On 30/10/2024 05:25, Jiri Slaby wrote:
> > > On 25. 10. 24, 15:27, Usama Arif wrote:
> > >> Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
> > >> All of these should be just be in the dmesg.
> > > efi: EFI v2.6 by American Megatrends
>
> Tossing in another observation - the AMI EFI we've been working with has been
>
> EFI v2.8 by American Megatrends
> or
> EFI v2.9 by American Megatrends
>
> We have not seen this particular behavior (cold boot corruption issues) on top
> of these version.  Might be worth investigating this issue.
>
> you may also want to investigate this patch set:
>
> https://lore.kernel.org/all/20240913231954.20081-1-gourry@gourry.net/
>
> which I believe would have caught your "eat all memory" sign extention issue.
>
> This is queued up for v6.13 i think - but possibly 1/4 deserves a stable mark.
>

To me, it does not seem obvious at all that the TPM code is the
culprit here. The firmware produces a corrupted memory attributes
table now that the EFI stub uses ACPI reclaim memory for the TPM event
log, but to me, it smells like a firmware issue, not an issue in the
EFI stub. (Pool allocations can trigger page allocations, affecting
the layout of the EFI memory map).

So let's keep an open mind here, and not stare ourselves blind on the
TPM event log code.

