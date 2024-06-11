Return-Path: <linux-efi+bounces-1196-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388B1902E67
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 04:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213421C21CEA
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 02:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF916F84B;
	Tue, 11 Jun 2024 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1UYISocw"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146FAAD59;
	Tue, 11 Jun 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073202; cv=none; b=OOqlvC1zfLacuJVDXBiQ7gzEleTYdQ6MRaV5icMeKui+/tcGPglp70RWc5KEqKObwLSO1U2qUt8WS5je+wo14EnNhXNQnKqpzGF9JGUPr/cjvfMJtbRIj6F2FX4BOat+lzUybzYt/1Jn10tiKI8oY7uD5ZG6JB+/Prttn86wksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073202; c=relaxed/simple;
	bh=THNgh4FZcql1DTTeV3hnnPPUyy1VqB0lKWjg99comYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3O6jikpxYez6utn/Ac5MQCGpV90GaW6NFEF4cO6Fmpyv3SeNSbbebHWjnnHcOsSYEej03H/VcdYZ2JIfmWFizJXI29PEOUqvs6iwEXax9IClma4SrmdkTVJ0VmRvakVhbqln/H7SSby4VF/ugddcVH/MySVKV3sokzSQUCTbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1UYISocw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=pShm9lxCJ+b2fSyVlY4N79GwCSVK+vqhYK/KheofYh8=; b=1UYISocwT3IrBF8cb6QHDhaMF3
	v7iPtZnFL66/FNLUfb/dsBdH/Fg1iXUp3ro8LY3vLE70WuCNj5K7unDgtqi08NH/kXK2hfBsGzlAY
	FVN2tXujo6GLYiUDDL3ztcDFLcuJ6A5sMcHUEUyx0ADHeVhsVmOz3VNy8nud0p0vQhR+6OvhDWzwz
	aht81RUK+fI6v+5YobacPb2PjXPoCf3jOdgpj6PTNdjxyX5dkfDu3FvdjmFsG2jSBoudXyurbagFE
	W9A2ZrF2xKK6UsCOJShYGtBtwh5Q6bc1zqjEk8Lp2ifUldNTQGLdzpMHlYI7OykuErtt9VzQpaPhx
	8OaT50rw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGrK2-00000007ABE-0zEf;
	Tue, 11 Jun 2024 02:33:18 +0000
Message-ID: <754d54b0-5848-4775-a989-43b75dac4dbf@infradead.org>
Date: Mon, 10 Jun 2024 19:33:16 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/8] clavis: Introduce new LSM called clavis
To: Eric Snowberg <eric.snowberg@oracle.com>,
 linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 mic@digikod.net, casey@schaufler-ca.com, stefanb@linux.ibm.com,
 ebiggers@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
 <20240531003945.44594-9-eric.snowberg@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240531003945.44594-9-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 5/30/24 5:39 PM, Eric Snowberg wrote:
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  Documentation/admin-guide/LSM/clavis.rst | 198 +++++++++++++++++++++++
>  MAINTAINERS                              |   7 +
>  crypto/asymmetric_keys/signature.c       |   4 +
>  include/linux/lsm_hook_defs.h            |   2 +
>  include/linux/security.h                 |   7 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |  10 +-
>  security/clavis/Makefile                 |   1 +
>  security/clavis/clavis.c                 |  25 +++
>  security/clavis/clavis.h                 |   4 +
>  security/clavis/clavis_keyring.c         |  83 ++++++++++
>  security/security.c                      |  16 +-
>  12 files changed, 352 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/clavis.rst
>  create mode 100644 security/clavis/clavis.c
> 
> diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation/admin-guide/LSM/clavis.rst
> new file mode 100644
> index 000000000000..d1641e3ef38b
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/clavis.rst
> @@ -0,0 +1,198 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======
> +Clavis
> +======
> +
> +Clavis is a Linux Security Module that provides mandatory access control to
> +system kernel keys (i.e. builtin, secondary, machine and platform). These
> +restrictions will prohibit keys from being used for validation. Upon boot, the
> +Clavis LSM is provided a key id as a boot param.  This single key is then

                                        boot parameter.

