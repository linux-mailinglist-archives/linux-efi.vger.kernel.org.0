Return-Path: <linux-efi+bounces-161-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B01580BA22
	for <lists+linux-efi@lfdr.de>; Sun, 10 Dec 2023 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83278B209BC
	for <lists+linux-efi@lfdr.de>; Sun, 10 Dec 2023 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F57472;
	Sun, 10 Dec 2023 10:17:29 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063BF2;
	Sun, 10 Dec 2023 02:17:24 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rCGs9-0003ab-LH; Sun, 10 Dec 2023 11:17:17 +0100
Message-ID: <01fe1a4d-a346-4ddd-bd1c-22182ed0e60a@leemhuis.info>
Date: Sun, 10 Dec 2023 11:17:16 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel 6.6.1 hangs on "loading initial ramdisk"
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: bwg <whirl@mniotilta.ca>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, shibedrill1@gmail.com
References: <9057d7de-f2e0-44ba-bec7-8b0861b2a850@gmail.com>
 <ZXVdZE3D-KFBqPnj@archie.me>
 <fe7a2b72-9418-42dc-b6fb-2aa93bc4eabc@leemhuis.info>
 <7cf21703-391a-4123-b862-14a1af62aeaa@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <7cf21703-391a-4123-b862-14a1af62aeaa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702203445;a3d68dd5;
X-HE-SMSGID: 1rCGs9-0003ab-LH

On 10.12.23 08:30, Bagas Sanjaya wrote:
> On 12/10/23 14:15, Linux regression tracking (Thorsten Leemhuis) wrote:
[...]
>> [1] This is why: You just added Ard and Boris to the CC, but did not
>> make it obvious *why* they should care about that mail. They (and all
>> the other recipients) for sure will have no idea what a1b87d54f4e45f
>> exactly is, so you should have mentioned the commit summary. And doing
>> that after a big quote makes it worse, as many people now need to scroll
>> down to see if that mails contains something that might be relevant for
>> them -- and just a waste of time if not.
>>
>> Furthermore, sending the first mail of the thread to all those people
>> and lists was likely not very wise, as nobody is likely to care in a
>> case like this. And not removing all those people and lists in the
>> second mail of the thread make it a lot worse, as it became clear that
>> many people and list do not care about it now that the regression was
>> bisected. Hence it's best to remove them, we all get enough mail already.
>>
>> All that makes people ignore mails from you -- and maybe about
>> regression tracking in general. :-(
> 
> Oops, I didn't greet additional Cc's as you mentioned (that's my
> tendency when handling regressions).

Well, yes, but as mentioned  that is just one of several things that
were slightly off.

> So maybe we continue tracking this on Bugzilla or keeping on ML or
> both?

Not sure what you mean. I'll reply in private, no need to bother the
others with even more mail.

BTW: Ard, I noticed you got involved in the ticket. Thx for that!

Ciao, Thorsten

