Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBF4CBA1D
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiCCJXx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 04:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiCCJW4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 04:22:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F21768CD;
        Thu,  3 Mar 2022 01:22:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0756261C3F;
        Thu,  3 Mar 2022 09:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69242C34101;
        Thu,  3 Mar 2022 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646299329;
        bh=iXq0ELG0V7/AnDh81T6u19yP5MwiSYcM6qTcBJBe4OA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BLN8UtJxH2XlmmKj6rKAbVrjo3Pon/hgpSka8U3+lkFp83NAiJPVWDlenOAuu40Zu
         JshkUbmydrKwtwN8VZjMUeRtJFeaXG0VX7bKkd27RGXG1TIIX1EGU1hvag1kRwT0dO
         E6fyVvn4RzWjt772MSVPyl8GRYpowkXv+cDAXglgV7lXIUDniyBoKZGqNxd7Ln1MYP
         fiOzU2YuRWuEZIdSGi/E3OfTjycqqkYll8bP7dIPybg4wEJvvf70/RD5md268T6fPC
         yoHz3VHHbQzueVLBvJTt8aB5F8/zNasWgOh1BQhZukuND+2NmCgKw38T22Tlvt39pr
         IZpNbHU7B909w==
Received: by mail-yb1-f178.google.com with SMTP id f38so8956524ybi.3;
        Thu, 03 Mar 2022 01:22:09 -0800 (PST)
X-Gm-Message-State: AOAM5302Z5u2pfmbKE7QZzzGeYSVLEq58A+4Jk6Cb9FB37dZbPLckMKr
        WRlKZgGTYcfug2VCEehQLMIIc+4RcVBF+wyUhgs=
X-Google-Smtp-Source: ABdhPJzGxW9K6XK02dNQgFGymwfkQglSqb+hdrqFixJgS607dC1+UsEFXJMQe/H318w5RYW/Cg+KjYeLPNx5dYV37BA=
X-Received: by 2002:a25:585:0:b0:628:9860:39da with SMTP id
 127-20020a250585000000b00628986039damr7949048ybf.383.1646299328178; Thu, 03
 Mar 2022 01:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-30-brijesh.singh@amd.com> <Yh3r1PSx/fjqoBB3@nazgul.tnic>
 <671a6137-0d45-3a8c-433a-32448019961f@amd.com> <Yh+Jc20ed82Vyxge@nazgul.tnic>
In-Reply-To: <Yh+Jc20ed82Vyxge@nazgul.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Mar 2022 09:21:57 +0000
X-Gmail-Original-Message-ID: <CAMj1kXH7vYQ4yjVUpB3wur9UkRxWf=1DEiX8TArk1vpm-8KPuQ@mail.gmail.com>
Message-ID: <CAMj1kXH7vYQ4yjVUpB3wur9UkRxWf=1DEiX8TArk1vpm-8KPuQ@mail.gmail.com>
Subject: Re: [PATCH v11 29/45] x86/boot: Add Confidential Computing type to setup_data
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2 Mar 2022 at 15:13, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 02, 2022 at 08:25:45AM -0600, Brijesh Singh wrote:
> > Yep, I am waiting for Linux patches to finalize and then sync OVMF with it.
> > I will rename the field to magic in OVMF to keep both of them in sync.
>
> Ok, thx.
>
> Btw, Ard, ACK for the EFI hunk?
>

Yep,

Acked-by: Ard Biesheuvel <ardb@kernel.org>
