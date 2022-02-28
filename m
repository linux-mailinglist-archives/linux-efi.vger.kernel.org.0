Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0204C6DA2
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiB1NQq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 08:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiB1NQc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 08:16:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192327462B;
        Mon, 28 Feb 2022 05:15:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD26FB810BF;
        Mon, 28 Feb 2022 13:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58204C340FA;
        Mon, 28 Feb 2022 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646054150;
        bh=XC7q336p+3yz9SXS9ZVHG+qns5z7lvEURk+VZZRcFRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbQVeAU4fSucwMwELJ2chTApjPOmF9JV0Bq5ZQ+SLVOeuzaOEKn8OCD86frbDeTUk
         178U9AVLlTn39ViS32nJUTew0lzqS0jEupKT5cWc6LEotoNepUDqIRFs1QMgCAZqwx
         lSVS7McGv8T6ZJozZAKgUq3qSTypblHzo+rQT6jKX2qMjcv7/BzzwzRNf/ehHJsFwy
         TrYWKm3uuTvPQeKUbg0ZQ9XNnfYzV08QCcZMEqRtap0GeIWlSA8b2rEJ86yhe++kUc
         iwE1ZQoB7T4QjP+wBxCAa7/jzm60j0NngX0Od+S4/ZGoOHVCr+6Ed/e/QbPitjMKnv
         8eVyCwaim79Rg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2d68d519a33so107434077b3.7;
        Mon, 28 Feb 2022 05:15:50 -0800 (PST)
X-Gm-Message-State: AOAM531Hz/vKOguZ3KM81OEHHNGQfvICmmqjzQbCACzOungT0pRcZfW8
        km1JLL7OFBA1r76Dk1nwMJUnnr7VwlW1hz3WFc8=
X-Google-Smtp-Source: ABdhPJzcscw84x/z6KkT11IgEGwYFMOpSyj0Psgek7g+cza2KTS9W2gr/p1yvNnykksnbs2/Yvgyve+4H8UgCXvYcdU=
X-Received: by 2002:a81:7d04:0:b0:2d0:d0e2:126f with SMTP id
 y4-20020a817d04000000b002d0d0e2126fmr19559172ywc.485.1646054149209; Mon, 28
 Feb 2022 05:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <20220228114254.1099945-4-dovmurik@linux.ibm.com> <CAMj1kXFybkGtxH2U6oAi_Qeqe-i_kH-hZjUZKY3-UzPHUg55vg@mail.gmail.com>
 <f3de6cd9-9f58-7db3-e367-a6a5a5d826e2@linux.ibm.com>
In-Reply-To: <f3de6cd9-9f58-7db3-e367-a6a5a5d826e2@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 14:15:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEKh-Ve3iPDnNTxi10=hcARN4ntpyQOrmb=B+4DpC24vQ@mail.gmail.com>
Message-ID: <CAMj1kXEKh-Ve3iPDnNTxi10=hcARN4ntpyQOrmb=B+4DpC24vQ@mail.gmail.com>
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
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 28 Feb 2022 at 14:07, Dov Murik <dovmurik@linux.ibm.com> wrote:
>
>
>
> On 28/02/2022 14:49, Ard Biesheuvel wrote:
> > On Mon, 28 Feb 2022 at 12:43, Dov Murik <dovmurik@linux.ibm.com> wrote:
> >>
> >> If the efi_secret module is built, register a late_initcall in the EFI
> >> driver which checks whether the EFI secret area is available and
> >> populated, and then requests to load the efi_secret module.
> >>
> >> This will cause the <securityfs>/secrets/coco directory to appear in
> >> guests into which secrets were injected; in other cases, the module is
> >> not loaded.
> >>
> >> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> >> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > It would be better to simply expose a platform device and associated
> > driver, instead of hooking into the module machinery directly.
> >
> > We already do something similar for the EFI rtc and the efivars
> > subsystem, using platform_device_register_simple()
> >
>
> Thanks Ard, I'll look into this.
>
> I hope the mechanism you suggest allows me to perform complex check to
> see if the device is really there (in this case: check for an efi
> variable, map memory as encrypted, verify it starts with a specific GUID
> -- everything before request_module() in the code below).
>

There is the device part and the driver part. Some of this belongs in
the core code that registers the platform device, and some of it
belongs in the driver. At this point, it probably does not matter that
much which side does what, as the platform driver simply probes and
can perform whatever check it needs, as long as it can back out
gracefully (although I understand that, in this particular case, there
are reasons why the driver may decide to wipe the secret)
