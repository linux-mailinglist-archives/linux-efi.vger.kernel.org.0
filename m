Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481EA1442F6
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2020 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAURS4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jan 2020 12:18:56 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38810 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAURS4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jan 2020 12:18:56 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1itxAy-0006Ef-Vp; Tue, 21 Jan 2020 10:18:53 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1itxAx-0003e8-5J; Tue, 21 Jan 2020 10:18:52 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>
References: <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
        <20161215122856.7d24b7a8@endymion>
        <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
        <1481890738.9552.70.camel@linux.intel.com>
        <20161216143330.69e9c8ee@endymion>
        <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
        <20200120121927.GJ32742@smile.fi.intel.com>
        <87a76i9ksr.fsf@x220.int.ebiederm.org>
        <CAHp75VdjwWfqHtJ3n-UK_n5nzpgcpERbM+_9-Z3FrjJx7nHQzQ@mail.gmail.com>
        <CAKv+Gu-sVSWNYHEjzjOfbEryOR_XruwH=qQphq4uTXMLPK18tw@mail.gmail.com>
        <20200121153730.GZ32742@smile.fi.intel.com>
Date:   Tue, 21 Jan 2020 11:17:19 -0600
In-Reply-To: <20200121153730.GZ32742@smile.fi.intel.com> (Andy Shevchenko's
        message of "Tue, 21 Jan 2020 17:37:30 +0200")
