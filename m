Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782262103B
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 13:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiKHMUF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 07:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiKHMUD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 07:20:03 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E313F1A;
        Tue,  8 Nov 2022 04:20:02 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1osNaA-0000q6-9s; Tue, 08 Nov 2022 13:19:58 +0100
Message-ID: <76b09d3a-fe10-74b3-40a0-1aaa75b70ba6@leemhuis.info>
Date:   Tue, 8 Nov 2022 13:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [Possible BUG] arm64: efi: efi_runtime_fixup_exception() and
 efi_call_virt_check_flags() both taint the kernel #forregzbot
Content-Language: en-US, de-DE
To:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <Y2lAB508TrrjpDPi@monolith.localdoman>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y2lAB508TrrjpDPi@monolith.localdoman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667910002;f2c334a3;
X-HE-SMSGID: 1osNaA-0000q6-9s
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 07.11.22 18:27, Alexandru Elisei wrote:
> I'm going to preface this by saying that I'm extremely unfamiliar with the
> EFI code.
> 
> Commit d3549a938b73 ("efi/arm64: libstub: avoid SetVirtualAddressMap() when
> possible") skipped the call to SetVirtualAddressMap() for certain
> configurations, and that started causing kernel panics on an Ampere Altra
> machine due to an EFI synchronous exception.
> 
> Commit 23715a26c8d8 ("arm64: efi: Recover from synchronous exceptions
> occurring in firmware") made the EFI exception non-fatal.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced d3549a938b73
#regzbot title efi: arm64: updating the firmware is not feasible anymore
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
