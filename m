Return-Path: <linux-efi+bounces-4510-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9F1B19BC6
	for <lists+linux-efi@lfdr.de>; Mon,  4 Aug 2025 08:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D327164A4F
	for <lists+linux-efi@lfdr.de>; Mon,  4 Aug 2025 06:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88E233712;
	Mon,  4 Aug 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hFmN5bIr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C21E9B2A;
	Mon,  4 Aug 2025 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290601; cv=none; b=mlDU128bsZpWu8kYQ+R61rJyiYV3co9qnhqm48FNfze3/yJeAJUzguVAgEU+HKDq3j/JH06+yvQ6+tKhQ9MxpbKhEjlsw8NYrJZt4P8piJoTFFjAROG4UWS0mh4AQyPej/cWFTAtjP3Lzzx5LUrs/KgqbzT+r01keXDudTrWBVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290601; c=relaxed/simple;
	bh=6Uxfo/n+FmHLvR+WWWhh+s7r7X3EBAjRA421qiR6QUs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gHa4ewb3tfnYBJvcpe3uTHtko2+n4VKu4NJ6EX7dCodvTccejv2Q1OiBuRZih/BMhhtM8O14HO4vPym0+Inh9cyslw+HfyyfL7GL+AhuT3r8JZ2OLPhjWcF0muJ5jByu0zLIOfoNv8LZZusb9Xh8SHJ9/YstgCdbJIn2Znisd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hFmN5bIr; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5746tNXj718207
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 3 Aug 2025 23:55:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5746tNXj718207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1754290530;
	bh=6Uxfo/n+FmHLvR+WWWhh+s7r7X3EBAjRA421qiR6QUs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hFmN5bIrGhwAqRzowBAQP+K7JKfkTZmxrPVOSbJS31LX45O5bseelsScA7k2yDAPP
	 mUWGJ9cRkp3wnCfLfOCOdLrCRaSejeDQvKQhqYD0KFFqPhWPi9VD5ehD5kwjJBQj2t
	 EglMcvwE5YmBnva0NyndOecbfVvrxckhlbHsKMMsbeWG/mVa+QaqaWu1UUe5ZAxFnL
	 1mZ5QW73IgNc+sHyKKBk2/Gt9h16K/EL0SMXj0hZdrOO0sLOUeqwekZA4MobIa0aa3
	 oUKY2QoT7lwUsXmsn2UM5m5MzP1sYfQoYlcAvGmOUImszdjO9LWUNNL4GiLRQ7btCZ
	 G/wBKmENMoORA==
Date: Sun, 03 Aug 2025 23:55:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>
CC: Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
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
        linux-mm@kvack.org, "Kirill A. Shutemov" <kas@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        X86-kernel <x86@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv9_04/16=5D_x86/cpu=3A_Defer_?=
 =?US-ASCII?Q?CR_pinning_setup_until_core_initcall?=
User-Agent: K-9 Mail for Android
In-Reply-To: <202508021149.B4BFF8D1@keescook>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com> <20250707080317.3791624-5-kirill.shutemov@linux.intel.com> <6075af69-299f-43d2-a3c8-353a2a3b7ee7@intel.com> <98a7a91b-3b46-4407-82a7-5f80443b7e00@intel.com> <6e768f25-3a1c-48b9-bc53-56877a556a83@intel.com> <202508021149.B4BFF8D1@keescook>
Message-ID: <5BC99441-D69E-4B23-9485-6802F8ED8A42@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 2, 2025 11:51:28 AM PDT, Kees Cook <kees@kernel=2Eorg> wrote:
>On Thu, Jul 31, 2025 at 05:01:37PM -0700, Dave Hansen wrote:
>> On 7/31/25 16:45, Sohil Mehta wrote:
>> > On 7/9/2025 10:00 AM, Dave Hansen wrote:
>> >> On 7/7/25 01:03, Kirill A=2E Shutemov wrote:
>> >>> Instead of moving setup_cr_pinning() below efi_enter_virtual_mode()=
 in
>> >>> arch_cpu_finalize_init(), defer it until core initcall=2E
>> >> What are the side effects of this move? Are there other benefits? Wh=
at
>> >> are the risks?
>> >>
>> > Picking this up from Kirill=2E=2E Reevaluating this, core_initcall() =
seems
>> > too late for setup_cr_pinning()=2E
>> >=20
>> > We need to have CR pinning completed, and the associated static key
>> > enabled before AP bring up=2E start_secondary()->cr4_init() depends o=
n the
>> > cr_pinning static key to initialize CR4 for APs=2E
>>=20
>> Sure, if you leave cr4_init() completely as-is=2E
>>=20
>> 'cr4_pinned_bits' should be set by the boot CPU=2E Secondary CPUs shoul=
d
>> also read 'cr4_pinned_bits' when setting up their own cr4's,
>> unconditionally, independent of 'cr_pinning'=2E
>>=20
>> The thing I think we should change is the pinning _enforcement_=2E The
>> easiest way to do that is to remove the static_branch_likely() in
>> cr4_init() and then delay flipping the static branch until just before
>> userspace starts=2E
>
>Yeah, this is fine from my perspective=2E The goal with the pinning was
>about keeping things safe in the face of an attack from userspace that
>managed to get at MSR values and keeping them from being trivially
>changed=2E
>

I have mentioned this before: I would like to see CR4-pinning use a patcha=
ble immediate to make it harder to manipulate=2E If the mask is final when =
alternatives are run, that would be a good time to install it; the code can=
 just contain a zero immediate (no pinning) or a very limited set of bits t=
hat must never be changed at all up to that point=2E

