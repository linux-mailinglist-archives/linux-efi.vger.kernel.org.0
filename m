Return-Path: <linux-efi+bounces-4735-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE59DB534DA
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D748E1C22914
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912063314CC;
	Thu, 11 Sep 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="kr9/qo0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQvPsas3"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD2335BBC;
	Thu, 11 Sep 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599679; cv=none; b=oOhSLoF+cz+s50jErwdvYHdsnzcc7y34Q9/gWSE3RsPzq5QNhdtTEIPnIRo9NkfSb68M2Vxg9S+rj70Ow4GwD7AzIM9+Sto1W11fjB4abxvm/LU43JStZP/iSQuNjtozWenpz30sCniw/CUUiCHxHPa9Vk9wSvGfPLCK12Ax+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599679; c=relaxed/simple;
	bh=12qnGEA+L3OAnlRsUnuhOCXh35RWwj/l9yuG+xevubk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=omH0pMl/pLxFvKfmDRUadBmsuqBVBhNo9SlbFdXH6YBdMGgkLWKvTGljpZbfsjmaLITIwZ9Q7JNSOjY+aW6W0DhFib32AC7XopVg5CPJ09cizpCqiTXnr/5SvtiBccY8hn07vOqMLoqaP5mkCyvSE8M4TSv+Wds7/5Qp2yBQf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=kr9/qo0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQvPsas3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 12C4BEC01BC;
	Thu, 11 Sep 2025 10:07:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 11 Sep 2025 10:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1757599676; x=1757686076; bh=uEYnB7YMtFbSpYh+8MMip4fPKS/ZUyYV
	YWNehhXOTE4=; b=kr9/qo0ISKDlWJ5KNrqoZVK+DPe6Lsd8QHDbIMGUyVyH5mwW
	TrA91v56mW8brtJXHIfHqwMItmOPElkDmffgnqaLiIgr+S6GeDrNtZqSY/IIOLVS
	5zqgBDLqqCpuogK6h/ccFP70X6BwXgg0Cqj/wBkblcuLWs2ewNXOeH130JqXwi/f
	93kAT3blIsFva9yplGdQLc0TsEFZWSLBjEPtxtogCE2kM9hVE68obWOiGmpL4eFj
	Ww/TygoyOObGnSJRW4BQrgH1rLFyanTR6cNv6akFbXl0Lgwu+oXgnAtoq2YrvX/y
	JpuWsnCMh+Vv9eNJUrFPlDnT+WXZX07eL9PlgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757599676; x=
	1757686076; bh=uEYnB7YMtFbSpYh+8MMip4fPKS/ZUyYVYWNehhXOTE4=; b=k
	QvPsas3rd8ezxuleI6AedCwncxX+JXzlFK81agdv0pfkdTDCuE9AscRSCVbfdNVX
	kPRltPRAZUje5fT2MxRSky/srnO1pefZXpGxV9fTESh+CS2e+M34unrgdg177gE4
	rlGkhCqYdXPRq2OubbxA3MMYuAwspa/8L5TZgj1FXDjP5iC47fDVICI8uwEvqrbx
	mQvEKh/DAZfdEVLl2rPEbk2k8Kczd7wmUSOvCY249xWO7oNDTcYFNZi60IDNYScN
	draChjEDkjOyH4t0RzkCWhdf7ywhGqXgTg5ol4d9wqc6Tfdhj0ItWnZr5ULD1aUU
	5A+lpqhpA/E2YAHQhncjg==
