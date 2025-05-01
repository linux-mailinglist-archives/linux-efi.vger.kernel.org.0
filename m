Return-Path: <linux-efi+bounces-3525-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE9AA630A
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 20:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970F03B9E28
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F121FF2F;
	Thu,  1 May 2025 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CPhyjWUz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685226ADD;
	Thu,  1 May 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124996; cv=none; b=KIaaIoJ6wl8vwQfHr/FPCxt+Flb81eL9hKd/XUTmornjkoANxSDimMGc3zcZmve08fAqzArInObuQQULPNAQvKg7+W6wUW0ICnuq5UDEj4Ug3y2e1z1MQKpXOcwZdhPmeNZ3fnjTAAhUKW1+617Q6MWam9u6D6G0qp1nE7PoqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124996; c=relaxed/simple;
	bh=1gyIlx9axnv68Zrz7DWQtlCSlSwVZgCra6Beufb9Lu8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sFBOs7aqAm20Yfq/X9tVjiFVBW+SB/UmIVl3jzwwNhbPLzA9Ak+km4Toyn7yWqN+YpKq0T+bZSZKKU8KGBN010SzA5aznsfF3hFTbqP4A7V0cPK43W89SfC5XqYRI9aHslUDrjTviiS1Uf+9ErH7lvh97+rLpJVXmqSsjnM7ABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CPhyjWUz; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 541Ig76T1525152
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 1 May 2025 11:42:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 541Ig76T1525152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746124930;
	bh=JEwUx9gZBXnFZokmZ1aFIK+cuB3ayUpbOuFYnlBC6l0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CPhyjWUz2Hfqn31lGf3+z38xHG2p+Anr448wmTB6q4cPOtyvLNsBdWLJD0i9l+cGN
	 W84c5s4Nvhb+drLc54OGeeejnSlEsFVw9CMie0m0Ufh7oFS6ys19ycVX9VGQSaH9yE
	 yAzzEMQz3k9/2SquF0nuageEDvp9YVFB/m6ucQlnoLB6AhhDDLx8iqXkAcecX/FTi+
	 OEtNT03wwti+0yT5MtHDqELgG1lPuAteSdWJ0zSib/APgtawmV07VefZgeCEVBCvEw
	 r5ozmDCZnS2xtBn2gD6vCnFmzEmDPDCUzhM/wzxvWV5+cIdoXGTAMG/de8Zj5ohf1U
	 SLw/gCl26T2Wg==
Date: Thu, 01 May 2025 11:42:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        jpoimboe@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, samitolvanen@google.com, ojeda@kernel.org,
        xin@zytor.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_00/13=5D_objtool=3A_Detect_and_wa?=
 =?US-ASCII?Q?rn_about_indirect_calls_in_=5F=5Fnocfi_functions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aBO9uoLnxCSD0UwT@google.com>
References: <20250430110734.392235199@infradead.org> <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com> <20250430190600.GQ4439@noisy.programming.kicks-ass.net> <20250501103038.GB4356@noisy.programming.kicks-ass.net> <20250501153844.GD4356@noisy.programming.kicks-ass.net> <aBO9uoLnxCSD0UwT@google.com>
Message-ID: <EB1786D7-C7FE-4517-A207-C5F63AC0F911@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 1, 2025 11:30:18 AM PDT, Sean Christopherson <seanjc@google=2Ecom> w=
rote:
>On Thu, May 01, 2025, Peter Zijlstra wrote:
>> On Thu, May 01, 2025 at 12:30:38PM +0200, Peter Zijlstra wrote:
>> > On Wed, Apr 30, 2025 at 09:06:00PM +0200, Peter Zijlstra wrote:
>> > > On Wed, Apr 30, 2025 at 07:24:15AM -0700, H=2E Peter Anvin wrote:
>> > >=20
>> > > > >KVM has another; the VMX interrupt injection stuff calls the IDT=
 handler
>> > > > >directly=2E  Is there an alternative? Can we keep a table of Lin=
ux functions
>> > > > >slighly higher up the call stack (asm_\cfunc ?) and add CFI to t=
hose?
>> > >=20
>> > > > We do have a table of handlers higher up in the stack in the form=
 of
>> > > > the dispatch tables for FRED=2E They don't in general even need t=
he
>> > > > assembly entry stubs, either=2E
>> > >=20
>> > > Oh, right=2E I'll go have a look at those=2E
>> >=20
>> > Right, so perhaps the easiest way around this is to setup the FRED en=
try
>> > tables unconditionally, have VMX mandate CONFIG_FRED and then have it
>> > always use the FRED entry points=2E
>> >=20
>> > Let me see how ugly that gets=2E
>>=20
>> Something like so=2E=2E=2E except this is broken=2E Its reporting spuri=
ous
>> interrupts on vector 0x00, so something is buggered passing that vector
>> along=2E
>
>Uh, aren't you making this way more complex than it needs to be?  IIUC, K=
VM never
>uses the FRED hardware entry points, i=2Ee=2E the FRED entry tables don't=
 need to be
>in place because they'll never be used=2E  The only bits of code KVM need=
s is the
>__fred_entry_from_kvm() glue=2E
>
>Lightly tested, but this combo works for IRQs and NMIs on non-FRED hardwa=
re=2E
>
>--
>From 664468143109ab7c525c0babeba62195fa4c657e Mon Sep 17 00:00:00 2001
>From: Sean Christopherson <seanjc@google=2Ecom>
>Date: Thu, 1 May 2025 11:20:29 -0700
>Subject: [PATCH 1/2] x86/fred: Play nice with invoking
> asm_fred_entry_from_kvm() on non-FRED hardware
>
>Modify asm_fred_entry_from_kvm() to allow it to be invoked by KVM even
>when FRED isn't fully enabled, e=2Eg=2E when running with CONFIG_X86_FRED=
=3Dy
>on non-FRED hardware=2E  This will allow forcing KVM to always use the FR=
ED
>entry points for 64-bit kernels, which in turn will eliminate a rather
>gross non-CFI indirect call that KVM uses to trampoline IRQs by doing IDT
>lookups=2E
>
>When FRED isn't enabled, simply skip ERETS and restore RBP and RSP from
>the stack frame prior to doing a "regular" RET back to KVM (in quotes
>because of all the RET mitigation horrors)=2E
>
>Signed-off-by: Sean Christopherson <seanjc@google=2Ecom>
>---
> arch/x86/entry/entry_64_fred=2ES | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/entry/entry_64_fred=2ES b/arch/x86/entry/entry_64_f=
red=2ES
>index 29c5c32c16c3=2E=2E7aff2f0a285f 100644
>--- a/arch/x86/entry/entry_64_fred=2ES
>+++ b/arch/x86/entry/entry_64_fred=2ES
>@@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> 	movq %rsp, %rdi				/* %rdi -> pt_regs */
> 	call __fred_entry_from_kvm		/* Call the C entry point */
> 	POP_REGS
>-	ERETS
>+
>+	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED
> 1:
> 	/*
> 	 * Objtool doesn't understand what ERETS does, this hint tells it that
>@@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> 	 * isn't strictly needed, but it's the simplest form=2E
> 	 */
> 	UNWIND_HINT_RESTORE
>-	pop %rbp
>+	leave
> 	RET
>=20
> SYM_FUNC_END(asm_fred_entry_from_kvm)
>
>base-commit: 45eb29140e68ffe8e93a5471006858a018480a45

Ok maybe I'm being dense, but what is left other than simply calling __fre=
d_entry_from_kvm() as a normal C function?=20

I'm on the go so there might be something in the code I'm missing, but on =
the surface=2E=2E=2E?

