Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA94F66CFA6
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 20:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjAPTn3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 14:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjAPTn2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 14:43:28 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90032BF12
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 11:43:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y5so21729947pfe.2
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QnxAd4xLU7p98OVD+hAsykoKTEdCqXWogG3RU5BW2po=;
        b=ZcgKRE6TB59mnjD/69kiQ20Z15m7bNSMriL7cCAPHuh6s0qMmw+VhH9/on66EdmyjG
         dw+fC/siS31TgmABCX7jG5ljxR34baQbn2QAFlOMyC6RoGGt0sl6Dd01TGoSs81kW41H
         /m/0cOLtBkTdCpNSq4jwfCUtu7SCSzahq6v+iqF2maHjILg/pM08hFgRULqBCmUyhUsq
         kIukAxQBh2juj0YJZlLd3PTYG7FL7Ki0fVwqAYNnBNQCB03cmbfOtUZqOzMyI5W+mrJE
         p22Uh2fLoOQWfDXIUAhqVxLH/MYPc9NlmffBKuwgjR/77qDogUgwsWcBzSpIgev0q2DU
         4jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnxAd4xLU7p98OVD+hAsykoKTEdCqXWogG3RU5BW2po=;
        b=2P7lXxqlBrPuXKCfrPcOFMdmqiHtCQbhbyIisfpQ7v4s/WA8klgrHYxpVCMqr6vjZZ
         gGiERgZ1KrazfafhCQmJf+Jrxvrivro0+nGrqHjzCuRBcvVVatpBipOZMkr9Pz+vB/nN
         Mht/bSklXnkxHmHFrDez+N3Z6+WDN99i2W82VJ9Vpm815sJ+jPiialQB5gFAzn72upop
         HsXeA2MEZEFPtCSqfSaYx/foh60+bd1bYNrZKLw7A48AU2YQVZP5LdsX2slxc6wC9rYi
         lN1bzCxtw510Cg1nqKSiYsT4vGNrNunMdDrG0w3+83NDfJA7wQXJ4q8mLiko3kjT542S
         fKTQ==
X-Gm-Message-State: AFqh2kr3krcS18mrM3YJFJOTNWWdeefq6aC0sgqcGAmOhacWOOWZyF76
        cqQLFZQATEQlfzBNG5vU7+tx5G5WfdC5oA8XvGD2rA==
X-Google-Smtp-Source: AMrXdXvRa28f2drx0DONjUaAUAdPmnXdgxceoVRg7DzO+7/OGGo7wfvJ9qE3DzAJUOTUVpW5+88s6/wvOr8nM4thdqw=
X-Received: by 2002:a63:db57:0:b0:478:e542:7d77 with SMTP id
 x23-20020a63db57000000b00478e5427d77mr12990pgi.101.1673898207101; Mon, 16 Jan
 2023 11:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name> <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name> <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
 <20230116134246.soworigs56bz5v7o@box.shutemov.name>
In-Reply-To: <20230116134246.soworigs56bz5v7o@box.shutemov.name>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 16 Jan 2023 11:43:15 -0800
Message-ID: <CAAH4kHb6-6QkMnYbcQ6MyMkwSBUN-Q3CcM3fuiStdbbnSfJv1A@mail.gmail.com>
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

> > I still don't understand why we need to support every imaginable
> > combination of firmware, bootloader and OS. Unaccepted memory only
> > exists on a special kind of virtual machine, which provides very
> > little added value unless you opt into the security and attestation
> > features, which are all heavily based on firmware protocols. So why
> > should care about a EFI-aware bootloader calling ExitBootServices()
> > and subsequently doing a legacy boot of Linux on such systems?
>
> Why break what works? Some users want it.
>

The users that want legacy boot features will not be broken, they'll
only get a safe view of the memory map. I don't think it's right to
choose unsafe behavior for a legacy setup.

> This patch adds complexity, breaks what works and the only upside will
> turn into a dead weight soon.
>
> There's alternative to add option to instruct firmware to accept all
> memory from VMM side. It will serve legacy OS that doesn't know about
> unaccepted memory and it is also can be use by latency-sensitive users
> later on (analog of qemu -mem-prealloc).
>

This means that users of a distro that has not enabled unaccepted
memory support cannot simply start a VM with the usual command, but
instead have to know a baroque extra flag to get access to all the
memory that they configured the machine (and for a CSP customer, paid
for). That's not a good experience.

With GCE at least, you can't (shouldn't) associate the boot feature
flag with a disk image because disks are mutable. If a customer
upgrades their kernel after initially starting their VM, they can't
remove the flag due to the way image annotations work.

All of this headache goes away by adopting a small patch to the kernel
that calls a 0-ary protocol interface and keeping safe acceptance
behavior in the firmware. I think Gerd is right here that we should
treat it as a transition feature that we can remove later.

> --
>   Kiryl Shutsemau / Kirill A. Shutemov



-- 
-Dionna Glaze, PhD (she/her)
