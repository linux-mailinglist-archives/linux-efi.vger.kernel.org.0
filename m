Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126894BD2B9
	for <lists+linux-efi@lfdr.de>; Mon, 21 Feb 2022 00:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbiBTXXB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Feb 2022 18:23:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbiBTXXA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Feb 2022 18:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D239A;
        Sun, 20 Feb 2022 15:22:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86C8E60FA7;
        Sun, 20 Feb 2022 23:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186BFC340E8;
        Sun, 20 Feb 2022 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645399357;
        bh=3z3X8nPJCphhYNhLkKRt8j/6BnWu10ouKJ/lOj8V9dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vzr4UtPq3g/zuq5Yx0UWTzFk5C47Z5UT1uYcxWnjNNIUKM4Rwaov+Doduz+HHTGg/
         r48VnDUm6JeGrW+vYEOaG/DGYLEUxUJNqJ3NM8i1xeoxhiJIA3ISyzENb8ahvNT8p8
         DFZPbBGibzvZtng+NnRASrEbwYxuUpmNL6UOO13vYzWA0QLQcFFyOfaNbfUWDqqu75
         HvAcnLXtj7HYnWMBXi6uGLrR7KgeJ+UapgZaViXuKjbWXTQtuOcTFpIWx2dEHdB5kV
         VZhEb5nlHneoOaJR2qerCZ6uQd/ArXmEp+dDX6xl2gFmSg6mwHEip8qPu04H+GxkoV
         DOpvHDOM+qGxQ==
