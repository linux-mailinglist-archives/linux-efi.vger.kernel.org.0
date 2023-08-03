Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D77376EC7D
	for <lists+linux-efi@lfdr.de>; Thu,  3 Aug 2023 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjHCO2O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Aug 2023 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjHCO16 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Aug 2023 10:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE4DA;
        Thu,  3 Aug 2023 07:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDD0161DD1;
        Thu,  3 Aug 2023 14:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BC9C433CB;
        Thu,  3 Aug 2023 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691072875;
        bh=SYezfMKoOwd06i4EdWxJdHq56YPVKCiPJTP05WrmoRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ce/zqNjzKTx1w0oEMvSeHRwJFaXj5t64SjzqGMBvSrjuRDlSertEXIyMH6eFgCiR4
         0FzZRKjTZD7J/dSdi3DqzfDqUSH5JWTYDeC7sHxKW4qQJwJ3oazo6As/lYfBHcvIam
         Mbs7Z/NZEL9fhlCxBOL3BKW5YjA0/A0OEBkMg+2GsezEALvkmp1KnuODa5JlbpkvFI
         fk5ESeBlo7N+WiTKKW6BVICyWEOv4X9Ptqfydi8AwZrBxqgiNINnejLfVTzLAVC2ec
         O3FSVvpxkKWNzF/SoCH30FUCBkcIAdzeJyTkkO9plQNPKcBtdtkj5cuEJPIlb8EK+b
         BHWoMImDB56OA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so16109831fa.1;
        Thu, 03 Aug 2023 07:27:55 -0700 (PDT)
X-Gm-Message-State: ABy/qLYaZoXJigmzolcLIScSNkVaBf4AMyJ+Ag43KUBMLTX6BdDBpkFa
        iy5ae16oRhxCqsniY7aT5jC674kNq4qLW/3wCcw=
X-Google-Smtp-Source: APBJJlE2li6enqKdhY/67+FOLHVsKLoDwihFl4Guijp3+nlazzgS5h35KJKK4NMvZ4fFFAlcETvzQ20xCTP2P0SmadQ=
X-Received: by 2002:a2e:870a:0:b0:2b9:4821:22b6 with SMTP id
 m10-20020a2e870a000000b002b9482122b6mr8216088lji.10.1691072873230; Thu, 03
 Aug 2023 07:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local> <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local> <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local> <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local> <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
 <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local> <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Aug 2023 16:27:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
Message-ID: <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tao Liu <ltao@redhat.com>, Michael Roth <michael.roth@amd.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
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

On Thu, 3 Aug 2023 at 13:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 2 Aug 2023 at 17:52, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Aug 02, 2023 at 04:55:27PM +0200, Ard Biesheuvel wrote:
> > > ... because now, entering via startup_32 is broken, given that it only
> > > maps the kernel image itself and relies on the #PF handling for
> > > everything else it accesses, including firmware tables.
> > >
> > > AFAICT this also means that entering via startup_32 is broken entirely
> > > for any configuration that enables the cc blob config table check,
> > > regardless of the platform.
> >
> > Lemme brain-dump what Tom and I just talked on IRC.
> >
> > That startup_32 entry path for SNP guests was used with old grubs which
> > used to enter through there and not anymore, reportedly. Which means,
> > that must've worked at some point but Joerg would know. CCed.
> >
>
> Sadly, not only 'old' grubs - GRUB mainline only recently added
> support for booting Linux/x86 via the EFI stub (because I wrote the
> code for them), but it will still fall back to the previous mode for
> kernels that are built without EFI stub support, or which are older
> than ~v5.8 (because their EFI stub does not implement the generic EFI
> initrd loading mechanism)
>
> This fallback still appears to enter via startup_32, even when GRUB
> itself runs in long mode in the context of EFI.
>
> > Newer grubs enter through the 64-bit entry point and thus are fine
> > - otherwise we would be seeing explosions left and right.
> >
>
> Yeah. what seems to be saving our ass here is that startup_32 maps the
> first 1G of physical address space 4 times, and x86_64 EFI usually
> puts firmware tables below 4G. This means the cc blob check doesn't
> fault, but it may dereference bogus memory traversing the config table
> array looking for the cc blob GUID. However, the system table field
> holding the size of the array may also appear as bogus so this may
> still break in weird ways.
>
> > So dependent on what we wanna do, if we kill the 32-bit path, we can
> > kill the 32-bit C-bit verif code. But that's for later and an item on my
> > TODO list.
> >
>
> I don't think we can kill it yet, but it would be nice if we could
> avoid the need to support SNP boot when entering that way.

https://lists.gnu.org/archive/html/grub-devel/2023-08/msg00005.html

Coming to your distro any decade now!