X-ME-Sender: <xms:u9fCaFV0gW_P_N0mxkY2P50XupraMSZ9ZgGmhYIYt7pUsZWaArwp7Q>
    <xme:u9fCaFkC9QQ_2luoXLEOikKgMfGe5PfGlAayfsQA15odYhvkXnwxodSG7ldgu5GwA
    6MOu3LbPYE_dakddA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfjuhhgohcu
    qfhsvhgrlhguohcuuegrrhhrvghrrgdfuceohhhughhoseifhhihnhhothhhuhhgohdrnh
    hlqeenucggtffrrghtthgvrhhnpeduieefkedvhfdugefggfeghfekffeitdehjeejtdek
    vdelvedtvedvfefhjefgtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhsrhdrhh
    htpdhmrghinhdrrhhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephhhughhoseifhhihnhhothhhuhhgohdrnhhlpdhnsggprhgtphhtthhope
    duvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggv
    pdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtth
    hopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthht
    oheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhhinhhgohesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:u9fCaFTmhRdBs2ToqP4Tt3Mnyp88sSmArfIEpmzTY9ppQavryaNN7A>
    <xmx:u9fCaI2UTBfUjJ0SEoKa4lSkfHAWZJ6iqnmTqGGsBt4cXvdHCDOhWg>
    <xmx:u9fCaPw5uP6rTf5DhAkdMnJ0cpBLQ3Yj6E2oiItpkMZbLRndQfpgDg>
    <xmx:u9fCaEz7xm4AiWVg2EEYvbybf-CLHyxp-Zlh7uQXPujzYJzlNawgzw>
    <xmx:vNfCaNuJKCMlb9oiBMfJQbAUkRjjWNkqIGnvrvfjjFZfj-OqNXt-XuUl>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 439D21B4006D; Thu, 11 Sep 2025 10:07:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Atl5U7xjKeAs
Date: Thu, 11 Sep 2025 16:07:33 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Documentation" <linux-doc@vger.kernel.org>,
 "Linux EFI" <linux-efi@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <4f36eee9-7e25-4e2f-ab9d-82f9732d0bf1@app.fastmail.com>
In-Reply-To: 
 <CAMj1kXFtdqN+cDVVWK1KTbfyfe0kazHt1t1XmPz58uf+axknOg@mail.gmail.com>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
 <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
 <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>
 <CAMj1kXFtdqN+cDVVWK1KTbfyfe0kazHt1t1XmPz58uf+axknOg@mail.gmail.com>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 11 Sep 2025, at 14:49, Ard Biesheuvel wrote:
> On Thu, 11 Sept 2025 at 13:23, Hugo Osvaldo Barrera <hugo@whynothugo.nl> wrote:
>>
>>
>>
>> On Thu, 11 Sep 2025, at 08:46, Ard Biesheuvel wrote:
>> > On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> >>
>> >> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>> >>
> ...
>> >> +For sample implementations, refer to `the original u-boot implementation`_ or
>> >> +`the implementation in candyboot`_.
>> >> +
>> >> +.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
>> >> +.. _the implementation in candyboot: https://git.sr.ht/~whynothugo/candyboot/tree/4097b2538d7f1cf85f03922bf42409490b666202/item/src/main.rs#L225
>> >>
>> >
>> > What is candyboot, and why are we adding this plug for it into the
>> > Linux documentation?
>>
>> It's a UEFI stub loader which can load the Linux kernel and provide it with an
>> initramfs using the above described protocol.
>>
>> The original version of this patch was based on my notes researching _how_
>> to implement this stub loader. The implementation is quite minimal, so I think
>> it serves as a useful reference example.
>>
>
> I think one example reference is sufficient, and I think piggybacking
> a plug of your own project onto a documentation refactoring patch is
> slightly dodgy, to be completely honest.

I don't know what kind of reaction you're expecting. The documentation
improvements were a side-effect of developing candyboot. You're free to
exclude the mention if you feel it is inadequate, but I don't appreciate
the personal attack.

> Where is candyboot used, and what does it add to the existing u-boot
> reference, which is the most widely used EFI implementation after EDK2
> for non-x86 systems?

candyboot can be used to produce a single bootable UEFI binary bundling
the kernel, cmdline and initrd. This binary can be signed to boot using
SecureBoot on regular consumer hardware. It is typically useful is
situations where u-boot isn't supported, and useless in most situations
where u-boot is usable.

The use-case is somewhat tangential here; the reference is merely as a
minimal (single file) reference implementation of the feature being
described here.

> If anything, we should be referring to the OVMF implementation here.

Agreed (I didn't know of its existence), here's a link to it:

https://github.com/tianocore/edk2/blob/502f0dfda4f2c4d1cc091f68b6467b6ef12cab45/OvmfPkg/QemuKernelLoaderFsDxe/QemuKernelLoaderFsDxe.c#L908

-- 
Hugo

