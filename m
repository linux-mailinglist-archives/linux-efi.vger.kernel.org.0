Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609FE4FDDFF
	for <lists+linux-efi@lfdr.de>; Tue, 12 Apr 2022 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbiDLLYe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353326AbiDLLYX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 07:24:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055CA98F7C;
        Tue, 12 Apr 2022 03:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 270DAB81BBA;
        Tue, 12 Apr 2022 10:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5578C385B4;
        Tue, 12 Apr 2022 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649757895;
        bh=gtObvUz5qCRpJc0RtVC3K8eVrLVVSXdYSjCClwfhmfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=krQz5LNrhl3gtajoIOtRaAdR5SMcegiZtBNAoyBjSIwKns16EQRV/S6pFZKrDJOh4
         20RCXYRUKdvOSVD40coKkQ3XtR92eLwqFy7ofnMUAtofsmv4XOBQFABzJ1tRCPVfbN
         IXpY8w1uWEiUzh8Kg5hkzT7ZR42N2smxPuyaHQwi24RZbXECtmVTLwc03Si/rN+r4v
         dknW0PZQELntgEm/UdwEYaUMRBbcOEHvE64947n99dgIaGvKdCfceegfJUb5IlFI08
         tLMHEoYghPah6rH28V1rrwDPy6G5QIf5HzpM5feMn0a9++s1lvEpYSajY1sWlpTAxY
         KVz5gkEiKt+kw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so20211742fac.11;
        Tue, 12 Apr 2022 03:04:55 -0700 (PDT)
X-Gm-Message-State: AOAM530yXNgtcj8TvlrcXTFy+SwMDSMipLUFeTfYktEq9QdS+Duoc46U
        AQUfEiIFe1ORIURkHOsczqVTZXoeFUeC9b3AFGs=
X-Google-Smtp-Source: ABdhPJzBfRdtpFhBmeTPriIQBUDch40V+DCtV0PMUEGK1A2oSvcsKj7EeDbH7DO7MJxob6lIbZTVRQxADuh3LcDNiDc=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr1711844oae.126.1649757894728; Tue, 12
 Apr 2022 03:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220331215607.3182232-1-dovmurik@linux.ibm.com> <48e087af-cc93-72f0-3907-9d1978530b87@linux.ibm.com>
In-Reply-To: <48e087af-cc93-72f0-3907-9d1978530b87@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 Apr 2022 12:04:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG1rqLjQMZvnPZzvyg+qfR-zaDnXVrDNRYYqr0dU=oW7w@mail.gmail.com>
Message-ID: <CAMj1kXG1rqLjQMZvnPZzvyg+qfR-zaDnXVrDNRYYqr0dU=oW7w@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Allow guest access to EFI confidential computing
 secret area
To:     Dov Murik <dovmurik@linux.ibm.com>
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

