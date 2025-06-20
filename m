Return-Path: <linux-efi+bounces-3873-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6AAE1FF6
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73E83A435A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9BE26E708;
	Fri, 20 Jun 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NzUAHSxL"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5211DD543;
	Fri, 20 Jun 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436212; cv=none; b=EQ3/kdT8Vgm+PWhTm0IiWaYZBbdoIQDqEZ3lKfhuoMKkcnEj2P+bROupfqlgneyXz5PET/0XcRr1oyZdRWIguA9049hkxOwcI/ZU2wQenfIgzyB1RASGwtuly23+31TTseDHVBgOrBeZpeSjF67WDDqnRHwLBjX4kkSQN84oeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436212; c=relaxed/simple;
	bh=OovyfZojvEvfK/IluwDmW7AttOfCw6eB1mMojJhah4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAiqyEyYFNSmpdXvCKMeCMKNXozDEz7r4VWoYSxMBAWGHnx/AxxWTpm0RGD7rtLDJtRk45qSldXQM7WwQC+CoOgi+6/Zybm9L6gTbUr1mV4xg12p7kYZeu3pylS8ael7/lvr3szqIuNNV0YTqc0hgk/BEkbNttNutKRx1k/+kDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NzUAHSxL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=/UszJjjGrQLyE6OizYSxEL7kIKQs9jlpRaVnh3Txp7Q=; b=NzUAHSxLxUuaq+/uq+Gx6Hwl74
	UwndDaca3nFD6rmDc20q3U3sbzuVWs8X13VCpClNfOxrkHzo2IdUHkE2bsFe7bX4p1Hyrkdd7ON61
	rU5iK2IjOoGJWFL32Ma9HL/vjsVoL8AU8bH8XEFeWO67jkXgmSJhqZtUUpypOk/zI4w9xjdZevCmI
	8VNInXcNw8qNMOhNS/ZyO4e+j3DdtGSF6cuyqGuJksihob2vSanG+POuEQU8e13asskUwt19ad5Ym
	o3vvvUAjp1A/Mq79GNW4qsGDROAUDqqHtMYOybWLMEIl/i7EHtUWpA/O+VOyWoNC4weXBNF61y899
	/wuIGeeA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSePg-0000000D3pz-2rbi;
	Fri, 20 Jun 2025 16:16:24 +0000
Message-ID: <756e93a2-7e42-4323-ae21-a5437e71148e@infradead.org>
Date: Fri, 20 Jun 2025 09:16:13 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
To: Xin Li <xin@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
 Breno Leitao <leitao@debian.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
 Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
 Changbin Du <changbin.du@huawei.com>,
 Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org,
 Yian Chen <yian.chen@intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <25600557-9cd5-406c-9acf-abc163afde2d@infradead.org>
 <98703493-109a-4795-8abd-6cfe10b941f4@zytor.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <98703493-109a-4795-8abd-6cfe10b941f4@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/20/25 9:12 AM, Xin Li wrote:
> On 6/20/2025 9:02 AM, Randy Dunlap wrote:
>>> +config X86_DISABLED_FEATURE_LASS
>>> +    def_bool y
>>> +    depends on !X86_64
>> Please explain why this is   !X86_64.
> 
> When NOT on X86_64, the LASS code should not be compiled.

Ah yes, the double negative caught me.

> But first of all, as I replied earlier, X86_DISABLED_FEATURE_LASS is
> completely not needed.

That's good.

Thanks.

-- 
~Randy


