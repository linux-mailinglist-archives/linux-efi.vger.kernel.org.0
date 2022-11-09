Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EBE622F5D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiKIPuc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 10:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiKIPu3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 10:50:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6411D65F;
        Wed,  9 Nov 2022 07:50:25 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1osnLL-0003Gq-O2; Wed, 09 Nov 2022 16:50:23 +0100
Message-ID: <9b1d1006-2b58-6eda-7e43-861074e9ccfa@leemhuis.info>
Date:   Wed, 9 Nov 2022 16:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [BUG] rtc-efi: Error in efi.get_time() spams dmesg with error
 message #forregzbot
Content-Language: en-US, de-DE
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <Y2o1hdZK9GGDVJsS@monolith.localdoman>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y2o1hdZK9GGDVJsS@monolith.localdoman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668009025;3d7d429c;
X-HE-SMSGID: 1osnLL-0003Gq-O2
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
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

On 08.11.22 11:55, Alexandru Elisei wrote:

> Commit d3549a938b73 ("efi/arm64: libstub: avoid SetVirtualAddressMap() when
> possible") exposed a firmware error on an Ampere Altra machine that was
> causing the machine to panic. Then commit 23715a26c8d8 ("arm64: efi:
> Recover from synchronous exceptions occurring in firmware") made the EFI
> exception non-fatal, and disabled runtime services when the exception
> happens. The interaction between those two patches are being discussed in a
> separate thread [1], but that should be orthogonal to this.
> 
> Now efi.get_time() fails and each time an error message is printed to
> dmesg, which happens several times a second and clutters dmesg
> unnecessarily, to the point it becomes unusable.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 23715a26c8d8
#regzbot title arm64: efi: efi.get_time() fails and clutters dmesg
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
