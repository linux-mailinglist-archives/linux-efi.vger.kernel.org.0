Return-Path: <linux-efi+bounces-3080-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A6A70184
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECDC7A795D
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D160D266EE4;
	Tue, 25 Mar 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB2oGxjS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC798266EE2
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908208; cv=none; b=fsbVXSuru2iYAR+nJlcfdKYRFEL7tkwg5BRAfIRRKL9OLTDCQYU2e1BalA1rUN1yfkLnOTB19qEiS2lTkRqvp/MyaPtkWj3WpfTO4BZf9TGYhbmSsiajJeSJMqtL/IGSCgvtNg8xDk89R9h+odcGgcuI4z2DPqh2sGajYnlus/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908208; c=relaxed/simple;
	bh=IHtkqPD2xwX+qOA+CbKhwxHy0/yFQMVH64oyEcMGmfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0lEbbBAc1+fDf259QkMZxmOYhnjAcipz+pdcjHlB7vo3+6MeMfhdVAKFnW9Mg/oXaEPgFz0bv9r2DTV1vy7TseVO6WnhoFe6IULAGEDVhyIgW72RYPNWMIx1vmhxAjXVHZiDc5kx8DTJJTrJKqgk2j7vYneOMaanIribCISd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB2oGxjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AB0C4CEEF
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908208;
	bh=IHtkqPD2xwX+qOA+CbKhwxHy0/yFQMVH64oyEcMGmfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BB2oGxjSJE934xNhtABHw6yHcsTUj77baBWU3AudBRLnmRkrUzmfVG8LsGWZXvSbS
	 4iZ4XaIUuPe5ycrRSRRYcmi8ptAzuUrfe4kXPidrGMGDxoiTvw0t6xJwQA8y18x3Rz
	 bwkdb7N7wPllCyJZ8eXvzfRNDHCwtgj5krKjSFj/Vvp7BE29qOnSIUkIwX/wlvLugF
	 nfcS5zfc8k0lcWc4rlP+sz7ZO/owbKmrjDLf3ohQBpW5DCRO7AxuSS5GTPYudH28K6
	 I3Aap7ucsH76ZlNmfiQjoaUsLknlFA2n8sgZ6XWmWlZhBzpqdPsL3QFOr8UMNwWh/7
	 IA+Q0F17CPcSA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so6518000e87.3
        for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 06:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwGgIv4hIT0a6D7xYkrh37GNPLvifp6qNymCpbFVuavqD2rq9zbrPdSy9t1NbaxjitJ+qnlTmehRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucD76nWr8Ks08or46eHNskjDwy3RP7qORa1CmwItu4mDGNrUY
	VISm2nB41NGy1HWW+R8T/A/2eoQyI8Y4Moom84qM0WqKsmyzQXFoPB7O20bOah/KWz1gH9DuK/3
	yz9DUt2rqv0w1q8Ras7Zm1g4zKpE=
X-Google-Smtp-Source: AGHT+IHmnY5T05VbTpqs5ogFqUGjRQptUhuwS7pW3Ntp9uT+Xz6sz74KEzs2hrjvm+Uu3IDgFqf4tTjrUEHo/oBN7qU=
X-Received: by 2002:a05:6512:3d09:b0:549:9190:a5a1 with SMTP id
 2adb3069b0e04-54ad646ceeamr5365663e87.4.1742908206550; Tue, 25 Mar 2025
 06:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325091614.1203411-2-ardb+git@google.com> <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com> <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
In-Reply-To: <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 25 Mar 2025 14:09:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
X-Gm-Features: AQ5f1JoEq5ITC__kqxqot4bYw3zp7jqIYnFxVw9BY8t6cb6Byy3sQbemfqLJxSg
Message-ID: <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before ExitBootServices()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-coco@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 13:59, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Mar 25, 2025 at 01:41:04PM +0100, Ard Biesheuvel wrote:
> > On Tue, 25 Mar 2025 at 13:36, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Tue, Mar 25, 2025 at 10:16:15AM +0100, Ard Biesheuvel wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Currently, setup_e820() in the x86 EFI stub records unaccepted memory in
> > > > the associated bitmap, which has a 2 MiB granularity. To avoid
> > > > ambiguities, any unaccepted region that is not aligned to 2 MiB will be
> > > > partially accepted upfront, so that all regions recorded into the bitmap
> > > > are aligned to the bitmap's granularity.
> > > >
> > > > On SEV-SNP, this results in calls into the SEV support code before it is
> > > > initialized, and crucially, before ExitBootServices() is called, which
> > > > means that the firmware is still in charge at that point, and
> > > > initializing the SEV support code is not even permitted.
> > > >
> > > > So instead, round the unaccepted regions outwards, so that all
> > > > unaccepted memory is recorded as such in the bitmap, along with possibly
> > > > some pages that have already been accepted. This is less efficient in
> > > > theory, but should rarely occur -and therefore not matter- in practice.
> > >
> > > NAK.
> > >
> > > It opens us for double-accept attacks:
> > >
> > > https://lore.kernel.org/all/zuz27i7ffrsa3hksveuroxpwxos5qx65py23gvupaadizwrsss@uhb6ye4j2eqn/
> > >
> >
> > So what fix are you proposing? The code is currently broken.
>
> I don't know SEV specifics, but I wounder how BIOS itself accepts the
> memory?
>

That is an implementation detail, so it doesn't really matter. The
firmware owns the platform, and is therefore in charge of
communicating with the hypervisor and/or the VMM, and the code running
in the EFI stub should not go behind its back and communicate
directly.

> Since the problem happens before ExitBootServices(), can we allocate this
> memory range with EFI API and free it back?
>

In principle, yes - we could allocate these misaligned chunks as
EfiLoaderData, and it wouldn't even be necessary to free them, as they
would become available to the OS automatically.

But doing this in setup_e820() is tricky, because every page
allocation modifies the EFI memory map, and we may have to restart
from the beginning. And there is no guarantee that some asynchronous
event in the firmware context does not attempt to allocate some pages,
in a way that might result in another misaligned unaccepted region.

So ideally, firmware would adopt the same granularity when accepting
memory, and we wouldn't have this problem. (Or maybe this is why
nobody noticed until I found it by inspection?)

