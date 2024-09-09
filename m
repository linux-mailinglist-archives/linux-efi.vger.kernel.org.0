Return-Path: <linux-efi+bounces-1686-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD0D971C17
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1961F23651
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D691B3F23;
	Mon,  9 Sep 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk2Gj73F"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E517837E;
	Mon,  9 Sep 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890704; cv=none; b=mzSaIXk5B1uZXSsTG49MF8lVxpy8rrKaUg+XKLCVfcY+W1xyNAI/ml03U8Vw/yY2vkeUrR8l6T7M0tgnFvrVkHgLInw0ajxx+zgGizl0H1i5gPQVxBH5SxwR6qjiZSSa0hDTRdnjusaKrcayDzsANunoRjmrjziehBcuJ6s/cnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890704; c=relaxed/simple;
	bh=39t/3qJV4Q2JW5H0rZSfS2mJT51lZ2xxZvskNVI7R9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZN0z+A45xZTouqM+m2xfC5FtAoRJ5tHlVDBmlpMLdtq6SzOZH2Mk3rldoaHbvKtyDv3Pu4abWG1TPbbebyzQdg3LGrSdQXiY6H37EvecZNILdTmC+gbSFta1QykwiUh4N6wswy1RTKj5TM23xVTD59Y7ettfojUT2idVwszoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk2Gj73F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BED0C4CECC;
	Mon,  9 Sep 2024 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725890703;
	bh=39t/3qJV4Q2JW5H0rZSfS2mJT51lZ2xxZvskNVI7R9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lk2Gj73FjiSiEZus3uC7mkNG4XywWqQ7NR0y3ikap2Q+6o++ADr1PK8l7VSXdhcsQ
	 NrMbhgAEtgUEC99n6rRBm5+kaHpo5Mop5C3UcgHmG1YsEOqL8UYNP7ne3w/YGnDQab
	 VN2eyxke+dnFp1KjS1Bft2bKSut8sTHIM/gKDNpyMWTR06KGjTm7cd6TRZIv/S93Ob
	 jN3iD2WphAFVmr+r3zIFplnxxY0ChXDhTvmCHR04xg+fxiKIEf9BFe24MzKGHEKKNm
	 zzvs+TMo+CjJxcZP5R8dUsyksaRN9X8bPXbOQandqBAkMMmORoo12ZNGx4OZ/M/+fG
	 FpucO2WUCsqDw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3771865e87.0;
        Mon, 09 Sep 2024 07:05:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNBN9b6BDH+ZlQGE5uV45aV3H+nPbu1mhk6vpXCx9iVPq9qDJDea6JgcKP25i9pPT2k3fn173BYdCY+PnC@vger.kernel.org, AJvYcCXkfEg499gEdfWnKlSbU1FBaDruw5yvT8uL+u0JAV7n1o/T8Kpz2qD/Lwhe+ItkxbySwJiLCe77Seo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYu61DusMNJHistRuoFSOQWfKc3+6i41ndA7QQGig81YUrj+8H
	rM70r79CwtVsPK/U41kifJkbktsrNwuE6AUa1MUqGRcsrPkYr+CJwTy8ymtb7FcEcQQ4ACowDFr
	xdFJISHts729MjWw1tj0nX2qSufM=
X-Google-Smtp-Source: AGHT+IEJTNfHR7krKocDudQJXBZne2qOZFYCOAl5tMDGgePisWMZ4797/twUNPb5n/v9GxwDhTtOYhmZyMfcyRmybBY=
X-Received: by 2002:a05:6512:1283:b0:536:553f:a6e7 with SMTP id
 2adb3069b0e04-536587c7fe0mr10827543e87.32.1725890701674; Mon, 09 Sep 2024
 07:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen> <Zt7EbvWjF9WPCYfn@gardel-login>
 <Zt7RJepoCiCMRZSu@archlinux> <20240909154940.7ab93782@rotkaeppchen>
In-Reply-To: <20240909154940.7ab93782@rotkaeppchen>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Sep 2024 16:04:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>
Message-ID: <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Philipp Rudo <prudo@redhat.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Lennart Poettering <mzxreary@0pointer.de>, 
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 15:49, Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Lennart,
> Hi Jan,
>
> On Mon, 9 Sep 2024 12:42:45 +0200
> Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> > On 09 11:48:30, Lennart Poettering wrote:
> > > On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:
> > >
> > > > I mostly agree on what you have wrote. But I see a big problem in
> > > > running the EFI emulator in user space when it comes to secure boot.
> > > > The chain of trust ends in the kernel. So it's the kernel that needs to
> > > > verify that the image to be loaded can be trusted. But when the EFI
> > > > runtime is in user space the kernel simply cannot do that. Which means,
> > > > if we want to go this way, we would need to extend the chain of trust
> > > > to user space. Which will be a whole bucket of worms, not just a
> > > > can.
> > >
> > > May it would be nice to have a way to "zap" userspace away, i.e. allow
> > > the kernel to get rid of all processes in some way, reliable. And then
> > > simply start a new userspace, from a trusted definition. Or in other
> > > words: if you don't want to trust the usual userspace, then let's
> > > maybe just terminate it, and create it anew, with a clean, pristine
> > > definition the old userspace cannot get access to.
> >
> > Well, this is an interesting idea!
> >
> > However, I'm sceptical if this could be done in a secure way. How do we
> > ensure that nothing the old userspace did with the various interfaces to
> > the kernel has no impact on the new userspace? Maybe others can chime in
> > on this? Does kernel_lockdown give more guarantees related to this?
> >
> > Even if this is possible in a secure way, there is a problem with doing
> > this for kernels that are to be kexec'd on kernel panic. In this
> > approach we can't pre-run them until EBS(), so we would rely on the old
> > kernel to still be intact when we want to kexec reboot.
>
> I don't believe there's a way to do that on running kernels. As Jan
> pointed out, this cannot be done during reboot, as for kdump that would
> mean to run after a panic. So it would need to run when the new image
> is loaded. But at that time your user space is running. Plus you also
> always have a user space component that triggers kexec. So you cannot
> simply "zap" user space but have to somehow stash it away, run your
> trusted user space and, then restore the old user space again. That
> sounds pretty error prone to me. Plus it will tank your performance
> every time you do a kexec, which for kdump is every boot...
>

