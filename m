Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47C4708B9F
	for <lists+linux-efi@lfdr.de>; Fri, 19 May 2023 00:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjERWdg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 May 2023 18:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERWdf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 May 2023 18:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC5E5E;
        Thu, 18 May 2023 15:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9759651A9;
        Thu, 18 May 2023 22:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B42AC433EF;
        Thu, 18 May 2023 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684449213;
        bh=3SPU5sYCnrWeME1i5HOqaeY2hIR0bEqSK30+Pg6ijac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KlHYXS62CGuLV8DSciHZZCFtTYEdufIG51eXIpM+9tCZYdP0nHcUGwRxKlIxwSrS2
         ZJRj7HtKlZEvjw+4DkRdLivhyV0rpOEduLE3dBqxkygRuuF7BBA5egzipt82CF2PU+
         PeEAwun21VCuDlxKTJNu4B2jqiY9Jz2DaVGCrQBjVItiBx+nLu/FZ198xVugT1ANr0
         6mxO5eBWgS74EaVOz0pGf0ACIYbdm4pjuir0t8ArPAuYkmzGPCZYzpc3+YU5a2/vBJ
         HPG4MjWR0nZyUfvL48S/jMIBk+pWR8WisjUzbAdvIwjG2GqwcsSu4LRLmN24bFVd6i
         RN7sz2NQ5pXgg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2acb6571922so27339801fa.0;
        Thu, 18 May 2023 15:33:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDzA9cmwfCu3tI2vUWCweLc4FkC3v5Hz5wssFA3/aGFMqZK6LC4M
        HlGvK9U/Zk6QsNFK1W124e/bsSb1UC2RXjKkNCc=
X-Google-Smtp-Source: ACHHUZ5IRxLoqvZxPYcymgaw53tZjrhR3fjx5Z+MQT5nRSGG07wxfBt38v/3TDIdBeTbxRwTltHqAhNaMy+p2JLu/FI=
X-Received: by 2002:a2e:9989:0:b0:2ad:ad0b:d0fb with SMTP id
 w9-20020a2e9989000000b002adad0bd0fbmr12603486lji.30.1684449211337; Thu, 18
 May 2023 15:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230508070330.582131-1-ardb@kernel.org> <20230508070330.582131-19-ardb@kernel.org>
 <a7580b4c-09f3-da32-8547-5b0193709c16@amd.com>
In-Reply-To: <a7580b4c-09f3-da32-8547-5b0193709c16@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 May 2023 00:33:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFvfyPibZWTLUaLb6pJQWJbV2p7wV__dcCAyjLAuPrtQg@mail.gmail.com>
Message-ID: <CAMj1kXFvfyPibZWTLUaLb6pJQWJbV2p7wV__dcCAyjLAuPrtQg@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] x86: efistub: Avoid legacy decompressor when
 doing EFI boot
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 18 May 2023 at 22:48, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/8/23 02:03, Ard Biesheuvel wrote:
> > The bare metal decompressor code was never really intended to run in a
> > hosted environment such as the EFI boot services, and does a few things
> > that are problematic in the context of EFI boot now that the logo
> > requirements are getting tighter.
> >
> > In particular, the decompressor moves its own executable image around in
> > memory, and relies on demand paging to populate the identity mappings,
> > and these things are difficult to support in a context where memory is
> > not permitted to be mapped writable and executable at the same time or,
> > at the very least, is mapped non-executable by default, and needs
> > special treatment for this restriction to be lifted.
> >
> > Since EFI already maps all of memory 1:1, we don't need to create new
> > page tables or handle page faults when decompressing the kernel. That
> > means there is also no need to replace the special exception handlers
> > for SEV. Generally, there is little need to do anything that the
> > decompressor does beyond
> >
> > - initialize SEV encryption, if needed,
> > - perform the 4/5 level paging switch, if needed,
> > - decompress the kernel
> > - relocate the kernel
> >
> > So let's do all of this from the EFI stub code, and avoid the bare metal
> > decompressor altogether.
>
> This patch crashes SEV guests, probably because of the BSS is accessed
> encrypted and results in ciphertext for what would be a zero for a non-SEV
> guest. After pushing patch #19 everything started working again. From a
> bisectability perspective, you probably want patch #19 before this one.
>

Noted, thanks.
