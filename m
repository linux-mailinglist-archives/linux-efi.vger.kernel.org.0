Return-Path: <linux-efi+bounces-3886-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F3AE25C0
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 00:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD681BC626E
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9A224898;
	Fri, 20 Jun 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cKKXzbi2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD519E98C;
	Fri, 20 Jun 2025 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458669; cv=none; b=FSHhctPnhH2VK+SU8Xv0yVpUIfdtHfWAj+C+uzXdfvtNhw+0U7ATa0SYMewF7VAKCxieiT30r5Il82wjSFSzqWRZ423KcWylHYzmkzdREY/qqpJb38nuWBDAbwQpiP3qdy10KTqxZRZ6Ee3SmponE2P97az48Lkb7H6OoAOfwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458669; c=relaxed/simple;
	bh=IvV8y7FgT6Z9NQTic4jjwW6fRJ9gYHOpKpv9Msn6yHY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=u9mQju16IA7/4IHGZPrTVN7rz1AK9eaiFd818bQpayHuAQCY5uQD+n4275RF5swfKOFhw36JnhuaWBWbnvmJIjUo2+Zbw1B8FO62CeL/A7jDrir8DfZmsb9n5+9jbQ8ESOTXLz39kAj8/KVf81G+YvPdq0SKkyAl4x+5i2wEy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cKKXzbi2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55KMTekk2664527
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 20 Jun 2025 15:29:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55KMTekk2664527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1750458584;
	bh=NFHsX281PHfMaq1TZr3LtRwyyKn/XB9//Vw62Ww9rmU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cKKXzbi2zOSggWzu9GRYGPur0hcsu3P5H+oiJF9qlkLF6VQwT/8dYBxlWN4dau/px
	 TsgL5BqWsv60nY29wBtoGxda/qKI1a0q+UjVuWJnDFTQmQtEdTTQ8PM3l//kIAxaWJ
	 nAvJNusN3AJUtX+StSfrXBtSrJtNt9ygICBi4vPFUMH0JIxm3lDg7kURtrPL6TDhh6
	 8eUp0ETVQzftcOztul4p+M7/1rxdNKvEZ/HYbb8FBeL2Df/Z4+4Oy9Qmglem9/FnWv
	 Nb3cxdB2Q23CAfzObW+s4MBPhJo60V+hJpZrgYDET9XrkttaeFWUrKCHLAUNOToAoR
	 kBFiaScqVT4Bw==
Date: Fri, 20 Jun 2025 15:29:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@intel.com
CC: acme@redhat.com, aik@amd.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, ardb@kernel.org, ast@kernel.org,
        bp@alien8.de, brijesh.singh@amd.com, changbin.du@huawei.com,
        christophe.leroy@csgroup.eu, corbet@lwn.net,
        daniel.sneddon@linux.intel.com, dave.hansen@linux.intel.com,
        ebiggers@google.com, geert+renesas@glider.be, houtao1@huawei.com,
        jgg@ziepe.ca, jgross@suse.com, jpoimboe@kernel.org,
        kai.huang@intel.com, kees@kernel.org, kirill.shutemov@linux.intel.com,
        leitao@debian.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@rasmusvillemoes.dk, luto@kernel.org,
        mcgrof@kernel.org, mhiramat@kernel.org, michael.roth@amd.com,
        mingo@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
        sandipan.das@amd.com, shijie@os.amperecomputing.com,
        sohil.mehta@intel.com, tglx@linutronix.de, tj@kernel.org,
        tony.luck@intel.com, vegard.nossum@oracle.com, x86@kernel.org,
        xin3.li@intel.com, xiongwei.song@windriver.com, ytcoode@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv6_00/16=5D_x86=3A_Enable_Lin?=
 =?US-ASCII?Q?ear_Address_Space_Separation_support?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1aa5fb31-ce23-4c9f-ba1b-d5dc93402209@citrix.com>
References: <61af62d9-4cd0-485f-8f0c-2da981f52695@intel.com> <1aa5fb31-ce23-4c9f-ba1b-d5dc93402209@citrix.com>
Message-ID: <97B65822-F133-4F7C-AFCD-6E3BB1EDCF9F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 20, 2025 3:04:53 PM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2Ec=
om> wrote:
>> Most of the cover letter here reads like an Intel whitepaper=2E That's =
not
>> the worst thing in the world, but I think it glosses over one very
>> important point:
>>
>> 	Had it been available, LASS alone would have mitigated Meltdown=2E
>>
>> Could we say this up front in a prominent place, please?
>
>I'm going to nitpick=2E :)
>
>Yes, LASS would have made Meltdown a far less major problem than it was,
>but I don't think that phrasing is fair=2E=C2=A0 As I recall, LASS was
>literally invented as a "what would have been useful?" exercise in the
>wake of Meltdown=2E
>
>However, a less well known/researched area of Meltdown, which would not
>be addressed by LASS, is the ability to pend stores to read-only memory
>and proceed with the expectation that they'll success=2E
>
>Other things which would have helped would have been PKS (and this *was*
>asked for ahead of Skylake launching=2E=2E=2E)
>
>The other important thing about LASS is that it does cut off a whole
>class of sidechannels=2E=C2=A0 This halts definitely-rogue speculation, b=
ut is
>useful for non-speculative security too=2E
>
>~Andrew

Could you clarify what you mean with "pend stores to read-only memory?"

