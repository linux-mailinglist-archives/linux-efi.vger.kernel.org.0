Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE4143229
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2020 20:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgATT1X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 14:27:23 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:42384 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATT1X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jan 2020 14:27:23 -0500
X-Greylist: delayed 12101 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2020 14:27:22 EST
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1itZYa-00015n-O0; Mon, 20 Jan 2020 09:05:40 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1itZYV-0005Jn-BB; Mon, 20 Jan 2020 09:05:40 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-efi@vger.kernel.org,
        ard.biesheuvel@linaro.org, matt@codeblueprint.co.uk,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
        <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
        <20161215122856.7d24b7a8@endymion>
        <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
        <1481890738.9552.70.camel@linux.intel.com>
        <20161216143330.69e9c8ee@endymion>
        <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
        <20200120121927.GJ32742@smile.fi.intel.com>
Date:   Mon, 20 Jan 2020 10:04:04 -0600
In-Reply-To: <20200120121927.GJ32742@smile.fi.intel.com> (Andy Shevchenko's
        message of "Mon, 20 Jan 2020 14:19:27 +0200")
Message-ID: <87a76i9ksr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1itZYV-0005Jn-BB;;;mid=<87a76i9ksr.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/gB42Om93MVQYunpLwTKkpM5H9wK/PFUg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4818]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4396 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 2.7 (0.1%), b_tie_ro: 1.71 (0.0%), parse: 1.42
        (0.0%), extract_message_metadata: 13 (0.3%), get_uri_detail_list: 2.3
        (0.1%), tests_pri_-1000: 12 (0.3%), tests_pri_-950: 1.33 (0.0%),
        tests_pri_-900: 1.11 (0.0%), tests_pri_-90: 34 (0.8%), check_bayes: 32
        (0.7%), b_tokenize: 9 (0.2%), b_tok_get_all: 11 (0.3%), b_comp_prob:
        3.6 (0.1%), b_tok_touch_all: 4.1 (0.1%), b_finish: 0.67 (0.0%),
        tests_pri_0: 604 (13.7%), check_dkim_signature: 0.83 (0.0%),
        check_dkim_adsp: 24 (0.5%), poll_dns_idle: 3732 (84.9%), tests_pri_10:
        3.1 (0.1%), tests_pri_500: 3720 (84.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to kexec'ed kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:
>> Ccing efi people.
>> 
>> On 12/16/16 at 02:33pm, Jean Delvare wrote:
>> > On Fri, 16 Dec 2016 14:18:58 +0200, Andy Shevchenko wrote:
>> > > On Fri, 2016-12-16 at 10:32 +0800, Dave Young wrote:
>> > > > On 12/15/16 at 12:28pm, Jean Delvare wrote:
>> > > > > I am no kexec expert but this confuses me. Shouldn't the second
>> > > > > kernel have access to the EFI systab as the first kernel does? It
>> > > > > includes many more pointers than just ACPI and DMI tables, and it
>> > > > > would seem inconvenient to have to pass all these addresses
>> > > > > individually explicitly.
>> > > > 
>> > > > Yes, in modern linux kernel, kexec has the support for EFI, I think it
>> > > > should work naturally at least in x86_64.
>> > > 
>> > > Thanks for this good news!
>> > > 
>> > > Unfortunately Intel Galileo is 32-bit platform.
>> > 
>> > If it was done for X86_64 then maybe it can be generalized to X86?
>> 
>> For X86_64, we have a new way for efi runtime memmory mapping, in i386
>> code it still use old ioremap way. It is impossible to use same way as
>> the X86_64 since the virtual address space is limited.
>> 
>> But maybe for 32bit, kexec kernel can run in physical mode, but I'm not
>> sure, I would suggest Andy to do a test first with efi=noruntime for
>> kexec 2nd kernel.
>
> Guys, it was quite a long no hear from you. As I told you the proposed work
> around didn't help. Today I found that Microsoft Surface 3 also affected
> by this.
>
> Can we apply these patches for now until you will find better
> solution?

Not a chance.  The patches don't apply to any kernel in the git history.

Which may be part of your problem.  You are or at least were running
with code that has not been merged upstream.

> P.S. I may resend them rebased on recent vanilla.

Second.  I looked at your test results and they don't directly make
sense.  dmidecode bypasses the kernel completely or it did last time
I looked so I don't know why you would be using that to test if
something in the kernel is working.

However dmidecode failing suggests that the actual problem is something
in the first kernel is stomping the dmi tables.

Adding a command line option won't fix stomped tables.

So what I would suggest is:
a) Verify that dmidecode works before kexec.
b) Test to see if dmidecode works after kexec.
c) Once (a) shows that dmidecode works and (b) shows that dmidecode
   fails figure out what is stomping your dmi tables during or before
   kexec and that is what should get fixed.

Now using a non-efi method of dmi detection relies on the
tables being between 0xF0000 and 0x10000. AKA the last 64K
of the first 1MiB of memory.  You might check to see if your
dmi tables are in that address range.

Otherwise I suspect the good solution is to give efi it's own page
tables in the kernel and switch to it whenever efi functions are called.

But on 32bit the Linux kernel has historically been just fine directly
accessing the hardware, and ignoring efi and all of the other BIOS's.
So if that doesn't work on Intel Galileo that is probably a firmware
problem.

Eric

