Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D317266E3FB
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjAQQqZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 11:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjAQQqP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 11:46:15 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF6B31E06
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 08:46:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c26so19522181pfp.10
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 08:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8r/Ogh+1/rmJVW9GjnyNto0Qv9HGXvmys+QiP8n0bi8=;
        b=Zqt//Us+4i857n+1xJVy2kkiE5l4YyMXMIvgWnWkki7y+W0sVhGU7GIzy/3mnhJcVh
         AO9ehmCXyq8Zjlok12JrlNyWu96zyA4m91XxdHC3feS1LeskkK+wS6WJtz19vBz5lbf8
         FsodO4/8VeNqWqlUkFt1l29qjDON1oLjFf/dy45FsvbDT5mSch0lYU5O5lTPYBBTU26B
         XwyQhQAi1GiMa3kshq4YMcGMOtHLhYQmQIzTVWOm50Q2S0csgbclGjASM7KoUMKbJsv9
         cGyMsfMY2qY2VBkBT1xri5EpObUoiNQuN5eRQgKE8mOqv4jVIhXT9RUPOj79tz4IZ4UK
         nMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8r/Ogh+1/rmJVW9GjnyNto0Qv9HGXvmys+QiP8n0bi8=;
        b=e6SFgC3X1fsCpJVmnPTP2HBuPWVPczKsxejiVXp2ZRdtDEpDifIwhG8cQD30fIUZf3
         1/c39/77t5SpSstNdc+pKV7sv18nPkfOI2lhHeqR0dGCiB8t9pzSki7DUvbLiIirIKrK
         Fes+2M/iaRhthJ2LSuCbIVpP1LzwmrjK0RojaU13Zx1QAjD9a2jBOk6yDCU2C4+FOdxF
         mwqaFCOG0ZvhWJ1THcsoGAn3L0/N0MnpBeSZzaNi9+wooeFTA3MWtJuzGu7KGWfRw6E1
         h8JRyavoCGUC18ETrOTSi1en5mMLHaN8paV9SxHKH8HeAKG1ez1lVPfmzcKlzL89UpEV
         Q/dw==
X-Gm-Message-State: AFqh2koMynftmnDGVdEY/gMIvK53gOm4QVbCJTo4OZLicp+buB3v7s0J
        EkEpYJyqDBX7wWGqteyajWdrf7vNL2E460nwrQeNyQ==
X-Google-Smtp-Source: AMrXdXvmt+G5DhP5JqGzTo6vSZ2dEV8T2ZcnAuC/JQQLSI8ITdJioU6zwhMbHa4S4QZ26d7cQeWycCJXdHN6GUZuv38=
X-Received: by 2002:aa7:85d5:0:b0:577:81cb:4761 with SMTP id
 z21-20020aa785d5000000b0057781cb4761mr353156pfn.46.1673973967519; Tue, 17 Jan
 2023 08:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name> <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name> <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
 <20230116134246.soworigs56bz5v7o@box.shutemov.name> <CAAH4kHb6-6QkMnYbcQ6MyMkwSBUN-Q3CcM3fuiStdbbnSfJv1A@mail.gmail.com>
 <20230116231711.cudsnxvnfg6aef3w@box.shutemov.name>
In-Reply-To: <20230116231711.cudsnxvnfg6aef3w@box.shutemov.name>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 17 Jan 2023 08:45:55 -0800
Message-ID: <CAAH4kHbhSfeDeBCLCO4Bc2MK8Ds-kjXxCnrkMEP1j_GO5sh18w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

>
> Why do you call boot with a bootloader a legacy feature?
>

Gerd answered this about EBS called from the bootloader.

> > they'll only get a safe view of the memory map. I don't think it's right
> > to choose unsafe behavior for a legacy setup.
>
> Present memory map with unaccepted memory to OS that doesn't about it is
> perfectly safe. This portion of the memory will be ignored. It is "feature
> not [yet] implemented" case.
>

SNP guest support is already in Linux, and it gets a full view of the
memory given to the VM. If the firmware ever introduces unaccepted
memory, then the kernel's behavior is retroactively broken without the
"accept all if AllowUnacceptedMemory() not called" behavior of the
UEFI.
The memory that existed before becomes ignored. This is not the right
approach IMO.

> > > This patch adds complexity, breaks what works and the only upside will
> > > turn into a dead weight soon.
> > >
> > > There's alternative to add option to instruct firmware to accept all
> > > memory from VMM side. It will serve legacy OS that doesn't know about
> > > unaccepted memory and it is also can be use by latency-sensitive users
> > > later on (analog of qemu -mem-prealloc).
> > >
> >
> > This means that users of a distro that has not enabled unaccepted
> > memory support cannot simply start a VM with the usual command, but
> > instead have to know a baroque extra flag to get access to all the
> > memory that they configured the machine (and for a CSP customer, paid
> > for). That's not a good experience.
>
> New features require enabling. It is not something new.
>

What I'm saying is that you're suggesting a feature _dis_abling
requirement, which is an antipattern. Any SNP user right now would
need to add a "don't use an unimplemented feature" flag to get access
to all its memory again.

> > With GCE at least, you can't (shouldn't) associate the boot feature
> > flag with a disk image because disks are mutable. If a customer
> > upgrades their kernel after initially starting their VM, they can't
> > remove the flag due to the way image annotations work.
>
> I guess a new VM has to be created, right? Doesn't sound like a big deal
> to me.
>

Usually it's not, but the retroactive need to create a new VM once the
firmware adds UEFI v2.9 support with unaccepted memory is a big deal.

> The old will not break with upgraded kernel. Just not get benefit of the
> feature.
>

A user buys access to a high memory VM: 768GiB. They then shut down
and bring it back up on a new firmware that uses unaccepted memory.

That VM goes from 785GiB free memory to 3GiB free memory at boot.

This is because all memory above 4GiB (and nothing there for the
3-4GiB MMIO hole) would be the unknown unaccepted memory type. We need
the accept-all-if-support-not-acked semantics with the protocol.

> > All of this headache goes away by adopting a small patch to the kernel
> > that calls a 0-ary protocol interface and keeping safe acceptance
> > behavior in the firmware. I think Gerd is right here that we should
> > treat it as a transition feature that we can remove later.
>
> Removing a feature is harder than adding one. How do you define that
> "later" has come?
>

Gerd's response of after 6.1-lts EOL is reasonable to me. At the same
time, both SEV-SNP and TDX's Kconfig would need to strictly require
unaccepted memory.

The semantics of the UEFI under the proposed protocol is allowed to
change the default behavior when the protocol is not exposed to the
OS. The default would then be to always introduce unaccepted memory
for TDX and SEV-SNP guests.

To Gerd's point, removing "first in edk2, later in linux too" I think
is backwards. We need all users of the protocol to agree that SEV-SNP
and TDX strictly imply unaccepted memory support. Only then can we
remove the protocol from EDK2.

> Anyway, I think we walk in a circle. I consider it a misfeature. If you
> want still go this path, please add my
>
> Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>

Thanks for your time discussing.


-- 
-Dionna Glaze, PhD (she/her)
