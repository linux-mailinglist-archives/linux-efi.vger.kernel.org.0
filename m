Return-Path: <linux-efi+bounces-3928-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21531AE5818
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 01:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4DB446C2A
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559022B8A9;
	Mon, 23 Jun 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jyILhge1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94D22173D;
	Mon, 23 Jun 2025 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721870; cv=none; b=jo7gfFT+rJkz6xc8ogj0BGgVqHyRE9dMpPgWtu7ls04Y31702VgADUEhyvHCyo6TB8DLJdb22oBDRzQI6MjdqHA35WGvNCk6IxB6qsgIpYjh3ByMjo7iVD0EgxOVSwVbaWRFD3FBxKVG8NCeyeC+XW3Tlvzzrn9LYH8+WWK6uws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721870; c=relaxed/simple;
	bh=4IQtmiTnjaNxG4Vd/OylPOVdcycefppT12bFqblU+kU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E4pVRnZPdbUYneSMG/5Z7Kt0yPT2AiB2+x/dY7lxztkIh+BuA7Wykw0sY9XDZRm16q7knDi7Rem+zY5Ymk0wTqtoEpjeMuI4as0Cz+cLbkc5zuP9OScSjwb9EQZfL5H/YPw5lBV8p9b9yZ0EWVaBgaa9AOzTKxgN4ZEDan4Wi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=jyILhge1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55NNaXe21125411
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 16:36:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55NNaXe21125411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750721797;
	bh=b0SnNTpTmp8KAx7qFKJDLHDogIjzK3DQTJWcnHQWcHw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jyILhge1PoHKMdmYcXFHg1mzoZJxnqCkIDylkzKB+ztz7NhHsWT3ZILfet5+kWdTr
	 YCOO6t2eA63gasI5gjhWLxorZE/MVgh8GTB3qwoHoMGJ3CUcdt0FJBUvPXuJ9GYXGO
	 FCfNB9UAChC8/1oDUYhxVCD2lkM/Gc6AaQ52PpyZd0xvIdN1wUqNInxnncT2Io4wNi
	 GEJJTnm09CgtWNLpxlEghDmGkmK985effkl8N7Tqu1uk0vRokAwqLb4Z0YtptrLUqw
	 69LXd2R92o9+ilfzSYsXEHX17qO9FxCiLIWxLFNslsiMA4ni6zVIegpkMp/E6csVhi
	 EL5RF1EpjMuZQ==
Date: Mon, 23 Jun 2025 16:36:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yian Chen <yian.chen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: RE: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <DS7PR11MB607789E9CDFF5C4DC1461015FC79A@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com> <20250620135325.3300848-2-kirill.shutemov@linux.intel.com> <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com> <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com> <SJ1PR11MB6083AE2EF85FB5D2FE39D4F0FC79A@SJ1PR11MB6083.namprd11.prod.outlook.com> <8f0913d7-9e77-41e0-91e2-17ca2454b296@intel.com> <DS7PR11MB607789E9CDFF5C4DC1461015FC79A@DS7PR11MB6077.namprd11.prod.outlook.com>
Message-ID: <299ED4FB-6949-4E7E-82D4-94E2E9F0A0B5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 23, 2025 4:13:34 PM PDT, "Luck, Tony" <tony=2Eluck@intel=2Ecom> wro=
te:
>> >> Logically there are two completely different things:
>> >>
>> >>       1=2E Touching userspace
>> >>       2=2E Touching the lower half of the address space
>> >>
>> >> If it's only userspace in the lower half of the address space, then
>> >> there's no controversy=2E But the problem obviously occurs when you =
want
>> >> to touch kernel mappings in the lower half of the address space=2E
>> >
>> > Why does the kernel create the mappings to poke kernel text
>> > for ALTERNATIVE patching in the lower half of the address space?
>> >
>> > Instead of special "we really to want to access the lower addresses"
>> > code, wouldn't it be easier to map the "poke" virtual addresses in no=
rmal
>> > kernel upper-half space?
>>
>> The upper half of the address space is shared kernel space, right? Ever=
y
>> PGD has identical contents in the upper half=2E So if we create a mappi=
ng
>> there,everybody get access to it=2E Every mm can access it=2E Every
>> *process* can access it=2E It still has kernel permissions of course, b=
ut
>> it's still a place that everybody can get at=2E
>>
>> The lower half is *ONLY* accessible to the local mm=2E In this case, on=
ly
>> the text poking mm=2E It's a natural, safe, place to create a mapping t=
hat
>> you want to be private and not be exploited=2E
>>
>> So, doing it in the upper half is risky=2E
>>
>> If we *wanted*, we could have a non-shared PGD entry in the top half of
>> the address space=2E But we'd need to reserve its address space and all
>> that jazz=2E I'm not sure it's any better than just disabling LASS
>> enforcement for a moment=2E
>
>Maybe it=E2=80=99s a thing to put on the list for "when x86 drops support=
 for 32-bit"=2E
>
>Reserving a PGD entry in the kernel half of the address space for
>local CPU use would be practical then=2E Perhaps there might be other
>uses too=2E
>
>-Tony
>

Are we actually doing patching on more than one CPU at a time?