> +used as the root of trust for any access control modifications made going
> +forward. Access control updates must be signed and validated by this key.
> +
> +Clavis has its own keyring.  All ACL updates are applied through this keyring.
> +The update must be signed by the single root of trust key.
> +
> +When enabled, all system keys are prohibited from being used until an ACL is
> +added for them. There is two exceptions to this rule, builtin keys may be used

                   There are                       rule:


> +to validate both signed kernels and modules.
> +
> +Adding system kernel keys can only be performed by the machine owner; this
> +could be through the Machine Owner Key (MOK) or the UEFI Secure Boot DB. It
> +is possible the machine owner and system administrator may be different
> +people. The system administrator will not be able to make ACL updates without
> +them being signed by the machine owner.
> +
> +On UEFI platforms, the root of trust key shall survive a kexec. Trying to
> +defeat or change it from the command line is not allowed.  The original boot
> +param is stored in UEFI and will always be referenced following a kexec.

   parameter

> +
> +The Clavis LSM contains a system keyring call .clavis.  It contains a single
> +asymmetric key that is use to validate anything added to it.  This key can only

                          used

> +be added during boot and must be a preexisting system kernel key.  If the
> +``clavis=`` boot param is not used, the keyring does not exist and the feature

                    parameter

> +can not be used until the next reboot.

   cannot
preferably

> +
> +The only user space components are OpenSSL and the keyctl utility. A new
> +key type call ``clavis_key_acl`` is used for ACL updates. Any number of signed
> +``clavis_key_acl`` entries may be added to the .clavis keyring. The
> +``clavis_key_acl`` contains the subject key identifier along with the allowed
> +usage type for
> +the key.

Join 2 lines?

> +
> +The format is as follows:
> +
> +.. code-block:: console
> +
> +  XX:YYYYYYYYYYY
> +
> +  XX - Single byte of the key type
> +	VERIFYING_MODULE_SIGNATURE            00
> +	VERIFYING_FIRMWARE_SIGNATURE          01
> +	VERIFYING_KEXEC_PE_SIGNATURE          02
> +	VERIFYING_KEY_SIGNATURE               03
> +	VERIFYING_KEY_SELF_SIGNATURE          04
> +	VERIFYING_UNSPECIFIED_SIGNATURE       05
> +  :  - ASCII colon
> +  YY - Even number of hexadecimal characters representing the key id
> +
> +The ``clavis_key_acl`` must be S/MIME signed by the sole asymmetric key contained
> +within the .clavis keyring.
> +
> +In the future if new features are added, new key types could be created.
> +
> +Usage Examples
> +==============
> +
> +How to create a signing key:
> +----------------------------
> +
> +.. code-block:: bash
> +
> +  cat <<EOF > clavis-lsm.genkey
> +  [ req ]
> +  default_bits = 4096
> +  distinguished_name = req_distinguished_name
> +  prompt = no
> +  string_mask = utf8only
> +  x509_extensions = v3_ca
> +  [ req_distinguished_name ]
> +  O = TEST
> +  CN = Clavis LSM key
> +  emailAddress = user@example.com
> +  [ v3_ca ]
> +  basicConstraints=CA:TRUE
> +  subjectKeyIdentifier=hash
> +  authorityKeyIdentifier=keyid:always,issuer
> +  keyUsage=digitalSignature
> +  EOF
> +
> +  openssl req -new -x509 -utf8 -sha256 -days 3650 -batch \
> +        -config clavis-lsm.genkey -outform DER \
> +        -out clavis-lsm.x509 -keyout clavis-lsm.priv
> +
> +How to get the Subject Key Identifier
> +-------------------------------------
> +
> +.. code-block:: bash
> +
> +  openssl x509 -in ./clavis-lsm.x509 -inform der \
> +        -ext subjectKeyIdentifier  -nocert \
> +        | tail -n +2 | cut -f2 -d '='| tr -d ':'
> +  4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +How to enroll the signing key into the MOK
> +------------------------------------------
> +
> +The key must now be added to the machine or platform keyrings.  This
> +indicates the key was added by the system owner. To add to the machine
> +keyring on x86 do:

