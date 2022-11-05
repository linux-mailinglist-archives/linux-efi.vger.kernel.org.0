Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B5161DDF4
	for <lists+linux-efi@lfdr.de>; Sat,  5 Nov 2022 21:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiKEUSb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEUSa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 16:18:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDB112C
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 13:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A0D8B8069F
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 20:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7331C433D7
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667679504;
        bh=ufG0K66hY0eOp6jH5ZQA4a8vSnfuLykEMS+EUVW81Qs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dqfX8ApIXlTlApOqXl15pW0N5gIn5Vi0TapgLQFTucOJorBE1pFtAe4irWTNcBPhI
         02dNs3to3k7HfhRdT32UTkhXRMs0mKs7R4NjgwELGgoBD2I49kzWoULaeknnIKweMi
         PPrUQ79QbvtWIeSCtgnsAQ329gtFvH/695CYNbojezGWzNRUzFlxeXZ4oK4p5Rm4Vn
         qWuiuhrEj2zBqWURhCSl0bjHp9TW5W3s7CjT3foxiF5XgPp/Y6BpV+Kk6qQAj3DupC
         oFQjkJIrjbbC+LPD3YPLW/yPAiqq3NLWwt4ENHgvtyxWLtglf31bf4BENS1o8OqzIA
         FPAHy6qi0a9HA==
Received: by mail-lf1-f49.google.com with SMTP id f37so11760422lfv.8
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 13:18:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf26JK8fIlQVOfEyGwW7I4IlRn2nkWhSrzWLA2p2WHa8gGo+noiq
        aCpOxmFK34i8FvDvhasvcBGR60yMXlUpcLPXOc8=
X-Google-Smtp-Source: AMsMyM79uU45eFpEetPx3aJwbX3GvUgMZCJjKZua1ACslgebPkrWo3DSWLMV4hlTv3cP8Tl+8E19rKW2czMv3I3L6aI=
X-Received: by 2002:a19:4f53:0:b0:4b1:1f35:279b with SMTP id
 a19-20020a194f53000000b004b11f35279bmr8987491lfk.637.1667679502692; Sat, 05
 Nov 2022 13:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
In-Reply-To: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 5 Nov 2022 21:18:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFkp_W4P7twyZhM2mrP0PibOdWAwvKg-rb_jvh08RG_sg@mail.gmail.com>
Message-ID: <CAMj1kXFkp_W4P7twyZhM2mrP0PibOdWAwvKg-rb_jvh08RG_sg@mail.gmail.com>
Subject: Re: Remove WARN_ONCE for unaligned UEFI region?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Nov 2022 at 20:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So this has been going on since I got my M2 laptop, but I finally
> decided it's really annoying and would like it removed..
>
> The arm64 EFI code does that
>
>         if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
>                       "UEFI Runtime regions are not aligned to 64 KB
> -- buggy firmware?"))
>
> for unaligned UEFI data, and that most definitely triggers on the M2.
>
> Yet I can't really see the point of the stack trace and register dump
> for something like this.
>
> IOW, why isn't it just a
>
>         if (!PAGE_ALIGNED(md->phys_addr)) {
>                 pr_warn_once("UEFI Runtime regions are not aligned to
> 64 KB -- buggy firmware?");
>                 return pgprot_val(PAGE_KERNEL_EXEC);
>         }
>
> instead?
>
> As it is, it's just annoying, and doesn't actually even tell anything
> interesting. The stack trace points to arm_enable_runtime_services(),
> which isn't a surprise, and it's obviously just that
> efi_virtmap_init() got inlined.
>
> Now, if it actually mentioned which mapping it was that was unaligned,
> maybe that would be interesting, but it doesn't even do that. So it's
> just noise with no actual information in it.
>
> I get a number of other warnings on the M2 ("Unable to detect cache
> hierarchy for CPU X"), but hey, that's normal. My regular Threadripper
> workstation also has ACPI warnings ("Failure creating named object")
> due to duplicate objects etc. Firmware is buggy - what else is new?
> That's just how life is.
>
> But using WARN_ON() instead of "pr_warn()" for it seems a bit excessive.
>
> I can do that change myself, or take a patch the usual ways, but let's
> get rid of this annoyance, ok? Just let me know.
>

Yeah just rip it out. In the beginning, we tended to make these
warnings noisy so people will actually notice.

I'd still like to see a memory map (boot with efi=debug) so we can get
this reported and fixed in uboot. We need that so 16k and 64k pages
boot doesn't cause surprises with overlapping mappings.
