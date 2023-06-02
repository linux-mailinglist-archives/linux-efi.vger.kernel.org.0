Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8272073C
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjFBQRh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjFBQRf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 12:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070B1BC;
        Fri,  2 Jun 2023 09:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C12651ED;
        Fri,  2 Jun 2023 16:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3217C433AF;
        Fri,  2 Jun 2023 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685722646;
        bh=0LXWB6qbl7vNu7SKXUaME4/d4fTO2GJDhz+PMgj1S0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SXB8En8ACHxlfNJrKl8snRDjI0SW5WbtG2YcLk6gYZn/Adh++9MnPwJN7Fh9ICli9
         uZN1un7gPrm8q6lMeMZxN9pARGEBI1WBJeYPb1SuymHsXddfYAgZJw47RTcAcDq6OI
         t8gCQ7iaubrcdYxmPKSrjngzZFCG2s08xQK2gjUbNp0NJ+kzt5bSCa8XbmewZWUEm/
         sZu0SDL/0fGWYpY5BVOYeDANN0++h90UtCQfFaRRi5uIop2PspqPn0UN4GEIQr628l
         qbYecZeZU71c1p2O5kPFlKsJzoZYf+CtRWs4Wqq77OoQLBtZPH1xLE+flRL/ibQfYy
         fJ1UsgumuTddA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f6170b1486so365501e87.0;
        Fri, 02 Jun 2023 09:17:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDztP1elazxjkt4zzJg60zCGJzKn4PYSbEAun+L7GmIx9HYLeWdL
        OUTzItwi3bsUqfuWp3gpP7bpE0O41F17d4bkQhg=
X-Google-Smtp-Source: ACHHUZ57JR133XIQLAUk+rYZuI9gg8d//ps8CXBWqmwRU+ABEoaxhgQm18/e5YUvZCUet/HCioKmGfNZszzaXPmaegU=
X-Received: by 2002:a05:6512:118c:b0:4eb:412f:9e0e with SMTP id
 g12-20020a056512118c00b004eb412f9e0emr1014207lfr.26.1685722644861; Fri, 02
 Jun 2023 09:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-5-kirill.shutemov@linux.intel.com> <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
 <20230602153644.cbdicj2cc6p6goh3@box.shutemov.name> <20230602160900.GEZHoUHHpPKMnzV3bs@fat_crate.local>
In-Reply-To: <20230602160900.GEZHoUHHpPKMnzV3bs@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Jun 2023 18:17:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXENJ6VJMDtVmKqozRb6NMU7Y-fhYJWiCbRd2aQ_tmXHMg@mail.gmail.com>
Message-ID: <CAMj1kXENJ6VJMDtVmKqozRb6NMU7Y-fhYJWiCbRd2aQ_tmXHMg@mail.gmail.com>
Subject: Re: [PATCHv13 4/9] x86/boot/compressed: Handle unaccepted memory
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Jun 2023 at 18:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jun 02, 2023 at 06:36:44PM +0300, Kirill A. Shutemov wrote:
..
> > Configuration table suppose to be present, even if unaccepted memory is
> > not supported. Something is very wrong if it is missing.
>
> I am not sure if it is the decompressor's job to do such validation
> - I guess this is something the EFI code should do.
>

'EFI code' is ambiguous here.

Most of the decompressor code is constructed in a way that permits
- booting 'native EFI' via the EFI stub
- booting 'pseudo-EFI' where GRUB or another Linux/x86 specific
bootloader populates boot_params with all the EFI specific information
(system table, memory map, etc)

This distinction has been abstracted away here, and so we might be
dealing with the second case, and booting from a GRUB that does not
understand accepted memory, but simply copied the EFI memory map
(including unaccepted regions) as it normally does. (Note that the
second case also covers kexec boot, so we do need to support it)
