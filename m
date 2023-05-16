Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9CE705594
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjEPSBy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 14:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEPSBy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 14:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9AC3A81;
        Tue, 16 May 2023 11:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C21963D7A;
        Tue, 16 May 2023 18:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008BFC433AE;
        Tue, 16 May 2023 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684260112;
        bh=fTMeSN7AzVHCiTkT+f9pmwZrYPpPz9puMnicx/1cTkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RlotsGFNhRhoLtH8XEDeUgZi0A9QysXGzNW8uROo+1oL6hMQNZvWQDrnhux+u4kuL
         rBR59dmF/PkfieVlBNIH1U1SIcpn0efnUOGY3QnJJtnJ4UrDjHDcH5D9BhjF4kBaZ8
         bBRiBA/tSfue4MAsveruziEiuKBZXaGVBbBHbJo7QB4ByWcpqPORiEgRXW3lfSlaZe
         vhxpodHCgI5iUhqpiYlCygt5y6dfBbI0TX3fSEyE2Fu1uRkyevrX1u4p12epe/aDh2
         E8lkieM74b5CRgpImmOljoSHYCgGLLGVIGkWnZfUVCItCqyIIOLcoTGf6Igll8FGOP
         HDcxizFz2RvQQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f00d41df22so5965380e87.1;
        Tue, 16 May 2023 11:01:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDz/3ocs2lhoWG4IBLPTMn6f5yEqLPkKQgzdX/Gxdj9OVZkKOae8
        V7p1ulzO7YeX0vvdhGgyZL5TC5RoqUXb8m3ZXi8=
X-Google-Smtp-Source: ACHHUZ5mkGKvbS8jLvIh+c+5mkY/if/pIGe5q1s0NkvzsdFe2AoncbM41M63JlAbaP+eAQpipVwoyg4qvgPfbmTVI+I=
X-Received: by 2002:a05:651c:1728:b0:2a9:f9e0:a820 with SMTP id
 be40-20020a05651c172800b002a9f9e0a820mr7846949ljb.11.1684260109821; Tue, 16
 May 2023 11:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-4-kirill.shutemov@linux.intel.com> <9549d984-e581-048d-95a3-7c54acd70fb8@redhat.com>
 <20230514211324.fymzoa263wx2hs2p@box.shutemov.name>
In-Reply-To: <20230514211324.fymzoa263wx2hs2p@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 20:01:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGzqfHVcg2EAeXqnHG0mmg3ykOBVEa8OpJHc-+k2Xx2Aw@mail.gmail.com>
Message-ID: <CAMj1kXGzqfHVcg2EAeXqnHG0mmg3ykOBVEa8OpJHc-+k2Xx2Aw@mail.gmail.com>
Subject: Re: [PATCHv11 3/9] efi/libstub: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 14 May 2023 at 23:13, Kirill A. Shutemov <kirill@shutemov.name> wro=
te:
>
> On Sun, May 14, 2023 at 08:08:07AM +0300, Mika Penttil=C3=A4 wrote:
> > > +   status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > > +                        sizeof(*unaccepted_table) + bitmap_size,
> > > +                        (void **)&unaccepted_table);
> >
> >
> > Wonder if EFI_LOADER_DATA guarantees bitmap not to be freed, or should =
some
> > more persistent type be used. If EFI_LOADER_DATA is enough, maybe a com=
ment
> > why it is safe could be added.
>
> Ughh.. I've lost the hunk that reserves the memory explicitly while
> folding in the patch we discussed with Ard. See below.
>
> But the question is solid.
>
> Ard, do we want to allocate the memory as EFI_RUNTIME_SERVICES_DATA (or
> something else?) that got reserved automatically without additional steps=
?
>


EFI loader data should be fine here, as long as we reserve it.

EFI runtime services data is intended for allocations that have
significance to the firmware itself, so it gets mapped into the EFI
runtime page tables and on some architectures, it gets removed from
the direct map as well.

The unaccepted bitmap is only accessed by the OS itself, so runtime
services data is really not the right choice. We just have to ensure
the bitmap gets reserved in memblock sufficiently early.

> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index e15a2005ed93..d817e7afd266 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -765,6 +765,25 @@ int __init efi_config_parse_tables(const efi_config_=
table_t *config_tables,
>                 }
>         }
>
> +       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> +           efi.unaccepted !=3D EFI_INVALID_TABLE_ADDR) {
> +               struct efi_unaccepted_memory *unaccepted;
> +
> +               unaccepted =3D early_memremap(efi.unaccepted, sizeof(*una=
ccepted));
> +               if (unaccepted) {
> +                       unsigned long size;
> +
> +                       if (unaccepted->version =3D=3D 1) {
> +                               size =3D sizeof(*unaccepted) + unaccepted=
->size;
> +                               memblock_reserve(efi.unaccepted, size);
> +                       } else {
> +                               efi.unaccepted =3D EFI_INVALID_TABLE_ADDR=
;
> +                       }
> +
> +                       early_memunmap(unaccepted, sizeof(*unaccepted));
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
