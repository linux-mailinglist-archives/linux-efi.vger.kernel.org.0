Return-Path: <linux-efi+bounces-1570-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B0C95B410
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 13:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0531F22212
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2506F1C93CE;
	Thu, 22 Aug 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="S1wl8aJl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAszmFp+"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7317A584;
	Thu, 22 Aug 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326931; cv=none; b=g1qA5rqge/zhj3fV4gRp3/QzKHRSmDcdL0AENZD4mwIQRGUY+vtBXrvgSpcdw6VwOZJeeQhDi81KDS2itrKBy4vgL8WEUDf0EswqDCAys5ij8cDh+ogHa4BRVUdAPfsrw5NUPBzCk7RBcx/u2wFr4FFcAJbK/46AAzgwyWrjXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326931; c=relaxed/simple;
	bh=Iad6v0CjLjtYNAFwcj0lYekP7FKD8IOJ8QGY9HI8ClU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkn8p0Dh2uauyNtxEXXaZxYcpEIqTDnetc/UebZD4usK9yaWKO2GTFhbv/fRoWcLcSyJ/jEygJe3fTUaTpCE1jR4zw5xBVC/PNg9QUOA1ZMPpRENoh1zim9USjXyLQNhuqz7TOvtq4vU71sPQalaA48V9rgOC5QyykJEIu8HGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=S1wl8aJl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAszmFp+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5365E1151B10;
	Thu, 22 Aug 2024 07:42:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Aug 2024 07:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724326928;
	 x=1724413328; bh=UcM8Jlfp+a1fzzKXODZIjPcikyaSsQEZD/xDqW5eziU=; b=
	S1wl8aJlVnjcu159bFDByn4cjMya+W0/WKUD1NpkuLGVGOk7NgaP5w0wUKgHHaCt
	dJFvpUiLImF2AvFLwUWpNolBIm+AOoPQT093hqDauLwaJlTES3uO/JVynzyYP0m/
	yScOM7PKMfIWme0HLjTfdYlKORSRIkGnaV0BY2k/zu5jxfUHaFyRZvspaX2K0LlO
	bV4EIahR0q0Af9Iv7lTo50CB7Sr5WO7/Lk2/NQOvt039D4i5qmIePK84JqEmZupe
	E+1J5nX8RFZDuUcW8LHrzZScLA0rXPWxcP/QEujd1gMncETozzkk2Weloutf0fCB
	zyRfJVvvXXxvwQFsNbe/bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724326928; x=
	1724413328; bh=UcM8Jlfp+a1fzzKXODZIjPcikyaSsQEZD/xDqW5eziU=; b=f
	AszmFp+eAZcEyHshEefMOGKDGv+hKfZf/U9AVJ8aiA0ohPFW3F/1WeStaPoK4GhG
	QoOw9lOkFl5zK++F9Ao7il+r9UmffJd3Gzu4z4QktaaLFwKl7LJMGS3zPBV08abi
	QtFX1ZKx7nwKvlbFmLSZ6aN8S5Io5wWXGOFpmuAqNejBFj0Uq81yNMJro15iBUad
	CbTWWzkJf86IEi3MC/WhZQ6xbp99Hsuwf26pnKzM+iN36253oNl8zMieFNP/Xwpz
	HOXA9vfRN3A9blnyDCbmnK8fcO2XG4dp4rzB0V/HK839IRPW9KNbseHiyyEMYnHb
	pdLE5RLJZ5rWuo52eg31Q==
X-ME-Sender: <xms:DyTHZl7WwXem6qvT1iG2m3JY6i5SQnESvsc5-7V_Kt9LuXeAolOPRw>
    <xme:DyTHZi7Wvo7kSgl_Cp1LIPrEOekmQoRolyijpz7wURUlKkcsM8sg6sBe5Cq6BVYAj
    bkhKz3kFnjHIsX6gpU>
X-ME-Received: <xmr:DyTHZsfddomsqQy-UpR37g0acHAGml7Nw0beJ8jbNTv0kz7JLWbs5EnaENN7xcYrt91a9mZQ49uera9DrqFjuByRmkxv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomheplfgrnhcujfgvnhgurhhikhcuhfgrrh
    hruceokhgvrhhnvghlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepgfffudej
    kefhueetueelffehueekkeeiffejkeejkeehudfgvdfggfdtiefhudejnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgr
    rhhrrdgttgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpihhlihhusehrvgguhhgrthdrtghomhdprhgtphhtthhopehmiiigrhgvrghr
    hiestdhpohhinhhtvghrrdguvgdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhruhguohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgr
    rhhkkhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghivgguvghrmhesgihmih
    hsshhiohhnrdgtohhmpdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepugihohhunhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrkhdrrh
    huthhlrghnugesrghrmhdrtghomh
X-ME-Proxy: <xmx:DyTHZuKjNJ1E_3F5ssB9rwiXTetfCRIdx2-dOQ-4_PPnzilooRX0dg>
    <xmx:DyTHZpKXQoeC6yGLu5Sm98oJ212fW6I8n11CZ8pauGzq4-oN_XqG-A>
    <xmx:DyTHZnxRBkPO-ZcNpFQf_joTDFEe_2xud2sxrsZV7Lfuv1XZze0v0A>
    <xmx:DyTHZlKr00-tHU210kbHZtPAug4VF-PbPVCPHkGhcKATuIErErKKNA>
    <xmx:ECTHZribbWUMKX6FtKYZg2NwHFTi-OOlO2j-SY18lVJVylE1vYvUbWnq>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 07:42:05 -0400 (EDT)
