Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E506766A0
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jan 2023 15:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAUOEW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Jan 2023 09:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUOEW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 Jan 2023 09:04:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329EC37556
        for <linux-efi@vger.kernel.org>; Sat, 21 Jan 2023 06:04:21 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pJETj-0004S4-Hk; Sat, 21 Jan 2023 15:04:19 +0100
Message-ID: <4d435512-5209-01c9-8e23-4dec0271cec5@leemhuis.info>
Date:   Sat, 21 Jan 2023 15:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Is there a known boot failure with 6.2-rc and the Intel SDV EFI
 systems?
Content-Language: en-US, de-DE
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-efi@vger.kernel.org
References: <f2503170d12dc567c00998d4e72ba806f7677730.camel@HansenPartnership.com>
 <0eabbe98-db6e-b5db-ca5b-3f212bf2f734@leemhuis.info>
 <e75c7d4be4cda26dc1e40a88e8de5cfa12810d3f.camel@HansenPartnership.com>
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <e75c7d4be4cda26dc1e40a88e8de5cfa12810d3f.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674309861;7c99757e;
X-HE-SMSGID: 1pJETj-0004S4-Hk
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 21.01.23 14:23, James Bottomley wrote:
> On Sat, 2023-01-21 at 14:20 +0100, Linux kernel regression tracking
> (#adding) wrote:
>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>> regressions; the text you find below is based on a few templates
>> paragraphs you might have encountered already in similar form.
>> See link in footer if these mails annoy you.]
> 
> This isn't an EFI regression.  It actually bisects to an oops in one of
> my modified TPM drivers which is being initialized early because of
> IMA.  The problem is the EFI console isn't showing it, so I just get no
> output after loading the initrd but, as far as I can tell, this is a
> longstanding problem.

Thx for the update, in that case:

#regzbot resolve: turns out it apparently is a longstanding problem and
not a regression

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
