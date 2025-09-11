Return-Path: <linux-efi+bounces-4733-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CBBB531E6
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 14:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F15C04E287C
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37F3203B6;
	Thu, 11 Sep 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="J0j3Y7D2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LsBAg+Ua"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC43203B2;
	Thu, 11 Sep 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593037; cv=none; b=CmaFKrA3R3EgLAXZqmKo1KFlKFeUkoHK8TrNmEoHuYkD2SabmwR+Ryn/wmNYUhvGIL5+HWpnUuKyG7osttNY+Glm02uFCuz/StaenvRrICe2ZTuNL6wRGwBS9YBOrUKEMIi159HN9qpG9NnTeAn7wruPWagTq9GJELAgtGb/Hjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593037; c=relaxed/simple;
	bh=ZpWSwL4LmNuCcXKC6qmJqu5ridpoM9QV9176BrgpZYk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gUmBgGXpkaGmxY6FitzWT7oVuFPkM5eUOdcGUrhm3ElxFAj4PNiLCUR8QOf0iA7ipkfR1YihU7fQB3CHN0VFrUKNyT1fq/S1ZcWfnpF6jXvNhWBROZCTnD/uaDfVRX+aQVl3QjV1SwzScBZILpvipV0zMvHRe7lg2O5S27u9gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=J0j3Y7D2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LsBAg+Ua; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id F411CEC0102;
	Thu, 11 Sep 2025 08:17:13 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 11 Sep 2025 08:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1757593033; x=1757679433; bh=yjN0S5cOPMNX2Vc6vnqc0JA3pI9D0QpI
	exSzZuvWALg=; b=J0j3Y7D2qPaCwVYmSVlaZWOp3ZjWsqwASMraGgQOn4jcTX3f
	NJwyitRTWCwnEMuUKCEcslHJMx6jObUuTL1kG6Pg82aQKlLkOzlfa2GXVccxCWAw
	fGkTub0g0mBfilq4uhq5AByXoa/TL3ZABj6t58dLZtUqDJHe+o0Q+EBoqLQWtOEA
	3dQ+uzcB6lFQXANR5Q2oIgz1Q4zvcoNTuHeXeHepkh/AAyNirxhAzDpYKelcHPDi
	JsZwtiEDBZx3k8Ppwf2oDNBsscUP4uqyMW0hRwp6J8yNl8ZX98xiKzjNNeq/UGO5
	iL6MiZFC2R4PASK5+wh/+I5PArL+c0qyZ1JfMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757593033; x=
	1757679433; bh=yjN0S5cOPMNX2Vc6vnqc0JA3pI9D0QpIexSzZuvWALg=; b=L
	sBAg+Uaf1BUs4kVfZ8eh0XkAL+tZhULikJs9qYZ05hIjZEHZnMzU50G1ojss85Ng
	j7fQ3kVuVh+5ZeyhgqqOUsH0ozf/SFzt7gZ7sN8pGk1776mqT2+kR3tNqCCw8llR
	cHTTKRD22xJIRkWn9O+DzYjEb4MittQe2fVOULvZ46AvbSvE/rVpZp/MKDEdPJx+
	OgS6NhDjEVYfov9vVascEAhZzSOxkg1YfrlT2BiZKdrf3rJGu/bNGXGEU21rVW4L
	iCKSgPiOzcQdEa0qswmhnnqIH9ZxvGTF8u03qiTr8LGgHy8/k5aLMOD8x+x0SoPO
	84HHBu4BTIihPf2M2sH+Q==
X-ME-Sender: <xms:yb3CaHu9rGtKc6RVBXTP0E0LqkdLdsGJGdSxrDLL_N8hupvo6S-ztA>
    <xme:yb3CaIdLI6r5mBE7WUEpFk6GA7MnDIN2FAAUcJQKDQJv-JBJ6_G2O8am0LLRKrb4b
    03cP1L1TDjUMPW5Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfjuhhgohcu
    qfhsvhgrlhguohcuuegrrhhrvghrrgdfuceohhhughhoseifhhihnhhothhhuhhgohdrnh
    hlqeenucggtffrrghtthgvrhhnpeevgeffgfeiffegteelteekhefgfffhkeffudfgfffh
    ueegveevuedthedthedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhughhoseifhhih
    nhhothhhuhhgohdrnhhlpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepsggrghgrshgu
    ohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhl
    gieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnse
    hlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhn
    vghtpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yb3CaGq6zZfd9pRaRUdcJwEhLx9E6g-7gayt79vFUD9XZJyRQd2yig>
    <xmx:yb3CaOultdYgqPTdtOpTSLwD03Ypicx8ui3xoGZnKXRAlzFvCAD0GQ>
    <xmx:yb3CaAITt2qxsxV5H7zdu2t96-a143Z-ODesC_g8XPI8V-878nTj4w>
    <xmx:yb3CaNrGzKZKb2v2PtZGsZ8s61CWSmHhSCtbrrKITPwARtFqXLdBKg>
    <xmx:yb3CaEAdDthbuCmtmaz2bk31bmfmSQ_L6Zc3kACYEWSXgaAfRY5QojND>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 487791B40071; Thu, 11 Sep 2025 08:17:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Atl5U7xjKeAs
Date: Thu, 11 Sep 2025 14:16:34 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>, "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Documentation" <linux-doc@vger.kernel.org>,
 "Linux EFI" <linux-efi@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <073bbd39-5173-4f6d-b9a6-0e4259959551@app.fastmail.com>
In-Reply-To: <aMK3h1zvHc0sK-F3@archie.me>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
 <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
 <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>
 <aMK3h1zvHc0sK-F3@archie.me>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, 11 Sep 2025, at 13:50, Bagas Sanjaya wrote:
> On Thu, Sep 11, 2025 at 01:22:54PM +0200, Hugo Osvaldo Barrera wrote:
>> On Thu, 11 Sep 2025, at 08:46, Ard Biesheuvel wrote:
>> > On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> >> +.. _pe-coff-entry-point:
>> >> +
>> >> +PE/COFF entry point
>> >> +===================
>> >> +
>> >> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
>> >> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
>> >> +implementation details.
>> >> +
>> 
>> This should be a link rather than a path to the source file.
>
> I think you miss the point of Jon's comment on your original submission [1].
> Long story short, in Sphinx, one would cross-reference to other documentation
> files (so-called internal linking) either with :doc: or :ref: directives. In
> case of kernel docs, there is third and preferred way: simply mentioning the
> full docs path. The latter is preferred as it is simpler and also allows
> building only portion of docs (with make SPHINXDIRS=<dir>) without triggering
> any reference warnings. Hence why I did addressing his comment.
> For more information, see Documentation/doc-guide/sphinx.rst.
>

The RST files are source files to produce documentation in HTML and PDF. If you
write the path to another source file, the resulting HTML files don't have
any link and the reference is completely lost.

Given the path Documentation/admin-guide/efi-stub.rst, if I'm looking at
https://www.kernel.org/doc/html/latest/arch/x86/boot.html, I'd have on idea
where this path is pointing me to.

WRT Jon's comment on the original submission, I do agree that the label
is unnecessary, since we can link to the page directly without a label at
the top.

> Thanks.
>
> [1]: https://lore.kernel.org/all/87ecx1x4su.fsf@trenco.lwn.net/
>
> -- 
> An old man doll... just what I always wanted! - Clara
>
> Attachments:
> * signature.asc

-- 
Hugo

