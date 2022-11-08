Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4F62141E
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 14:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiKHN5Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 08:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiKHN5U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 08:57:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6E66C98
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 05:57:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E631DB81AE4
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 13:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDD2C43470
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667915836;
        bh=6QgA7zxZr+06ErVA5yLWjruENerkbvVZ8g40ZACW0Qw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o5hlcTdSWBRBBBlzBv7mgPeCk2O/1omOozvo/2MmX0KLYUyARlkcxc4XCFScYrrDa
         W0dG30T7hOq309UWG15pl/aD8Ffe3jDlvCZ7dENRO2k5sPs4XZ6pZLD2N/JcqyyHpy
         RE6mYTzvSVBwf0AnHKzeMcxs7HVXO6Ch9+C2XfMc3mr6cRLglNWqNOXQfnOTGl7C5r
         hLqk2Pe2s5wspuHJvRoOIG8Zr8Z9ENgnvldm5Xg72+J8GFesROMfp/NiLiOS5V5lmU
         NZFAtc+LLNaxLlX/D/YIeEJ0ZVlJeJlYzGr0lWLNkwfB7mQlLIGHgqjX5OL9efo25r
         DqHkm+TZVCvgg==
Received: by mail-lj1-f175.google.com with SMTP id b9so21215044ljr.5
        for <linux-efi@vger.kernel.org>; Tue, 08 Nov 2022 05:57:16 -0800 (PST)
X-Gm-Message-State: ACrzQf0U2V20Kkr18Qg5ISwligb/SEIR/SpuS3KVPq5wDE953sgiDGa7
        HeTWpYivfoz2zQM4IQ2xZf3C4OfTfTRKQq7s18U=
X-Google-Smtp-Source: AMsMyM4DrU6m7IQbAp2gogLHTqpm2L4TWLX3iaTEyeI9HvgJ1PcAZHtzwCl6Cw9AnRk5yppPDMeMk8hgdAW5vt++tHU=
X-Received: by 2002:a2e:3a1a:0:b0:277:7eef:1d97 with SMTP id
 h26-20020a2e3a1a000000b002777eef1d97mr5895000lja.516.1667915834647; Tue, 08
 Nov 2022 05:57:14 -0800 (PST)
MIME-Version: 1.0
References: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
 <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
 <d469f6b9-d23a-abe6-27b7-f58f9de12a45@redhat.com> <CAMj1kXFUfAE6bGTxTFDQe9HxAZAuAOXenU+GC-39QJfaBOt4tA@mail.gmail.com>
 <34d7f903-9d1a-d63b-0d32-b72ae775f26a@leemhuis.info>
In-Reply-To: <34d7f903-9d1a-d63b-0d32-b72ae775f26a@leemhuis.info>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 8 Nov 2022 14:57:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtitTuxVSBsxX0j_NHxwnX2oVupip4xy7TKqe-rja_Vw@mail.gmail.com>
Message-ID: <CAMj1kXFtitTuxVSBsxX0j_NHxwnX2oVupip4xy7TKqe-rja_Vw@mail.gmail.com>
Subject: Re: [Issue] EFI runtime-wrapper is broken
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Gavin Shan <gshan@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 8 Nov 2022 at 13:26, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker. CCing the regression
> mailing list, as it should be in the loop for all regressions, as
> explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>
> On 28.10.22 11:39, Ard Biesheuvel wrote:
> > On Fri, 28 Oct 2022 at 11:38, Gavin Shan <gshan@redhat.com> wrote:
> >> On 10/28/22 5:21 PM, Ard Biesheuvel wrote:
> >>> On Fri, 28 Oct 2022 at 11:10, Gavin Shan <gshan@redhat.com> wrote:
> >>>> I ran into the following crash with v6.1.rc2. I'm not sure if it's known
> >>>> issue. Last good version is v6.0.rc6/rc7. The kernel configuration is attached.
> >>>
> >>> This is probably related to the patch below. It means the firmware is
> >>> buggy, and does not work as it should if the firmware never calls
> >>> SetVirtualAddressMap() [and doing so is explicitly described as
> >>> OPTIONAL by the EFI specification].
> >>>
> >>> The problem here is that other EFI implementations (primarily the
> >>> Qualcomm ones used on Windows-on-ARM laptops) are buggy too, and don't
> >>> tolerate SetVirtualAddressMap().
> >>>
> >>> Can you try whether reverting the patch below helps?
> >>
> >> I ran into the issue on server, equipped with Ampere CPUs. With d3549a938b73
> >> reverted, the crash disappeared.
> >
> > Thanks for confirming
> >
> > Can you please share the complete boot log and the DMI/SMBIOS data? Thanks.
>
> Gavin, did you ever send this?
>
> Or Ard, was there any progress to get the issue fixed?
>
> I ask because I have this on the list of tracked regression -- and I
> noticed there is another report about problems caused by d3549a938b73
> now from Alexandru Elisei:
> https://lore.kernel.org/lkml/Y2lAB508TrrjpDPi@monolith.localdoman/
>

Yes, this is essentially the exact same problem, only on a different
type of Ampere hardware

I have an idea how to fix this more comprehensively - I'll work with
Alexandru to converge on a fix and get it queued up.
