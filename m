Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29645751EB2
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 12:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjGMKSP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjGMKSO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 06:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573E1724;
        Thu, 13 Jul 2023 03:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B0C60C00;
        Thu, 13 Jul 2023 10:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1E9C433CD;
        Thu, 13 Jul 2023 10:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689243491;
        bh=ET0PIk/EJwOtrnFetQCgnV0IGpMF5SKCWlqW+zEctgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YMlAn0FKUIcij8cMaBk1sFjGdlftqb544w6tk1470W3FP8qhFxn+egxqkXA5LavAS
         esTIPGnjOKs03CHA1k5fK0BcLZG62Fd+YJjjeUX9Jx/+xTrTWAxHKlJCXj/+I0fcf6
         tgt9Hl+9GgifspdfdEgIMhgHCX9v0289T95tYeQ7gFQeNRPmW8uUyl6JLAr/+vh+sU
         EArTQBAxwB/G70oaog4LkVrUoXGF7PalknTC3Qf4N+/v/qvWOAIvAtxUG8G1VdKaZC
         SiS90semh7lh/XT8ETTWgIFpxHQAzLQ8xhYpCzly4tEAIDqDQZ178VA/ugu6IOY3u9
         uYQDvUzquX5OQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f122ff663eso927751e87.2;
        Thu, 13 Jul 2023 03:18:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLagSoMP+j+D3AolVsy2Lq2p5ZXHYn0FXKC7gGLd5huehqVITJ8i
        m363FG3oXb6HSwnlDFOh77jGFNVRVq+0GlSBe8Y=
X-Google-Smtp-Source: APBJJlFBQWCejzkySepLV/mSpZDO69J/ce++jVUzK0IbQmheOsTIP22zHMFDXog7ITY4n68UbN14AQPbrEm/zMas0Pg=
X-Received: by 2002:a05:6512:3984:b0:4f8:7513:8cb0 with SMTP id
 j4-20020a056512398400b004f875138cb0mr1040508lfu.2.1689243489214; Thu, 13 Jul
 2023 03:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv> <ZKfLYG_4DANc_i5r@suse.de>
 <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local> <20230707152515.42gpfzjgvfwe6rf7@amd.com>
 <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local>
In-Reply-To: <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Jul 2023 12:17:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
Message-ID: <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>,
        Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Jul 2023 at 19:12, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 07, 2023 at 10:25:15AM -0500, Michael Roth wrote:
> > ...
> > It would be unfortunate if we finally abandoned this path because of the
> > issue being hit here though. I think the patch posted here is the proper
> > resolution to the issue being hit, and I'm hoping at this point we've
> > identified all the similar cases where EFI/setup_data-related structures
> > were missing explicit mappings. But if we still think it's too much of a
> > liability to access the EFI config table outside of SEV-enabled guests,
> > then I can work on re-implementing things based on the above logic.
>
> Replying here to Tom's note too...
>
> So, I like the idea of rechecking CPUID. Yes, let's do the sev_status
> check. As a result, we either fail the guest - no problem - or we boot
> and we recheck. Thus, we don't run AMD code on !AMD machines, if the HV
> is not a lying bastard.
>
> Now, if we've gotten a valid setup_data SETUP_EFI entry with a valid
> pointer to an EFI config table, then that should happen in the generic
> path - initialize_identity_maps(), for example - like you've done in
> b57feed2cc26 - not in the kexec code because kexec *happens* to need it.
>
> We want to access the EFI config table? Sure, by all means, but make
> that generic for all code.
>

OK, so in summary, what seems to be happening here is that the SEV
init code in the decompressor looks for the cc blob table before the
on-demand mapping code is up, which normally ensures that any RAM
address is accessible even if it hasn't been mapped explicitly.

This is why the fix happens to work: the code only maps the array of
(guid, phys_addr) tuples that describes the list of configuration
tables that have been provided by the firmware. The actual
configuration tables themselves could be anywhere in physical memory,
and without prior knowledge of a particular GUID value, there is no
way to know the size of the table, and so they cannot be mapped
upfront like this. However, the cc blob table does not exist on this
machine, and so whether the EFI config tables themselves are mapped or
not is irrelevant.

But it does mean the fix is incomplete, and certainly does not belong
in generic kexec code. If anything, we should be fixing the
decompressor code to defer the cc blob table check until after the
demand mapping code is up.

If this is problematic, we might instead disable SEV for kexec, and
rely on the fact that SEV firmware enters with a complete 1:1 map (as
we seem to be doing currently). If kexec for SEV is needed at some
point, we can re-enable it by having it provide a mapping for the
config table array and the cc blob table explicitly.
