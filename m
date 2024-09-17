Return-Path: <linux-efi+bounces-1788-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE42E97B22C
	for <lists+linux-efi@lfdr.de>; Tue, 17 Sep 2024 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D741C23953
	for <lists+linux-efi@lfdr.de>; Tue, 17 Sep 2024 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45517B4ED;
	Tue, 17 Sep 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8QpCMsl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E93E47B;
	Tue, 17 Sep 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587334; cv=none; b=g3YbBNPE9vKgdXPzrA3diwHgTUfF9kZvu+ZvLZta09D1FpqBmY8IlLrL04d7gnXS1CUtqMeuf7g/7yFADr/5XGsN5+apmH92Y8kpcRzewIT4ZMfE3r8XOjx/jBFvfB/HC/ZPrVEIMngaqtOsUco7KYZhsNi3Mxyu/9U+CDyyWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587334; c=relaxed/simple;
	bh=jJt7WnZBGuBV8L4paI1I1Es2EO1tM2i2LNNETVlvlLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZVcbm3QnAtwT/L+QdLSlGHsBRyKpPhEYptJdpREz6EHtKLs4iggRsWRFhWXm4itULU0rVlvObRD3ftn66xdYE3x4mtVpiaI0QVsdP7AElIz8NkwVl6TeaZr4WwnIxtNXe6GoITONidVJSum/RrMVh6AjXMp9jj/uTBthOQl5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8QpCMsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16913C4CECE;
	Tue, 17 Sep 2024 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587334;
	bh=jJt7WnZBGuBV8L4paI1I1Es2EO1tM2i2LNNETVlvlLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D8QpCMsl4hL6URbZ0y9GOTbkwLbGidkNzrLm1OkyRJYFPfL6xa1fjlldFR0Fzh33n
	 vrYhxuly++Rq4Hge4f6PnD1FDN+6sraoPg/xbrhbAZrs2yFG4w/MO9n/sjudVgT9VI
	 J78/7dtup430/h5ym92SJBJ5uh+F6K4gtFGHz3xi1xpJnADasSvmaNdw0BLTDSo4fZ
	 MKHVluYW9UUXCF3XIWRmhMTH8EKtJcZNUz5Gd8EMn/GceO97jcBIYQCaViClbBGSJ4
	 og7dPqrPLgIm751QTNcZm3Fr3RRkyTJlGUb5lHqGgdER87ld2wRzk05pKy0eL85QqP
	 gafhFW9lu7stg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f74e613a10so61235551fa.1;
        Tue, 17 Sep 2024 08:35:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH5O6ahxsBD9bJlHSqikNXxzuL3Bm5dxhmwqlt3YsnptOFwrT266QS4vqklx1a8MFwFB3hHey9OLw=@vger.kernel.org, AJvYcCX56DEzN38L5b0r3v055jMyNhn2kTiynMEl0Gdq9bRZvk7C1rgbhCol3NK6rYCWZhsn9Z/4S4iGgl0+j2Qm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywue90WQ4HMYqp7kC3ms5GRJilQPqGCXu3DDGgcsDuif12zEa3X
	mywAV/+7WtG6cavsDIP4xkWJwOADETnZ2Q/wVTDckaA80IkIZEtIfPlXs/Wd7YXzseI+eG7MSaw
	OkID7ObH67S1YCmIABTUl9E975wM=
X-Google-Smtp-Source: AGHT+IFfQJc8EcaWULN3Z+i8J/MSKeJvx5yHNWVN+ecZpADLsbwRegnU6nAb8P+zRnNC86xZWl36vWg3eoJPTQEschw=
X-Received: by 2002:a2e:b8d3:0:b0:2f7:7fe7:ca94 with SMTP id
 38308e7fff4ca-2f7918e4df3mr114333291fa.1.1726587332402; Tue, 17 Sep 2024
 08:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
 <20240913-careful-maroon-crab-8a0541@leitao> <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org> <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874j6e482p.fsf@email.froward.int.ebiederm.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Sep 2024 17:35:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
