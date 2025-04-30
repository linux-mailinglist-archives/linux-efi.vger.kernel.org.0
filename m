Return-Path: <linux-efi+bounces-3509-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD725AA4E70
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22753ACAA2
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AB25D1F7;
	Wed, 30 Apr 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="G1ewDVEd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C521ABC6;
	Wed, 30 Apr 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023103; cv=none; b=IPgMKpISL5Yfm7hI54xHYv4wJAjTWKd2hmvVXIsr5Vk7qREpBuxrO5+qWM22EM4SuxCQlRPeRrcEAzUkMBaIvN7o9NQ2taco3Tk8gnIfbuQRBHLmL/YuVVcRbQijw3KiE+iwZB+pzPKSaZQvEpzi6uQnsa7cmliGZte4zWn8fvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023103; c=relaxed/simple;
	bh=rjMvhhoHC1X7+lw3l2dB4rGD+6HMJz3GsS5ASyow71I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=I0i1LuueXFVgdy2vc2anFJ0gnz7XJyx1o3WUBDhp6wTG8bnS3+8iBDw3BWuu+qYXYJoBtzKqMjP6nQJVN16bnDDtJ7sIjarrY3znJ52uh5hYL+auVSHUghHlasK2nrIXp8qDO4dQdCXOcDUPpDQokUEWwkXd56uAWfr4n265iS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=G1ewDVEd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53UEOI5X931491
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 30 Apr 2025 07:24:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53UEOI5X931491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746023059;
	bh=pQL8GxGCP0lOqhjZgQIjgeXZK6YREx5vQoMNpPTLrHU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G1ewDVEdQC6La4J5R7kMKwnkqVpNGebEjVhRdP8CbyAj4JzpaV+0lhKWzQgviR5Jz
	 DnHGbQYWM0DUzo52eq8rHyuiP6ugp8H+u4HqECJ8ihkukboZW7TMa7IIrDAplGBmdO
	 PnYBtM1FotSDGP0Bwmd3LQeqCgtZ+/DRE8sWb1QLo6aQbwVT8vaa4jQ32stDbGr9Pv
	 oxP6dsv+CWX+tLfnoiF9XpDI0hZpikUo9GVld07MAjzYS/EGIUqWvWp07qhZNwt/Wg
	 jHQIj1zz1GDMcwQqmZxnpwFKTpI2+0AEGA4hhTodBLWJXHWfh1l0J23ON/EjuigJld
	 JJ/nQMjAp4l8g==
Date: Wed, 30 Apr 2025 07:24:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
CC: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, seanjc@google.com,
        pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        jpoimboe@kernel.org, peterz@infradead.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-efi@vger.kernel.org,
        samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_00/13=5D_objtool=3A_Detect_and_wa?=
 =?US-ASCII?Q?rn_about_indirect_calls_in_=5F=5Fnocfi_functions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250430110734.392235199@infradead.org>
References: <20250430110734.392235199@infradead.org>
Message-ID: <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 30, 2025 4:07:34 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>Hi!
>
>On kCFI (CONFIG_CFI_CLANG=3Dy) builds all indirect calls should have the =
CFI
>check on (with very few exceptions)=2E Not having the CFI checks undermin=
es the
>protection provided by CFI and will make these sites candidates for peopl=
e
>wanting to steal your cookies=2E
>
>Specifically the ABI changes are so that doing indirect calls without the=
 CFI
>magic, to a CFI adorned function is not compatible (although it happens t=
o work
>for some setups, it very much does not for FineIBT)=2E
>
>Rust people tripped over this the other day, since their 'core' happened =
to
>have some no_sanitize(kcfi) bits in, which promptly exploded when ran wit=
h
>FineIBT on=2E
>
>Since this is very much not a supported model -- on purpose, have objtool
>detect and warn about such constructs=2E
>
>This effort [1] found all existing [2] non-cfi indirect calls in the kern=
el=2E
>
>Notably the KVM fastop emulation stuff -- which I've completely rewritten=
 for
>this version -- the generated code doesn't look horrific, but is slightly=
 more
>verbose=2E I'm running on the assumption that instruction emulation is no=
t super
>performance critical these days of zero VM-exit VMs etc=2E
>
>KVM has another; the VMX interrupt injection stuff calls the IDT handler
>directly=2E  Is there an alternative? Can we keep a table of Linux functi=
ons
>slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?
>
>HyperV hypercall page stuff, which I've previously suggested use direct c=
alls,
>and which I've now converted (after getting properly annoyed with that co=
de)=2E
>
>Also available at:
>
>  git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/peterz/queue=2Egit x8=
6/core
>
>Changes since v1:
>
> - complete rewrite of the fastop stuff
> - HyperV tweaks (Michael)
> - objtool changes (Josh)
>
>
>[1] https://lkml=2Ekernel=2Eorg/r/20250410154556=2EGB9003@noisy=2Eprogram=
ming=2Ekicks-ass=2Enet
>[2] https://lkml=2Ekernel=2Eorg/r/20250410194334=2EGA3248459@google=2Ecom
>

We do have a table of handlers higher up in the stack in the form of the d=
ispatch tables for FRED=2E They don't in general even need the assembly ent=
ry stubs, either=2E

