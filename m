Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EEA525B09
	for <lists+linux-efi@lfdr.de>; Fri, 13 May 2022 07:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377099AbiEMFeP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 May 2022 01:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377095AbiEMFeO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 May 2022 01:34:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C651916A257
        for <linux-efi@vger.kernel.org>; Thu, 12 May 2022 22:34:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso79089877b3.9
        for <linux-efi@vger.kernel.org>; Thu, 12 May 2022 22:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzuLZkvGtBtGQw1pDL6vVc7H+kdQt/J9TPee+0oSim0=;
        b=aJUNIyh0bt3QZBpNiFdkambzLl3faJNTEzhdur1OgekhYmVwx4JYk0LTXQcg+OFwzx
         tgWk34RcWG8/Y4/7fPJJ1tzImbyE1MXVgT1f/btb2jmoOI03bWLr3qJsQbJ0poQdQQph
         eQvRtlvKAdyr82raWhu+JQi2JNaKpAbyuZYMA4jCcoXxv3sHPJpenbeWg2gOCUq8QR7l
         Id3os4GVb0FoGWuliBiz4c2TXNY1sV5sApK6JdyfvfH2WSD/RIT+54qt4Yd7/Z7Phj20
         04xEmautD+SZxJB9aakX8kR52XAMIniucHIOgzuPJYUXP/RRj1fxItIHfNvmlh+TXQ0Y
         dVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzuLZkvGtBtGQw1pDL6vVc7H+kdQt/J9TPee+0oSim0=;
        b=toKsh4dyTqpIEWipFdaFagxiyJDfQ850oBA4rdWVv4vFbhUf+g3G0yurggUNJCCxNd
         i/GFfgRJDlYst7OLUmesCU+D8xeRjzXoxWMKfgdaLTNzPdk+STUF4ZVeJyUWbFSmGwWN
         65NRQ/AKQcFEef9p6q+ocFhMjJ+bs48MupsBuzzs6+VEdV8WTwtPw0++XLQfQR5fi9Tr
         KtJIyznbEEm0QBxLfAaPcbPfa6RN8P3OsJf9VXzeK8xe2K4R+8QMyCtYp5eRW/6OSD8s
         8cD3KW0S7U1XFVI+q0mTzzhQdpYo/nAPBfnAjV64oY/alMSqme4clTIrDT8n1ESNAvuL
         1tLw==
X-Gm-Message-State: AOAM533gwy3MXqivDqtAmbJXU8tyiJiCjKJM3YewAdono8hvyFLnY9Xm
        AeeA/h/MZZX6e5FB1HnPIJiodXV7xhYMb0W96AsXJg==
X-Google-Smtp-Source: ABdhPJzbvJITAyF9pezasvdbf9Ebv/WVdiqeWUMVoaO1Sw2Z4IgmSKbjl1gIk4rgrnQk4UVM1yDalurYFkxnnMGZV0c=
X-Received: by 2002:a0d:db43:0:b0:2f8:9a:8c1d with SMTP id d64-20020a0ddb43000000b002f8009a8c1dmr3941612ywe.72.1652420052877;
 Thu, 12 May 2022 22:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com> <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name> <YnpGnMoviGoK4Ucq@zn.tnic>
In-Reply-To: <YnpGnMoviGoK4Ucq@zn.tnic>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 12 May 2022 22:34:02 -0700
Message-ID: <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Kirill, I've been tracking these changes to see if we can handle the
unaccepted memory type for SEV-SNP, but testing has been an issue. The
proposed patch in Ovmf to introduce unaccepted memory seems to have
stalled out last September
(https://www.mail-archive.com/devel@edk2.groups.io/msg35842.html) and
is particularly difficult to adapt to SEV-SNP since it doesn't follow
the TDVF way of initializing all memory. Is there a different
development I might have missed so that we might test these cases?
Without the UEFI introducing EFI_UNACCEPTED_MEMORY type, any kernel
uses are essentially dead code.

Thanks,
-Dionna

(apologies for repost in text mode)

On Tue, May 10, 2022 at 4:04 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, May 06, 2022 at 06:30:13PM +0300, Kirill A. Shutemov wrote:
> > I find it harder to follow.
>
> If in doubt, always consider using a helper function:
>
> ---
>
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> index 7db2f41b54cd..cf475243b6d5 100644
> --- a/arch/x86/boot/compressed/efi.h
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -32,6 +32,7 @@ typedef       struct {
>  } efi_table_hdr_t;
>
>  #define EFI_CONVENTIONAL_MEMORY                 7
> +#define EFI_UNACCEPTED_MEMORY          15
>
>  #define EFI_MEMORY_MORE_RELIABLE \
>                                 ((u64)0x0000000000010000ULL)    /* higher reliability */
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 28b91df9d31e..39bb4c319dfc 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -671,6 +671,23 @@ static bool process_mem_region(struct mem_vector *region,
>  }
>
>  #ifdef CONFIG_EFI
> +
> +/*
> + * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are guaranteed
> + * to be free.
> + */
> +static inline bool memory_type_is_free(efi_memory_desc_t *md)
> +{
> +       if (md->type == EFI_CONVENTIONAL_MEMORY)
> +               return true;
> +
> +       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> +               if (md->type == EFI_UNACCEPTED_MEMORY)
> +                       return true;
> +
> +       return false;
> +}
> +
>  /*
>   * Returns true if we processed the EFI memmap, which we prefer over the E820
>   * table if it is available.
> @@ -723,21 +740,9 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>                  * free memory and thus available to place the kernel image into,
>                  * but in practice there's firmware where using that memory leads
>                  * to crashes.
> -                *
> -                * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
> -                * supported) are guaranteed to be free.
>                  */
> -
> -               switch (md->type) {
> -               case EFI_CONVENTIONAL_MEMORY:
> -                       break;
> -               case EFI_UNACCEPTED_MEMORY:
> -                       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> -                               break;
> +               if (!memory_type_is_free(md))
>                         continue;
> -               default:
> -                       continue;
> -               }
>
>                 if (efi_soft_reserve_enabled() &&
>                     (md->attribute & EFI_MEMORY_SP))
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
-Dionna Glaze, PhD (she/her)
