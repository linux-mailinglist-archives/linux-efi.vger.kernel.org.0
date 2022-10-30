Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0970612BAD
	for <lists+linux-efi@lfdr.de>; Sun, 30 Oct 2022 17:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ3Qth (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Oct 2022 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Qtg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Oct 2022 12:49:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD9AE4C
        for <linux-efi@vger.kernel.org>; Sun, 30 Oct 2022 09:49:34 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1opBV3-0006eZ-0c; Sun, 30 Oct 2022 17:49:29 +0100
Message-ID: <84860928-db02-b0f8-d13a-2bb8598d04dd@leemhuis.info>
Date:   Sun, 30 Oct 2022 17:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [Issue] EFI runtime-wrapper is broken #forregzbot
Content-Language: en-US, de-DE
To:     linux-efi <linux-efi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
 <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667148574;87bcd245;
X-HE-SMSGID: 1opBV3-0006eZ-0c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

On 28.10.22 11:21, Ard Biesheuvel wrote:
> On Fri, 28 Oct 2022 at 11:10, Gavin Shan <gshan@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> I ran into the following crash with v6.1.rc2. I'm not sure if it's known
>> issue. Last good version is v6.0.rc6/rc7. The kernel configuration is attached.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced d3549a938b73f203e
#regzbot title: efi: crashes due to broken runtime-wrapper
#regzbot from: Gavin Shan <gshan@redhat.com>
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