Date:   Mon, 21 Feb 2022 00:23:15 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v8 00/17] Enroll kernel keys thru MOK
Message-ID: <YhLNYxBTbKW62vtC@iki.fi>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 23, 2021 at 11:41:07PM -0500, Eric Snowberg wrote:
> Back in 2013 Linus requested a feature to allow end-users to have the 
> ability "to add their own keys and sign modules they trust". This was
> his *second* order outlined here [1]. There have been many attempts 
> over the years to solve this problem, all have been rejected.  Many 
> of the failed attempts loaded all preboot firmware keys into the kernel,
> including the Secure Boot keys. Many distributions carry one of these 
> rejected attempts [2], [3], [4]. This series tries to solve this problem 
> with a solution that takes into account all the problems brought up in 
> the previous attempts.
> 
> On UEFI based systems, this series introduces a new Linux kernel keyring 
> containing the Machine Owner Keys (MOK) called machine. It also defines
> a new MOK variable in shim. This variable allows the end-user to decide 
> if they want to load MOK keys into the machine keyring. Mimi has suggested 
> that only CA keys contained within the MOK be loaded into the machine 
> keyring. All other certs will load into the platform keyring instead.
> 
> By default, nothing changes; MOK keys are not loaded into the machine
> keyring.  They are only loaded after the end-user makes the decision 
> themselves.  The end-user would set this through mokutil using a new 
> --trust-mok option [5]. This would work similar to how the kernel uses 
> MOK variables to enable/disable signature validation as well as use/ignore 
> the db. Any kernel operation that uses either the builtin or secondary 
> trusted keys as a trust source shall also reference the new machine 
> keyring as a trust source.
> 
> Secure Boot keys will never be loaded into the machine keyring.  They
> will always be loaded into the platform keyring.  If an end-user wanted 
> to load one, they would need to enroll it into the MOK.
> 
> Steps required by the end user:
> 
> Sign kernel module with user created key:
> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
>    machine_signing_key.priv machine_signing_key.x509 my_module.ko
> 
> Import the key into the MOK
> $ mokutil --import machine_signing_key.x509
> 
> Setup the kernel to load MOK keys into the .machine keyring
> $ mokutil --trust-mok
> 
> Then reboot, the MokManager will load and ask if you want to trust the
> MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
> module will load.
> 
> I have included  a link to the mokutil [5] changes I have made to support 
> this new functionality.  The shim changes have now been accepted
> upstream [6].
> 
> Upstream shim is located here [7], the build instructions are here [8].
> TLDR:
> 
> $ git clone --recurse-submodules https://github.com/rhboot/shim
> $ cd shim
> $ make
> 
> After building shim, move shimx64.efi and mmx64.efi to the vendor or 
> distribution specific directory on your EFI System Partition (assuming
> you are building on x86). The instructions above are the minimal
> steps needed to build shim to test this feature. It is assumed
> Secure Boot shall not be enabled for this testing. To do testing
> with Secure Boot enabled, all steps in the build instructions [8]
> must be followed.
> 
> Instructions for building mokutil (including the new changes):
> 
> $ git clone -b mokvars-v3 https://github.com/esnowberg/mokutil.git
> $ cd mokutil/
> $ ./autogen.sh
> $ make
> 
> [1] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
> [2] https://lore.kernel.org/lkml/1479737095.2487.34.camel@linux.vnet.ibm.com/
> [3] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
> [4] https://lore.kernel.org/linux-integrity/1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com/
> [5] https://github.com/esnowberg/mokutil/tree/mokvars-v3
> [6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f
> [7] https://github.com/rhboot/shim
> [8] https://github.com/rhboot/shim/blob/main/BUILDING
> 
> 
> Eric Snowberg (17):
>   KEYS: Create static version of public_key_verify_signature
>   integrity: Fix warning about missing prototypes
>   integrity: Introduce a Linux keyring called machine
>   integrity: Do not allow machine keyring updates following init
>   X.509: Parse Basic Constraints for CA
>   KEYS: CA link restriction
>   integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
>   integrity: add new keyring handler for mok keys
>   KEYS: Rename get_builtin_and_secondary_restriction
>   KEYS: add a reference to machine keyring
>   KEYS: Introduce link restriction for machine keys
>   KEYS: integrity: change link restriction to trust the machine keyring
>   integrity: store reference to machine keyring
>   KEYS: link machine trusted keys to secondary_trusted_keys
>   efi/mokvar: move up init order
>   integrity: Trust MOK keys if MokListTrustedRT found
>   integrity: Only use machine keyring when uefi_check_trust_mok_keys is
>     true
> 
>  certs/system_keyring.c                        | 48 +++++++++++-
>  crypto/asymmetric_keys/restrict.c             | 43 +++++++++++
>  crypto/asymmetric_keys/x509_cert_parser.c     |  9 +++
>  drivers/firmware/efi/mokvar-table.c           |  2 +-
>  include/crypto/public_key.h                   | 25 ++++++
>  include/keys/system_keyring.h                 | 14 ++++
>  security/integrity/Kconfig                    | 12 +++
>  security/integrity/Makefile                   |  1 +
>  security/integrity/digsig.c                   | 23 +++++-
>  security/integrity/integrity.h                | 17 +++-
>  .../platform_certs/keyring_handler.c          | 18 ++++-
>  .../platform_certs/keyring_handler.h          |  5 ++
>  security/integrity/platform_certs/load_uefi.c |  4 +-
>  .../platform_certs/machine_keyring.c          | 77 +++++++++++++++++++
>  14 files changed, 287 insertions(+), 11 deletions(-)
>  create mode 100644 security/integrity/platform_certs/machine_keyring.c
> 
> 
> base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
> -- 
> 2.18.4
> 

When I try to apply this:

$ b4  am 20211124044124.998170-8-eric.snowberg@oracle.com
Looking up https://lore.kernel.org/r/20211124044124.998170-8-eric.snowberg%40oracle.com
Analyzing 40 messages in the thread
Checking attestation on all messages, may take a moment...
# ...
$ git am -3 v8_20211123_eric_snowberg_enroll_kernel_keys_thru_mok.mbx
Applying: KEYS: Create static version of public_key_verify_signature
Applying: integrity: Fix warning about missing prototypes
Applying: integrity: Introduce a Linux keyring called machine
Applying: integrity: Do not allow machine keyring updates following init
Applying: X.509: Parse Basic Constraints for CA
Applying: KEYS: CA link restriction
error: sha1 information is lacking or useless (include/crypto/public_key.h).
error: could not build fake ancestor
Patch failed at 0006 KEYS: CA link restriction
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

BR, Jarkko
