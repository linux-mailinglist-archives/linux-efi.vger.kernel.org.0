Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8C622F4B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKIPph (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 10:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKIPph (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 10:45:37 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478CA1B9D5
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 07:45:35 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1osnGe-0001Pl-6z; Wed, 09 Nov 2022 16:45:32 +0100
Message-ID: <00c9d729-b287-eee4-315c-235837faf2e4@leemhuis.info>
Date:   Wed, 9 Nov 2022 16:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [Issue] EFI runtime-wrapper is broken #forregzbot
Content-Language: en-US, de-DE
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>
References: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
 <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
 <d469f6b9-d23a-abe6-27b7-f58f9de12a45@redhat.com>
 <CAMj1kXFUfAE6bGTxTFDQe9HxAZAuAOXenU+GC-39QJfaBOt4tA@mail.gmail.com>
 <34d7f903-9d1a-d63b-0d32-b72ae775f26a@leemhuis.info>
 <CAMj1kXFtitTuxVSBsxX0j_NHxwnX2oVupip4xy7TKqe-rja_Vw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAMj1kXFtitTuxVSBsxX0j_NHxwnX2oVupip4xy7TKqe-rja_Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668008735;d7d0c9e1;
X-HE-SMSGID: 1osnGe-0001Pl-6z
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

On 08.11.22 14:57, Ard Biesheuvel wrote:
>> I ask because I have this on the list of tracked regression -- and I
>> noticed there is another report about problems caused by d3549a938b73
>> now from Alexandru Elisei:
>> https://lore.kernel.org/lkml/Y2lAB508TrrjpDPi@monolith.localdoman/
> Yes, this is essentially the exact same problem, only on a different
> type of Ampere hardware
> 
> I have an idea how to fix this more comprehensively - I'll work with
> Alexandru to converge on a fix and get it queued up.

In that case:

#regzbot dup-of:
https://lore.kernel.org/lkml/Y2lAB508TrrjpDPi@monolith.localdoman/

