Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14572BBD
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2019 11:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfGXJwk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Jul 2019 05:52:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37151 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXJwk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Jul 2019 05:52:40 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so88246114iog.4;
        Wed, 24 Jul 2019 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhDzbuvFs0yJ/WUz3ukdt8uO4k/3AKV8qsjWlE0aKEw=;
        b=SGvqCL4O1tDMyTtUF8VzsVIaleRAOFgk1B28yr96Tc5DkoDBmOCfKpb+8DoWOK/MrX
         2D3N8WoY7chRvw1ox0YQgUQqnONnS6yXFvZAdnPH8u3VnvSIbpzzJWjXzHKMfgCzGy90
         Ikf3cqKH73hhRrRiXIlELX/hkzMl6g8ZyiraOiMiFY1ELoTqUl6cQObs2IC8PxxVkObK
         aWQF7OxsUJrsYaSNx4NsIbUmrMO0Z5iz6Yan+Wsf7OjG4e87Tlz+wka5UxTeg/6hajeb
         Vt/ISV+jdgor/H1Sg1FLW5SZ9D6Q5TXu4MG5mHRGgirz3QzqaPNgRt7teGd54t14d4E/
         ruvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhDzbuvFs0yJ/WUz3ukdt8uO4k/3AKV8qsjWlE0aKEw=;
        b=PxL1axhm0kNunLYTIZlaGGBHUnsufHcIjotDOoUKAGssa1SlxcxLpOxJsFlkiBCNiY
         pe6b5ZcN30uuryD6AzAngeG5rAt7tD/bl2DJaZHph1yO2o2u2CENleULT7ebPkHmCz5Y
         mg9c6wcW7RQ9oSDmPDyZCi02wV7ye5pzPiDcqoqzgBCzZXeF+T6NaNCn/C2hr/nb8zZC
         EGDgdtfOxnIjyrhfUlaK+L6KAD3jtGkvoKLgs56Ro6HdWEQU/6jy3DTQIjhrkB62BPLg
         qD9bQhVwhMdXx12Igm7e/Zdq0rAZ5qu018BayxihfN4vfMA3geGZ19XDJiEFktq2G0Ti
         l/2g==
X-Gm-Message-State: APjAAAWhg0EIT7KOU8RrxSEUSpvKNXrFQ9PmQfm4wx3ugkBZxBLBMIuH
        iNTUGblqxgNs7twT7RQ7dKTKlvOqlerFTfwo7Bs=
X-Google-Smtp-Source: APXvYqzWo9lCX65m/qQJPiWc2w2e8N/+FLhFIZ0DpQbgEIju2e27m5KvrfTquDsr7BpwzrPpgtrGq0LH0Cy0lwpS2eI=
X-Received: by 2002:a5d:8497:: with SMTP id t23mr50409358iom.298.1563961959018;
 Wed, 24 Jul 2019 02:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
 <1560459027-5248-3-git-send-email-nayna@linux.ibm.com> <87o92910fg.fsf@concordia.ellerman.id.au>
 <6d2988c1-9b89-448b-4537-c3c6673b6dd1@linux.vnet.ibm.com>
In-Reply-To: <6d2988c1-9b89-448b-4537-c3c6673b6dd1@linux.vnet.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 24 Jul 2019 19:52:28 +1000
Message-ID: <CAOSf1CFHYv5VsBMEnNAqa7v7WakPfdpGpbENmG8chusm=hW21g@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: expose secure variables via sysfs
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        linux-efi@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 24, 2019 at 12:35 AM Nayna <nayna@linux.vnet.ibm.com> wrote:
>
> On 07/05/2019 02:05 AM, Michael Ellerman wrote:
> > Hi Nayna,
>
> Hi Michael, Oliver,
>
> > Nayna Jain <nayna@linux.ibm.com> writes:
> >> As part of PowerNV secure boot support, OS verification keys are stored
> >> and controlled by OPAL as secure variables. These need to be exposed to
> >> the userspace so that sysadmins can perform key management tasks.
> >>
> >> This patch adds the support to expose secure variables via a sysfs
> >> interface It reuses the the existing efi defined hooks and backend in
> >> order to maintain the compatibility with the userspace tools.
> > Which tools? Can you include a log demonstrating how they're used, ie.
> > so that I can test the sequence of commands.
> >
> >> Though it reuses a great deal of efi, POWER platforms do not use EFI.
> >> A new config, POWER_SECVAR_SYSFS, is defined to enable this new sysfs
> >> interface.
> > Sorry I haven't been able to keep up with all the discussions, but I
> > thought the consensus was that pretending to be EFI-like was a bad idea,
> > because we don't have actual EFI and we're not implementing an entirely
> > compatible scheme to EFI anyway.

My read is the consensus was that pretending to be EFI is a bad idea
unless we're going to behave like EFI.

> > Greg suggested just putting the variables in sysfs, why does that not
> > work? Matthew mentioned "complex semantics around variable deletion and
> > immutability" but do we have to emulate those semantics on powerpc?
>
> Sorry for the delay in the response.
>
> Yes, I agree. The purpose of the v2 version of the patchset was to try
> and quickly address Matthew's concerns. This version of the patchset:

> * is based on Greg's suggestion to use sysfs

As far as I can tell Greg made that suggestion here:

https://lwn.net/ml/linux-fsdevel/20190603072916.GA7545@kroah.com/

Then walked back on that suggestion after Matthew pointed out that
efivars is separate because of the immutability requirement and the
odd update semantics:

https://lwn.net/ml/linux-fsdevel/20190605081301.GA23180@kroah.com/

Considering the whole point of this is to present the same user-facing
interface so shouldn't you be dealing with all the problems that
interface creates?

> * is not using any EFI configs
That's true, but...

> * is not exposing secure variables via efivarfs
> * is STILL using some of the existing EFI code, that is used by EFI to
> expose its variables via sysfs, to avoid code duplication.

We avoid some of the potential problems of selecting CONFIG_EFI and we
gain a bunch of other potential problems since you've hacked the
makefiles to build code that's normally CONFIG_EFI only.

> * is using efivar hooks to expose secure variables for tool compatibility

Here's the real problem. For compatibility with the existing userspace
tooling, which expects UEFI,  you need to present the same interface
with the same semantics. Trying to not use efivarfs means you've
already lost since you no longer have the same interface. So how is
this an improvement? I think the options here are to either:

1) Come up with a new interface, implement it, and adapt the user
tooling to deal with the new API.

*or*

2) Use efivarsfs and fix the based i-cant-believe-its-not-efi variable
backend so it behaves *exactly* like the UEFI get/setVariable APIs.
This means that you need to validate the update certificates at
runtime. I don't think this is a huge strech since you're already
implementing the validator.

1) gives you the flexibility to change the key hierarchy and whatnot,
while 2) means we've got less weird powerpc crap for users to deal
with. I have no strong opinions about which you choose to do, but
don't do this.

Oliver
