Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75B27A49B8
	for <lists+linux-efi@lfdr.de>; Mon, 18 Sep 2023 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbjIRMcq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Sep 2023 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241293AbjIRMcW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Sep 2023 08:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B52FE7
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 05:32:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E12C433CD
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695040335;
        bh=LDnSb3HteQ4la+S2WMvGPFOQQbWoP23nKIuJ/U5L8yM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WYTSWJkKDXsK4AZhSvApBMR2osJ3nhPi7HuyHoaD0ZOiW5XX5Mjh9o1iOqrEBAPT6
         MU8sRKUPBmeXaJRtmd9AozYqnjDJlSlNBDw3fMuJoZHm9qItuO3+XV1RG+ICxMRzD9
         IfqFUKB7yNQid384Z4vjzp9jnPRrH5vjnsQjAU9Qhf5r5amV0B/Qeb5vNqLQsR2bpV
         h8HjU8jAFiD/Bc+vZdPy4GpNwsPMHnhKRfUA/UTyBTDKUsSr8ksOB8H4CXspOeFnI0
         vRQGwl+P5kbWBan6MGsmlIjRn0VbaXSaNGb79klvQ0o3ULK7uVU7GnnRXD4dpocNHC
         GYLCwCobZpvQA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2bfb12b24e5so70620551fa.0
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 05:32:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YyjGRqHsWWkSarnGnWEgQGW4xe5uKnoXQo7lg35wHM8osaK6Zhx
        RQ8o+NMEuyAAyClzgH+nDxSaqv2gljvMA9M79rQ=
X-Google-Smtp-Source: AGHT+IHbSPqor8UcTl98qQCVnrzQrjvQcnuwoHC5gjnv0Tp3xUklA5sHGZHQT6Ve5HFQE4MeP9prrRmYSktRDBpXDYo=
X-Received: by 2002:a05:651c:218:b0:2bc:e221:676c with SMTP id
 y24-20020a05651c021800b002bce221676cmr7355174ljn.0.1695040333407; Mon, 18 Sep
 2023 05:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190557.3738-1-ardb@kernel.org> <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
 <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
 <20230818151628.d7srn5k73vms7dcf@box.shutemov.name> <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
 <20230907104914.a4nt23yuronohivo@box.shutemov.name> <20230917170629.d35gnwb6o54bdrhl@box.shutemov.name>
 <CAMj1kXF3BgEpZDpzfLm0=1cdSUy0ovb6Uog17em58=YLHaADug@mail.gmail.com> <20230918121241.5zbplrgao7ybvv5n@box.shutemov.name>
In-Reply-To: <20230918121241.5zbplrgao7ybvv5n@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 18 Sep 2023 14:32:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8LN862T7w62ngS783OGJFSk2ZWEzqk_LasExdimr=PQ@mail.gmail.com>
Message-ID: <CAMj1kXG8LN862T7w62ngS783OGJFSk2ZWEzqk_LasExdimr=PQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, linux-efi@vger.kernel.org,
        x86@kernel.org, Hongyu Ning <hongyu.ning@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 18 Sept 2023 at 14:13, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Sep 18, 2023 at 09:01:27AM +0200, Ard Biesheuvel wrote:
> > On Sun, 17 Sept 2023 at 19:06, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Thu, Sep 07, 2023 at 01:49:14PM +0300, Kirill A. Shutemov wrote:
> > > > On Wed, Sep 06, 2023 at 11:17:12AM +0200, Ard Biesheuvel wrote:
> > > > > On Fri, 18 Aug 2023 at 17:16, Kirill A. Shutemov
> > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 17, 2023 at 10:25:56PM +0200, Ard Biesheuvel wrote:
> > > > > > > On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
> > > > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> > > > > > > > things, guides where direct mapping ends. Any memory above max_pfn is
> > > > > > > > not going to be present in the direct mapping.
> > > > > > > >
> > > > > > > > e820__end_of_ram_pfn() finds the end of the ram based on the highest
> > > > > > > > E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> > > > > > > > calculation.
> > > > > > > >
> > > > > > > > Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> > > > > > > > tables and might be required by kernel to function properly.
> > > > > > > >
> > > > > > > > Usually the problem is hidden because there is some E820_TYPE_RAM memory
> > > > > > > > above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> > > > > > > > memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> > > > > > > > can fit under the last E820_TYPE_ACPI range.
> > > > > > > >
> > > > > > > > Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> > > > > > > > E820_TYPE_ACPI memory.
> > > > > > > >
> > > > > > > > The problem was discovered during debugging kexec for TDX guest. TDX
> > > > > > > > guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> > > > > > > > it between the kernels on kexec.
> > > > > > > >
> > > > > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > > >
> > > > > > > No objections to this, but we might also simply drop E820_TYPE_ACPI
> > > > > > > altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
> > > > > > > memory that can be used by the OS as ordinary RAM if it is not
> > > > > > > interested in the contents (or has already consumed them). So this
> > > > > > > could arguably be classified as E820_TYPE_RAM too.
> > > > > >
> > > > > > Hm. I'm not sure about this. E820_TYPE_ACPI also get tracked as
> > > > > > IORES_DESC_ACPI_TABLES resource and get passed to the next kernel on
> > > > > > kexec, regardless if it is crash kernel or not. I'm not sure we would not
> > > > > > break anything.
> > > > > >
> > > > >
> > > > > Yeah, you're right. So this patch is necessary in any case.
> > > > >
> > > > > Do we also need the EFI side patch then?
> > > >
> > > > Yes, we need it to get it mapped into the crashkernel direct mapping.
> > >
> > > Ughh. The patch alone causes crash as EFI_ACPI_RELACLAIM_MEMORY is not
> > > mapped into direct mapping during memory init.
> > >
> >
> > It would be good if this boot path could be covered by lkp@ as well -
> > currently, you are the only person testing this manually. The same
> > applies to SEV-SNP by the way - there is zero coverage except for the
> > manual testing that Boris or Tom Lendacky might do.
>
> It made me remember that I forgot attribute the finding:
>
> Reported-by: "Hongyu Ning" <hongyu.ning@intel.com>
>

OK, I will add that next time I update the branch.

> Hongyu tests linux-next periodically, but I agree we need to get LKP
> working.
>
> I will try to get LKP going for TDX guest.
>

Yes, please. We are likely to run into such issues again if we don't
have test coverage for this functionality.

Thanks,
Ard.
