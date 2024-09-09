Return-Path: <linux-efi+bounces-1682-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9083B97158F
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 12:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2F0B2615D
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9411B3F3D;
	Mon,  9 Sep 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="ro+MYWG+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l011lgwr"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64F1B4C4D;
	Mon,  9 Sep 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878572; cv=none; b=dC3DfqklOwpAu/4y5JLlNFC4hNDP4MuxP3pcKr5QWIDw43pRjnPEZwpjj/sewa5nVgN9Tr1U19Aaa2TX2AxqI9TlrkuaiM4hkevZwRXNgL6wu10glVhFppebQ4J44+MKDIKONcUgCTddok3xr5sqCO1DJsKlaSoc1LKTnd7JdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878572; c=relaxed/simple;
	bh=zbWvCp2Ln7Z1FkE6rb5eCGP8rWOJnCjmfIGYDktlLe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er+LbjpWJOqKSViDAYbPiW5nvxKc1RrT4yeUa5n3113g164WD/jjFTS+JfmidBiBJGGktRJWHMYgnUgk3mEaWDgUuE7K97E5EjLuCZSmzYQSyOUa8nS5aYZow0w+91dBsoVM2FVltBj84TPsd/ycf1OmPN0qN5akddDozRyegvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=ro+MYWG+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l011lgwr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40CC91140206;
	Mon,  9 Sep 2024 06:42:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Sep 2024 06:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1725878569; x=1725964969; bh=ZFTA+pO0V1
	16RhPMfAQzVCkGKQSIt4l0h5shzFuOeNk=; b=ro+MYWG+JmT2YEB/62iuK8yM9O
	3exbN72n/Ol15M23lBZ2inyBUN+ZR/NpTqFeaxX1dns071cyW6QuGVWfdp7yrgIK
	r4QasFH4QQxmDGAKMid6/K4zFubqMZyxmKItJDX1/jUKYnVOY1noWmIkbjMNNDrD
	5FPIuteECmGKG8DLQlMqZuR8n5ofokP2FiTQpJoHJ0Lk13VHUUVMME4GHbumaUKa
	CgdVzHqEF8srQ9JsmJ5K8iOwUd6ibacSl1BsEa0H8c85vbnfDhNTG0Y5Tiee6i9C
	oDdDqeEJyrdXm0MTr0R4c9nioUaS84Fv1ay6106zHq9lPH+ZzkWkIxgpwT5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725878569; x=1725964969; bh=ZFTA+pO0V116RhPMfAQzVCkGKQSI
	t4l0h5shzFuOeNk=; b=l011lgwrlWJ0pDW7aJCNH/DMfXqPMe/pxYc3knKROLOF
	hiithLggMKjYVkQuYjZ4HoRXQCw/3SZr4+aiElmc57GycZVuws+sMFQwh/fAUd+T
	CFEYa9Xusf/s2P9dvcFd2hraW7xhtYpwg7OXDr3WPrlFAn4rRuKFoRIQLeE2aXYZ
	9ovU8mCvgue8GnbmHlu5j2DpQ9h2mZZf3O/DgPQaGWNe/laiS4vUHSFakXi4VLi4
	DnAPNXw1YZzJajTxr/tQDSnKZlyVEYKBea4CiWgB9Fh5Q+e5RYWPdz93Qqg7TBUH
	GJQMB/TzCR0AuW8XfL3cApzkXIGJzye+7nnVeOKrhA==
X-ME-Sender: <xms:KNHeZr3wBH6Jopv0Q3WJM1mr6LZ6MPHep4kKOSizOqvR3CzWK5QFSg>
    <xme:KNHeZqFqljSXp3Sdnb8bp5OuQ1XkxH2kE7B9R9LOgn_JaTJ3ZPZdL3F9otWQILt-N
    ztKzJtkfIvvOoxlXug>
X-ME-Received: <xmr:KNHeZr5kpGmddeHQGeobGRqYj1b3aXRGNx7CeUj-vCtqfB0fX4BPG9NYtw9CC4jAxGu5dc1UMeKUwvaxiBq878RheAQp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrh
    cuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedukeegffdt
    feeihfehteevvdeiueetteelgfefvdfhleeufeegieduieduhfekieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghr
    rhdrtggtpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhiigihrvggrrhihsedtphhoihhnthgvrhdruggvpdhrtghpthhtohepphhruhgu
    ohesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpihhlihhusehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghr
    khhkoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhish
    hsihhonhdrtghomhdprhgtphhtthhopegshhgvsehrvgguhhgrthdrtghomhdprhgtphht
    thhopeguhihouhhnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruh
    htlhgrnhgusegrrhhmrdgtohhm
