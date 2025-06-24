Return-Path: <linux-efi+bounces-3933-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F25AE5985
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC93BDD39
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785491534EC;
	Tue, 24 Jun 2025 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eBBb7hag"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658C2AD20;
	Tue, 24 Jun 2025 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730702; cv=none; b=Kmu5oEvTwWo+iMpK2qA2poFozn7UDd1C3NnSU4YLNapkl5XoUAl+vl0u7YJeKNNVcKtnKiyagCY6a2xtrUjtJmP/domjg3w6GPZEkASYZxzMeKPxAHCjKmCaJ+S66ShEPD24S3nIEhAVJ+ceOjzWlYgiTeMy03h/ByQj2BaFX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730702; c=relaxed/simple;
	bh=ozhNlPrG1zY3QnOQtbtSXT7lm+SrDzV7TAF7n5LDm5c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hv4109TC/oYAtfyGMbKerIykCtrmjnlRZhCBYhyiTlUxQPW573a9+hQgJrSWuHiRh4PawQzu5D9bLgGayw4LX7ek+0c7kHKyd3E1BNx96x/6X5XPvjVQcauezKrl+gWWetzEfNyR22FEKvVYRdIExLPPNEk0GytQyv2Teg16di8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eBBb7hag; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55O246qt1165702
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 19:04:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55O246qt1165702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750730648;
	bh=L3efv8sWvW3xYmKWauFJHtNCboQZu0NBi75OSGIZRQs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=eBBb7hagbmX719xPfYNmOmXwj6p75pGqZMYrqOrcUt7OdbZ/si3q8TUCP3nV5ZNGI
	 7zQ9dpCrNvDDvZg+1RoDsF5xFuAM0UHYlcWBNoKHQDxwLh8EwwPMLxfCAGabKtj6mc
	 fhBcpg+bPg2hfzpCxgL5RPkxjcg61+8E1A7xR3oyHJ3lVuvuODrPXPUAn75ShbMTU7
	 zze2izK2c5CrWHSvOdPWT5pwFV6BFxVbxOQ+nssk7dR2Rper6L95RfcLCepdleCuih
	 BkWAe3uL/jTMuHkGXyRJwKr1cK9PwcSCuGnPJeo9fLYR8WfM3eNPq89tdFqSdj2Mi1
	 IGSaayTzP7Tzw==
Date: Mon, 23 Jun 2025 19:04:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
        Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <73796800-819b-4433-b0ef-db852336d7a4@zytor.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com> <20250620135325.3300848-2-kirill.shutemov@linux.intel.com> <d3055288-c640-4df3-978e-abb97b1610e7@zytor.com> <tfpekzid4hu4xguq3fetosyltg3owjy2cactqklohfohalhbza@hx7qdrpcymrn> <aa91aadb-758e-42db-86ab-451384e466ed@zytor.com> <D8783A84-119A-4981-9EB1-12C21BB34714@zytor.com> <f04936b7-e1e1-4a63-a907-33315af0dd8f@zytor.com> <73796800-819b-4433-b0ef-db852336d7a4@zytor.com>
Message-ID: <0A71C898-B587-4292-AB05-6CA46BBD6F88@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 23, 2025 10:40:59 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 6/20/2025 5:50 PM, H=2E Peter Anvin wrote:
>> On 2025-06-20 17:45, H=2E Peter Anvin wrote:
>>>>=20
>>>> But I simply hate adding a disabled feature that depends on !X86_64;
>>>> x86_64 has a broad scope, and new CPU features are often intentionall=
y
>>>> not enabled for 32-bit=2E
>>>>=20
>>>> (X86_DISABLED_FEATURE_PCID is the only one before LASS)
>>>=20
>>> More importantly, it is wrong=2E
>>>=20
>>> The 32-bit build can depend on this feature not existing, therefore it=
 SHOULD be listed as a disabled feature=2E
>>>=20
>>=20
>> Ok, that was word salad=2E What I meant was that the original patch is =
correct, and we SHOULD have this as a disabled feature=2E
>
>Agreed!
>
>> The reason is that it reduces the need to explicitly test for 32/64 bit=
s for features that don't exist on 32 bits=2E When they are flagged as disa=
bled, they get filtered out *at compile time*=2E
>
>It's better to make it depend on X86_32 directly rather than !X86_64:
>
>config X86_DISABLED_FEATURE_LASS
>	def_bool y
>	depends on X86_32
>
>
>But the disabled feature list due to lack of 32-bit enabling will keep
>growing until we remove 32-bit kernel code=2E
>
>Wondering should we bother enforcing cpuid_deps[] on 32-bit?
>
>IOW, turn off the feature when its dependency isn=E2=80=99t satisfied on =
32b-it;
>don=E2=80=99t just throw a warning and hope for the best=2E
>
>Thanks!
>    Xin
>

We should have the dependencies enforced; in fact, preferably we would enf=
orce them at build time as well=2E