kdump has a kexec kernel 'standby' to launch when the kernel panics.
So for the UKI/EFI payload case, this would imply that the load
involves running the payload until EBS() and freezing the state.

Whether execution occurs in true user space or in a deprivileged
kernel context is an implementation detail, imho. We don't want to run
external code in privileged mode inside the kernel in any case, as
this would violate lockdown already. But it should be feasible to have
a EFI compatible layer in the kernel that invokes the EFI entrypoint
of an image in a way that protects the host kernel. This could be user
mode on the CPU or perhaps a minimal KVM virtual machine.

The advantage of this approach is that the whole concept of purgatory
can be avoided - the EFI boot phase runs in parallel with the previous
kernel, which has full control over authentication and [emulated] PCR
externsion, and has ultimate control over whether the kexec reboot is
permitted.

> > You could do a system where you kexec into an intermediate kernel. That
> > kernel get's kexec'd with a signed initrd that can use the normal
> > kexec_load syscall to load do any kind of preparation in userspace.
> > Problem: For that intermediate enviroment we already need a format
> > that combines kernel image, initrd, cmdline all signed in one package
> > aka UKI. Was it the chicken or the egg?
> >
> > But this shows that if we implemented UKIs the easy way (kernel simply
> > checks signature, extracts the pieces, and kexecs them like normal),
> > this approach could always be used to support kexec for other future
> > formats. They could use the kernels UKI support to boot into an
> > intermediate kernel with UEFI implemented in userspace in the initrd.
> >
> > So basically support UKIs the easy way and use them to be able to
> > securely zap away userspace and start with a fresh kernel and signed
> > userspace as a way to support other UEFI formats that are not UKI.
>
> Well, in theory that should work. But I see several problems:
>
> 1) How does the first kernel tell the intermediate kernel which
> file(s) with wich command line to load? In fact, how does the first
> kernel get the information itself? You would need a new system call
> that takes two kernel images, one for the intermediate and one for the
> kernel to load,for that.
>
> Of course you could also build the intermediate UKI during kernel build
> and include it into the image. Similar to what is done with the
> purgatory. But that would totally bloat the kernel image.
>
> 2) I expect that to be extremely painful to debug, if the intermediate
> kernel runs into a panic. For sure kdump won't work in that case...
>
> 3) Distros would need maintain and test the additional UKI.
>
> 4) This approach basically needs to boot twice. But there are people
> out there who fight to reduce boot times extremely hard. For them every
> millisecond counts. Telling them that they will need to wait twice as
> long will be very hard to sell.
>

I don't think intermediate kernels are the solution here. We need to
run as much as possible under the control of the preceding kernel, and
minimize the bare metal handover that occurs after EBS(). Adding more
code to the purgatory (as this series does) is not acceptable to me,
as it is extremely difficult to debug, and duplicates drivers and
other logic (making it an 'intermediate kernel' of sorts already)

> > >
> > > > Let me throw an other wild idea in the ring. Instead of implementing
> > > > a EFI runtime we could also include a eBPF version of the stub into the
> > > > images. kexec could then extract the eBPF program and let it run just
> > > > like any other eBPF program with all the pros (and cons) that come with
> > > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > > simply kexec any OS installer. On the other hand it would make it
> > > > easier to port UKIs et al. to non-EFI systems. What do you think?
> > >
> > > ebpf is not turing complete, I am not sure how far you will make it
> > > with this, in the various implementations of EFI payloads there are
> > > plenty of loops, sometimes IO loops, sometimes hash loops of huge data
> > > (for measurements). As I understand ebpf is not really compatible such
> > > code.
>
> I don't believe we can simply take all those payloads and recompile
> them to eBPF. There definitely needs to be some refactoring done first.
> For example the IO loops you can drop for eBPF and simply map to the
> corresponding kernel function, letting them do the full IO in one go.
> There will be cases where that will be more difficult like for hash
> loops when you have to have the same hash at the end. But I believe
> even for that ways could be found to get it to work.
>
> Anyway, I'm sure that the picture I have in my head is way
> oversimplified. There will be many pitfalls to handle for sure. Still I
> believe it would be a nice experiment.
>

Today, UKI functionality is implemented in terms of EFI API calls. Any
solution that needs either a parallel implementation (eBPF vs EFI) or
needs to unpack the UKI in order to perform the steps that the UKI
would perform itself if it were executed in an EFI environment is a
no-go in my opinion.

So either we provide some EFI compatible runtime sufficient to run a
UKI, or we re-engineer UKI to be built on top of an abstraction that
can be implemented straight-forwardly both on system firmware and in
the EFI context.

