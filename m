Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34314FFBB6
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiDMQvD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiDMQvC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 12:51:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88447694A8;
        Wed, 13 Apr 2022 09:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A518B825EF;
        Wed, 13 Apr 2022 16:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D956BC385B1;
        Wed, 13 Apr 2022 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649868514;
        bh=W5Rf60oEFjgZFRko4gvOWE22lbGgMYC79qcAyl6Bjeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L75BlIuyCHjaQA4HE7L2QX1kjx7k7yMTESX1l9XEcRsUGtwiiU80X2IVM92A8GCp7
         3l2EVJbbFLfUCD+OTKr1U6uDCYqdwzhgLnzfsgmG3rc8rEe8HonznGLtvH0ic1icRG
         lV6VX9vnSe6oqwJJG4t/yQeWE0HW/MzBXwJJfIyccB4eyaoIx2KA7hIepMJYx5BO79
         7Gl40lh54niuprVWr90ykPKhxdr8RsVTjuoV2tqa/kDb9CywcfBlIOlDYltF42n1Sh
         5OPDgkueHMdvScuzJ23S94/qO9phhEagxL2+3nOpreKl0PrPYN/hNqm87UU1z0JyGv
         7ML4DPNzhkjXQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-d39f741ba0so2557022fac.13;
        Wed, 13 Apr 2022 09:48:34 -0700 (PDT)
X-Gm-Message-State: AOAM531lALGMhFBrgDnfMFkH0FK4jUAAXx+/rMmF4o/UDH9i1uixpVGr
        H4MRG48utTb7VeZbekC1hAGYMrs8QKfk+xUFhMM=
X-Google-Smtp-Source: ABdhPJwvWPaFmaZO9HwJqmqb82Kyqfurf4iagadp+RDPFOZFqf24kux+lbZxjGE6wAO6Limf6s0sASYqCfxTaRnVklo=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr4914280oap.228.1649868513679; Wed, 13
 Apr 2022 09:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220412212127.154182-1-dovmurik@linux.ibm.com>
In-Reply-To: <20220412212127.154182-1-dovmurik@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 18:48:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJaC-wdy1_ExOzP9UvGV_Ht+-SF_ySGzyzjd8aD92=BQ@mail.gmail.com>
Message-ID: <CAMj1kXFJaC-wdy1_ExOzP9UvGV_Ht+-SF_ySGzyzjd8aD92=BQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] Allow guest access to EFI confidential computing
 secret area
To:     Dov Murik <dovmurik@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
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
        Gerd Hoffmann <kraxel@redhat.com>,
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

(cc Jon for the Documentation/ changes)

On Tue, 12 Apr 2022 at 23:21, Dov Murik <dovmurik@linux.ibm.com> wrote:
>
> Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
> Virtualization) allows guest owners to inject secrets into the VMs
> memory without the host/hypervisor being able to read them.  In SEV,
> secret injection is performed early in the VM launch process, before the
> guest starts running.
>
> OVMF already reserves designated area for secret injection (in its
> AmdSev package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the
> Sev Secret area using a configuration table" [1]), but the secrets were
> not available in the guest kernel.
>
> The patch series keeps the address of the EFI-provided memory for
> injected secrets, and exposes the secrets to userspace via securityfs
> using a new efi_secret kernel module.  The module is autoloaded (by the
> EFI driver) if the secret area is populated.
>
> The first patch in EFI keeps the address of the secret area as passed in
> the EFI configuration table.  The second patch introduces the new
> efi_secret module that exposes the content of the secret entries as
> securityfs files, and allows clearing out secrets with a file unlink
> interface.  The third patch auto-loads the efi_secret module during
> startup if the injected secrets area is populated.  The last patch
> documents the data flow of confidential computing secret injection.
>
> As a usage example, consider a guest performing computations on
> encrypted files.  The Guest Owner provides the decryption key (= secret)
> using the secret injection mechanism.  The guest application reads the
> secret from the efi_secret filesystem and proceeds to decrypt the files
> into memory and then performs the needed computations on the content.
>
> In this example, the host can't read the files from the disk image
> because they are encrypted.  Host can't read the decryption key because
> it is passed using the secret injection mechanism (= secure channel).
> Host can't read the decrypted content from memory because it's a
> confidential (memory-encrypted) guest.
>
> This has been tested with AMD SEV and SEV-ES guests, but the kernel side
> of handling the secret area has no SEV-specific dependencies, and
> therefore might be usable (perhaps with minor changes) for any
> confidential computing hardware that can publish the secret area via the
> standard EFI config table entry.
>
> To enable this functionality, set CONFIG_EFI_SECRET=m when building the
> guest kernel.
>
> Here is a simple example for usage of the efi_secret module in a guest
> to which an EFI secret area with 4 secrets was injected during launch:
>
> ...
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi: CocoSecret=0x7f222680 SMBIOS=0x7f541000 ACPI=0x7f77e000 ACPI 2.0=0x7f77e014 MEMATTR=0x7ea16418
> ...
> [    1.127627] Run /init as init process
> Loading, please wait...
> Starting version 245.4-4ubuntu3.15
> ...
> [    0.763204] efi_secret efi_secret.0: Created 4 entries in securityfs secrets/coco
> ...
>
> # ls -la /sys/kernel/security/secrets/coco
> total 0
> drwxr-xr-x 2 root root 0 Jun 28 11:54 .
> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
>
> # hd /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
> 00000000  74 68 65 73 65 2d 61 72  65 2d 74 68 65 2d 6b 61  |these-are-the-ka|
> 00000010  74 61 2d 73 65 63 72 65  74 73 00 01 02 03 04 05  |ta-secrets......|
> 00000020  06 07                                             |..|
> 00000022
>
> # rm /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
>
> # ls -la /sys/kernel/security/secrets/coco
> total 0
> drwxr-xr-x 2 root root 0 Jun 28 11:55 .
> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
>
>
> [1] https://github.com/tianocore/edk2/commit/01726b6d23d4
>
>
> ---
>
> v10 changes:
> - Add #ifdef CONFIG_EFI_COCO_SECRET to platform device registration in
>   patch 3.
>

I have queued this up in efi/next. Jon, is that ok with you?

Thanks all,
