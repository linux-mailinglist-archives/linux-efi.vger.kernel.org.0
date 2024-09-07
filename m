Return-Path: <linux-efi+bounces-1679-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9789701F4
	for <lists+linux-efi@lfdr.de>; Sat,  7 Sep 2024 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B232836AF
	for <lists+linux-efi@lfdr.de>; Sat,  7 Sep 2024 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0155913C9A1;
	Sat,  7 Sep 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7QcIwe1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA5A55;
	Sat,  7 Sep 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725709302; cv=none; b=stkbhrUuSNFEYtvLYBsKUnM2v9sunbrOTT77/PZkEqiXq+LvSgFjG4iwMae5V6u22q5fXcA96Km7efYh8EKynpfALF01We3VqCi5kvC9EyT+cFoW7dY5PCpuzsFhMTlNfRPmYYcLSk98/vgf1alOCWtusuyYD4ognt49kWTyauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725709302; c=relaxed/simple;
	bh=5BvnWm80oXcTcRI+nnG3/BNTU5tdY3GPplxqRwUqxIg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=h/IPQbMkHQbO477TKD7egBS2XBxLTPDHwIBNH7ymwZErEzNEbtRxPDfiJvYj/Dre0d7l46OJhzjabnMT4Z7TPhqLv28YwxHNmZ7opBP/OmB2zbJC+qHPy1yH7OPx3uHpw42OB2DHcEXYDA49IHbTVqZyFDPL+8r6tEx7Z5sK0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7QcIwe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2846C4CEC2;
	Sat,  7 Sep 2024 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725709302;
	bh=5BvnWm80oXcTcRI+nnG3/BNTU5tdY3GPplxqRwUqxIg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=A7QcIwe1yd8HhMzhKhBXj1O2t0CGPqP8NCaXH0DWj1flZ9+8j3keUqNw6oL3gs2PC
	 vSzzvj5qYiDqCh9BuEinI1EA0K24ZFZJGv/PRMSp9cLM2onqQEE7IIGkRFCnyrcrQZ
	 iGQrra3hsQ7Xsv8HLGqoWKaRCqT4TRMUDwL6acrNZYxgutip/wO966Q2VRQBSZ/Sw2
	 UgeBxQz4MYXbo/+aXBN01MHuIRJ/GIVHI1AwtibEUk569WxMIoLkkWutBc7HE8KcTc
	 LWv0O2V+7P4q1mIJ/Q5cwevSjCTJ70k7B/we0GbmUixgQFfvJNBcue/rhPlvQLgjFW
	 utn3u1L67bZJw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Sep 2024 14:41:38 +0300
Message-Id: <D400W37FR01S.CLFIKA98YWX7@kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Philipp Rudo"
 <prudo@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Pingfan Liu" <piliu@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Lennart Poettering" <mzxreary@0pointer.de>, "Eric Biederman"
 <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>, "Dave Young"
 <dyoung@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon"
 <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <D400L4YN4K7K.264IDL4O8374F@kernel.org>
 <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
In-Reply-To: <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>

On Sat Sep 7, 2024 at 2:31 PM EEST, Jarkko Sakkinen wrote:
> On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote:
> > On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:
> > > Let me throw an other wild idea in the ring. Instead of implementing
> > > a EFI runtime we could also include a eBPF version of the stub into t=
he
> > > images. kexec could then extract the eBPF program and let it run just
> > > like any other eBPF program with all the pros (and cons) that come wi=
th
> > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > simply kexec any OS installer. On the other hand it would make it
> > > easier to port UKIs et al. to non-EFI systems. What do you think?
> >
> > BPF would have some guarantees that are favorable such as programs
> > always end, even faulty ones. It always has implicit "ExitBootServices"=
.
> >
> > Just a remark.
>
> Some days ago I was thinking could some of the kernel functionality be
> eBPF at least like in formal theory because most of it is amortized,
> i.e. does a fixed chunk of work. Not going into that rabbit hole but
> I really like this idea and could be good experimentation ground for
> such innovation.

E.g. let's imagine there would imaginary eBPF-TPM driver framework.

How I would go doing that would be to take the existing TPM driver
functionality and provide extra functions and resources available for
subsystem specific BPF environment, and have the orhestration code as
eBPF. I pretty much concluded that there is a chance that such could
work out.

Not something in my immediate table but it is still really interesting
idea, as instead of using language to separate "safe" and unsafe"
regions you would use "VM" environments to create the walls. In the
end of the day that would also great venture for Rust in kernel, i.e.
compile that BPF from Rust.

Sorry going of the hook the comment triggered me ;-)

BR, Jarkko

