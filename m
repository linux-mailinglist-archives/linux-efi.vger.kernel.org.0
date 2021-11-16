Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6925445369E
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhKPQDe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 11:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238619AbhKPQDd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Nov 2021 11:03:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3FFA61C12;
        Tue, 16 Nov 2021 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637078436;
        bh=JwxnYwbgjPGa5I2tARYbozTLXPfvt8vxbd7WNU9JvRA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JHqr3wSXUs6/2LCB1i0BwUkEOuft8NUX2nn7LbdnN4RlbtrNAxVbkvnGGuWYDEHaj
         g+l8IXd4nWozKS4ef3PI7UaSErC/GWw4eQ+I0lrmgayG6SJogWxn34dtnveij05Yw2
         4mmnn6RLNJx6e/VAkFlN7yaIO7xYcKSgGSEi2+9kplKBoSZ928HsHJP0Sqm4arfD3t
         /e7854T6dbsJd9ghvbJegay0Uhyp4fVgz4rF/efpAaxTgu7X71UanxgwgyOZY29UJJ
         CzD6dqtEtonOIzvgCzaqKT5Mf0m2DSZ5v7JepbTROJHvcgncd8HYRVdCPNVjqAZzZO
         VE/H0jUXQRlqA==
Message-ID: <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
Subject: Re: [PATCH v7 00/17] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Tue, 16 Nov 2021 18:00:34 +0200
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> Back in 2013 Linus requested a feature to allow end-users to have the=20
> ability "to add their own keys and sign modules they trust". This was
> his *second* order outlined here [1]. There have been many attempts=20
> over the years to solve this problem, all have been rejected.=C2=A0 Many=
=20
> of the failed attempts loaded all preboot firmware keys into the kernel,
> including the Secure Boot keys. Many distributions carry one of these=20
> rejected attempts [2], [3], [4]. This series tries to solve this problem=
=20
> with a solution that takes into account all the problems brought up in=
=20
> the previous attempts.
>=20
> On UEFI based systems, this series introduces a new Linux kernel keyring=
=20
> containing the Machine Owner Keys (MOK) called machine. It also defines
> a new MOK variable in shim. This variable allows the end-user to decide=
=20
> if they want to load MOK keys into the machine keyring. Mimi has suggeste=
d=20
> that only CA keys contained within the MOK be loaded into the machine=20
> keyring. All other certs will load into the platform keyring instead.
>=20
> By default, nothing changes; MOK keys are not loaded into the machine
> keyring.=C2=A0 They are only loaded after the end-user makes the decision=
=20
> themselves.=C2=A0 The end-user would set this through mokutil using a new=
=20
> --trust-mok option [5]. This would work similar to how the kernel uses=
=20
> MOK variables to enable/disable signature validation as well as use/ignor=
e=20
> the db. Any kernel operation that uses either the builtin or secondary=
=20
> trusted keys as a trust source shall also reference the new machine=20
> keyring as a trust source.
>=20
> Secure Boot keys will never be loaded into the machine keyring.=C2=A0 The=
y
> will always be loaded into the platform keyring.=C2=A0 If an end-user wan=
ted=20
> to load one, they would need to enroll it into the MOK.
>=20
> Steps required by the end user:
>=20
> Sign kernel module with user created key:
> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
> =C2=A0=C2=A0 machine_signing_key.priv machine_signing_key.x509 my_module.=
ko
>=20
> Import the key into the MOK
> $ mokutil --import machine_signing_key.x509
>=20
> Setup the kernel to load MOK keys into the .machine keyring
> $ mokutil --trust-mok
>=20
> Then reboot, the MokManager will load and ask if you want to trust the
> MOK key and enroll the MOK into the MOKList.=C2=A0 Afterwards the signed =
kernel
> module will load.
>=20
> I have included=C2=A0 a link to the mokutil [5] changes I have made to su=
pport=20
> this new functionality.=C2=A0 The shim changes have now been accepted
> upstream [6].
>=20
> [1] https://marc.info/?l=3Dlinux-kernel&m=3D136185386310140&w=3D2
> [2] https://lore.kernel.org/lkml/1479737095.2487.34.camel@linux.vnet.ibm.=
com/
> [3] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnersh=
ip.com/
> [4] https://lore.kernel.org/linux-integrity/1e41f22b1f11784f1e943f32bf620=
34d4e054cdb.camel@HansenPartnership.com/
> [5] https://github.com/esnowberg/mokutil/tree/mokvars-v3
> [6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec=
130c5208f
>=20
> Eric Snowberg (17):
> =C2=A0 integrity: Introduce a Linux keyring called machine
> =C2=A0 integrity: Do not allow machine keyring updates following init
> =C2=A0 KEYS: Create static version of public_key_verify_signature
> =C2=A0 X.509: Parse Basic Constraints for CA
> =C2=A0 KEYS: CA link restriction
> =C2=A0 integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_=
ca
> =C2=A0 integrity: Fix warning about missing prototypes
> =C2=A0 integrity: add new keyring handler for mok keys
> =C2=A0 KEYS: Rename get_builtin_and_secondary_restriction
> =C2=A0 KEYS: add a reference to machine keyring
> =C2=A0 KEYS: Introduce link restriction for machine keys
> =C2=A0 KEYS: integrity: change link restriction to trust the machine keyr=
ing
> =C2=A0 KEYS: link secondary_trusted_keys to machine trusted keys
> =C2=A0 integrity: store reference to machine keyring
> =C2=A0 efi/mokvar: move up init order
> =C2=A0 integrity: Trust MOK keys if MokListTrustedRT found
> =C2=A0 integrity: Only use machine keyring when uefi_check_trust_mok_keys=
 is
> =C2=A0=C2=A0=C2=A0 true
>=20
> =C2=A0certs/system_keyring.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 44 ++++++++++-
> =C2=A0crypto/asymmetric_keys/restrict.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 43 +++++++++++
> =C2=A0crypto/asymmetric_keys/x509_cert_parser.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 +++
> =C2=A0drivers/firmware/efi/mokvar-table.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0include/crypto/public_key.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 =
++++
> =C2=A0include/keys/system_keyring.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++
> =C2=A0security/integrity/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 12 +++
> =C2=A0security/integrity/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> =C2=A0security/integrity/digsig.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 23 =
+++++-
> =C2=A0security/integrity/integrity.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++-
> =C2=A0.../platform_certs/keyring_handler.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++-
> =C2=A0.../platform_certs/keyring_handler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++
> =C2=A0security/integrity/platform_certs/load_uefi.c |=C2=A0 4 +-
> =C2=A0.../platform_certs/machine_keyring.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 77 +++++++++++++++++++
> =C2=A014 files changed, 273 insertions(+), 11 deletions(-)
> =C2=A0create mode 100644 security/integrity/platform_certs/machine_keyrin=
g.c
>=20
>=20
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf

Does shim have the necessary features in a release?

/Jarkko
