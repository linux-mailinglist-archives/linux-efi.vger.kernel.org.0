Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46862714B
	for <lists+linux-efi@lfdr.de>; Sun, 13 Nov 2022 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiKMRnI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Nov 2022 12:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiKMRnH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Nov 2022 12:43:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102ADF69;
        Sun, 13 Nov 2022 09:43:06 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ouH0Z-0000Z2-DB; Sun, 13 Nov 2022 18:43:03 +0100
Message-ID: <456466ec-b347-2c08-1b14-f6b7726229d5@leemhuis.info>
Date:   Sun, 13 Nov 2022 18:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [BUG] rtc-efi: Error in efi.get_time() spams dmesg with error
 message #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <Y2o1hdZK9GGDVJsS@monolith.localdoman>
 <9b1d1006-2b58-6eda-7e43-861074e9ccfa@leemhuis.info>
In-Reply-To: <9b1d1006-2b58-6eda-7e43-861074e9ccfa@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668361386;d8a43a48;
X-HE-SMSGID: 1ouH0Z-0000Z2-DB
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

On 09.11.22 16:50, Thorsten Leemhuis wrote:
> On 08.11.22 11:55, Alexandru Elisei wrote:
> 
>> Commit d3549a938b73 ("efi/arm64: libstub: avoid SetVirtualAddressMap() when
>> possible") exposed a firmware error on an Ampere Altra machine that was
>> causing the machine to panic. Then commit 23715a26c8d8 ("arm64: efi:
>> Recover from synchronous exceptions occurring in firmware") made the EFI
>> exception non-fatal, and disabled runtime services when the exception
>> happens. The interaction between those two patches are being discussed in a
>> separate thread [1], but that should be orthogonal to this.
>>
>> Now efi.get_time() fails and each time an error message is printed to
>> dmesg, which happens several times a second and clutters dmesg
>> unnecessarily, to the point it becomes unusable.
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 23715a26c8d8
> #regzbot title arm64: efi: efi.get_time() fails and clutters dmesg
> #regzbot ignore-activity

#regzbot fixed-by: 550b33cfd445296