Message-ID: <87h80o4tls.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1itxAx-0003e8-5J;;;mid=<87h80o4tls.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19olwcf/WiE23jCAyJYJej7Qqs8NFwJG8E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMStockSpam_06,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 XMStockSpam_06 Stock Index Spam Sym,Price
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Andy Shevchenko <andy.shevchenko@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1250 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.2%), b_tie_ro: 1.74 (0.1%), parse: 1.29
        (0.1%), extract_message_metadata: 22 (1.8%), get_uri_detail_list: 6
        (0.5%), tests_pri_-1000: 24 (1.9%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 70 (5.6%), check_bayes: 68
        (5.4%), b_tokenize: 30 (2.4%), b_tok_get_all: 20 (1.6%), b_comp_prob:
        9 (0.8%), b_tok_touch_all: 4.8 (0.4%), b_finish: 0.68 (0.1%),
        tests_pri_0: 1068 (85.4%), check_dkim_signature: 1.06 (0.1%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 0.04 (0.0%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 54 (4.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to kexec'ed kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, Jan 21, 2020 at 12:18:03AM +0100, Ard Biesheuvel wrote:
>> On Mon, 20 Jan 2020 at 23:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> > On Mon, Jan 20, 2020 at 9:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > > > On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:
>
> ...
>
>> > > > Can we apply these patches for now until you will find better
>> > > > solution?
>> > >
>> > > Not a chance.  The patches don't apply to any kernel in the git history.
>> > >
>> > > Which may be part of your problem.  You are or at least were running
>> > > with code that has not been merged upstream.
>> >
>> > It's done against linux-next.
>> > Applied clearly. (Not the version in this more than yearly old series
>> > of course, that's why I told I can resend)
>> >
>> > > > P.S. I may resend them rebased on recent vanilla.
>> > >
>> > > Second.  I looked at your test results and they don't directly make
>> > > sense.  dmidecode bypasses the kernel completely or it did last time
>> > > I looked so I don't know why you would be using that to test if
>> > > something in the kernel is working.
>> > >
>> > > However dmidecode failing suggests that the actual problem is something
>> > > in the first kernel is stomping the dmi tables.
>> >
>> > See below.
>> >
>> > > Adding a command line option won't fix stomped tables.
>> >
>> > It provides a mechanism, which seems to be absent, to the second
>> > kernel to know where to look for SMBIOS tables.
>> >
>> > > So what I would suggest is:
>> > > a) Verify that dmidecode works before kexec.
>> >
>> > Yes, it does.
>> >
>> > > b) Test to see if dmidecode works after kexec.
>> >
>> > No, it doesn't.
>> >
>> > > c) Once (a) shows that dmidecode works and (b) shows that dmidecode
>> > >    fails figure out what is stomping your dmi tables during or before
>> > >    kexec and that is what should get fixed.
>> >
>> > The problem here as I can see it that EFI and kexec protocols are not
>> > friendly to each other.
>> > I'm not an expert in either. That's why I'm asking for possible
>> > solutions. And this needs to be done in kernel to allow drivers to
>> > work.
>> >
>> > Does the
>> >
>> > commit 4996c02306a25def1d352ec8e8f48895bbc7dea9
>> > Author: Takao Indoh <indou.takao@jp.fujitsu.com>
>> > Date:   Thu Jul 14 18:05:21 2011 -0400
>> >
>> >     ACPI: introduce "acpi_rsdp=" parameter for kdump
>> >
>> > description shed a light on this?
>> >
>> > > Now using a non-efi method of dmi detection relies on the
>> > > tables being between 0xF0000 and 0x10000. AKA the last 64K
>> > > of the first 1MiB of memory.  You might check to see if your
>> > > dmi tables are in that address range.
>> >
>> > # dmidecode --no-sysfs
>> > # dmidecode 3.2
>> > Scanning /dev/mem for entry point.
>> > # No SMBIOS nor DMI entry point found, sorry.
>> >
>> > === with patch applied ===
>> > # dmidecode
>> > ...
>> >         Release Date: 03/10/2015
>> > ...
>> >
>> > >
>> > > Otherwise I suspect the good solution is to give efi it's own page
>> > > tables in the kernel and switch to it whenever efi functions are called.
>> > >
>> >
>> > > But on 32bit the Linux kernel has historically been just fine directly
>> > > accessing the hardware, and ignoring efi and all of the other BIOS's.
>> >
>> > It seems not only for 32-bit Linux kernel anymore. MS Surface 3 runs
>> > 64-bit code.
>> >
>> > > So if that doesn't work on Intel Galileo that is probably a firmware
>> > > problem.
>> >
>> > It's not only about Galileo anymore.
>> >
>> 
>> Looking at the x86 kexec EFI code, it seems that it has special
>> handling for the legacy SMBIOS table address, but not for the SMBIOS3
>> table address, which was introduced to accommodate SMBIOS tables
>> living in memory that is not 32-bit addressable.
>> 
>> Could anyone check whether these systems provide SMBIOS 3.0 tables,
>> and whether their address gets virtually remapped at ExitBootServices?
>
> On Microsoft Surface 3 tablet:
>
> === First kernel ===
>
> # uname -a
>
> (Previously reported issue on)
> Linux buildroot 4.13.0+ #39 SMP Tue Sep 5 14:58:23 EEST 2017 x86_64 GNU/Linux
>
> (Updated today to)
> Linux buildroot 5.4.0+ #2 SMP Tue Nov 26 15:36:31 EET 2019 x86_64 GNU/Linux
>
> # ls -l /sys/firmware/dmi/tables/
> total 0
> -r--------    1 root     root           825 Jan 21 15:41 DMI
> -r--------    1 root     root            31 Jan 21 15:41 smbios_entry_point
>
> # od -Ax -tx1 /sys/firmware/dmi/tables/smbios_entry_point
> 000000 5f 53 4d 5f 0f 1f 02 08 6a 00 00 00 00 00 00 00
> 000010 5f 44 4d 49 5f e0 39 03 00 40 5b 7b 0f 00 27
> 00001f
>
> # dmesg | grep -i dmi
> [    0.000000] DMI: Microsoft Corporation Surface 3/Surface 3, BIOS 1.50410.78 03/10/2015
> [    0.403058] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
>
> # dmesg | grep -i smb
> [    0.000000] efi:  ESRT=0x7b7c6c98  ACPI=0x7ad5a000  ACPI 2.0=0x7ad5a000  SMBIOS=0x7b5f7d18
> [    0.000000] SMBIOS 2.8 present.
>
> === kexec'ed kernel ===
> # uname -a
> (in both cases, see above `uname -a`, the same version)
> Linux buildroot 5.5.0-rc7+ #161 SMP Tue Jan 21 15:50:02 EET 2020 x86_64 GNU/Linux
>
> # dmidecode
> # dmidecode 3.2
> 	Scanning /dev/mem for entry point.
> # No SMBIOS nor DMI entry point found, sorry.
>
> # dmidecode --no-sysfs
> # dmidecode 3.2
> 	Scanning /dev/mem for entry point.
> # No SMBIOS nor DMI entry point found, sorry.

This sounds like at least something of a different issue, with similar
symptoms.

I don't think it is fundamentally wrong to pass the location of the dmi
tables in a command line option.  If you can build that command line
option independent of kexec and it takes practically no maintenance then
it does not harm, and can be used as a debug option by others.

My primary concern with your original patch is because it did not
apply to any version of the kernel in Linus's git tree that it had not
been tested on any code.



That said let me lay some background on kexec and efi so we can
have a productive conversation about how to maintain their cooperation
in the long term.  I am going to do this from memory so please forgive
me where I get my details slightly off.

EFI has two interesting calls for an operating system.

SetVirtualMap
ExitBootServices

The law of large numbers strongly suggests that when it comes to
emperical testing any interface that is not so heavily used it will fail
to boot all operating systems if it doesn't work will have at least one
broken implementation somewhere.  A bug so bad nothing can boot means
the hardware is unshippable and so will not be seen in the wild.  As
firmware is essentially fixed once a machine ships this means that all
firmware problems have to be dealt with by the boot loader and the
operating system.


SetVirtualMap by design can be called only once, which is problematic
when you are switching operating systems on a running system (kexec).
Last I was paying attention there were also systems discovered that
won't work if SetVirtualMap is not called at all.  I believe the
solution adopted for x86_64 was to always map EFI at the same location
in the page tables and only call SetVirtualMap the first time.


ExitBootSerives is similarly challenging as it can only be called once,
and there are systems that get it wrong if you call it at all.  Even if
ExitBootServices works you can't depend on any of the boot services for
the second kernel.



There are two primary uses for kexec.  To use the first kernel as a boot
loader in which case it is desiable for everything to work after kexec
is called.  To use the second kernel as something to capture a crash
dump in which case simply a best effor is needed and failing cleanly
if something won't work properly.


You are running interactive commands so I presume you are wanting to use
kexec as a bootloader.


I don't know where things are now but for a while was no desire to
address the concerns of people using kexec by the folks implementing EFI
or the folks implementing EFI support in the kernel.  But that is
probably how we got into a situation where efi support does not work
cleanly.

EFI choosing to place firwmare tables in somewhere besides their
architecturally defined location does not help.

I don't practically have a system with EFI so I have not personally
cared to fix any of the problems.


My sense is that for making EFI calls from any linux kernel should be
isolated in it's own page table, so isolate as much as possible any
EFI bugs from the rest of the kernel.  That is probably also needed to
provide a guard against speculative execution side channel attacks.



I can see doing some work to get EFI functional after kexec if it isn't
but at the same time I am not a fan of performing any unnecessary
firmware calls.  Someone sometime will implement one wrong, and it will
be a headache for everyone until it is removed.


By the same token I don't understand the problem with DMI not working.
As I recall all the linux kernel really uses DMI for is to decide which
quirks to apply.  It might be better just to pass a board name string
on the kernel command line, and use that string for quirk selection
instead.  A simple string seems like an easy to implement and use
debug command line option, that has uses outside of kexec.  AKA testing
to see if quirks do what you expect them too.


Which brings us to the question of quirks.  Why are quirks important?
If they are that suggests something else is wrong.  Maybe that something
else should be fixed.

Why do those boards need the DMI information in the first place?

Eric

