Return-Path: <linux-efi+bounces-1790-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CA97B899
	for <lists+linux-efi@lfdr.de>; Wed, 18 Sep 2024 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771881F22775
	for <lists+linux-efi@lfdr.de>; Wed, 18 Sep 2024 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FE273DC;
	Wed, 18 Sep 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBsRuPcZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902E13792B;
	Wed, 18 Sep 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644980; cv=none; b=AjLURQ3PRlHnqZQqZRbNx0oR481ZKg6cLzF1pEvhNpvLzSpr6NOmSxkQvc6au5u8CF01Wx4AxNnUt1yJq/OcqAJac8Cv0Y/CPTxEpTvmNahbO5lDLTyK99OLSuU/Ltnuueme5mhoto18J+Nv6m0VWEhgf3hX7/L5E/8nsXYVt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644980; c=relaxed/simple;
	bh=QmWF8/w9I2mjmPpEBTl4/a8Wl8TIynzjPFu2lFi2LvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USo40zVxiIROsT/vQ18tV8nlsYA3c8Ac6ow//gOVHH0sDDFsfyvHPZrgDP+BrPl3F2hncePqXC1Nm6HfCRkuzqeBN1/QYs4tcsjFgSz13aJ385+R2i62fYXZJqw5Gzv+8LMnKQPh/Rk+1Ft8K8/WKiUOgkgDSu9I8ryLxD5fXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBsRuPcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFE8C4CED3;
	Wed, 18 Sep 2024 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726644980;
	bh=QmWF8/w9I2mjmPpEBTl4/a8Wl8TIynzjPFu2lFi2LvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBsRuPcZcV+IlJLPHAxKRkgrymX0pKZwlAnHbIPuI1LxdQUWeSdeiPVTNDlYTBTIF
	 ezY28658o90M+gMYRyyAsoLnZvyzizPvNorMaauWiFxuQqMHhqUP6sdL/B8uPW0uh5
	 Qs6TidAa3CbgaC046s0KI/TBPe1cQU0zB8yNgnDrxxPFIBw+zypQ62e63JrSo2FzcK
	 kYQlwNW9vsXMTvrbPg4gJsKBaenGa50bz7/YB38dlz3gRLq7WgOi6E793kMTbivbaQ
	 rhbY9GyTjlkp1vyPCixOHAkP6PBEWUsROHVxY9EJth6fPcURcfgAsTyrgHyOMFgwMN
	 1weqnwrhBVvyA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so52724801fa.0;
        Wed, 18 Sep 2024 00:36:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4Yd1x1CSKQNY7uO0RGxGjyoqi3g/aQ7bXdjyyEBWEzJ65h68WiXabsbJ3wpShN3USz/sETXZ4ITY=@vger.kernel.org, AJvYcCVfWThllTz6frd8K1NC6mlVfdIsq8gkh1k9VhmGgmflFPdPzy1hfQKYQpFohOPgdpT5uVFBGTHZckt9SMeV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6k2YKy4hTPjkBnjBQfDTtAyCV3LxR+2jvEn32qd/mmZjPOwOy
	OgbO35cm6G7lhq4zpITmy7LV2AGYZPh1Ab1M3oRko70zr9cf8vjZ+Uoj24j7iKNUj7+/aVQsHt4
	S9KDjtLzurTqAgSQ9ZMxALKQiTY8=
X-Google-Smtp-Source: AGHT+IEpWHKdL+L9Y+xhZYZC6/UQSWdrojN6ocFQBi8ZV2M4mzRjq9mYS9qvchQuooT/ISVsdHtaTqhl8nAvL7V9ePQ=
X-Received: by 2002:a05:651c:4cb:b0:2f7:4f46:8344 with SMTP id
 38308e7fff4ca-2f7a2a48ec5mr55271711fa.21.1726644978238; Wed, 18 Sep 2024
 00:36:18 -0700 (PDT)
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
 <874j6e482p.fsf@email.froward.int.ebiederm.org> <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
 <87setx3b8l.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87setx3b8l.fsf@email.froward.int.ebiederm.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 18 Sep 2024 09:36:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
