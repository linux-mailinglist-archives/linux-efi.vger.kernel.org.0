Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DAD38A943
	for <lists+linux-efi@lfdr.de>; Thu, 20 May 2021 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhETLAd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 May 2021 07:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239098AbhETK5u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 May 2021 06:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621508188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQZCINOYapruthT4D/kwlMlBLQw/cWatEEnCVt5MAZo=;
        b=c5OO0FLuaTNkRySWlpEmx8JZUrd5JOu15OGzXfj/mOTqojc9acJD8aSP+4EwpyB217Y9t5
        rz5/YgMqXzuWvzr4VXgAWyJCnTVE8PevckNakQJzCDWiGzAIQrOdFm7biMciisNrSA51jd
        rnPGSprAEEVO3t9s2TrUX62qOVE42To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-zvnL7eXuN1ir7c5k61mAUg-1; Thu, 20 May 2021 06:56:26 -0400
X-MC-Unique: zvnL7eXuN1ir7c5k61mAUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE00801106;
        Thu, 20 May 2021 10:56:24 +0000 (UTC)
Received: from work-vm (ovpn-115-44.ams2.redhat.com [10.36.115.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F60F5D742;
        Thu, 20 May 2021 10:56:20 +0000 (UTC)
Date:   Thu, 20 May 2021 11:56:17 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, ak@linux.intel.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
Message-ID: <YKZAUdbikp2Pt0XV@work-vm>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> Hi Dov,
> 
> 
> On 5/13/21 1:26 AM, Dov Murik wrote:
> > Confidential computing hardware such as AMD SEV (Secure Encrypted
> > Virtualization) allows guest owners to inject secrets into the VMs
> > memory without the host/hypervisor being able to read them.  In SEV,
> > secret injection is performed early in the VM launch process, before the
> > guest starts running.
> >
> > Support for secret injection is already available in OVMF (in its AmdSev
> > package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the Sev
> > Secret area using a configuration table" [1]), but the secrets were not
> > available in the guest kernel.
> >
> > The patch series copies the secrets from the EFI-provided memory to
> > kernel reserved memory, and optionally exposes them to userspace via
> > securityfs using a new sev_secret kernel module.
> >
> > The first patch in efi/libstub copies the secret area from the EFI
> > memory to specially allocated memory; the second patch reserves that
> > memory block; and the third patch introduces the new sev_secret module
> > that exposes the content of the secret entries as securityfs files.
> >
> > This has been tested with AMD SEV guests, but the kernel side of
> > handling the secret area has no SEV-specific dependencies, and therefore
> > should be usable for any confidential computing hardware that can
> > publish the secret area via the standard EFI config table entry.
> >
> > Here is a simple example for usage of the sev_secret module in a guest to which
> > secrets were injected during launch:
> >
> > # modprobe sev_secret
> > # ls -la /sys/kernel/security/sev_secret
> > total 0
> > drwxr-xr-x 2 root root 0 May 12 18:03 .
> > drwxr-xr-x 3 root root 0 May 12 18:02 ..
> > -r--r----- 1 root root 0 May 12 18:03 736870e5-84f0-4973-92ec-06879ce3da0b
> > -r--r----- 1 root root 0 May 12 18:03 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> > -r--r----- 1 root root 0 May 12 18:03 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> > -r--r----- 1 root root 0 May 12 18:03 e6f5a162-d67f-4750-a67c-5d065f2a9910
> >
> > # xxd /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> > 00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
> > 00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
> > 00000020: 0607                                     ..
> 
> I am adding a new virt driver to help get the attestation report for the
> SEV-SNP guest. I understand they both are different, in case of the SEV
> the attestation is already completed and we are simply exposing the
> secret provided after the attestation to the userspace, whereas in SNP,
> the userspace is querying the attestation and will probably derive keys
> etc based on the attestation report. I am wondering if we should merge
> both the SEV secret and SNP attestation query in a single driver ?
> Should we cover usecases where SEV guest is not booted under the EFI ?
> Also, it appears that this driver need to be manually loaded, should we
> create a platform device so that the driver binds to platform device and
> use the resource structure to find the location of the secret data?

The nice thing about Dov's device/file is that it's a simple text file
that userspace can then read the secret out of;  I'm not sure if there's
anything similar in SNP (or for that matter TDX, cc'ing in Andi)

Dave

> I was trying to answer some of these questions SNP series. See these patches
> 
> https://marc.info/?l=kvm&m=161978514019741&w=2
> 
> https://marc.info/?l=kvm&m=161978514119744&w=2
> 
> https://marc.info/?l=kvm&m=161978514219751&w=2
> 
> 
> >
> > [1] https://github.com/tianocore/edk2/commit/01726b6d23d4
> >
> >
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Ashish Kalra <ashish.kalra@amd.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: James Bottomley <jejb@linux.ibm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-efi@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > Dov Murik (3):
> >   efi/libstub: Copy confidential computing secret area
> >   efi: Reserve confidential computing secret area
> >   virt: Add sev_secret module to expose confidential computing secrets
> >
> >  drivers/firmware/efi/Makefile                 |   2 +-
> >  drivers/firmware/efi/confidential-computing.c |  41 +++
> >  drivers/firmware/efi/efi.c                    |   5 +
> >  drivers/firmware/efi/libstub/Makefile         |   3 +-
> >  .../efi/libstub/confidential-computing.c      |  68 +++++
> >  drivers/firmware/efi/libstub/efi-stub.c       |   2 +
> >  drivers/firmware/efi/libstub/efistub.h        |   2 +
> >  drivers/firmware/efi/libstub/x86-stub.c       |   2 +
> >  drivers/virt/Kconfig                          |   2 +
> >  drivers/virt/Makefile                         |   1 +
> >  drivers/virt/sev_secret/Kconfig               |  11 +
> >  drivers/virt/sev_secret/Makefile              |   2 +
> >  drivers/virt/sev_secret/sev_secret.c          | 260 ++++++++++++++++++
> >  include/linux/efi.h                           |  11 +
> >  14 files changed, 410 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/firmware/efi/confidential-computing.c
> >  create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c
> >  create mode 100644 drivers/virt/sev_secret/Kconfig
> >  create mode 100644 drivers/virt/sev_secret/Makefile
> >  create mode 100644 drivers/virt/sev_secret/sev_secret.c
> >
> >
> > base-commit: c06a2ba62fc401b7aaefd23f5d0bc06d2457ccc1
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

