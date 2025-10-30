Return-Path: <linux-efi+bounces-5264-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B4C217AD
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 774164E8658
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30C365D29;
	Thu, 30 Oct 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="odjeaoCs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E036838E;
	Thu, 30 Oct 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845027; cv=none; b=ARwWxodw+8IO5pLaFRJ21tecSzt8jrnEz6a5dtvEwprbPbxnrUDyTsWqPGDCLTFYEM2AQXaeDFgKhCRxJscuTVKg1Op32gKiijW25BAykjXD08plnxUKX+a9Vhn0QUw/e4uWPHqKZQeOIdGLJWluwEc75GqqgYXziIzLGL4NvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845027; c=relaxed/simple;
	bh=x9DT0ApeZTLKuLY6/VRAZqUivydjkWhEIpEmeRZVkME=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GA/moOmphojlVWa8DD6Hi2KF0c+71b3POwkC68ZP0+LiL/sMqb/3LVLD1LFglmMQwik1iVNqT11VlCSQu+qxaLbSiSIL4d4QSayvsNrNOQc+pjfOcXpTEBf7JKXG8K6Bs6A4mE+1EfAckqGhQyg6S77EM3tABgcqsoNJmwkpxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=odjeaoCs; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59UHMUbc2749119
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 30 Oct 2025 10:22:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59UHMUbc2749119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1761844952;
	bh=eR7Js9uHq09PsJZq3jgDD0w9S+adY8NtcZdzq73Y+Cw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=odjeaoCssYMreqtTAf/nexUVAx4wmuHR5cxW0zx2fme+f8ViioPuZN7Rw0iZz6oWz
	 MULv3h5M8svCBAOV0Th6ELMBUNgWZF50iW4SgUWrvndGzEMPREflPdXrs7Fd6aHF2X
	 Vxq3zAud4uyINR8hau5JieP47YkxHDYO1Iu/scBvkQUMvizGQQqtyPJBXLKATWpFf5
	 jqXL83zVN++MnEOWbIf8F/+xJF9WlRaSXsMvpw9EngmqIMeqxaWTqYnG7Sio4URdkM
	 y6X+2YGi8I0rj4WrN9YdiHCiTy8l8O/G3JtRB9NHSMRtHApN9wz6LNmvfcr5aAxUux
	 qAcMNJqzaOEZQ==
Date: Thu, 30 Oct 2025 10:22:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Kirill A . Shutemov" <kas@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Vegard Nossum <vegard.nossum@oracle.com>, Xin Li <xin@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v10_08/15=5D_x86/vsyscall=3A_Re?=
 =?US-ASCII?Q?organize_the_page_fault_emulation_code?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com> <20251007065119.148605-9-sohil.mehta@intel.com> <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com> <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com> <f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
Message-ID: <E95F62DC-0B5D-47ED-8B72-F619B45340C8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 30, 2025 9:58:02 AM PDT, Andy Lutomirski <luto@kernel=2Eorg> wro=
te:
>
>
>On Tue, Oct 7, 2025, at 11:48 AM, Dave Hansen wrote:
>> On 10/7/25 11:37, Edgecombe, Rick P wrote:
>>>>  	/*
>>>>  	 * No point in checking CS -- the only way to get here is a user mo=
de
>>>>  	 * trap to a high address, which means that we're in 64-bit user co=
de=2E
>>> I don't know=2E Is this as true any more? We are now sometimes guessin=
g based on
>>> regs->ip of a #GP=2E What if the kernel accidentally tries to jump to =
the vsyscall
>>> address? Then we are reading the kernel stack and strange things=2E Ma=
ybe it's
>>> worth replacing the comment with a check? Feel free to call this paran=
oid=2E
>>
>> The first check in emulate_vsyscall() is:
>>
>>        /* Write faults or kernel-privilege faults never get fixed up=2E=
 */
>>        if ((error_code & (X86_PF_WRITE | X86_PF_USER)) !=3D X86_PF_USER=
)
>>                return false;
>>
>> If the kernel jumped to the vsyscall page, it would end up there, retur=
n
>> false, and never reach the code near the "No point in checking CS" comm=
ent=2E
>>
>> Right? Or am I misunderstanding the scenario you're calling out?
>>
>> If I'm understanding it right, I'd be a bit reluctant to add a CS check
>> as well=2E
>
>IMO it should boil down to exactly the same thing as the current code for=
 the #PF case and, for #GP, there are two logical conditions that we care a=
bout:
>
>1=2E Are we in user mode?
>
>2=2E Are we using a 64-bit CS such that vsyscall emulation makes sense=2E
>
>Now I'd be a tiny bit surprised if a CPU allows you to lretq or similar t=
o a 32-bit CS with >2^63 RIP, but what do I know?  One could test this on a=
 variety of machines, both Intel and AMD, to see what actually happens=2E
>
>But the kernel wraps all this up as user_64bit_mode(regs)=2E  If user_64b=
it_mode(regs) is true and RIP points to a vsyscall, then ISTM there aren't =
a whole lot of options=2E  Somehow we're in user mode, either via an exit f=
rom kernel mode or via CALL/JMP/whatever from user mode, and RIP is pointin=
g at the vsyscall page, and CS is such that, in the absence of LASS, we wou=
ld execute the vsyscall=2E  I suppose the #GP could be from some other caus=
e than a LASS violation, but that doesn't seem worth worrying about=2E
>
>So I think all that's needed is to update "[PATCH v10 10/15] x86/vsyscall=
: Add vsyscall emulation for #GP" to check user_64bit_mode(regs) for the vs=
yscall case=2E  (As submitted, unless I missed something while composing th=
e patches in my head, it's only checking user_mode(regs), and I think it's =
worth the single extra line of code to make the result a tiny bit more robu=
st=2E)

user_64bit_mode() is a CS check :)

There is that one extra check for PARAVIRT_XXL that *could* be gotten rid =
of by making the PV code report its 64-bit selector and patching it into th=
e test, but it is on the error path anyway=2E=2E=2E


