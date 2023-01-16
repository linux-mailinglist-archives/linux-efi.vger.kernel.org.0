Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2466BF4D
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 14:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjAPNPA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 08:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjAPNOY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 08:14:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19320062;
        Mon, 16 Jan 2023 05:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F54AB80E3B;
        Mon, 16 Jan 2023 13:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6D3C43392;
        Mon, 16 Jan 2023 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673874700;
        bh=ViLRsNYn/+STNoQKh82qpwjuc9u2kMaHr8Vsiu+ew4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=evik7e7CJUbBiMDkvWQ1PG5bIg235a2y6Q6NXGMpvkjsU6x10gOt0M/Nxjc8XwyIb
         QHICKn4epsHlG1KkEB5Kmp3gYZaTnvss63mNTTI0Q3am6TiWEgJgIo3EPEOHvfyQih
         JvD+blAcqsQJhHgaHelRNeTDtMxexf43ZOGYmpxiI0ToUw3u3FTrWRignW9Uav3gAY
         WH9CNopUqiBH4ohZas+QC/TH5QQCn5NP3GuAF8oeRxnpNWyKagJwDH5G+KB5J7Obc7
         Leujp3a8ie+Y9Rl4do/ukOHIoll2eJ6xpLC0G1c5UU5GC7s/HMZi0Ej9HLiymbGJs8
         9L5AVUNvVSMtw==
Received: by mail-lj1-f181.google.com with SMTP id s25so29954570lji.2;
        Mon, 16 Jan 2023 05:11:39 -0800 (PST)
X-Gm-Message-State: AFqh2korQU5xhANQzoPf/lvE2b8Tu83ojP5/3MXsNK+Vsgg6j1lF1EBu
        qMiPZ6POrPFgxbXVUx8+AFrzqWgjp3pcodDGiyQ=
X-Google-Smtp-Source: AMrXdXt53zMwSzWq+4aycjXl4Sq3X2MS1v3PCFPahTyknXjfsVr8l69bBAJmRpKeVj9au9FE1N22gXugS2wMY0JOfTw=
X-Received: by 2002:a2e:bd0c:0:b0:27f:bc58:3924 with SMTP id
 n12-20020a2ebd0c000000b0027fbc583924mr5987806ljq.352.1673874698000; Mon, 16
 Jan 2023 05:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name> <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name>
In-Reply-To: <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 16 Jan 2023 14:11:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
Message-ID: <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
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

On Mon, 16 Jan 2023 at 13:31, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Jan 16, 2023 at 11:56:48AM +0100, Gerd Hoffmann wrote:
> > On Sat, Jan 14, 2023 at 01:20:24AM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Jan 13, 2023 at 09:29:26PM +0000, Dionna Glaze wrote:
> > > > This patch depends on Kirill A. Shutemov's series
> > > >
> > > > [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory
> > > >
> > > > The UEFI v2.9 specification includes a new memory type to be used in
> > > > environments where the OS must accept memory that is provided from its
> > > > host. Before the introduction of this memory type, all memory was
> > > > accepted eagerly in the firmware. In order for the firmware to safely
> > > > stop accepting memory on the OS's behalf, the OS must affirmatively
> > > > indicate support to the firmware.
> > >
> > > I think it is a bad idea.
> > >
> > > This approach breaks use case with a bootloader between BIOS and OS.
> > > As the bootloader does ExitBootServices() it has to make the call on
> > > behalf of OS when it has no idea if the OS supports unaccepted.
> >
> > Nothing breaks, it'll error on the safe side.  If the protocol callback
> > is not called the firmware will simply accept all memory.  The guest OS
> > will only see unaccepted memory if it explicitly asked for it (assuming
> > the firmware wants know to support both cases, of course the firmware
> > could also enforce the one or the other and just not offer the
> > protocol).
>
> How bootloader suppose to know if OS will ask for unaccepted memory?
> It can't. It means the use-case with bootloader cannot ever use
> unaccepted memory. That's broken design.
>

I still don't understand why we need to support every imaginable
combination of firmware, bootloader and OS. Unaccepted memory only
exists on a special kind of virtual machine, which provides very
little added value unless you opt into the security and attestation
features, which are all heavily based on firmware protocols. So why
should care about a EFI-aware bootloader calling ExitBootServices()
and subsequently doing a legacy boot of Linux on such systems?