Date: Thu, 22 Aug 2024 13:42:04 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Pingfan Liu <piliu@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <gnym722ge3bgzz765u7plh65kq2tk7odw7hs4nq5ufxdp5xauf@bgb32wlzcchc>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login>
 <CAF+s44TauSXk-gDgRHn=6CsQrAv8Q-QyGXkDJO+_sTh_yKde5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44TauSXk-gDgRHn=6CsQrAv8Q-QyGXkDJO+_sTh_yKde5w@mail.gmail.com>

On 22 18:45:38, Pingfan Liu wrote:
> On Thu, Aug 22, 2024 at 4:23 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > On Do, 22.08.24 13:42, Pingfan Liu (piliu@redhat.com) wrote:
> >
> >  > On Wed, Aug 21, 2024 at 10:27 PM Lennart Poettering
> > > <mzxreary@0pointer.de> wrote:
> > > >
> > > > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> > > >
> > > > > *** Background ***
> > > > >
> > > > > As more PE format kernel images are introduced, it post challenge to kexec to
> > > > > cope with the new format.
> > > > >
> > > > > In my attempt to add support for arm64 zboot image in the kernel [1],
> > > > > Ard suggested using an emulator to tackle this issue.  Last year, when
> > > > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> > > > > emulator approach again [3]
> > > >
> > > > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > > > files placed next to the UKI, via the UEFI file system APIs. What's
> > > > your intention with the UEFI emulator regarding that? The sidecars are
> > > > somewhat important, because that's how we parameterize otherwise
> > > > strictly sealed, immutable UKIs.
> > > >
> > > IIUC, you are referring to UKI addons.
> >
> > Yeah, UKI addons, as well as credential files, and sysext/confext
> > DDIs.
> >
> > The addons are the most interesting btw, because we load them into
> > memory as PE files, and ask the UEFI to authenticate them.
> >
> > > > Hence, what's the story there? implement some form of fs driver (for
> > > > what fs precisely?) in the emulator too?
> > > >
> > > As for addon, that is a missing part in this series. I have overlooked
> > > this issue. Originally, I thought that there was no need to implement
> > > a disk driver and vfat file system, just preload them into memory, and
> > > finally present them through the uefi API. I will take a closer look
> > > at it and chew on it.
> >
> > It doesn't have to be VFAT btw. It just has to be something. For
> > example, it might suffice to take these files, pack them up as cpio or
> > so and pass them along with the UEFI execution. The UEFI emulator
> > would then have to expose them as a file system then.
> >
> > We are not talking of a bazillion of files here, it's mostly a
> > smallish number of sidecar files I'd expect.
> >
> Yes, I think about using <key, value>, where key is the file path,
> value is the file content.
> 
> > > > And regarding tpm? tpms require drivers and i guess at the moment uefi
> > > > emulator would run those aren't available anymore? but we really
> > > > should do a separator measurement then. (also there needs to be some
> > > > way to pass over measurement log of that measurement?)
> > >
> > > It is a pity that it is a common issue persistent with kexec-reboot
> > > kernel nowadays.
> > > I am not familiar with TPM and have no clear idea for the time being.
> > > (emulating Platform Configuration Registers ?).  But since this
> > > emulator is held inside a linux kernel image, and the UKI's signature
> > > is checked during kexec_file_load. All of them are safe from
> > > modification, this security is not an urgent issue.
> >
> > Hmm, I'd really think about this with some priority. The measurement
> > stuff should not be an afterthought, it typically has major
> > implications on how you design your transitions, because measurements
> > of some component always need to happen *before* you pass control to
> > it, otherwise they are pointless.
> >
> 
> OK, I will look into the details of TPM to see how to bail out.

This issue is why I thought a different approach to the UEFI emulator
might be useful:

(1) On "kexec -l" execute the EFI binary inside the kernel as a kthread
until it exits boot services and record all TPM measurements into a
buffer
(2) On "kexec -e" use the kernels tpm driver to actually perform all the
prerecorded measurements.
(3) Transition into a "purgatory" that will
clean up the address space to make sure we get to an identity
mapping.
(4) Return control to the EFI app at the point it exited boot services

Additional advantage is that we have filesystem access during (1) so it's
simple to load additional sidecar files for the UKI.

I have two questions:

1: Does the systemd-stub only perform measurements before exiting boot
services or also afterwards?

2: Is it okay to just go to an identity mapping when boot services are
exited or is the identidy mapping actually required for the entire
execution of the EFI app (I know the UEFI spec calls for this, but I
think it should be possible to clean up the address space in a purgatory)?


I played around with this approach last year and got the start of the
kernels EFI stub executing in a kthread and calling into provided boot
services, but the difficult part is memory allocation and cleaning up
the address space in a purgatory.

> 
> Thanks,
> 
> Pingfan
> 

Kind regards,
Jan