Message-ID: <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Breno Leitao <leitao@debian.org>, 
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com, 
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > Hi Eric,
> >
> > Thanks for chiming in.
>
> It just looked like after James gave some expert input the
> conversation got stuck, so I am just trying to move it along.
>
> I don't think anyone knows what this whole elephant looks like,
> which makes solving the problem tricky.
>
> > On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
...
> >>
> >> This leaves two practical questions if I have been following everything
> >> correctly.
> >>
> >> 1) How to get kexec to avoid picking that memory for the new kernel to
> >>    run in before it initializes itself. (AKA the getting stomped by
> >>    relocate kernel problem).
> >>
> >> 2) How to point the new kernel to preserved tpm_log.
> >>
> >>
> >> This recommendation is from memory so it may be a bit off but
> >> the general structure should work.  The idea is as follows.
> >>
> >> - Pass the information between kernels.
> >>
> >>   It is probably simplest for the kernel to have a command line option
> >>   that tells the kernel the address and size of the tpm_log.
> >>
> >>   We have a couple of mechanisms here.  Assuming you are loading a
> >>   bzImage with kexec_file_load you should be able to have the in kernel
> >>   loader to add those arguments to the kernel command line.
> >>
> >
> > This shouldn't be necessary, and I think it is actively harmful to
> > keep inventing special ways for the kexec kernel to learn about these
> > things that deviate from the methods used by the first kernel. This is
> > how we ended up with 5 sources of truth for the physical memory map
> > (EFI memory map, memblock and 3 different versions of the e820 memory
> > map).
> >
> > We should try very hard to make kexec idempotent, and reuse the
> > existing methods where possible. In this case, the EFI configuration
> > table is already being exposed to the kexec kernel, which describes
> > the base of the allocation. The size of the allocation can be derived
> > from the table header.
> >
> >> - Ensure that when the loader is finding an address to load the new
> >>   kernel it treats the address of the tpm_log as unavailable.
> >>
> >
> > The TPM log is a table created by the EFI stub loader, which is part
> > of the kernel. So if we need to tweak this for kexec's benefit, I'd
> > prefer changing it in a way that can accommodate the first kernel too.
> > However, I think the current method already has that property so I
> > don't think we need to do anything (modulo fixing the bug)
>
> I am fine with not inventing a new mechanism, but I think we need
> to reuse whatever mechanism the stub loader uses to pass it's
> table to the kernel.  Not the EFI table that disappears at
> ExitBootServices().
>

Not sure what you mean here - the EFI table that gets clobbered by
kexec *is* the table that is created by the stub loader to pass the
TPM log to the kernel. Not sure what alternative you have in mind
here.

> > That said, I am doubtful that the kexec kernel can make meaningful use
> > of the TPM log to begin with, given that the TPM will be out of sync
> > at this point. But it is still better to keep it for symmetry, letting
> > the higher level kexec/kdump logic running in user space reason about
> > whether the TPM log has any value to it.
>
> Someone seems to think so or there would not be a complaint that it is
> getting corrupted.
>

No. The problem is that the size of the table is *in* the table, and
so if it gets corrupted, the code that attempts to memblock_reserve()
it goes off into the weeds. But that does not imply there is a point
to having access to this table from a kexec kernel in the first place.

> This should not be the kexec-on-panic kernel as that runs in memory
> that is reserved solely for it's own use.  So we are talking something
> like using kexec as a bootloader.
>

kexec as a bootloader under TPM based measured boot will need to do a
lot more than pass the firmware's event log to the next kernel. I'd
expect a properly engineered kexec to replace this table entirely, and
include the hashes of the assets it has loaded and measured into the
respective PCRs.

But let's stick to solving the actual issue here, rather than
philosophize on how kexec might work in this context.

