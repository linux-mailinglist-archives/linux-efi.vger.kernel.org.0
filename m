Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881AA6721FB
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 16:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjARPs0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 10:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjARPqf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 10:46:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C3D303FE;
        Wed, 18 Jan 2023 07:46:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B71F9B81D92;
        Wed, 18 Jan 2023 15:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD50C433A7;
        Wed, 18 Jan 2023 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674056782;
        bh=lJ/kwmiQYsl9y9vng7yDw5HKTngvmR93U8NLEJb0qC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HGktXM+t0fav2jneq3mlMvIxWBD0QL/poes7B/slAUYayFIgsJRoq7GMyWxQHyQ30
         DYwofhaZCBfUySVcz1+zOh/BO7XS/9vdrb5FbY0Ztp0gnnubaX/uCDceFDUC2B7naf
         XJHto2uEPugeT0p7yw/0hrAoP4vu0n3cl/zEIkwoQRFCYkonCQ2wvsSpjOSbQ8B7Ka
         14JkWnDCqVeZr+L5JTwPVxT1syzgByDDMXLoOiFzlR/yYLvsLkB4MD5ThrGS3AqloN
         A8KHdzZHCPWrpesaPKVueVOIzTOdw9RqO+tVoWM7ppGc09qDM+DhL8ByhiJ9Mt74TE
         86p41mhSUyR3A==
Received: by mail-lf1-f50.google.com with SMTP id bp15so52245474lfb.13;
        Wed, 18 Jan 2023 07:46:22 -0800 (PST)
X-Gm-Message-State: AFqh2kolVIv9e1r11FI0GDfBJGE89jrxbZvRVw8HB6I2/CXPYHx3+Uue
        DzZiuzj3XUBUxZqx5qmGkLEudGY3Awv0u+Ip3uA=
X-Google-Smtp-Source: AMrXdXvKd2ozhrn+S6d4qTJhm2W4B4noZo8m76bKLACYxbKqjGgo6a44usnJhpG+sf2bB37FJHUokCJHIo3g/InSZOY=
X-Received: by 2002:a19:c501:0:b0:4b8:9001:a694 with SMTP id
 w1-20020a19c501000000b004b89001a694mr380330lfe.426.1674056780228; Wed, 18 Jan
 2023 07:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name> <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com> <1818a72f-31ef-07b0-d1b4-6a8904636db2@amd.com>
 <CAMj1kXG7s_B1nyEgsxFRRvUzsWNXcFfTszRA2hKY=_a-L24PZg@mail.gmail.com> <e1986845-9eb9-2147-5073-5d7a45633aba@intel.com>
In-Reply-To: <e1986845-9eb9-2147-5073-5d7a45633aba@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Jan 2023 16:46:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG=rec5HSxfteQnc6ZZ0RnQZq+-wX6HNG5gm4tiSOuH_g@mail.gmail.com>
Message-ID: <CAMj1kXG=rec5HSxfteQnc6ZZ0RnQZq+-wX6HNG5gm4tiSOuH_g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
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

On Wed, 18 Jan 2023 at 16:41, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/18/23 07:09, Ard Biesheuvel wrote:
> > However, I guess we're at a point where SEV and TDX really want
> > different solutions, so I think divergence might be the way to
> > proceed.
>
> I don't think they want different things really.
>
> TDX doesn't need this protocol.  It sounds like SEV does need it,
> though.  That doesn't mean they really diverge.  They're *both* going to
> have to poke at this protocol knob to get the firmware to not accept the
> memory.
>

No, on TDX, the firmware would never accept all memory. On SEV, it
would only do so if the protocol has not been called prior to the call
to ExitBootServices().

> This does slightly change the motivation for doing explicit unaccepted
> memory support in the kernel.
>

Not on TDX.

> I also don't know _quite_ how this will look to a guest.  For instance,
> will they see different memory maps based on which protocol they are
> using?  I assume so, but didn't see any of that explicitly mentioned in
> this patch.

The EFI memory map will not contain ranges of type
EFI_UNACCEPTED_MEMORY if the memory was accepted on behalf of the OS
by the firmware. That is the point, really, as non-enlightened OSes
will ignore those.
