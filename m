Return-Path: <linux-efi+bounces-158-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1CD80B999
	for <lists+linux-efi@lfdr.de>; Sun, 10 Dec 2023 08:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC221C20777
	for <lists+linux-efi@lfdr.de>; Sun, 10 Dec 2023 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6A4439;
	Sun, 10 Dec 2023 07:15:55 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F77C1;
	Sat,  9 Dec 2023 23:15:49 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rCE2O-0007XZ-HN; Sun, 10 Dec 2023 08:15:40 +0100
Message-ID: <fe7a2b72-9418-42dc-b6fb-2aa93bc4eabc@leemhuis.info>
Date: Sun, 10 Dec 2023 08:15:39 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel 6.6.1 hangs on "loading initial ramdisk"
Content-Language: en-US, de-DE
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, bwg <whirl@mniotilta.ca>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-efi <linux-efi@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, shibedrill1@gmail.com
References: <9057d7de-f2e0-44ba-bec7-8b0861b2a850@gmail.com>
 <ZXVdZE3D-KFBqPnj@archie.me>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZXVdZE3D-KFBqPnj@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702192549;0aa0df20;
X-HE-SMSGID: 1rCE2O-0007XZ-HN

[Moved a lot of people CCed in the previous mail to BCC, as I'm pretty
sure they do not care about this regression; at the same time add the
x86 maintainers and the efi list.]

[Top posting for once to make this easier accessible for everyone.]

Ard, Boris, just to make it obvious: the regression report quoted below
 was bisected to a1b87d54f4e45f ("x86/efistub: Avoid legacy decompressor
when doing EFI boot") [v6.6-rc1] from Ard which committed by Boris.
There are two users that seem to be affected by this. Both seem to run
Arch. For details see:
https://bugzilla.kernel.org/show_bug.cgi?id=218173

Bagas, FWIW, I know you want to help, but your previous mail is not
helpful at all -- on the contrary, as it is yet another one that is
likely hurting my regression tracking efforts[1]. Please stop and just
tell me about things like this in a private mail, as we agreed on earlier.

Ciao, Thorsten

[1] This is why: You just added Ard and Boris to the CC, but did not
make it obvious *why* they should care about that mail. They (and all
the other recipients) for sure will have no idea what a1b87d54f4e45f
exactly is, so you should have mentioned the commit summary. And doing
that after a big quote makes it worse, as many people now need to scroll
down to see if that mails contains something that might be relevant for
them -- and just a waste of time if not.

Furthermore, sending the first mail of the thread to all those people
and lists was likely not very wise, as nobody is likely to care in a
case like this. And not removing all those people and lists in the
second mail of the thread make it a lot worse, as it became clear that
many people and list do not care about it now that the regression was
bisected. Hence it's best to remove them, we all get enough mail already.

All that makes people ignore mails from you -- and maybe about
regression tracking in general. :-(

On 10.12.23 07:40, Bagas Sanjaya wrote:
> On Wed, Nov 22, 2023 at 07:06:50AM +0700, Bagas Sanjaya wrote:
>> Hi,
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> After upgrading from 6.5.9 to 6.6.1 on my Dell Latitude E6420 (Intel i5-2520M) with EndeavourOS, the boot process would hang at "loading initial ramdisk". The issue is present on the 6.6.1 release of both Linux and Linux-zen, but not the 6.5.9 release, which makes me think this is somehow upstream in the kernel, rather than to do with packaging. My current workaround is using the Linux LTS kernel.
>>>
>>> I have been unable to consistently reproduce this bug. Between 50 and 30 percent of the time, the "loading initial ramdisk" will display, the disk activity indicator will turn off briefly and then resume blinking, and then the kernel boots as expected. The other 50 to 70 percent of the time, the boot stops at "loading initial ramdisk" and the disk activity indicator turns off, and does not resume blinking. The disk activity light is constantly flashing during normal system operation, so I know it's not secretly booting but not updating the display. I haven't been able to replicate this issue in QEMU. I have seen similar bugs that have been solved by disabling IOMMU, but this has not had any effect. Neither has disabling graphics drivers and modesetting. I have been able to reproduce it while using Nouveau, so I don't believe it has to do with Nvidia's proprietary drivers.
>>>
>>> Examining dmesg and journalctl, there doesn't appear to be ANY logs from the failed boots. I don't believe the kernel even is started on these failed boots. Enabling GRUB debug messages (linux,loader,init,fs,device,disk,partition) shows that the hang occurs after GRUB attempts to start the loaded image- it's able to load the image into memory, but the boot stalls after "Starting image" with a hex address (presumably the start addr of the kernel).  
>>>
>>> I've been trying to compile the kernel myself to see if I can solve the issue, or at least aid in reproduceability, but this is not easy or fast to do on a 2012 i5 processor. I'll update if I can successfully recompile the kernel and if it yields any information.  
>>>
>>> Please let me know if I should provide any additional information. This is my first time filing a bug here.
>>
>> See Bugzilla for the full thread and attached grub output.
>>
>> Anyway, I'm adding this regression to regzbot:
>>
>> #regzbot introduced: v6.5..v6.6 https://bugzilla.kernel.org/show_bug.cgi?id=218173
>> #regzbot title: initramfs loading hang on nouveau system (Dell Latitude E6420)
>>
> 
> Another reporter on Bugzilla had bisected the regression, so:
> 
> #regzbot introduced: a1b87d54f4e45f
> 
> Thanks.
> 

