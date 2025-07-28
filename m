Return-Path: <linux-efi+bounces-4491-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F84B1427E
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 21:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFE71896B25
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B821E082;
	Mon, 28 Jul 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="biJPsuNe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADC1C8606;
	Mon, 28 Jul 2025 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731013; cv=none; b=kOmJl71oJqeqODKz1XCpQdMNNGSIwaLKbFrHsPeSTn3vZrK2Xf3oy3hF5mjvS8d29GFy1TdBG8FoO1og49khmBs3hx7Mzj3+jIS0Ypafc9gY3DPll9lJMpRXc1NSnF0BOFLuWAzUNFREFvnDNh+/vJTpsPIs1XxafnyTPSa+JKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731013; c=relaxed/simple;
	bh=miWKbLoWcAZBvkXpveWN9SG1oVBtIGyLvi5kZTHp83I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DKV5KYjlCHHtwhzx6L1JQcGbIRNtUf3hKe0XH/lf1ws7piEHwqJ9ZdkkI7pV1zhvye2iMJLyjb4hX4ZOo48/BMsvSi9oZYwwc/Lu3J5eraxFcHmtmc5kEA2FRaqEeZjioPZSagVwhQvXGSNmNlj8qdqThBNqQYX61x9hDbNRj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=biJPsuNe; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56SJSYSu416102
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 28 Jul 2025 12:28:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56SJSYSu416102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753730918;
	bh=qaSC4sqEzLaCELCha6qIBiTeeIabGiKR5v+0QyZ4F8s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=biJPsuNeTxri3H9MoWJpmgZkkGQNuk21lGUNd/UGX0E+jkA7IRHGFfwvqnzYLgjyI
	 7IrpYPjZCNHFc5xhuao9cALcv4MeTy6uWXNU1I0k3t/294PzXyodbOHbGu2cA76VYo
	 TAxPmVGfVrjyntoadhsM8Di3RcccftzUDh7SYtUkXoOYlXT4076MMnuuTCePmG1Tqd
	 FZjJBQYK4/sS8CDtE3Qx7ADrtn5VrfwXWDV5MESUXcS0dk5cKyErIwQk/5eZz+uaQL
	 KERCz0I6QmZGsVz49Hz5YeDL3KDckKzAv8qlRwG6LKQ+w+MVo+7L25amYHBzmODrCi
	 cgqFA+v4RU8fg==
Date: Mon, 28 Jul 2025 12:28:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
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
        linux-mm@kvack.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv9_02/16=5D_x86/alternatives=3A_Disa?=
 =?US-ASCII?Q?ble_LASS_when_patching_kernel_alternatives?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250728201137.113d0f45@pumpkin>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com> <20250707080317.3791624-3-kirill.shutemov@linux.intel.com> <20250728201137.113d0f45@pumpkin>
Message-ID: <98BE7799-DA6C-4267-9E03-E6F68263D250@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 28, 2025 12:11:37 PM PDT, David Laight <david=2Elaight=2Elinux@gmai=
l=2Ecom> wrote:
>On Mon,  7 Jul 2025 11:03:02 +0300
>"Kirill A=2E Shutemov" <kirill=2Eshutemov@linux=2Eintel=2Ecom> wrote:
>
>> From: Sohil Mehta <sohil=2Emehta@intel=2Ecom>
>>=20
>> For patching, the kernel initializes a temporary mm area in the lower
>> half of the address range=2E See commit 4fc19708b165 ("x86/alternatives=
:
>> Initialize temporary mm for patching")=2E
>>=20
>> Disable LASS enforcement during patching to avoid triggering a #GP
>> fault=2E
>>=20
>> The objtool warns due to a call to a non-allowed function that exists
>> outside of the stac/clac guard, or references to any function with a
>> dynamic function pointer inside the guard=2E See the Objtool warnings
>> section #9 in the document tools/objtool/Documentation/objtool=2Etxt=2E
>>=20
>> Considering that patching is usually small, replace the memcpy() and
>> memset() functions in the text poking functions with their open coded
>> versions=2E
>=2E=2E=2E
>
>Or just write a byte copy loop in C with (eg) barrier() inside it
>to stop gcc converting it to memcpy()=2E
>
>	David

Great=2E It's rep movsb without any of the performance=2E

