Return-Path: <linux-efi+bounces-1688-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E95972008
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 19:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635B8288999
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92114D6FE;
	Mon,  9 Sep 2024 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4KtyCy2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0342AA1;
	Mon,  9 Sep 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901775; cv=none; b=brwg9Y0QYdOV5embbFYKDrAwIYH3MltovZA40qW65Nr477s5kRwqE696xzofvYywUGUOPblZBcwP1KAyqbzUmz6BwEDJ0RBAacKX7NhJI52HnqV6EFgqNCWcGNktLG1gVqgnvU+CamaefQDSm/TM+Vvs8DxbJX1TU5a2+J+tGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901775; c=relaxed/simple;
	bh=/qV0P6xJzrMSUVsz7Z1CsIbU69skcya/dmYXKueZ/lU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=oBl1BWnM0T2m22z1roLNa50QwmJ6jfH8s4WjjIQ2DUGq7kjH1yukp6d7AoF8//Z5XvumS1+z/FLCe8pcvX+eN+yDsmG89E0Js7ea0qI+jX8cwGf7UUDyxH2tWRGyBo3ckSRX5bZ0uBG9rzq4kTZ68mG26ktVNi64DB3B376TkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4KtyCy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E7C4CEC5;
	Mon,  9 Sep 2024 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725901774;
	bh=/qV0P6xJzrMSUVsz7Z1CsIbU69skcya/dmYXKueZ/lU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=e4KtyCy2WiCK98F3bH7l2m9CUia2bzqaID9ICtWdqJTNuSR67C61vg2hEyDg/8ngo
	 T9IUVXNXNfBMZapo4Gj6LOtBeZB/LOm6Mfrs3aadbj2EEtt78Bbx4OuHDiNNtKcbAS
	 eaY667XHP8he708UdopD2mFkn28mW+HSwG14hdHCsfAvb1G1cKMItNykSJlzkVZG31
	 lcpqA1Ic0fh5k7bqZ/7Ax+XY59vSc0ik+E6v4Hgw4OD3GiaU/1FbCUCzcUkYWulm3X
	 U6SZznf4jupfh1R2tn/JEkD4dKU6wjTJYmPeYpb68HnL2eRU2gaCYuOR8pI7JW4BpH
	 713bWSZ6kVGAA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Sep 2024 20:09:30 +0300
Message-Id: <D41X47S8U93M.IDL1ES4DB1Y9@kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Philipp Rudo" <prudo@redhat.com>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Pingfan Liu" <piliu@redhat.com>,
 "Jan Hendrik Farr" <kernel@jfarr.cc>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Eric Biederman" <ebiederm@xmission.com>, "Baoquan
 He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <D400L4YN4K7K.264IDL4O8374F@kernel.org>
 <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
 <D400W37FR01S.CLFIKA98YWX7@kernel.org>
 <20240909155555.257e13eb@rotkaeppchen>
In-Reply-To: <20240909155555.257e13eb@rotkaeppchen>

On Mon Sep 9, 2024 at 4:55 PM EEST, Philipp Rudo wrote:
> Hi Jarkko,
>
> On Sat, 07 Sep 2024 14:41:38 +0300
> "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
>
> > On Sat Sep 7, 2024 at 2:31 PM EEST, Jarkko Sakkinen wrote:
> > > On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote: =20
> > > > On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote: =20
> > > > > Let me throw an other wild idea in the ring. Instead of implement=
ing
> > > > > a EFI runtime we could also include a eBPF version of the stub in=
to the
> > > > > images. kexec could then extract the eBPF program and let it run =
just
> > > > > like any other eBPF program with all the pros (and cons) that com=
e with
> > > > > it. That won't be as generic as the EFI runtime, e.g. you couldn'=
t
> > > > > simply kexec any OS installer. On the other hand it would make it
> > > > > easier to port UKIs et al. to non-EFI systems. What do you think?=
 =20
> > > >
> > > > BPF would have some guarantees that are favorable such as programs
> > > > always end, even faulty ones. It always has implicit "ExitBootServi=
ces".
> > > >
> > > > Just a remark. =20
> > >
> > > Some days ago I was thinking could some of the kernel functionality b=
e
> > > eBPF at least like in formal theory because most of it is amortized,
> > > i.e. does a fixed chunk of work. Not going into that rabbit hole but
> > > I really like this idea and could be good experimentation ground for
> > > such innovation. =20
> >=20
> > E.g. let's imagine there would imaginary eBPF-TPM driver framework.
> >=20
> > How I would go doing that would be to take the existing TPM driver
> > functionality and provide extra functions and resources available for
> > subsystem specific BPF environment, and have the orhestration code as
> > eBPF. I pretty much concluded that there is a chance that such could
> > work out.
> >=20
> > Not something in my immediate table but it is still really interesting
> > idea, as instead of using language to separate "safe" and unsafe"
> > regions you would use "VM" environments to create the walls. In the
> > end of the day that would also great venture for Rust in kernel, i.e.
> > compile that BPF from Rust.
> >=20
> > Sorry going of the hook the comment triggered me ;-)
>
> I'm glad you like the idea :-)
>
> Sounds like an interesting idea you are having there!

Yeah, if you go forward with this please CC to me any possible
follow-ups :-)

BR, Jarkko

