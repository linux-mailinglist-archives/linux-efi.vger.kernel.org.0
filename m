Return-Path: <linux-efi+bounces-4730-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1CB5301A
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9643B91BA
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF893128D4;
	Thu, 11 Sep 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="aUwzyDUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtNp15C6"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05231076D;
	Thu, 11 Sep 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589800; cv=none; b=ZOC276q0RJg8hB8mJnS0hzAmL8d3jVp/TfRMclQuiw1nwxtgWqqAgJE1/lyg9JyUba5sK1IxJISJgm7q3dcB/VAFS56vah7QpKMjhaIyheD0nDbqqFAtKlwrKz8r0+sVnxm8lKbxzIASCzepzxQffO5dpWAbOlShbcyKcJ7LXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589800; c=relaxed/simple;
	bh=BhrTyR4yMbcsK5yfmOCBZj42BKA/FZ+kbUhnhlbCvo0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cqvjiuVvN0/92/JrGVrf1qYBFM7PzrJ8ZDgzPsiXaN7+qfoIZ5yYgrTDp8kIDA+tYJg+/0Sgx0buauOSS7VAtZVXiv7ykLSKOyUiA+V2Fj27fh9XFS9p3DJfdptjfweYMUZ0Qv9ipP9bfdinKE9kYIp8uSQtEWliiGyMKClCGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=aUwzyDUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HtNp15C6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED3611400037;
	Thu, 11 Sep 2025 07:23:16 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 11 Sep 2025 07:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1757589796; x=1757676196; bh=phsMw9DpPdUU5v2F8lNwtFPs0tTryaYN
	/3X1959+Xa8=; b=aUwzyDUS6Ni4t/QvgHl6LsBHmF3uI/J2bwfyWZz7hDPwalU1
	En7wI3iL9JLskuGRKmGCqKjNN/OdK81vPFBKO0IJ/KemD+GVGwNovZ3OOxMU/sEt
	ovW8IXtobZm7plBNei4gMlwR2se3NXojGVGB20ipf78KMQqPXvxBb2wDDEmkvjaf
	/jw0BLSXPZzTdY+zdq06NPikxsQksPOjLKKZlPkpVqvMSFWlcs0UtGTpOvRT6JzP
	65AdxFLBN49Nm4VgAzxaqVj2ankj04N9NfzF8/CHg7GtxD4fSWlgS/P5+9D1pqvY
	LQRum97mztFPSwrM/sfnKGOdk64VUIQ+CVWIoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757589796; x=
	1757676196; bh=phsMw9DpPdUU5v2F8lNwtFPs0tTryaYN/3X1959+Xa8=; b=H
	tNp15C6ewceirNuY7Lt55W5yO0gsECn8eon3Aav341PO3Ayad9iJzLUedEVsWylC
	n6ZlJU+i6w8g1PLoPRGDlT3Hnub9ko4xfllfieRkPktvhBqZ8ZYTSmCtJzFaOfSe
	I8wjOX4XfpRWGU1k/h6GPhs9BUdSG9Wq5KpX/a8hhOzej7EJH81MY4zpcmLRo7QJ
	pj3eEqeTD8MxsdEdloyYctr3yJJjh6YOLw5+N1gH+RAxItA1Qn3fVEN+k4OoHgL4
	vezNaFot0718VFsUYltuATRn6Cd6UBFMi/dqxuGm8guwW8hfPjKikBGOlRpE+Ovt
	YacpwppQk+iwffojfZpVA==
X-ME-Sender: <xms:I7HCaDWY9wJYM3hQR4RWcDQNUipz8bn_7SgxhAhqzVTY_TF-dxoRUw>
    <xme:I7HCaLmI_UR7JPJs2Cypq6Bq8AjyND1kUzfETAdN_O0PmkrrseLPQbPxlIupKUQn5
    dgRQ7ETps8TJ7wvVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfjuhhgohcu
    qfhsvhgrlhguohcuuegrrhhrvghrrgdfuceohhhughhoseifhhihnhhothhhuhhgohdrnh
    hlqeenucggtffrrghtthgvrhhnpefhgfeivdekvefgjeeludffieefgffgvdeugffgteef
    feefjeevhfefudduuddvffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhdpshhrrdhhthdpmhgrihhnrdhrshenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehhuhhgohesfihhhihnohhthhhughhordhnlh
    dpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegs
    phesrghlihgvnhekrdguvgdprhgtphhtthhopegsrghgrghsughothhmvgesghhmrghilh
    drtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    giekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonh
    higidruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhope
    hmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdguohgtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:I7HCaDS15vkvBBDt2u3ukQI2EAMZVffKfcwGK1NX4cJUbRaZanVXlw>
    <xmx:I7HCaO3p4WrzWAv7tZ6Wsn576pQ56gBCKOD3rLG7L3s3HoZ-1ahm6g>
    <xmx:I7HCaNzTgbSWNFQfP0mQ2Mq6DfuIjVcKK5fr3he1sGkesFC73ckddw>
    <xmx:I7HCaKy_XBAiduFtR37sRkWxZh9eGlikwkwJ8gIFwCzg2fZiyDIACg>
    <xmx:JLHCaDv0HHdTHulTCdDOew615F8frATTJRvqzWfntn4UX41y3_PEGXsU>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C56691B4006D; Thu, 11 Sep 2025 07:23:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Atl5U7xjKeAs