Message-ID: <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Breno Leitao <leitao@debian.org>, 
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com, 
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 05:14, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Ard Biesheuvel <ardb@kernel.org> writes:
> >>
> >> > Hi Eric,
> >> >
> >> > Thanks for chiming in.
> >>
> >> It just looked like after James gave some expert input the
> >> conversation got stuck, so I am just trying to move it along.
> >>
> >> I don't think anyone knows what this whole elephant looks like,
> >> which makes solving the problem tricky.
> >>
> >> > On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >>
> > ...
> >> >>
> >> >> This leaves two practical questions if I have been following everything
> >> >> correctly.
> >> >>
> >> >> 1) How to get kexec to avoid picking that memory for the new kernel to
> >> >>    run in before it initializes itself. (AKA the getting stomped by
> >> >>    relocate kernel problem).
> >> >>
> >> >> 2) How to point the new kernel to preserved tpm_log.
> >> >>
> >> >>
> >> >> This recommendation is from memory so it may be a bit off but
> >> >> the general structure should work.  The idea is as follows.
> >> >>
> >> >> - Pass the information between kernels.
> >> >>
> >> >>   It is probably simplest for the kernel to have a command line option
> >> >>   that tells the kernel the address and size of the tpm_log.
> >> >>
> >> >>   We have a couple of mechanisms here.  Assuming you are loading a
> >> >>   bzImage with kexec_file_load you should be able to have the in kernel
> >> >>   loader to add those arguments to the kernel command line.
> >> >>
> >> >
> >> > This shouldn't be necessary, and I think it is actively harmful to
> >> > keep inventing special ways for the kexec kernel to learn about these
> >> > things that deviate from the methods used by the first kernel. This is
> >> > how we ended up with 5 sources of truth for the physical memory map
> >> > (EFI memory map, memblock and 3 different versions of the e820 memory
> >> > map).
> >> >
> >> > We should try very hard to make kexec idempotent, and reuse the
> >> > existing methods where possible. In this case, the EFI configuration
> >> > table is already being exposed to the kexec kernel, which describes
> >> > the base of the allocation. The size of the allocation can be derived
> >> > from the table header.
> >> >
> >> >> - Ensure that when the loader is finding an address to load the new
> >> >>   kernel it treats the address of the tpm_log as unavailable.
> >> >>
> >> >
> >> > The TPM log is a table created by the EFI stub loader, which is part
> >> > of the kernel. So if we need to tweak this for kexec's benefit, I'd
> >> > prefer changing it in a way that can accommodate the first kernel too.
> >> > However, I think the current method already has that property so I
> >> > don't think we need to do anything (modulo fixing the bug)
> >>
> >> I am fine with not inventing a new mechanism, but I think we need
> >> to reuse whatever mechanism the stub loader uses to pass it's
> >> table to the kernel.  Not the EFI table that disappears at
> >> ExitBootServices().
> >>
> >
> > Not sure what you mean here - the EFI table that gets clobbered by
> > kexec *is* the table that is created by the stub loader to pass the
> > TPM log to the kernel. Not sure what alternative you have in mind
> > here.
>
> I was referring to whatever the EFI table that James Bottomley mentioned
> that I presume the stub loader reads from when the stub loader
> constructs the tpm_log that is passed to the kernel.
>

There is no such table. The event log is exposed by the firmware via a
TCG2 protocol interface, which is no longer available after boot. So
the stub loader (which is the last kernel component that has access to
this interface) invokes this protocol and copies the output into a
table in memory which is exposed to the kernel proper as a EFI
configuration table.

So the main issue here is that EFI configuration tables are passed on
to kexec kernels, and we have to ensure (in the general case) that the
associated memory is not reused. The implication is that the stub
loader should always use EFI_ACPI_RECLAIM_MEMORY for allocations that
are referenced via EFI configuration tables, and doing so for this
table makes the bug go away.


> So I believe we are in agreement of everything except terminology.
>

Sure.

> >> > That said, I am doubtful that the kexec kernel can make meaningful use
> >> > of the TPM log to begin with, given that the TPM will be out of sync
> >> > at this point. But it is still better to keep it for symmetry, letting
> >> > the higher level kexec/kdump logic running in user space reason about
> >> > whether the TPM log has any value to it.
> >>
> >> Someone seems to think so or there would not be a complaint that it is
> >> getting corrupted.
> >>
> >
> > No. The problem is that the size of the table is *in* the table, and
> > so if it gets corrupted, the code that attempts to memblock_reserve()
> > it goes off into the weeds. But that does not imply there is a point
> > to having access to this table from a kexec kernel in the first place.
>
> If there is no point to having access to it then we should just not
> pass anything to the loaded kernel, so the kernel does not think there
> is anything there.
>
> >> This should not be the kexec-on-panic kernel as that runs in memory
> >> that is reserved solely for it's own use.  So we are talking something
> >> like using kexec as a bootloader.
> >>
> >
> > kexec as a bootloader under TPM based measured boot will need to do a
> > lot more than pass the firmware's event log to the next kernel. I'd
> > expect a properly engineered kexec to replace this table entirely, and
> > include the hashes of the assets it has loaded and measured into the
> > respective PCRs.
> >
> > But let's stick to solving the actual issue here, rather than
> > philosophize on how kexec might work in this context.
>
>
> I am fine with that.  The complaint I had seen was that the table was
> being corrupted and asking how to solve that.  It seems I haven't read
> the part of the conversation where it was made clear that no one wants
> the tpm_log after kexec.
>

It was not made clear, that is why I raised the question. I argued
that the TPM log has limited utility after a kexec, given that we will
be in one of two situations:
- the kexec boot chain cares about the TPM and measured boot, and will
therefore have extended the TPM's PCRs and the TPM log will be out of
sync;
- the kexec boot chain does not care, and so there is no point in
forwarding the TPM log.

Perhaps there is a third case where kdump wants to inspect the TPM log
that the crashed kernel accessed? But this is rather speculative.

> If someone wants the tpm_log then we need to solve this problem.
>

Agreed.

