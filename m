Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29835705617
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEPSgR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEPSgQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 14:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823783FF;
        Tue, 16 May 2023 11:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03E5163DD9;
        Tue, 16 May 2023 18:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A443C433AE;
        Tue, 16 May 2023 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684262140;
        bh=Z+rISdoaaFjE0H3onVx9q3vVqV+GW7MmEBF4x723LEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qsSCep0ovkhnWtUBCdQLs1goten8s2jtIjcw8Yn2A2Fx9CEsj8jaFZW5pav22M/HH
         XlvZMyzFG13P/7meyUFtu84nuLvAQXuG4R0y7+LgQ8V1zVT18jpd6BpkyvH3yKLAV/
         bdmUK7ysNMhHrbnGRgjCkgfN3VBQW4CKjLOlxE2was/rt8ZpfT5eH6JcsX8IIknCGe
         Vj+md7SuXZceBuvLqI49DO3mcpc6wzNUQHWckel1K3XT343ftCeDkunrEoGR+J8Ewp
         AeUsFU9acu5rgFVPCiBlN20Fb4XjLPyQAbym96z38y7pW0PzLE3wiPpr7NULICnHVC
         DwHhJrmLqcJOw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ac82b07eb3so147496631fa.1;
        Tue, 16 May 2023 11:35:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDwfmMlzz4rh1pQKL7+veWv14w5JfrzgAhvzvnIYyKxPN4jQkDCz
        t7oqYWPdM2i1Kax4Nhtf9Td9+IvyMQApMP9s+TQ=
X-Google-Smtp-Source: ACHHUZ5zB+8IUFITFhNLmqcHJRTHm2jVmMPsT4tShbTcHbmGuzZnaX0f1Mw5ueRw5K5L4a1Zn7W53eulOz+0dIWl6J0=
X-Received: by 2002:a2e:8695:0:b0:2ad:90c9:bd29 with SMTP id
 l21-20020a2e8695000000b002ad90c9bd29mr8255580lji.18.1684262138332; Tue, 16
 May 2023 11:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com> <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
 <6fe42f66-819c-f2c8-176b-759c1c5a9cf5@intel.com>
In-Reply-To: <6fe42f66-819c-f2c8-176b-759c1c5a9cf5@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 20:35:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
Message-ID: <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 May 2023 at 20:27, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/16/23 11:08, Ard Biesheuvel wrote:
> >> But, this approach does not work for unaccepted memory. For TDX, a load
> >> from unaccepted memory will not lead to a recoverable exception within
> >> the guest. The guest will exit to the VMM where the only recourse is to
> >> terminate the guest.
> >>
> > Does this mean that the kernel maps memory before accepting it? As
> > otherwise, I would assume that such an access would page fault inside
> > the guest before triggering an exception related to the unaccepted
> > state.
>
> Yes, the kernel maps memory before accepting it (modulo things like
> DEBUG_PAGEALLOC).
>

OK, and so the architecture stipulates that prefetching or other
speculative accesses must never deliver exceptions to the host
regarding such ranges?

If this all works as it should, then I'm ok with leaving this here,
but I imagine we may want to factor out some arch specific policy here
in the future, as I don't think this would work the same on ARM.
