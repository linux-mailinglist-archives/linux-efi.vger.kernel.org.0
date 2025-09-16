Return-Path: <linux-efi+bounces-4844-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093EB59159
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 10:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D5E1703FA
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD328AAF9;
	Tue, 16 Sep 2025 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="cIf8yvt8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8t1WVWb"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90D280A56;
	Tue, 16 Sep 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012914; cv=none; b=uDUyrxS4KxTgbegATzu9y5lBQMSPYs0a47aVxD5NieRnV0VaZu7g0XiYKcbAHJ4ML3Pn0Nn4PuGo3DEXflmC38Ge3wv8aqyD6ejsDdKyA5kgrK1be1atM7ACJnnkEHwslnuBAqKVcWI/PNgZHKwZPOjf38fLv7NkqhDltjzKY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012914; c=relaxed/simple;
	bh=bTZ+VfeWzw63KZ3vzCqQwXjBV8fgJ+HHfsa0rsa7Jq8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P10uGZ3EH7mUwh0JRAnK3zvYqrhiN0+EZqGq3b2Uu4uEtePtItkARq0Krj3VeXtZxJPl8AjBD/T9esTd7guyduNQiKfvce4RlgUgpD85BGYsuEjPSd98Mj4WIuLXOMBgyqcV28IJuGFjQOBMNDfB9CP1ysuKJqH6fEF807MIu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=cIf8yvt8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8t1WVWb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C87C1D00221;
	Tue, 16 Sep 2025 04:55:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 16 Sep 2025 04:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1758012909; x=1758099309; bh=1ulH8g7Li7zG++T0/MO6PWY+rqx4PTpm
	j/wnHfCR1vg=; b=cIf8yvt860x+aSG4LH3Oqr2DL6nm0bWQq+p8JOW3CBdYHpvy
	6GmhQOgJKKarCcLBe3hEaze2RBDc7epTklge/Pjco2mjpFPi/fL/NooAWBk6Rqp4
	HZl7zvzjdSIr83Q1fyJrOONd4Sl1qyx44MQ3O9f6COd8nYE6mSW90H/7LCW+IC5g
	eUtkZ1NY7bm6gPUSbm1sfKjEFmvMb+XklB0/oMWGxx84L7+9E+GJJf9s4LLrBY3V
	NLt5E24ZfH1d8j0iGT6tKIG2WnstFqYeTj72DCoJA66OdY4DYjAEsQlhjzc2vfYI
	25Zfzt0Bf6fTGtZFfOf1JgyM+thdGmXRJbbmXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758012909; x=
	1758099309; bh=1ulH8g7Li7zG++T0/MO6PWY+rqx4PTpmj/wnHfCR1vg=; b=H
	8t1WVWbjCaYevmG2g3boG4+rszZVsqTXZ5EH7fmKgCkBNdGu/bwAHRxkf+fTxbsn
	XayVDXTNOaNFVdk+X3Tnqn9ZrbFzvcKIiFuAAl6cW2Jdzh6dj9xU0r84lJAersqq
	WUiN89pgvHdXnohzlbOIuRSmIxDOIJCyAMxSdn/oZVoF9YoTdUiCT+Z0/nByUSYk
	4cUDOZAg46p8TRS/lE8Vee+htpNfjPYNBClVJA+C6qPksasjiJlkhuCTzW9AvTeW
	WRM2Q6XZ1tPhwRH8ezxxmfPhSMZeGlsx2fVNU+bL+xRrqHkBN0qTex4tPzQEH2bJ
	D+myToFwvCAAL8Aoo0XOQ==
X-ME-Sender: <xms:7SXJaOcBgfc3hyy0V88jYTz2X9R83srQUbkwCv2g4BaoEwRw34r30A>
    <xme:7SXJaIN1jaTyjV9yTLM3yEKvJFztBwjE0J1CwPq5pRvFURwBJ_wCfCtBMD_zD32zF
    tP1HB41g97kUWvsKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfjuhhgohcu
    qfhsvhgrlhguohcuuegrrhhrvghrrgdfuceohhhughhoseifhhihnhhothhhuhhgohdrnh
    hlqeenucggtffrrghtthgvrhhnpeffleffgfdtkeffudekudeghfdtledukeeguefgteel
    udeukedtueekgeegfffgudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehhuhhgohesfihhhihnohhthhhughhordhnlhdpnhgspghrtghpthhtohepudefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgt
    phhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehrug
    hunhhlrghpsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgr
    nhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheptghorhgsvghtse
    hlfihnrdhnvghtpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:7SXJaJCx4hOenCD6YBq1wodpfVv5l3S0CmnP-QJT8npHWgOqlg_r-w>
    <xmx:7SXJaGCCN9MBaAEbU_XTW4fTBinQxrPMmw6H0hlHhUDWsWB2v4lMHQ>
    <xmx:7SXJaAECY9xR7D9MjMhPKFmrUROQPOK9t0dISAmchwjNDhASBIx2EQ>
    <xmx:7SXJaN5TXGPLxDr6udiwC9I4Gor-431BL5Udl1F6Uf_LT4HDyOApcg>
    <xmx:7SXJaPisxNyG8PZ--U6qVWJoUJG86k8sszX3jJPBo0TNYLj8m4roOjiE>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 795541B4006D; Tue, 16 Sep 2025 04:55:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ar2Xryr4sLlg
