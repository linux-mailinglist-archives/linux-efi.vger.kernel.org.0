Return-Path: <linux-efi+bounces-4737-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C7B53DAB
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 23:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C471BC4335
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5A12DEA8C;
	Thu, 11 Sep 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WC3z9Hpw"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9D2DEA67;
	Thu, 11 Sep 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625758; cv=none; b=M6APIx+9gCqYcTOhgY0uz54axT1XJVWjTiBrvctuiQJN7Bja/5AI/qbcsWi+bkniVvNTott8aqbYR7/dFOoD/ySy19kHtxlzgRvZgqbaDBjrLA+cWXfD29KmUWZVrMLOHZiAcrWizQRRC9oF7n9Am7Tl2AZ/KvT8Cki4j4t9AS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625758; c=relaxed/simple;
	bh=G4x8WT9IQ917qljQ8+0bEQAPkz5VVkbi0WgXNlnnUIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxgtQLCbof3SRflHRwwUySVCnjjAjd9XQdCwBara8d/oizscLfRTfaYkDg2kWJPsilkgYWa5ItPKUVBXYh5hAFSnZZDKPXGipu1kEyWeYi8WoSYD4G7m0VqyCVQPCF4fYmzHJBLpOOnforzPNPvBoqb/LNCtmHX2XR6O1i9N5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WC3z9Hpw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IVAYyMQ+cK3zA3EOneonkoIunE31Alk/hAhkIFvp5ZA=; b=WC3z9Hpwg06RkDRN9UoWSLMKw+
	1NZdFQNg+SOsv/W0WHi2Ca64Pgrvv6WlfFsc9HDsiE+o9J+H60UqpbcdKVQshA/2r3YjGbhoTHRQV
	rYpix/zDovTtt0QqINGPfIAHJSAWboKxm5HgDkcWQSC18dru5qVxHgCkx5znyzj5LJ6I07skuNg6w
	a0h+ZloMfspsNhgX61I18ygcSMXaJ2SWu83D/TC5U06KPatGue0Sv5v0ylDeZfK4/As3YOx5mOKKE
	ncSSXvP5zMKV9Z5Kk5OeRO8zb/O1DzucwpEau44eHQAYTQYio+lShoyHcNEc33mkRyn/SKcTWz9Ns
	msVGv2SQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwokT-00000005Qji-0ReA;
	Thu, 11 Sep 2025 21:22:33 +0000
Message-ID: <cfeacf42-c489-4b84-a21a-3cd126759cfc@infradead.org>
Date: Thu, 11 Sep 2025 14:22:32 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux EFI <linux-efi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
 <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
 <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>
 <aMK3h1zvHc0sK-F3@archie.me>
 <073bbd39-5173-4f6d-b9a6-0e4259959551@app.fastmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <073bbd39-5173-4f6d-b9a6-0e4259959551@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/25 5:16 AM, Hugo Osvaldo Barrera wrote:
> 
> 
> On Thu, 11 Sep 2025, at 13:50, Bagas Sanjaya wrote:
>> On Thu, Sep 11, 2025 at 01:22:54PM +0200, Hugo Osvaldo Barrera wrote:
>>> On Thu, 11 Sep 2025, at 08:46, Ard Biesheuvel wrote:
>>>> On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>>> +.. _pe-coff-entry-point:
>>>>> +
>>>>> +PE/COFF entry point
>>>>> +===================
>>>>> +
>>>>> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
>>>>> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
>>>>> +implementation details.
>>>>> +
>>>
>>> This should be a link rather than a path to the source file.
>>
>> I think you miss the point of Jon's comment on your original submission [1].
>> Long story short, in Sphinx, one would cross-reference to other documentation
>> files (so-called internal linking) either with :doc: or :ref: directives. In
>> case of kernel docs, there is third and preferred way: simply mentioning the
>> full docs path. The latter is preferred as it is simpler and also allows
>> building only portion of docs (with make SPHINXDIRS=<dir>) without triggering
>> any reference warnings. Hence why I did addressing his comment.
>> For more information, see Documentation/doc-guide/sphinx.rst.
>>
> 
> The RST files are source files to produce documentation in HTML and PDF. If you
> write the path to another source file, the resulting HTML files don't have
> any link and the reference is completely lost.
> 
> Given the path Documentation/admin-guide/efi-stub.rst, if I'm looking at
> https://www.kernel.org/doc/html/latest/arch/x86/boot.html, I'd have on idea
> where this path is pointing me to.

I applied the original patch from Bagas. I'm looking at
arch/x86/boot.html. It shows me:

1.16. PE/COFF entry point

  When compiled with CONFIG_EFI_STUB=y, the kernel can be executed as a regular PE/COFF binary. See The EFI Boot Stub for implementation details.

where "The EFI Boot Stub" is (in my browser) in blue and underlined and is a link to
admin-guide/efi-stub.html


Is this what you are saying will not happen or am I
completely confused?  Kernel documentation automarkup handles
Documentation/.../*.rst file links automatically.



> WRT Jon's comment on the original submission, I do agree that the label
> is unnecessary, since we can link to the page directly without a label at
> the top.

Thanks.
-- 
~Randy