On Tue, 12 Apr 2022 at 12:03, Dov Murik <dovmurik@linux.ibm.com> wrote:
>
>
>
> On 01/04/2022 0:56, Dov Murik wrote:
> > Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
> > Virtualization) allows guest owners to inject secrets into the VMs
> > memory without the host/hypervisor being able to read them.  In SEV,
> > secret injection is performed early in the VM launch process, before the
> > guest starts running.
> >
> > OVMF already reserves designated area for secret injection (in its
> > AmdSev package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the
> > Sev Secret area using a configuration table" [1]), but the secrets were
> > not available in the guest kernel.
> >
> > The patch series keeps the address of the EFI-provided memory for
> > injected secrets, and exposes the secrets to userspace via securityfs
> > using a new efi_secret kernel module.  The module is autoloaded (by the
> > EFI driver) if the secret area is populated.
> >
> > The first patch in EFI keeps the address of the secret area as passed in
> > the EFI configuration table.  The second patch introduces the new
> > efi_secret module that exposes the content of the secret entries as
> > securityfs files, and allows clearing out secrets with a file unlink
> > interface.  The third patch auto-loads the efi_secret module during
> > startup if the injected secrets area is populated.  The last patch
> > documents the data flow of confidential computing secret injection.
> >
> > As a usage example, consider a guest performing computations on
> > encrypted files.  The Guest Owner provides the decryption key (= secret)
> > using the secret injection mechanism.  The guest application reads the
> > secret from the efi_secret filesystem and proceeds to decrypt the files
> > into memory and then performs the needed computations on the content.
> >
> > In this example, the host can't read the files from the disk image
> > because they are encrypted.  Host can't read the decryption key because
> > it is passed using the secret injection mechanism (= secure channel).
> > Host can't read the decrypted content from memory because it's a
> > confidential (memory-encrypted) guest.
> >
> > This has been tested with AMD SEV and SEV-ES guests, but the kernel side
> > of handling the secret area has no SEV-specific dependencies, and
> > therefore might be usable (perhaps with minor changes) for any
> > confidential computing hardware that can publish the secret area via the
> > standard EFI config table entry.
> >
> > To enable this functionality, set CONFIG_EFI_SECRET=m when building the
> > guest kernel.
> >
> > Here is a simple example for usage of the efi_secret module in a guest
> > to which an EFI secret area with 4 secrets was injected during launch:
> >
> > ...
> > [    0.000000] efi: EFI v2.70 by EDK II
> > [    0.000000] efi: CocoSecret=0x7f222680 SMBIOS=0x7f541000 ACPI=0x7f77e000 ACPI 2.0=0x7f77e014 MEMATTR=0x7ea16418
> > ...
> > [    1.127627] Run /init as init process
> > Loading, please wait...
> > Starting version 245.4-4ubuntu3.15
> > ...
> > [    0.763204] efi_secret efi_secret.0: Created 4 entries in securityfs secrets/coco
> > ...
> >
> > # ls -la /sys/kernel/security/secrets/coco
> > total 0
> > drwxr-xr-x 2 root root 0 Jun 28 11:54 .
> > drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> > -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> > -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> > -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> > -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
> >
> > # hd /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
> > 00000000  74 68 65 73 65 2d 61 72  65 2d 74 68 65 2d 6b 61  |these-are-the-ka|
> > 00000010  74 61 2d 73 65 63 72 65  74 73 00 01 02 03 04 05  |ta-secrets......|
> > 00000020  06 07                                             |..|
> > 00000022
> >
> > # rm /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
> >
> > # ls -la /sys/kernel/security/secrets/coco
> > total 0
> > drwxr-xr-x 2 root root 0 Jun 28 11:55 .
> > drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> > -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> > -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> > -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> >
> >
> > [1] https://github.com/tianocore/edk2/commit/01726b6d23d4
> >
> >
> > ---
> >
> > v9 changes:
> > - Change the module into a platform driver (thanks Ard)
> > - Remove special auto-loading code in efi; instead register a platform
> >   device (udev will load the efi_secret module) (thanks Ard)
> > - Change logging in the efi_secret module to dev_err() etc.
> > - efi_secret: first check that the secret area header is valid; only then start
> >   creating securityfs dirs.
> >
> > v8: https://lore.kernel.org/linux-coco/20220228114254.1099945-1-dovmurik@linux.ibm.com/
> > v8 changes:
> >  - Change path of filesystem to <securityfs>/secrets/coco and fix the
> >    documentation accordingly (Thanks Gerd, Matthew)
> >  - Remove patch 2/5 (of v7) because the latest OVMF release (edk2-stable202202)
> >    already contains the fix to mark the launch secret page as EFI_RESERVED_TYPE.
> >
> > v7: https://lore.kernel.org/linux-coco/20220201124413.1093099-1-dovmurik@linux.ibm.com/
> > v7 changes:
> >  - Improve description of efi_secret module in Kconfig.
> >  - Fix sparse warnings on pointer address space mismatch
> >    (Reported-by: kernel test robot <lkp@intel.com>)
> >
> > v6: https://lore.kernel.org/linux-coco/20211129114251.3741721-1-dovmurik@linux.ibm.com/
> > v6 changes:
> >  - Autoload the efi_secret module if the secret area is populated
> >    (thanks Greg KH).
> >  - efi_secret: Depend on X86_64 because we use ioremap_encrypted() which
> >    is only defined for this arch.
> >  - efi_secret.c: Remove unneeded tableheader_guid local variable.
> >  - Documentation fixes.
> >
> > v5: https://lore.kernel.org/linux-coco/20211118113359.642571-1-dovmurik@linux.ibm.com/
> > v5 changes:
> >  - Simplify EFI code: instead of copying the secret area, the firmware
> >    marks the secret area as EFI_RESERVED_TYPE, and then the uefi_init()
> >    code just keeps the pointer as it appears in the EFI configuration
> >    table.  The use of reserved pages is similar to the AMD SEV-SNP
> >    patches for handling SNP-Secrets and SNP-CPUID pages.
> >  - In order to handle OVMF releases out there which mark the
> >    confidential computing secrets page as EFI_BOOT_SERVICES_DATA, add
> >    efi/libstub code that detects this and fixes the E820 map to reserve
> >    this page.
> >  - In the efi_secret module code, map the secrets page using
> >    ioremap_encrypted (again, similar to the AMD SEV-SNP guest patches
> >    for accessing SNP-Secrets and SNP-CPUID pages).
> >  - Add documentation in Documentation/security/coco/efi_secret.
> >
> > v4: https://lore.kernel.org/linux-coco/20211020061408.3447533-1-dovmurik@linux.ibm.com/
> > v4 changes:
> >  - Guard all the new EFI and efi-stub code (patches 1+2) with #ifdef
> >    CONFIG_EFI_COCO_SECRET (thanks Greg KH).  Selecting
> >    CONFIG_EFI_SECRET=m (patch 3) will enable the EFI parts as well.
> >  - Guard call to clflush_cache_range() with #ifdef CONFIG_X86
> >    (Reported-by: kernel test robot <lkp@intel.com>)
> >
> > v3: https://lore.kernel.org/linux-coco/20211014130848.592611-1-dovmurik@linux.ibm.com/
> > v3 changes:
> >  - Rename the module to efi_secret
> >  - Remove the exporting of clean_cache_range
> >  - Use clflush_cache_range in wipe_memory
> >  - Document function wipe_memory
> >  - Initialize efi.coco_secret to EFI_INVALID_TABLE_ADDR to correctly detect
> >    when there's no secret area published in the EFI configuration tables
> >
> > v2: https://lore.kernel.org/linux-coco/20211007061838.1381129-1-dovmurik@linux.ibm.com
> > v2 changes:
> >  - Export clean_cache_range()
> >  - When deleteing a secret, call clean_cache_range() after explicit_memzero
> >  - Add Documentation/ABI/testing/securityfs-coco-sev_secret
> >
> > v1: https://lore.kernel.org/linux-coco/20210809190157.279332-1-dovmurik@linux.ibm.com/
> >
> > RFC: https://lore.kernel.org/linux-coco/20210628183431.953934-1-dovmurik@linux.ibm.com/
> >
> >
> >
> > Dov Murik (4):
> >   efi: Save location of EFI confidential computing area
> >   virt: Add efi_secret module to expose confidential computing secrets
> >   efi: Register efi_secret platform device if EFI secret area is
> >     declared
> >   docs: security: Add secrets/coco documentation
> >
>
>
> This series has Reviewed-by tags on all patches (though, as I mentioned,
> there's a missing #ifdef in patch 3).
>
> Ard, are you going to take this through the EFI tree?
>
> Should I resend the series with the fix for patch 3?
>

Yes, please send a final version with all tags in place etc, and I
will queue it up.

Thanks,
Ard.
