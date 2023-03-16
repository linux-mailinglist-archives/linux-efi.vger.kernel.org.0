Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCB6BCB47
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 10:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCPJpO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCPJpM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 05:45:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA1D13DEF;
        Thu, 16 Mar 2023 02:45:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pckAT-0007w6-CW; Thu, 16 Mar 2023 10:45:05 +0100
Message-ID: <59064730-e731-d137-ae92-e19622a122d0@leemhuis.info>
Date:   Thu, 16 Mar 2023 10:45:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Content-Language: en-US, de-DE
To:     Andrea Righi <andrea.righi@canonical.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678959907;333adce4;
X-HE-SMSGID: 1pckAT-0007w6-CW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 16.03.23 08:54, Andrea Righi wrote:
> Hello,
> 
> the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> gets stuck and never completes the boot. On the console I see this:
> 
> [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> [   72.064949] Task dump for CPU 22:
> [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> [   72.082595] Call trace:
> [   72.085029]  __switch_to+0xbc/0x100
> [   72.088508]  0xffff80000fe83d4c
> 
> After that, as a consequence, I start to get a lot of hung task timeout traces.
> 
> I tried to bisect the problem and I found that the offending commit is
> this one:
> 
>  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> 
> I've reverted this commit for now and everything works just fine, but I
> was wondering if the problem could be caused by a lack of entropy on
> these arm64 boxes or something else.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced e7b813b32a42
#regzbot title efi: stuck at boot (efi_call_rts) on arm64
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
