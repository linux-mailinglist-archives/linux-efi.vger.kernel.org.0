Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF290664354
	for <lists+linux-efi@lfdr.de>; Tue, 10 Jan 2023 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjAJOdY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 09:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbjAJOc4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 09:32:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF451392DB;
        Tue, 10 Jan 2023 06:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B7166173E;
        Tue, 10 Jan 2023 14:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25F9C4339B;
        Tue, 10 Jan 2023 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673361175;
        bh=0U45HmZgegjPkMDOmrkm9NMlqi4zLwodMY8zNt/kRWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dfkXfpnXa63c3D8jyq0ORhwvSloUoK8fCFgqaZvZ+wRd3qSdNsCh6m8XRWaEkXxZX
         AsATo/OHKnIGbYKcP3wG+JIioJsbQ4dh4yuiNXo1ca/Wq/XX52ni59C1dBRQqEyF+W
         wIgoU4t89Sf2ykDuy7/Ng4J79qKpkLlzJkNUXiEqqmuJSHolUCOQyqKk+WSjcKQDGa
         w8PTaX4rEt1lcI/fjvFrqGC6dA8gq5q9IZhVfnYsEhQLjaM1lEBaF0OPyCskHASvwp
         7RAcFb4OqtdS4oXS9AvPrtplbOPTPlg+2Q4HRRoYttbrsuTCpzEClNUqqKg3hBNtSe
         NyY1JcIBXavSA==
Received: by mail-lf1-f48.google.com with SMTP id bt23so18687262lfb.5;
        Tue, 10 Jan 2023 06:32:54 -0800 (PST)
X-Gm-Message-State: AFqh2kokfitk29qHGRfAy8UFxqXX9YluPhlf37OY7CmEfepqHlpWQdoz
        p/BG1zT1OpgSxQdk9V+dT87HD3snPOWUCY6fZ+U=
X-Google-Smtp-Source: AMrXdXu6SHV+bJRSe9pB8EUBgBNaA/0cKm1zCebRcx57RXXlXO0ObqPFLAM1XRlK5LKNxQ2L6PsNtj6NR6LXqm5KLCY=
X-Received: by 2002:ac2:4a72:0:b0:4b6:f37c:c123 with SMTP id
 q18-20020ac24a72000000b004b6f37cc123mr4822738lfp.539.1673361172997; Tue, 10
 Jan 2023 06:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20221221105402.6598-1-markuss.broks@gmail.com>
 <CAMj1kXGUC7dsSwVEUsAMeAoqDYtbqrM7SDOJTXbPfi-LrcSk9g@mail.gmail.com> <97639381-2558-4cf5-75b0-7f80f0393b16@gmail.com>
In-Reply-To: <97639381-2558-4cf5-75b0-7f80f0393b16@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 10 Jan 2023 15:32:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE-GMxemfDA=CLvLUZeN7fHv6Ds2L2a2swYea8Q9U+b8g@mail.gmail.com>
Message-ID: <CAMj1kXE-GMxemfDA=CLvLUZeN7fHv6Ds2L2a2swYea8Q9U+b8g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add generic framebuffer support to EFI earlycon driver
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Jami Kettunen <jami.kettunen@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 23 Dec 2022 at 15:58, Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Hi Ard,
>
> On 12/23/22 16:42, Ard Biesheuvel wrote:
> > (cc Andy)
> >
> >
> > On Wed, 21 Dec 2022 at 11:54, Markuss Broks <markuss.broks@gmail.com> wrote:
> >> Make the EFI earlycon driver be suitable for any linear framebuffers.
> >> This should be helpful for early porting of boards with no other means of
> >> output, like smartphones/tablets. There seems to be an issue with early_ioremap
> >> function on ARM32, but I am unable to find the exact cause. It appears the mappings
> >> returned by it are somehow incorrect, thus the driver is disabled on ARM.
> > The reason that this driver is disabled on ARM is because the struct
> > screen_info is not populated early enough, as it is retrieved from a
> > UEFI configuration table.
>
> I believe I must be hitting some other bug then, since my driver should
> not use `struct screen_info` when the arguments are specified manually
> (e.g. in device-tree or in kernel command line options), and it still is
> broken on ARM when they are.

Define 'broken'

> I got it to work on ARM when I moved the
> early console initialization later into the kernel booting process, but
> that mostly defeats the purpose of early console driver, I believe. I've
> been thinking that it could be some stuff not getting initialized early
> enough indeed, but I've got no clue what could it be.
>

This is likely due to the fact that the ARM init code sets up the PTE
bits for various memory types, and using them beforehand is likely to
result in problems.
