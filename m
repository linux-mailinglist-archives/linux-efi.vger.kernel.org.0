Return-Path: <linux-efi+bounces-3932-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A80AE5982
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DA9481127
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180651C6FE9;
	Tue, 24 Jun 2025 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hnSxVh8W"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3855464E;
	Tue, 24 Jun 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730660; cv=none; b=NRm/9tP4IEu6gNLuATDABSXnAHrSMnN2lSgxTeIlB4/fEKs8dmIIZVgOKKwo6QFKZd4Aqo00aIZ4foJ8+fU93GG/RS8gMOyYLEqfB0UP3JNg5rR0xCcbikT6x0iWQQ5c6yKX+TaPVMknVPrP8riAbrZkcn/kkYzj5RZuTqfkUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730660; c=relaxed/simple;
	bh=YjnH5AyNp3kdo3oJxZ9mHajDP0DZCo+oydBTCl9SNLI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=S4C6u6EvuH7HAnBChGHP44HBWQF5eQwC2zV5+LiJX6Y6tq7ihMcG+1LxfUYWN3qcdAsjYhhiYK7qhcq2BxJx4uSMken/u71MpNcwJCebmBZWJg88ztZHlku0Q5enQN0dckNB6xiU6WYmha7EdtvUejgB32zniciuran5pCRCytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hnSxVh8W; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55O235ew1163699
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 19:03:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55O235ew1163699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750730591;
	bh=YjnH5AyNp3kdo3oJxZ9mHajDP0DZCo+oydBTCl9SNLI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hnSxVh8WQsGNQQyjRZoK08cqbWl+sESH3Ja2GQ4cURmzUWQmkLd6Ki5RN2jtx79uG
	 2fSKEO0J117ZkQgCz/DlGm2/hAdbZKIQiqfez9Z8V08rEdiOiLf/44cC7FhoVPJhAZ
	 ZHDRpllImUn0HlgbuZsR1mlp/3/NpXF40/Ri8l2ybMcu/omSC7PP2j4N7tUUymIoov
	 E4F5sQ5hQVxRp/sWHh9FMmhEAlBM7JpIuNWAAhpb3zeMAJ0WeAExMsLr20StHb743x
	 3Cb9VHqTNtkx4UUO91f4oZrtcEmIDL/FdVmqZqMB6FH+2yMI68gLJOdjjdSMxxz4cx
	 F3bvCpxfy1NYg==
Date: Mon, 23 Jun 2025 19:03:03 -0700
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
In-Reply-To: <SJ1PR11MB6083EC9DE16B472CBF10E484FC78A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com> <20250620135325.3300848-2-kirill.shutemov@linux.intel.com> <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com> <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com> <SJ1PR11MB6083AE2EF85FB5D2FE39D4F0FC79A@SJ1PR11MB6083.namprd11.prod.outlook.com> <8f0913d7-9e77-41e0-91e2-17ca2454b296@intel.com> <DS7PR11MB607789E9CDFF5C4DC1461015FC79A@DS7PR11MB6077.namprd11.prod.outlook.com> <299ED4FB-6949-4E7E-82D4-94E2E9F0A0B5@zytor.com> <SJ1PR11MB6083EC9DE16B472CBF10E484FC78A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Message-ID: <BAD6BC84-0554-412D-B587-9F6EA5D55746@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 23, 2025 5:10:50 PM PDT, "Luck, Tony" <tony=2Eluck@intel=2Ecom> wro=
te:
>> Are we actually doing patching on more than one CPU at a time?
>
>We could call static_key_enable()/static_key_disable() for different
>keys at the same time from multiple CPUs=2E
>
>Do we actually do that? Probably not=2E
>
>-Tony
>

But does it actually *work*?

