Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279B65F651D
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiJFLTt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiJFLTs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 07:19:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2B6441;
        Thu,  6 Oct 2022 04:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36BBDB8206B;
        Thu,  6 Oct 2022 11:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E589DC433C1;
        Thu,  6 Oct 2022 11:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665055183;
        bh=wh50eBbhJL8z0DHYoyJWlOF+qCE6ZsExUHD9mgoDXFA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c/v5yIHSXwksjYfnKUD7sBFkbUadn0hhSxfmHmIw8sva69GYCwFPuaw8uWmQNKhAz
         87Mnc3+U3Fgg+gnJ4XukXezzVg7ldP1FS4bWxBcluavbdHLsTsA6Lix/y0BdluS9Gl
         UoxNMrbtjE27XJ6PYgis9ptONkvq2GtO1K9seDuFlFpobarogRoYWacMy5eFgO8Dcw
         N/GIZB2xUXaW3Um6LtwWcv6nsT2+R1r5sh9EB9WTMrd02Cf9cUubdMVyqPXt1aTwsM
         hyE0ngeZSHx5kvktZVcnEfofGqtaoFERO0KLMuw/voT/HIe/vBgNYRWpreq6MQp+fj
         yHtfISHGQUKEQ==
Received: by mail-lj1-f178.google.com with SMTP id bn8so1847944ljb.6;
        Thu, 06 Oct 2022 04:19:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf2//FIZ2ObSzJbK2mxwlCCpO0wu6c0mN+4ilaiy0IdH/VnpB5m0
        aWqHYfyIdcR/PZ6JceqsRpqG4BVr+ExKMToeEG4=
X-Google-Smtp-Source: AMsMyM6nzkudLnHW3jJGMUGRB9MgyWq+WN5zc+ioNljelWejGjCp7Uq8juqJcaN/6vql2uz5XHka42fY9z3KGQOZCe8=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mr1661348ljq.152.1665055181979; Thu, 06
 Oct 2022 04:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220921145422.437618-1-ardb@kernel.org> <20220921145422.437618-3-ardb@kernel.org>
 <Yz6xBROUBPyaUSoB@zn.tnic> <CAMj1kXGCWmay_=cncZpZwXoyLgzt7=2dVuXHaaQU=K6NEXrezQ@mail.gmail.com>
 <Yz64aMVo4W+D70Fz@zn.tnic>
In-Reply-To: <Yz64aMVo4W+D70Fz@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 13:19:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHi4TgGd=vicfxVOUnzDrhSfsiR=572L6cEwi47JO17jw@mail.gmail.com>
Message-ID: <CAMj1kXHi4TgGd=vicfxVOUnzDrhSfsiR=572L6cEwi47JO17jw@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] x86/compressed: efi-mixed: move 32-bit
 entrypoint code into .text section
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Oct 2022 at 13:13, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Oct 06, 2022 at 12:56:09PM +0200, Ard Biesheuvel wrote:
> > efi32_pe_entry() preserves and restores the caller's value of %ebx,
> > because from there, we might actually return control to the firmware.
> > The value it keeps in %ebx itself is not live when it jumps to
> > efi32_entry - it stores its value into image_offset, which is reloaded
> > from memory at a later point.
>
> Hmm, might be prudent to have a comment there because it is using %ebx a
> couple of insns before the JMP:
>
>         subl    %esi, %ebx
>                       ^^^^
>         movl    %ebx, rva(image_offset)(%ebp)   // save image_offset
>
> <--- I think you mean that after this, %ebx is not needed anymore?
>

Exactly.

>         xorl    %esi, %esi
>         jmp     efi32_entry
>
> 2:      popl    %edi                            // restore callee-save registers
>         popl    %ebx
>
> and this restores its original value ofc.
>
> > efi32_stub_entry() is the 'EFI handover protocol' entry point, which
> > cannot return to the firmware (and we discard the return address
> > already) so %ebx can be clobbered.
>
> That info would be good to have in a comment above it.
>

Fair enough.