Are other architectures different? why?

> +
> +.. code-block:: bash
> +
> +  mokutil --import ./clavis-lsm.x509
> +
> +and then reboot and enroll the key through the MokManager.
> +
> +How to enable the Clavis LSM
> +----------------------------
> +
> +Add the key id to the ``clavis=`` boot param.  With the example above the

                                          parameter.

> +key id is the subject key identifier: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +Add the following boot param:

                          parameter:

> +
> +.. code-block:: console
> +
> +  clavis=4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +After booting there will be a single key contained in the .clavis keyring:
> +
> +.. code-block:: bash
> +
> +  keyctl show %:.clavis
> +  Keyring
> +    254954913 ----swrv      0     0  keyring: .clavis
> +    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +The original ``clavis=`` boot param will persist across any kexec. Changing it or

                                 parameter

> +removing it has no effect.
> +
> +
> +How to sign an entry to be added to the .clavis keyring:
> +--------------------------------------------------------
> +
> +In this example we have 3 keys in the machine keyring.  Our Clavis LSM key, a
> +key we want to use for kernel verification and a key we want to use for module
> +verification.
> +
> +.. code-block:: bash
> +
> +  keyctl show %:.machine
> +  Keyring
> +    999488265 ---lswrv      0     0  keyring: .machine
> +    912608009 ---lswrv      0     0   \_ asymmetric: TEST: Module Key: 17eb8c5bf766364be094c577625213700add9471
> +    646229664 ---lswrv      0     0   \_ asymmetric: TEST: Kernel Key: b360d113c848ace3f1e6a80060b43d1206f0487d
> +   1073737099 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +To update the .clavis kerying ACL list.  First create a file containing the

                                     list, first

> +key usage type followed by a colon and the key id that we want to allow to
> +validate that usage.  In the first example we are saying key
> +17eb8c5bf766364be094c577625213700add9471 is allowed to validate kernel modules.
> +In the second example we are saying key b360d113c848ace3f1e6a80060b43d1206f0487d
> +is allowed to validate signed kernels.
> +
> +.. code-block:: bash
> +
> +  echo "00:17eb8c5bf766364be094c577625213700add9471" > module-acl.txt
> +  echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt
> +
> +Now both these files must be signed by the key contained in the .clavis keyring:
> +
> +.. code-block:: bash
> +
> +  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in module-acl.txt \
> +        -out module-acl.pkcs7 -binary -outform DER -nodetach -noattr
> +
> +  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in kernel-acl.txt \
> +        -out kernel-acl.pkcs7 -binary -outform DER -nodetach -noattr
> +
> +Afterwards the ACL list in the clavis keyring can be updated:
> +
> +.. code-block:: bash
> +
> +  keyctl padd clavis_key_acl "" %:.clavis < module-acl.pkcs7
> +  keyctl padd clavis_key_acl "" %:.clavis < kernel-acl.pkcs7
> +
> +  keyctl show %:.clavis
> +
> +  Keyring
> +    254954913 ----swrv      0     0  keyring: .clavis
> +    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +   1013065475 --alswrv      0     0   \_ clavis_key_acl: 02:b360d113c848ace3f1e6a80060b43d1206f0487d
> +    445581284 --alswrv      0     0   \_ clavis_key_acl: 00:17eb8c5bf766364be094c577625213700add9471
> +
> +Now the 17eb8c5bf766364be094c577625213700add9471 key can be used for
> +validating kernel modules and the b360d113c848ace3f1e6a80060b43d1206f0487d
> +key can be used to validate signed kernels.


-- 
~Randy

