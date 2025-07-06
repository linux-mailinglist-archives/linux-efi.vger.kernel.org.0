Return-Path: <linux-efi+bounces-4140-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79EBAFA613
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D15E3B888A
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A0286413;
	Sun,  6 Jul 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VSkWNu26"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47531C84BD;
	Sun,  6 Jul 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751814538; cv=none; b=ApYh3ayuyn1MEiHLnNQekhXM2jXlYfCIePBad4Gss4wgwHsif3Owq/oQTsfVaDug+/TN+sERIPAx2V5yxD40+gZAS0ymKljY3Jc9cmOs2ciT1xBZ7KKiPJq1npkxdtU6DdYKPJPgwJVUfNpf6NYuj9IcM+Wa/tCf9zQxGcFA8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751814538; c=relaxed/simple;
	bh=ASDmyGnzfJljOZphyrCvLQ55mfID83fRQnnYfpooIkI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DKa3di7KI0372MAVtnP/0BrvlIr0HT9VEklOEb/R9K0A4P8sD2stWXM/nxJ1YmhT/NYrY3wG3oB9fscQbeLPRO7y1Fkp3m6NCvXVitdGqJHSHm0YpNaV05BMpEGbUdUb63z0JVDuSeHQOvhiBaAddxqGXN11t7gcLv85fvcKah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=VSkWNu26; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 566F7DpZ2515561
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 6 Jul 2025 08:07:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 566F7DpZ2515561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1751814439;
	bh=G79563uv22etjcsM52VSq8s7aFTNio1gT1rhuuWWu1o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VSkWNu2698xR5vmX6rnz5SP/yzVha3qsNlh6tb0QZ4tOdJmh9a0W7R9kBMAGW5ed/
	 BPpHtjKKWPaKAUo+zPDMtFfCph3ymVESLGzAPtI1EzcsL9d1Uw6/b/HvDfApQqLgqS
	 5NYfjDREuTyT9HQH8FvzNvowTLqlIyQde7tqLHbKCLSeBkUnzlgA/BrOivFXGNCNhn
	 MJKIlg7LTIQHkDmGNakFtprGe4zsLhcY7p+UVNnHHuhxJX6wQkvctzZrlagGGftm41
	 I/4ckbbNY6SfaAUjP796XY0NfgLfL+4FajRDyovrVhNllNE84n1q+nYSH7X1qbe82B
	 zCLZ9snwXETAQ==
Date: Sun, 06 Jul 2025 08:07:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Sohil Mehta <sohil.mehta@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
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
        linux-mm@kvack.org
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
User-Agent: K-9 Mail for Android
In-Reply-To: <20250706102213.4ab365d7@pumpkin>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com> <20250701095849.2360685-15-kirill.shutemov@linux.intel.com> <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com> <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com> <20250706102213.4ab365d7@pumpkin>
Message-ID: <29992EA3-8BEE-4B31-A38F-F3E65FA9609D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 6, 2025 2:22:13 AM PDT, David Laight <david=2Elaight=2Elinux@gmail=
=2Ecom> wrote:
>On Tue, 01 Jul 2025 19:06:10 -0700
>"H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote:
>=2E=2E=2E
>> Note: for a FRED system, ERETU can generate #SS for a non-canonical use=
r space
>> RSP even in the absence of LASS, so if that is not currently handled th=
at is an active bug=2E
>
>Is that a fault in kernel space, or a fault in user space=2E=20
>
>Some of the traps for 'iret' happen after the transition to user space,
>so the kernel doesn't have to handle them as special cases=2E
>(I simplified (and fixed) one version of that code=2E)
>
>	David
>

It's a fault in user space=2E I had a brain fart and managed to forget tha=
t RSP is technically a GPR and as such is not limited to the VA width of th=
e machine=2E

