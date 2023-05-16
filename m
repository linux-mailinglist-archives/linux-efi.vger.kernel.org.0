Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0520A7055A9
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjEPSIz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 14:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEPSIy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 14:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDDAA7;
        Tue, 16 May 2023 11:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D960C63B92;
        Tue, 16 May 2023 18:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4098AC433AC;
        Tue, 16 May 2023 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684260532;
        bh=EuLTL0z0cItgFiTcg+BNi9m4MmZo8uZTaS650kq9lR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eqrkQFx6rhRJujq4VWj4FzAyNGWYXTRwwDgyA5V3A+MHAv5k+HnqxBOF4OIy8cZkJ
         wlr/nGLB9U0awyzmtcWNdiQ3locGkyOpSlHrOTZrHPz7cdw7STS6cmzLETt17aRQUZ
         fkQu/Cq+SFiadTqPuOBZ5gStXcB2xqJYRpSp+bJKGfBGn7le4a7xeNDV1zbX5ztiGx
         i1ohR7qwbhExdzokVQagdx9ZsrS2RI8U+e8S3buraBXpfYStZQ09HaTMP8x2/bNuzr
         NG/f2QhWBJ8vXT5AilkZk2rYXxj5Eqo367bSvv+7iOHdMvmmK+W+kd5ieeRNFAJzFQ
         tQ3jSabpkTbMQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so154913331fa.3;
        Tue, 16 May 2023 11:08:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDwLdyjqtT8PSkYRcIWAXcU1EZICFlgoMXj7Son0qzc2L/F9DwpZ
        Z+GdwTcmNpEkK6AVXWE5deDt4V+Lqu4G4Gfe8pc=
X-Google-Smtp-Source: ACHHUZ5+shXS/oY0pTS/6qckGGB5Nhpshb8lVSqz1yNpZtyaX4Fz38IBjMuv/6+PbSqztZeXv7E5jFQB3se1sORtPTk=
X-Received: by 2002:a2e:9056:0:b0:2a8:bf35:3b7 with SMTP id
 n22-20020a2e9056000000b002a8bf3503b7mr7472306ljg.32.1684260530160; Tue, 16
 May 2023 11:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com> <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 20:08:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
Message-ID: <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 14 May 2023 at 00:04, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
>
> But, this approach does not work for unaccepted memory. For TDX, a load
> from unaccepted memory will not lead to a recoverable exception within
> the guest. The guest will exit to the VMM where the only recourse is to
> terminate the guest.
>

Does this mean that the kernel maps memory before accepting it? As
otherwise, I would assume that such an access would page fault inside
the guest before triggering an exception related to the unaccepted
state.

> There are two parts to fix this issue and comprehensively avoid access
> to unaccepted memory. Together these ensure that an extra "guard" page
> is accepted in addition to the memory that needs to be used.
>
> 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
>    checks up to end+unit_size if 'end' is aligned on a unit_size
>    boundary.
> 2. Implicitly extend accept_memory(start, end) to end+unit_size if 'end'
>    is aligned on a unit_size boundary.
>
> Side note: This leads to something strange. Pages which were accepted
>            at boot, marked by the firmware as accepted and will never
>            _need_ to be accepted might be on unaccepted_pages list
>            This is a cue to ensure that the next page is accepted
>            before 'page' can be used.
>
> This is an actual, real-world problem which was discovered during TDX
> testing.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  drivers/firmware/efi/unaccepted_memory.c | 35 ++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index bb91c41f76fb..3d1ca60916dd 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -37,6 +37,34 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>         start -= unaccepted->phys_base;
>         end -= unaccepted->phys_base;
>
> +       /*
> +        * load_unaligned_zeropad() can lead to unwanted loads across page
> +        * boundaries. The unwanted loads are typically harmless. But, they
> +        * might be made to totally unrelated or even unmapped memory.
> +        * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
> +        * #VE) to recover from these unwanted loads.
> +        *
> +        * But, this approach does not work for unaccepted memory. For TDX, a
> +        * load from unaccepted memory will not lead to a recoverable exception
> +        * within the guest. The guest will exit to the VMM where the only
> +        * recourse is to terminate the guest.
> +        *
> +        * There are two parts to fix this issue and comprehensively avoid
> +        * access to unaccepted memory. Together these ensure that an extra
> +        * "guard" page is accepted in addition to the memory that needs to be
> +        * used:
> +        *
> +        * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
> +        *    checks up to end+unit_size if 'end' is aligned on a unit_size
> +        *    boundary.
> +        *
> +        * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
> +        *    'end' is aligned on a unit_size boundary. (immediately following
> +        *    this comment)
> +        */
> +       if (!(end % unit_size))
> +               end += unit_size;
> +
>         /* Make sure not to overrun the bitmap */
>         if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
>                 end = unaccepted->size * unit_size * BITS_PER_BYTE;
> @@ -84,6 +112,13 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
>         start -= unaccepted->phys_base;
>         end -= unaccepted->phys_base;
>
> +       /*
> +        * Also consider the unaccepted state of the *next* page. See fix #1 in
> +        * the comment on load_unaligned_zeropad() in accept_memory().
> +        */
> +       if (!(end % unit_size))
> +               end += unit_size;
> +
>         /* Make sure not to overrun the bitmap */
>         if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
>                 end = unaccepted->size * unit_size * BITS_PER_BYTE;
> --
> 2.39.3
>
