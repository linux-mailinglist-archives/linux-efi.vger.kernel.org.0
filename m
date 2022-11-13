Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CADD6271A9
	for <lists+linux-efi@lfdr.de>; Sun, 13 Nov 2022 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKMSbm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Nov 2022 13:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMSbl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Nov 2022 13:31:41 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE1F594
        for <linux-efi@vger.kernel.org>; Sun, 13 Nov 2022 10:31:41 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ouHla-0006Tq-Kg; Sun, 13 Nov 2022 19:31:38 +0100
Message-ID: <0f936a56-29af-49d8-f291-398e91cce0e2@leemhuis.info>
Date:   Sun, 13 Nov 2022 19:31:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [Issue] EFI runtime-wrapper is broken #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>
References: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
 <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
 <d469f6b9-d23a-abe6-27b7-f58f9de12a45@redhat.com>
 <CAMj1kXFUfAE6bGTxTFDQe9HxAZAuAOXenU+GC-39QJfaBOt4tA@mail.gmail.com>
 <34d7f903-9d1a-d63b-0d32-b72ae775f26a@leemhuis.info>
In-Reply-To: <34d7f903-9d1a-d63b-0d32-b72ae775f26a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668364301;2fb03d76;
X-HE-SMSGID: 1ouHla-0006Tq-Kg
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

On 08.11.22 13:26, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker. CCing the regression
> mailing list, as it should be in the loop for all regressions, as
> explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> 
> On 28.10.22 11:39, Ard Biesheuvel wrote:
>> On Fri, 28 Oct 2022 at 11:38, Gavin Shan <gshan@redhat.com> wrote:
>>> On 10/28/22 5:21 PM, Ard Biesheuvel wrote:
>>>> On Fri, 28 Oct 2022 at 11:10, Gavin Shan <gshan@redhat.com> wrote:
>>>>> I ran into the following crash with v6.1.rc2. I'm not sure if it's known
>>>>> issue. Last good version is v6.0.rc6/rc7. The kernel configuration is attached.
>>>>
>>>> This is probably related to the patch below. It means the firmware is
>>>> buggy, and does not work as it should if the firmware never calls
>>>> SetVirtualAddressMap() [and doing so is explicitly described as
>>>> OPTIONAL by the EFI specification].
>>>>
>>>> The problem here is that other EFI implementations (primarily the
>>>> Qualcomm ones used on Windows-on-ARM laptops) are buggy too, and don't
>>>> tolerate SetVirtualAddressMap().
>>>>
>>>> Can you try whether reverting the patch below helps?
>>>
>>> I ran into the issue on server, equipped with Ampere CPUs. With d3549a938b73
>>> reverted, the crash disappeared.
>>
>> Thanks for confirming
>>
>> Can you please share the complete boot log and the DMI/SMBIOS data? Thanks.
> 
> Gavin, did you ever send this?
> 
> Or Ard, was there any progress to get the issue fixed?
> 
> I ask because I have this on the list of tracked regression -- and I
> noticed there is another report about problems caused by d3549a938b73
> now from Alexandru Elisei:
> https://lore.kernel.org/lkml/Y2lAB508TrrjpDPi@monolith.localdoman/

#regzbot fixed-by: 550b33cfd445296


