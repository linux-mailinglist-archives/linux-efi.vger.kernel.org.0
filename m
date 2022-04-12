Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDC4FE227
	for <lists+linux-efi@lfdr.de>; Tue, 12 Apr 2022 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355421AbiDLNUD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357498AbiDLNTc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 09:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581783DDCD;
        Tue, 12 Apr 2022 06:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F9DC619A9;
        Tue, 12 Apr 2022 13:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD37EC385B1;
        Tue, 12 Apr 2022 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649768917;
        bh=YcaQr1zTfjSLiNUXAkZxfTTaYuHy1HUaeyyk2AqglB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n2OtpAQoq+qrG0TzI0l8iMD7eTq2ktrCDTJaTsthrBjJGpRfw0n36ACC43KhSFYu8
         elNas01Yi2U5Rv8K+NDjzfQsCkpaDm77HkjCagq6lPDc9ljaAa3VRIq/wuZTG3SLBq
         K7L/rzQhQeMNykf6ALNmVK9+I+bT0i9qH3heMPIZjOpkXxcDKPEL2igyK8nH1YkotE
         k0pLawXRBkjoL5TAeKQDM3ZdZonfp7BASJv33whnsUke9OFr+MLeQ4nNX7LQ/6N3I+
         eSObTl3WDbkHxia2LPOQrWj4htFdaDqp4WD21mFStupsAe913FSkyp8rOXmwGRZUFK
         ITzadpcQeC75g==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e2afb80550so8768559fac.1;
        Tue, 12 Apr 2022 06:08:37 -0700 (PDT)
X-Gm-Message-State: AOAM531KKDPijTrWIKlklNdnZfUCNfkm01fYmHXwMOFi60T7OBoNC79/
        kU7SDWp/ZaMImrPabAl9PENdw7iX2Vs2Tcc5Vdo=
X-Google-Smtp-Source: ABdhPJwsT60EZGzvKxLvuDXi5RTXFmmCpZlzEo7mi7tnDG3CFikUWPsyoP9BI1LgcHDyPOnKWDH0WJEtwRAPvF8XgIc=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr2016587oae.126.1649768916454; Tue, 12
 Apr 2022 06:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <20220228114254.1099945-4-dovmurik@linux.ibm.com> <CAMj1kXFybkGtxH2U6oAi_Qeqe-i_kH-hZjUZKY3-UzPHUg55vg@mail.gmail.com>
 <f3de6cd9-9f58-7db3-e367-a6a5a5d826e2@linux.ibm.com> <CAMj1kXEKh-Ve3iPDnNTxi10=hcARN4ntpyQOrmb=B+4DpC24vQ@mail.gmail.com>
 <38daffb6-a72a-87f4-d927-0b857b7b6833@linux.ibm.com>
In-Reply-To: <38daffb6-a72a-87f4-d927-0b857b7b6833@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 Apr 2022 15:08:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHfeS9WzHkOyM3JGfgVLK8GQ78KBArD19NxcCMn-SDPKg@mail.gmail.com>
Message-ID: <CAMj1kXHfeS9WzHkOyM3JGfgVLK8GQ78KBArD19NxcCMn-SDPKg@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] efi: Load efi_secret module if EFI secret area is populated
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, 31 Mar 2022 at 11:05, Dov Murik <dovmurik@linux.ibm.com> wrote:
>
> Hello Ard,
>
> On 28/02/2022 15:15, Ard Biesheuvel wrote:
> > On Mon, 28 Feb 2022 at 14:07, Dov Murik <dovmurik@linux.ibm.com> wrote:
> >>
> >>
> >>
> >> On 28/02/2022 14:49, Ard Biesheuvel wrote:
> >>> On Mon, 28 Feb 2022 at 12:43, Dov Murik <dovmurik@linux.ibm.com> wrote:
> >>>>
> >>>> If the efi_secret module is built, register a late_initcall in the EFI
> >>>> driver which checks whether the EFI secret area is available and
> >>>> populated, and then requests to load the efi_secret module.
> >>>>
> >>>> This will cause the <securityfs>/secrets/coco directory to appear in
> >>>> guests into which secrets were injected; in other cases, the module is
> >>>> not loaded.
> >>>>
> >>>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> >>>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> >>>
> >>> It would be better to simply expose a platform device and associated
> >>> driver, instead of hooking into the module machinery directly.
> >>>
> >>> We already do something similar for the EFI rtc and the efivars
> >>> subsystem, using platform_device_register_simple()
> >>>
> >>
> >> Thanks Ard, I'll look into this.
> >>
> >> I hope the mechanism you suggest allows me to perform complex check to
> >> see if the device is really there (in this case: check for an efi
> >> variable, map memory as encrypted, verify it starts with a specific GUID
> >> -- everything before request_module() in the code below).
> >>
> >
> > There is the device part and the driver part. Some of this belongs in
> > the core code that registers the platform device, and some of it
> > belongs in the driver. At this point, it probably does not matter that
> > much which side does what, as the platform driver simply probes and
> > can perform whatever check it needs, as long as it can back out
> > gracefully (although I understand that, in this particular case, there
> > are reasons why the driver may decide to wipe the secret)
>
> I finally got to implement this, it seems like it makes the code simple.
> Thanks for the advice.
>
> Just making sure I understand correctly: in this approach this we rely
> on udev to load the efi_secret module (aliased as "platform:efi_secret")
> and call its .probe() function?  If there's no udev, the module will not
> be loaded automatically.  Did I understand that correctly?
>

Apologies, I am swamped in email and only spotted this now.

This looks good to me: is this what you implemented in the end?
