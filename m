Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1F7710F9
	for <lists+linux-efi@lfdr.de>; Sat,  5 Aug 2023 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjHERhe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Aug 2023 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHERhd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Aug 2023 13:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB6A7;
        Sat,  5 Aug 2023 10:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DC660D2D;
        Sat,  5 Aug 2023 17:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB44C43395;
        Sat,  5 Aug 2023 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691257050;
        bh=er88P3pSiNhk8D9eZqUBu62rZUnMIz6ys4uBzjWyrM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=auM7whtnRCHJH55HvQguO/4nU9uPpJDwzDo5i7kSYZbfc9b1dzFIPIfV8griKHUSj
         21k5rtJXEjljXEOZGux2waf/69P2G0/8LqUSJ6VEUCiUugrHwgefii8v+LaQG7OBrv
         +tVza9tI2GO0QQe25FaYBD23flJDtj8rYagRSE2lh6QVNS2vTIEq4zsaWO7xsB3m4e
         /vsKJ6UEVjv1KeEEt9c7n/prHE8wzp2hZtEcdQXjki5wLxw8VyBOZ9EIVWX12HWlGm
         1hRTV01LtDKeVWL2ex+L3rhehX1PBocBdG3N9SEWSEiD+7Hl+l4EbV21SdI9pvftRV
         v3lekbmgJFygA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so5399108e87.3;
        Sat, 05 Aug 2023 10:37:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxoey6uB7p1TxygSxKp7TvElvNIOgqzmnDcMNrdRiwzZl13h2mZ
        tDqYwo5y928SFu9yD02kfY3QPFUOrONpMWNyjY0=
X-Google-Smtp-Source: AGHT+IGFchYeagNTQ7SWwbt/7/FyYiKbhKgrQpcl+88PJUI1rh6E986/W9zbvtiE2VaapkGpa04yJIwf0LAFR7k5XCs=
X-Received: by 2002:a05:6512:3766:b0:4fb:52a3:e809 with SMTP id
 z6-20020a056512376600b004fb52a3e809mr2555145lft.28.1691257048728; Sat, 05 Aug
 2023 10:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230802154831.2147855-1-ardb@kernel.org> <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
In-Reply-To: <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 5 Aug 2023 19:37:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
Message-ID: <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
Subject: Re: [PATCH v8 00/23] efi/x86: Avoid bare metal decompressor during
 EFI boot
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Aug 2023 at 16:41, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 02, 2023 at 05:48:08PM +0200, Ard Biesheuvel wrote:
> > Update the x86 boot path to avoid the bare metal decompressor when
> > booting via the EFI stub. The bare metal decompressor inherits the
> > loader's 1:1 mapping of DRAM when entering in 64-bit mode, and assumes
> > that all of it is mapped read/write/execute, which will no longer be the
> > case on systems built to comply with recently tightened logo
> > requirements (*).
> >
> > Changes since v7 [10]:
>
> My Zen1 box fails booting with those. It is related to memory encryption
> because if I supply "mem_encrypt=off", it boots.
>
> The failure is (typing it off from the video from the BMC):
>
> /dev/root: Can't open blockdev
> VFS: Cannot open root device "UUID=..."
> Please append a correct "root=" boot option;
> ...
>
> I'll bisect now but it is pretty clear which one is the culprit.
>

So this is the host booting, right? So is the position of the C bit
perhaps getting detect incorrectly?
