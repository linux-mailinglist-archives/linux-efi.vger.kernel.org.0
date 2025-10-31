Return-Path: <linux-efi+bounces-5276-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2EC236BC
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 07:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6729F4E51A4
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 06:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B02F6900;
	Fri, 31 Oct 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hyg11viS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F813B58B;
	Fri, 31 Oct 2025 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892971; cv=none; b=e9yvoDnHig3SzSiL2UeeUyoDfvUpBK+L/Kl3hkq1O1L4lM6vwpXPuThqmHBnPTPBoEyRlizkLLhr8cmuGuVyqzNU/uUmcxNIXy7Axk2FxFWd84JlAdozc0ezHp9lCJQhmojW7HvTZsPk+Q8fhx/uFXtMTJ9I8j+4YcUn58fg9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892971; c=relaxed/simple;
	bh=Jr7uQINqJKCYQimDm+Nj1yJenH96XpWnb3kI5SA51jo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tVIYVoTUjarUlLNsFMxdIYBSqGyCWbuBs8us76ZNK0imXo6fjW87y1Hz8QhG0OYsUmuBVarijijSbOxXNuUz8N0TlCsiXbNEhjYH9/qgtS6Q51jSvOCEaC95iXMGI23E4TFPaSPgoiQaoqWoZ5wuP7T8PFn7mSHbMscliDLWloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hyg11viS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59V6fs8X3050203
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 30 Oct 2025 23:41:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59V6fs8X3050203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1761892917;
	bh=v0W2vuEQFIicFBqp5bhGyzIVnMExYE181rXr0yLdDRk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hyg11viSFxrXnCMHjhaJ4rWQKn3mR6bSc/mkYL0waRA/NRPaAL0iTg+lCQOmP4H8H
	 2+VP61+JcJh8RNXi8i9QeRjoR0LwZQzio3kYucdZyYWdyE0SE11IQ055hPRPdYL13q
	 zGfHYfWHLjlLAHCHTxlINduUDIwfipbgAx+zEHfQH0/ij2/CmCOnRNCP+Ufu1LsO4e
	 gxlh8tWgWnNQv488pd6ja6ziVWqxNtxoXyWa5Xzx+Da0a/0koG5s3eOuY1bm6pyXyH
	 LaJKszSFFQZYLadgUY+1bw6vlvGLqNZz/698yius+0PVhABRc69IEX5UiUiqcbYc+f
	 8cynS3UiQ/BQQ==
Date: Thu, 30 Oct 2025 23:41:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
        Sohil Mehta <sohil.mehta@intel.com>
CC: Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sean Christopherson <seanjc@google.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_9/9=5D_x86/cpu=3A_Enable_LA?=
 =?US-ASCII?Q?SS_by_default_during_CPU_initialization?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251030211318.74d90c3f@pumpkin>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-10-sohil.mehta@intel.com> <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com> <13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com> <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com> <20251030211318.74d90c3f@pumpkin>
Message-ID: <6C5D6437-5C95-41E1-BF88-0107C83B9CCB@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 30, 2025 2:13:18 PM PDT, David Laight <david=2Elaight=2Elinux@gm=
ail=2Ecom> wrote:
>On Thu, 30 Oct 2025 09:44:02 -0700
>Sohil Mehta <sohil=2Emehta@intel=2Ecom> wrote:
>
>> On 10/30/2025 8:45 AM, Andy Lutomirski wrote:
>> > On Thu, Oct 30, 2025, at 1:40 AM, H=2E Peter Anvin wrote: =20
>> >> Legacy vsyscalls have been obsolete for how long now? =20
>> >=20
>> > A looooong time=2E
>> >=20
>> > I would suggest defaulting LASS to on and *maybe* decoding just enoug=
h to log, once per boot, that a legacy vsyscall may have been attempted=2E =
It=E2=80=99s too bad that #GP doesn=E2=80=99t report the faulting address=
=2E
>> >  =20
>>=20
>> Unfortunately, CONFIG_X86_VSYSCALL_EMULATION defaults to y=2E Also, the
>> default Vsyscall mode is XONLY=2E So even if vsyscalls are deprecated,
>> there is a non-zero possibility someone would complain about it=2E
>
>Presumably a command line parameter could be used to disable LASS
>in order to enable vsyscall emulation?
>
>That might let LASS be enabled by default=2E
>
>	David
>

So I talked with Sohil about this earlier today, and there was a bit of a =
miscommunication =E2=80=94 XONLY mode is just fine=2E It is read emulation =
mode that has problems=2E

