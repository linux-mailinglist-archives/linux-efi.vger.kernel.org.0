Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF065E85E8
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiIWWdA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiIWWc7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 18:32:59 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BFB121E5C;
        Fri, 23 Sep 2022 15:32:58 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:40284)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1obrE5-009AGO-Rn; Fri, 23 Sep 2022 16:32:53 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:52214 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1obrE4-002SIJ-6J; Fri, 23 Sep 2022 16:32:52 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
        <20220922193157.1673623-1-dave.hansen@linux.intel.com>
        <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
        <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
        <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
        <5f443915-b38a-c78d-cccd-876501434cef@roeck-us.net>
        <CAMj1kXEt1RwYbkBOFa=KsML0KvJ6Zuu9eJ_=jQA7BTW-N2BSeA@mail.gmail.com>
        <202209231126.6855D54@keescook>
        <CAMj1kXHckEg6rwBSEc6piu=-JZzyDh7j+pvGSFp1OBUQuofrEQ@mail.gmail.com>
        <202209231417.F73F40060@keescook>
        <69e00173-087e-6a22-7a02-0c1212f42065@intel.com>
Date:   Fri, 23 Sep 2022 17:32:45 -0500
In-Reply-To: <69e00173-087e-6a22-7a02-0c1212f42065@intel.com> (Dave Hansen's
        message of "Fri, 23 Sep 2022 15:15:15 -0700")
Message-ID: <87a66p3enm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1obrE4-002SIJ-6J;;;mid=<87a66p3enm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19oWRRkF39/nqNxUkNH38XNkkkXt00RYVc=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dave Hansen <dave.hansen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 443 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 10 (2.3%), parse: 1.20
        (0.3%), extract_message_metadata: 14 (3.1%), get_uri_detail_list: 1.98
        (0.4%), tests_pri_-1000: 15 (3.3%), tests_pri_-950: 1.20 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 93 (21.1%), check_bayes:
        92 (20.7%), b_tokenize: 8 (1.7%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 69 (15.6%), b_finish: 0.98
        (0.2%), tests_pri_0: 293 (66.1%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 1.23 (0.3%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 9/23/22 14:19, Kees Cook wrote:
>>> But currently, PAE is not even enabled in the i386_defconfig, and
>>> defaults to off. This means people that are unaware of this won't
>>> enable it, and will be running without NX support.
>> And they all make me cry. ;)
>
> It's been like that for a long time, presumably because the defconfig
> should *boot* in as many cases as possible.  It wouldn't be hard to
> change.  It also wouldn't be hard to default to HIGHMEM4G (non-PAE) on
> targeted builds for CPUs that don't support it.  Patch attached to do
> that, if anyone else has an opinion.
>
> We should probably just leave i386 alone, but it breaks my heart to see
> Kees in tears.

Is it at all possible to simply drop efi support for 32bit builds?

Last I looked (and it was quite a while ago) efi was only supported
same architecture.  So we are talking about 32bit efi for 32bit kernels.

I think there were only a handful of systems that ever shipped 32bit
efi, because when 32bit efi came out 64bit processors had been shipping
for several years already.

We still probably need to deal with whatever is needed for the BIOS.

If there are enough interesting systems to care to keep the few systems
that shipped with 32bit efi support going it probably does make sense to
change how it is implemented because using the kernel's page tables has
been nasty and given kexec all kinds of challenges to support because
not only does efi happen strange mapping attributes but efi also winds
up living at a fixed virtual address, that can't be changed.  So if you
care about anything like address space layout randomization efi provides
a well know fixed target that defeats all of your work there as well.

Can we do something to isolate 32bit efi so it is not a painpoint?

Given how long 8bit and 16bit systems have lasted I rather suspect 32bit
x86 will last in some embedded form for a very long time.  PAE came in
about the first pentium's I think so most embedded i386 processors
should support it.

Eric
