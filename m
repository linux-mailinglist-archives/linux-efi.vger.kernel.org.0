Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AF849CBB3
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 14:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbiAZN6r (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 08:58:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36286 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbiAZN6q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 08:58:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27E88B81E4D;
        Wed, 26 Jan 2022 13:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A15EC340E3;
        Wed, 26 Jan 2022 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643205523;
        bh=MlpAabmQ4JYtkGLQhJb5n6x2seaU5znAQKHx0ndMt54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWbayifqJn9GedIaDKfjq3/DuTJ4jHHDsI5rnoaBzL/2LTKxVqWoQrSzlVajew0+U
         mpGUFmNMZimI+rteE1Vc2xUrYty7ilhCY5uuAXIt5dcrAOFOpvZ1eIdDYuDzE5j+P6
         Mb2sgxm/ZcKcxXFKeS1h+Kys5eJEJkZtaDF1/S1qKTfImcWY2vOfLkQnJwFdHNMCWq
         Fhi1OWh2aFgZD9eY6jL6fRdlcSOEgQu2o5ei3SnoQVzRHA/I6RqkCkKh0zb6HaORBZ
         EcWi4m2Cn4D6HdZyOzykpuvQ18iYt1vgi6wyrHMxI3fOqorVc3kiPmpKb2r3Ejuhom
         LYviphbqlRuaQ==
Date:   Wed, 26 Jan 2022 15:58:23 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 0/8] Enroll kernel keys thru MOK
Message-ID: <YfFTf6vIpNMIrwH0@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <YfFP6OHqBVNWKL2C@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFP6OHqBVNWKL2C@iki.fi>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 26, 2022 at 03:43:07PM +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 25, 2022 at 09:58:26PM -0500, Eric Snowberg wrote:
> > Back in 2013 Linus requested a feature to allow end-users to have the 
> > ability "to add their own keys and sign modules they trust". This was
> > his *second* order outlined here [1]. There have been many attempts 
> > over the years to solve this problem, all have been rejected.  Many 
> > of the failed attempts loaded all preboot firmware keys into the kernel,
> > including the Secure Boot keys. Many distributions carry one of these 
> > rejected attempts [2], [3], [4]. This series tries to solve this problem 
> > with a solution that takes into account all the problems brought up in 
> > the previous attempts.
> > 
> > On UEFI based systems, this series introduces a new Linux kernel keyring 
> > containing the Machine Owner Keys (MOK) called machine. It also defines
> > a new MOK variable in shim. This variable allows the end-user to decide 
> > if they want to load MOK keys into the machine keyring. 
> > 
> > By default, nothing changes; MOK keys are not loaded into the machine
> > keyring.  They are only loaded after the end-user makes the decision 
> > themselves.  The end-user would set this through mokutil using a new 
> > --trust-mok option [5]. This would work similar to how the kernel uses 
> > MOK variables to enable/disable signature validation as well as use/ignore 
> > the db. Any kernel operation that uses either the builtin or secondary 
> > trusted keys as a trust source shall also reference the new machine 
> > keyring as a trust source.
> > 
> > Secure Boot keys will never be loaded into the machine keyring.  They
> > will always be loaded into the platform keyring.  If an end-user wanted 
> > to load one, they would need to enroll it into the MOK.
> > 
> > Unlike previous versions of this patch set, IMA support has been removed
> > to simplify the series. After acceptance, a follow-on series will add IMA 
> > support.
> > 
> > Steps required by the end user:
> > 
> > Sign kernel module with user created key:
> > $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
> >    machine_signing_key.priv machine_signing_key.x509 my_module.ko
> > 
> > Import the key into the MOK
> > $ mokutil --import machine_signing_key.x509
> > 
> > Setup the kernel to load MOK keys into the .machine keyring
> > $ mokutil --trust-mok
> > 
> > Then reboot, the MokManager will load and ask if you want to trust the
> > MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
> > module will load.
> > 
> > I have included  a link to the mokutil [5] changes I have made to support 
> > this new functionality.  The shim changes have now been accepted
> > upstream [6].
> > 
> > Upstream shim is located here [7], the build instructions are here [8].
> > TLDR:
> > 
> > $ git clone --recurse-submodules https://github.com/rhboot/shim
> > $ cd shim
> > $ make
> > 
> > After building shim, move shimx64.efi and mmx64.efi to the vendor or 
> > distribution specific directory on your EFI System Partition (assuming
> > you are building on x86). The instructions above are the minimal
> > steps needed to build shim to test this feature. It is assumed
> > Secure Boot shall not be enabled for this testing. To do testing
> > with Secure Boot enabled, all steps in the build instructions [8]
> > must be followed.
> > 
> > Instructions for building mokutil (including the new changes):
> > 
> > $ git clone -b mokvars-v3 https://github.com/esnowberg/mokutil.git
> > $ cd mokutil/
> > $ ./autogen.sh
> > $ make
> > 
> > [1] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
> > [2] https://lore.kernel.org/lkml/1479737095.2487.34.camel@linux.vnet.ibm.com/
> > [3] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
> > [4] https://lore.kernel.org/linux-integrity/1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com/
> > [5] https://github.com/esnowberg/mokutil/tree/mokvars-v3
> > [6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f
> > [7] https://github.com/rhboot/shim
> > [8] https://github.com/rhboot/shim/blob/main/BUILDING
> > 
> > Eric Snowberg (8):
> >   integrity: Fix warning about missing prototypes
> >   integrity: Introduce a Linux keyring called machine
> >   integrity: add new keyring handler for mok keys
> >   KEYS: store reference to machine keyring
> >   KEYS: Introduce link restriction for machine keys
> >   efi/mokvar: move up init order
> >   integrity: Trust MOK keys if MokListTrustedRT found
> >   integrity: Only use machine keyring when uefi_check_trust_mok_keys is
> >     true
> > 
> >  certs/system_keyring.c                        | 44 ++++++++++-
> >  drivers/firmware/efi/mokvar-table.c           |  2 +-
> >  include/keys/system_keyring.h                 | 14 ++++
> >  security/integrity/Kconfig                    | 13 ++++
> >  security/integrity/Makefile                   |  1 +
> >  security/integrity/digsig.c                   | 15 +++-
> >  security/integrity/integrity.h                | 17 +++-
> >  .../platform_certs/keyring_handler.c          | 18 ++++-
> >  .../platform_certs/keyring_handler.h          |  5 ++
> >  security/integrity/platform_certs/load_uefi.c |  4 +-
> >  .../platform_certs/machine_keyring.c          | 77 +++++++++++++++++++
> >  11 files changed, 202 insertions(+), 8 deletions(-)
> >  create mode 100644 security/integrity/platform_certs/machine_keyring.c
> > 
> > 
> > base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> > -- 
> > 2.18.4
> > 
> 
> Thank you. I'll pick these soon. Is there any objections?

Mimi brought up that we need a MAINTAINERS update for this and also
.platform.

We have these:

- KEYS/KEYRINGS
- CERTIFICATE HANDLING

I would put them under KEYRINGS for now and would not consider further
subdivision for the moment.

/Jarkko