Date: Thu, 11 Sep 2025 13:22:54 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: "Ard Biesheuvel" <ardb@kernel.org>, "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Documentation" <linux-doc@vger.kernel.org>,
 "Linux EFI" <linux-efi@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>
In-Reply-To: 
 <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
 <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, 11 Sep 2025, at 08:46, Ard Biesheuvel wrote:
> On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>>
>> Since the Handover Protocol was deprecated, the recommended approach is
>> to provide an initrd using a UEFI boot service with the
>> LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
>> approach has been no more than an admonition with a link to an existing
>> implementation.
>>
>> Provide a short explanation of this functionality, to ease future
>> implementations without having to reverse engineer existing ones.
>>
>> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>> Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
>> [Bagas: Don't use :ref: link to EFI stub documentation]
>> Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  Documentation/admin-guide/efi-stub.rst |  3 +++
>>  Documentation/arch/x86/boot.rst        | 35 ++++++++++++++++++++------
>>  2 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
>> index 090f3a185e1897..2f0f040f6913a4 100644
>> --- a/Documentation/admin-guide/efi-stub.rst
>> +++ b/Documentation/admin-guide/efi-stub.rst
>> @@ -79,6 +79,9 @@ because the image we're executing is interpreted by the EFI shell,
>>  which understands relative paths, whereas the rest of the command line
>>  is passed to bzImage.efi.
>>
>> +.. hint::
>> +   It is also possible to provide an initrd using UEFI boot services. See
>> +   :ref:`pe-coff-entry-point` for details.
>>
>
> Better say 'using a Linux-specific UEFI protocol at boot time'. The
> boot services are a specific set of APIs none of which have anything
> to do with initrd loading.
>
>>  The "dtb=" option
>>  -----------------
>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
>> index 77e6163288db08..fadbe66517bdf2 100644
>> --- a/Documentation/arch/x86/boot.rst
>> +++ b/Documentation/arch/x86/boot.rst
>> @@ -1431,12 +1431,31 @@ The boot loader *must* fill out the following fields in bp::
>>  All other fields should be zero.
>>
>>  .. note::
>> -     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
>> -     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
>> -     loading protocol (refer to [0] for an example of the bootloader side of
>> -     this), which removes the need for any knowledge on the part of the EFI
>> -     bootloader regarding the internal representation of boot_params or any
>> -     requirements/limitations regarding the placement of the command line
>> -     and ramdisk in memory, or the placement of the kernel image itself.
>> +   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
>> +   entry point described below.
>>
>> -[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
>> +.. _pe-coff-entry-point:
>> +
>> +PE/COFF entry point
>> +===================
>> +
>> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
>> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
>> +implementation details.
>> +

This should be a link rather than a path to the source file.

>> +The stub loader can request the initrd via a UEFI protocol. For this to work,
>> +the firmware or bootloader needs to register a handle which implements the
>
> ... which carries implementations of the ``EFI_LOAD_FILE2`` protocol
> and the device path protocol exposing the
> ``LINUX_EFI_INITRD_MEDIA_GUID`` vendor media device path.
>
>> +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` device
>> +path. In this case, a kernel booting via the EFI stub will use the ``LoadFile``
>> +function on the registered handle to obtain a reference to the initrd.
>> +

Might be worth mentioning that this protocol is defined in the UEFI spec,
section 13.2.

>
> ... will invoke LoadFile2::LoadFile() method on the registered
> protocol to instruct the firmware to load the initrd into a memory
> location chosen by the kernel/EFI stub.
>
>> +This approach removes the need for any knowledge on the part of the EFI
>> +bootloader regarding the internal representation of boot_params or any
>> +requirements/limitations regarding the placement of the command line and
>> +ramdisk in memory, or the placement of the kernel image itself.
>> +
>> +For sample implementations, refer to `the original u-boot implementation`_ or
>> +`the implementation in candyboot`_.
>> +
>> +.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
>> +.. _the implementation in candyboot: https://git.sr.ht/~whynothugo/candyboot/tree/4097b2538d7f1cf85f03922bf42409490b666202/item/src/main.rs#L225
>>
>
> What is candyboot, and why are we adding this plug for it into the
> Linux documentation?

It's a UEFI stub loader which can load the Linux kernel and provide it with an
initramfs using the above described protocol.

The original version of this patch was based on my notes researching _how_
to implement this stub loader. The implementation is quite minimal, so I think
it serves as a useful reference example.

-- 
Hugo

