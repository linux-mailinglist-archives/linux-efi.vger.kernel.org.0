Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E37C82DE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 12:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMKRR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMKRR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 06:17:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFDFA9;
        Fri, 13 Oct 2023 03:17:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4353AC433CB;
        Fri, 13 Oct 2023 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697192235;
        bh=mPFeZ8RjEU6Rg0Kw8zpK+bhI7pcnvmwvlGnsqY5/x/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T4U/Odt37qLzJFSj3l28BaHjCh6mgXTYum8VyQLGb0FIxmpbqPmVaAPhuU/EqfA0q
         fU3biO2bbNVSAaW/rH6CE/fbN/RYXhcHlTPCJH2ZZmMlp9fY3sbY6ORruceDTXNXVF
         xvqQQ9tzLr+1yVb0SKMYanHZThl0w2WVDG/2Y05HBRoeLdpDqzWGL7rVbkW9Ud3hWs
         Ci/jPUFGAuZwvniw62CT4AL0tPNT994IP8ab3qp8y4Rpzoawj7HlO/chkfMESfyeKm
         0ha2CEOW2Y6VDMgVfHsY1rC5IFmmko3EU35n4CIaKzFBX3jEEzqtcyJiJbx2x9+oBa
         wvYRD2u2S+2PQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso9714401fa.2;
        Fri, 13 Oct 2023 03:17:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNJoE41d56WKE1P65qqLhWUoGrm1ajmQwJhfsiXKUmDVU+JbJG
        eSc1HJ2b+22PRNuEfKsjIx88TdKHoXsYcd1+rGI=
X-Google-Smtp-Source: AGHT+IHYXxzqEB2qSq1EYrSAFBl5lsbcnzHkUHFlEA8RsMn1h/PY3fiPCpjdfBgz84HZF8gZEW6w0uqXz9ebzyBTjqk=
X-Received: by 2002:a2e:8488:0:b0:2b6:cff1:cd1c with SMTP id
 b8-20020a2e8488000000b002b6cff1cd1cmr21104672ljh.34.1697192233474; Fri, 13
 Oct 2023 03:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231011192528.262425-1-nik.borisov@suse.com> <20231012101456.goamenepqlte65jv@box.shutemov.name>
 <9346655c-df15-498b-a6e3-f6dd918c663a@suse.com>
In-Reply-To: <9346655c-df15-498b-a6e3-f6dd918c663a@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Oct 2023 12:17:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE0zyzU9=cCk6HynfvPJGmzJvRDyjvmpNTsDNeEQTwz8A@mail.gmail.com>
Message-ID: <CAMj1kXE0zyzU9=cCk6HynfvPJGmzJvRDyjvmpNTsDNeEQTwz8A@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Don't try to print after ExitBootService()
To:     Nikolay Borisov <nik.borisov@suse.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Matthew)

On Thu, 12 Oct 2023 at 13:28, Nikolay Borisov <nik.borisov@suse.com> wrote:
>
>
>
> On 12.10.23 =D0=B3. 13:14 =D1=87., kirill.shutemov@linux.intel.com wrote:
> > On Wed, Oct 11, 2023 at 10:25:28PM +0300, Nikolay Borisov wrote:
> >> setup_e820() is executed after UEFI's ExitBootService has been called.
> >> This causes the firmware to throw an exception because Console IO
> >> protocol handler is supposed to work only during boot service
> >> environment. As per UEFI 2.9, section 12.1:
> >>
> >>   "This protocol isused to handle input and output of text-based
> >>   information intended for the system user during the operation of cod=
e
> >>   in the boot services environment."
> >>
> >> Running a TDX guest with TDVF with unaccepted memory disabled results =
in
> >> the following output:
> >
> > Oh. My bad.
> >
> > But there's other codepath that does the same. If setup_e820() fails wi=
th
> > EFI_BUFFER_TOO_SMALL, efi_stub_entry() would try to print "exit_boot()
> > failed\n".
> >
> > I wouldner if it is feasible to hook up earlyprintk console into
> > efi_printk() machinery for after ExitBootService() case? Silent boot
> > failure is not the best UX.
> >
>
> So looking at the code the only thing which would prevent refactoring to
> exit logic to directly call exit_boot_func etc and setup_e820 before
> calling efi_exit_boot_services is if the memory map changes. The current
> code ensures that we really have the latest memory map version and so
> setup_e820 is called with the latest version.
>
> Ard, how likely it is that the memory map can indeed change between the
> calls to getmemorymap and exitbootservice?

Very likely. Matthew mentioned this to me not too long ago, i.e., that
on real-world platforms, ExitBootServices() typically fails the first
time because of this, and only succeeds the second time (note that the
first call disables async event delivery so the second call is
guaranteed to succeed unless the caller modifies the memory map
themselves)
