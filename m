Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCAE6720A6
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 16:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjARPJm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 10:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjARPJe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 10:09:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA9A23C63;
        Wed, 18 Jan 2023 07:09:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396B861882;
        Wed, 18 Jan 2023 15:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BDC4339B;
        Wed, 18 Jan 2023 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674054572;
        bh=TGrJM/Z4UZIYD/nTOz+s34yWyW616YGOhgh+xuBnLNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J61GpLi7jzMgLNpoIHP+duq/KfyDYFuj8uqjuwvViozeraO5UYrhND/YJwJaygn+V
         vN+YB2AucxojyDBCSyrDuyxQXDBr7h3AKfm8/zf6JRqTIwRFB9eeza43WJtGbrN1Jf
         9rIKxl20fDjoAPjlDjmZlriI03HxAP18fdIV0Tm0ksv0EPaWrarvPvbq4aauumy2eV
         bxoHfqhZzxIGU/vvVUAsqCYNEkYIN7ITBuQz2QdhbhI/WszUY5OXkDq1s7aw+s1YER
         ShlIs56SHZz5Hvz8PnZWFYdUSXP70QgRdUW8WIGRtZhvJYxFa2f10aH8MQSBWP6YRc
         YZFa/JRRW1dkA==
Received: by mail-lf1-f41.google.com with SMTP id o20so20136050lfk.5;
        Wed, 18 Jan 2023 07:09:32 -0800 (PST)
X-Gm-Message-State: AFqh2kpfbXVn7F8AlXIfpVykcutgeJRiSKXgbrTdBWqzUZXCXed7GwlV
        NfvgIVFudijgB5svY26GuU9FHt2VXb9Xmudrtm4=
X-Google-Smtp-Source: AMrXdXuEmpdbM2h2hznzVk51O5SZEGdzUoGrzdEAdYc2vIg2hGVA4VZFyoQzK5oflRTKM2a+w1VCxxrZYTGhwGOB/3o=
X-Received: by 2002:ac2:4ade:0:b0:4d0:7b7:65dc with SMTP id
 m30-20020ac24ade000000b004d007b765dcmr323651lfp.122.1674054570399; Wed, 18
 Jan 2023 07:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name> <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com> <1818a72f-31ef-07b0-d1b4-6a8904636db2@amd.com>
In-Reply-To: <1818a72f-31ef-07b0-d1b4-6a8904636db2@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Jan 2023 16:09:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG7s_B1nyEgsxFRRvUzsWNXcFfTszRA2hKY=_a-L24PZg@mail.gmail.com>
Message-ID: <CAMj1kXG7s_B1nyEgsxFRRvUzsWNXcFfTszRA2hKY=_a-L24PZg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc'ing some folks whom I've discussed this with off-list today)

Full discussion here:
https://lore.kernel.org/linux-efi/20230113212926.2904735-1-dionnaglaze@google.com/

On Mon, 16 Jan 2023 at 23:46, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 1/16/23 15:22, Dave Hansen wrote:
> > On 1/16/23 02:56, Gerd Hoffmann wrote:
> >>> And we add this protocol to address very temporary problem: once
> >>> unaccepted memory support get upstream it is just a dead weight.
> >> Maybe, maybe not.  unaccepted memory support has a Kconfig switch after
> >> all.  If we figure in 3-5 years that all distros have enabled it anyway
> >> we can drop it again.  For the transition period it will surely be
> >> useful.
> >
> > I agree with Kirill here.
> >
> > Having unaccepted memory *AND* this firmware-driven feature really is
> > just implementing the same thing twice.
>
> I'm not sure I follow you. This feature merely tells the firmware whether
> or not the OS supports unaccepted memory, which then tells the firmware
> whether it needs to accept the memory or whether the kernel can.
>
> We have had SNP guest support since 5.19 without support for unaccepted
> memory. Imagine now using a newer OVMF that can support unaccepted memory.
> How does the firmware know whether it must accept all the memory or
> whether it can advertise unaccepted memory. By having the kernel call this
> boot service protocol once support for unaccepted memory is in place, the
> firmware now knows that it need not accept all the memory.
>

So if people deploying SEV agree that this is a useful feature to
have, and people working on TDX saying this protocol must never exist,
I think the obvious conclusion is that OVMF should only expose it when
running on SEV.

However, I am still failing to grasp why there is disagreement here.
Linux already implements SEV support but unaccepted memory protocol is
not supported yet, and so it is crystal clear that we need something
to bridge the compatibility gap. Without this protocol, firmware must
never accept memory, and the OS must always take charge of this, even
if it prefers to accept memory eagerly.

With this protocol in place, acceptance becomes a policy decision,
where the default policy is 'accept' for OS implementations that have
no understanding of unaccepted memory or the protocol. 'Enlightened'
OSes can still decide not to call the protocol and therefore not
having to bother with acceptance at all, given that the firmware will
take care of it.

As for the 'legacy' boot method: this bootloader can decide for itself
whether or not it needs to invoke the protocol, and can invent its own
methods for communicating/inspecting the OS image to obtain the
information to base this decision on. This is outside of the scope of
EFI. However, I also disagree with the binary 'no solution shall
exist' vs 'a solution must cover every imaginable combination of
bootloader and OS image': it makes sense to be pragmatic here, and
limit ourselves to what people are actually deploying. And given the
default behavior fo 'accept everything', the only penalty for ignoring
the legacy bootloader case is a slower boot.

I have been on the sidelines for most of the OVMF and Linux
development regarding confidential compute, but where I did get
involved, it was to try and reach consensus between the different
technologies (including the ARM one), to avoid ending up with radical
different approaches for doing the same thing.

However, I guess we're at a point where SEV and TDX really want
different solutions, so I think divergence might be the way to
proceed.