Date: Tue, 16 Sep 2025 10:54:39 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Documentation" <linux-doc@vger.kernel.org>,
 "Linux EFI" <linux-efi@vger.kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Randy Dunlap" <rdunlap@infradead.org>
Message-Id: <b629ff7e-a223-467f-8e32-78f825bd31ac@app.fastmail.com>
In-Reply-To: <20250916073244.590483-1-bagasdotme@gmail.com>
References: <20250916073244.590483-1-bagasdotme@gmail.com>
Subject: Re: [PATCH v2] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 16 Sep 2025, at 09:32, Bagas Sanjaya wrote:
> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>
> Since the Handover Protocol was deprecated, the recommended approach is
> to provide an initrd using a UEFI boot service with the
> LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
> approach has been no more than an admonition with a link to an existing
> implementation.
>
> Provide a short explanation of this functionality, to ease future
> implementations without having to reverse engineer existing ones.
>
> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
> [Bagas: Don't use :ref: link to EFI stub documentation and refer to
> OVMF/edk2 implementation]
> Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v1 [1]:
>
>   * Apply wording suggestion (Ard)
>   * Replace candyboot reference with OVMF (Ard)
>   * Invert patch subject prefix
>
> [1]: 
> https://lore.kernel.org/linux-doc/20250910015738.14848-2-bagasdotme@gmail.com/
>
>  Documentation/admin-guide/efi-stub.rst |  3 ++
>  Documentation/arch/x86/boot.rst        | 38 ++++++++++++++++++++------
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst 
> b/Documentation/admin-guide/efi-stub.rst
> index 090f3a185e1897..f8e7407698bd2a 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -79,6 +79,9 @@ because the image we're executing is interpreted by 
> the EFI shell,
>  which understands relative paths, whereas the rest of the command line
>  is passed to bzImage.efi.
> 
> +.. hint::
> +   It is also possible to provide an initrd using a Linux-specific UEFI
> +   protocol at boot time. See :ref:`pe-coff-entry-point` for details.
> 
>  The "dtb=" option
>  -----------------
> diff --git a/Documentation/arch/x86/boot.rst 
> b/Documentation/arch/x86/boot.rst
> index 77e6163288db08..32eea3d2807e1c 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -1431,12 +1431,34 @@ The boot loader *must* fill out the following 
> fields in bp::
>  All other fields should be zero.
> 
>  .. note::
> -     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> -     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
> -     loading protocol (refer to [0] for an example of the bootloader side of
> -     this), which removes the need for any knowledge on the part of the EFI
> -     bootloader regarding the internal representation of boot_params or any
> -     requirements/limitations regarding the placement of the command line
> -     and ramdisk in memory, or the placement of the kernel image itself.
> +   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> +   entry point described below.
> 
> -[0] 
> https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +.. _pe-coff-entry-point:
> +
> +PE/COFF entry point
> +===================
> +
> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed 
> as a
> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> +implementation details.

I must insist that it's a terrible idea to replace an actual link with the
name of the source file.

This might be (marginally) more convenient for somebody who's editing the
documentation, but it becomes completely useless for somebody who's READING
the documentation. Documentation needs to target readers.

For someone reading https://www.kernel.org/doc/html/latest/arch/x86/boot.html,
the above filename conveys no useful information.

> +
> +The stub loader can request the initrd via a UEFI protocol. For this 
> to work,
> +the firmware or bootloader needs to register a handle which carries
> +implementations of the ``EFI_LOAD_FILE2`` protocol and the device path
> +protocol exposing the ``LINUX_EFI_INITRD_MEDIA_GUID`` vendor media 
> device path.
> +In this case, a kernel booting via the EFI stub will invoke
> +``LoadFile2::LoadFile()`` method on the registered protocol to 
> instruct the
> +firmware to load the initrd into a memory location chosen by the 
> kernel/EFI
> +stub.
> +
> +This approach removes the need for any knowledge on the part of the EFI
> +bootloader regarding the internal representation of boot_params or any
> +requirements/limitations regarding the placement of the command line 
> and
> +ramdisk in memory, or the placement of the kernel image itself.
> +
> +For sample implementations, refer to `the original u-boot 
> implementation`_ or
> +`the OVMF implementation`_.
> +
> +.. _the original u-boot implementation: 
> https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +.. _the OVMF implementation: 
> https://github.com/tianocore/edk2/blob/1780373897f12c25075f8883e073144506441168/OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.c
>
> base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
> -- 
> An old man doll... just what I always wanted! - Clara

-- 
Hugo

