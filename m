Return-Path: <linux-efi+bounces-6267-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFBgEuVnq2kfcwEAu9opvQ
	(envelope-from <linux-efi+bounces-6267-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 07 Mar 2026 00:48:53 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B276F228D7A
	for <lists+linux-efi@lfdr.de>; Sat, 07 Mar 2026 00:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714573025D07
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457B354AE2;
	Fri,  6 Mar 2026 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PioK8n1G"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E972E9730;
	Fri,  6 Mar 2026 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840930; cv=none; b=rsr+7hlKRVYtPkMprk56esks+z60FQQFUoOxwvOEI7rVeOP6CnNEhWDmYMIxpyaCsNYX/8YWr2+5L+9wtWU9DNFEjOzyBhPI7l/GmkGMiNBDKN3qebW21q3IK3rzt/3mUk3+noYzGPZQ3042V7NwBxfH+S824r6ZLHebL1noDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840930; c=relaxed/simple;
	bh=Cumo5affjPLcsVDjRUQxVwzoQguZomb+2nAYaG1f9XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhhLwgZU0l926wfu4XcU18nytSj7Zqw+f5PKZ4LnwIbCZFgJh1RaB6zzr82XEGR9RX/Bo61dWOc9jtZaRxpNjr1IYFd8QiJ6/+mBbOzlEjdp6hw0dIznOXGQFHsBbXUx3wX3TTVsrHxFwhPzg1sWEMn/ZDiFPvkscb13UmnXpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PioK8n1G; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 626NVQj92208026
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 6 Mar 2026 15:31:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 626NVQj92208026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1772839922;
	bh=+EuyHHVP1ezysh+DOMChYpQ6YLA93nDMuTUQuNAbUKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PioK8n1GDOCMylG5Zt2121yBqaQjmuAgAG8ArmoqbSGk+AY2HjiUf0EtOT1DsexRY
	 3XzpMhpcVWr9RPSEgwVE9ESR7uck6X+0Brpr8WoubZ+TlXmlH4lDGa0CVViVEYVOPr
	 a2U1eLnne4Jq8YkGPdE7tatxcJ2Gd+LMg66XDUlWERyyYKh8whYexkpditNEyz4ILx
	 yckiGOkMmhcxGYFKzQD0ff8pydvHcvjyUktvDHaVTIquZDk64YCElixBnK+5hWClOa
	 uRJidGVd5gvOOIeokQ5EcbFwoFLXBWjUIyo+ZDse7szoWgdzIXdm2JW1VkFzyB6i6x
	 eQ3pvQwa4welw==
Message-ID: <75d0ca29-b227-49c1-8204-b305f64b009b@zytor.com>
Date: Fri, 6 Mar 2026 15:31:21 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kbuild: Switch from '-fms-extensions' to
 '-fms-anonymous-structs' when available
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
        llvm@lists.linux.dev
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <01433066-eb9b-4a96-8d7f-794af941d365@zytor.com>
 <20260306231705.GD2746259@ax162>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260306231705.GD2746259@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B276F228D7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026022301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6267-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,xen0n.name,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,zytor.com:dkim,zytor.com:mid,godbolt.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-06 15:17, Nathan Chancellor wrote:
> On Thu, Mar 05, 2026 at 03:43:29PM -0800, H. Peter Anvin wrote:
>> Question: does clang allow this with __extension__, or only if the option is
>> on the command line?  It would be desirable in the long run if both clang and
> 
> It looks like only on the command line:
> 
>   https://godbolt.org/z/zrE766obe
> 
>> gcc would allow this with __extension__, as that would be required to use it
>> in uapi headers (at least without some doable-but-nontrivial preprocessing,
>> which might be worthwhile to do anyway...)
> 
> I agree that would be desirable but wouldn't that change how
> __extension__ works? As far as I can tell from reading GCC's
> documentation [1], __extension__ just supresses warnings from -pedantic
> and such, it does not actually enable a used extension if it conflicts
> with whatever -std= value is passed?
> 
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html
> 

Maybe it does, but it's explicit purpose is to allow code to be compiled with
a -std= setting lower than the system libraries.

I was a little surprised to see that -std=c90 doesn't actually enforce C90
compatibility; even with -Wall -Wextra it requires -pedantic to issue
warnings; the same seems to apply to -std=c99 for at least some features that
were included in gnu* standards like anonymous structures and unions.

The latter is probably a particular indication about the desirability of this,
since the extension we are talking about is a relatively obvious extension of
the anonymous struct/union construct!

It is an incredibly useful thing in ABI headers, because it lets you avoid the
"copy/macro this entire structure definition into another."

	-hpa