X-ME-Proxy: <xmx:KNHeZg0FjZU7uScSbgbh3obke5N0LOltSv6hXggI3crxdagqrBzwsA>
    <xmx:KNHeZuGY1IkWebm7_BxT6C3PlBBCxpFFFoMbFj-ouBCuarvFAXy4GQ>
    <xmx:KNHeZh_aMT-9F9SYnt1-mmeGuoWBrGpIxUVn2J3mwvwDFntn25MPFQ>
    <xmx:KNHeZrlKYxvrEmbTpDWI3Anq021tpG4tKvxGtuktKSsBYfleGAXjaw>
    <xmx:KdHeZrdQJNBx9W6KzlOZ1Ky6jBnbcqsbNM-uf-XhwHmXDDXASLcsnz0v>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 06:42:46 -0400 (EDT)
Date: Mon, 9 Sep 2024 12:42:45 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Philipp Rudo <prudo@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt7RJepoCiCMRZSu@archlinux>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <Zt7EbvWjF9WPCYfn@gardel-login>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7EbvWjF9WPCYfn@gardel-login>

On 09 11:48:30, Lennart Poettering wrote:
> On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:
> 
> > I mostly agree on what you have wrote. But I see a big problem in
> > running the EFI emulator in user space when it comes to secure boot.
> > The chain of trust ends in the kernel. So it's the kernel that needs to
> > verify that the image to be loaded can be trusted. But when the EFI
> > runtime is in user space the kernel simply cannot do that. Which means,
> > if we want to go this way, we would need to extend the chain of trust
> > to user space. Which will be a whole bucket of worms, not just a
> > can.
> 
> May it would be nice to have a way to "zap" userspace away, i.e. allow
> the kernel to get rid of all processes in some way, reliable. And then
> simply start a new userspace, from a trusted definition. Or in other
> words: if you don't want to trust the usual userspace, then let's
> maybe just terminate it, and create it anew, with a clean, pristine
> definition the old userspace cannot get access to.

Well, this is an interesting idea!

However, I'm sceptical if this could be done in a secure way. How do we
ensure that nothing the old userspace did with the various interfaces to
the kernel has no impact on the new userspace? Maybe others can chime in
on this? Does kernel_lockdown give more guarantees related to this?

Even if this is possible in a secure way, there is a problem with doing
this for kernels that are to be kexec'd on kernel panic. In this
approach we can't pre-run them until EBS(), so we would rely on the old
kernel to still be intact when we want to kexec reboot.



You could do a system where you kexec into an intermediate kernel. That
kernel get's kexec'd with a signed initrd that can use the normal
kexec_load syscall to load do any kind of preparation in userspace.
Problem: For that intermediate enviroment we already need a format
that combines kernel image, initrd, cmdline all signed in one package
aka UKI. Was it the chicken or the egg?

But this shows that if we implemented UKIs the easy way (kernel simply
checks signature, extracts the pieces, and kexecs them like normal),
this approach could always be used to support kexec for other future
formats. They could use the kernels UKI support to boot into an
intermediate kernel with UEFI implemented in userspace in the initrd.

So basically support UKIs the easy way and use them to be able to
securely zap away userspace and start with a fresh kernel and signed
userspace as a way to support other UEFI formats that are not UKI.

> 
> > Let me throw an other wild idea in the ring. Instead of implementing
> > a EFI runtime we could also include a eBPF version of the stub into the
> > images. kexec could then extract the eBPF program and let it run just
> > like any other eBPF program with all the pros (and cons) that come with
> > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > simply kexec any OS installer. On the other hand it would make it
> > easier to port UKIs et al. to non-EFI systems. What do you think?
> 
> ebpf is not turing complete, I am not sure how far you will make it
> with this, in the various implementations of EFI payloads there are
> plenty of loops, sometimes IO loops, sometimes hash loops of huge data
> (for measurements). As I understand ebpf is not really compatible such
> code.
> 
> Lennart
> 
> --
> Lennart Poettering, Berlin

