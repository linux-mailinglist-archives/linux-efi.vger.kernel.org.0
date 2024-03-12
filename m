Return-Path: <linux-efi+bounces-807-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EFF878D21
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 03:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9E01F21CAF
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361979D8;
	Tue, 12 Mar 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BgrUt4Wd"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204053A1;
	Tue, 12 Mar 2024 02:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211542; cv=none; b=qVYjYQ+A240gnloeLMDru6oitrjrmOwfv+CAyyMdpjXL/FZGRn1xXsIGfZZygB3fkczAesxrNxEmdK9itg2D+tRuU8ptfuAMd3XO6koOese7t8YnB9NnvNHKj+uPwJTbQtJCU30tE+eMHNfGeNSSYmlqGnqIC5Ym4s2qIKWNqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211542; c=relaxed/simple;
	bh=sJ+l+E/VHR/guBPSrktOtGce38nElCTRPvus+ARJhb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbImLsqoEs9K6IfD2tpCFRsbIy53UIIBUh55EFct0tZSTc9GKXF29tukbZz3/HIaUqfP0DsU+yo3zrCzLGPRwsQf3kT2GoTPddf6cziqgOrKO+dwlwDrlSwQ4WELRNQFMdBJmAx7T7X0+imJqP+OTE8WtHImNZDVHTmoTcPv2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BgrUt4Wd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LR+o5zx6xwTvGFqahXOz00NdsDR6t5e6f6CcML+dlxs=; b=BgrUt4WdadJ0f7/2G+ZQGGr/Sz
	++FE+t9xZ9M/Wf1J7p9XqDMoGq/5uJWG4G+cUpHTT3q15rTmfnQlpqCWReYebnvBKTHBjTXfUOvsv
	gN59aBHSGQzpgUingDpB/ph9p4GPsvq/hI24BB5waWN70a4CQ/1gbvAJ+XsfsCwbd902KxdAT/NCO
	fwErWMAg6vHCzAprNODWIuAjRsp7bvrAXIoXi/pScZ/DRlYX+SY2KFQOLKt09/ktiWifTeBtYUyst
	9/9Exp5lMEDDtWqKbSGT9Q9jSGIkHRcLiHvcO7FZJHhmhiNMtm5NG9EZB4SKLJBbTQnoNVGUqIgvn
	Y/hCP5HA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjs91-000000042zE-3WL5;
	Tue, 12 Mar 2024 02:45:35 +0000
Message-ID: <50ec3230-c2c9-4c16-899e-d93d164a3e79@infradead.org>
Date: Mon, 11 Mar 2024 19:45:34 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 8/8] clavis: Introduce new LSM called clavis
Content-Language: en-US
To: Eric Snowberg <eric.snowberg@oracle.com>,
 linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 mic@digikod.net, casey@schaufler-ca.com, stefanb@linux.ibm.com,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-9-eric.snowberg@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240311161111.3268190-9-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/24 09:11, Eric Snowberg wrote:
> In the future it is envisioned this LSM could be enhanced to provide
> access control for UEFI Secure Boot Advanced Targeting (SBAT).  Using
> the same clavis= boot param and storing the additional contents within
> the new RT UEFI var, SBAT restrictions could be maintained across kexec.

What does "RT" mean here?

(more below)

> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  Documentation/admin-guide/LSM/clavis.rst | 190 +++++++++++++++++++++++
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
>  12 files changed, 344 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/clavis.rst
>  create mode 100644 security/clavis/clavis.c
> 


> diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation/admin-guide/LSM/clavis.rst
> new file mode 100644
> index 000000000000..b0a73defb4fc
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/clavis.rst
> @@ -0,0 +1,190 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====
> +Clavis
> +=====
> +
> +Clavis is a Linux Security Module that provides mandatory access control to
> +system kernel keys (i.e. builtin, secondary, machine and platform). These
> +restrictions will prohit keys from being used for validation. Upon boot, the

                     prohibit

> +Clavis LSM is provided a key id as a boot param.  This single key is then
> +used as the root of trust for any access control modifications made going
> +forward. Access control updates must be signed and validated by this key.
> +
> +Clavis has its own keyring.  All ACL updates are applied through this keyring.
> +The update must be signed by the single root of trust key.
> +
> +When enabled, all system keys are prohibited from being used until an ACL is
> +added for it. There is two exceptions to this rule, builtin keys may be used

What is     "it"?  The predecessor seems to be "all system keys" (plural).


> +to validate both signed kernels and modules.
> +
> +Adding system kernel keys can only be performed by the machine owner, this

                                                                  owner;

> +could be through the Machine Owner Key (MOK) or the UEFI Secure Boot DB. It
> +is possible the machine owner and system administrator may be different
> +people. The system administrator will not be able to make ACL updates without
> +them being signed by the machine owner.
> +
> +On UEFI platforms, the root of trust key shall survive a kexec. Trying to
> +defeat or change it from the command line is not allowed.  The original boot
> +param is stored in UEFI and will always be referenced following a kexec.
> +
> +The Clavis LSM contains a system keyring call .clavis.  It contains a single
> +asymmetric key that is use to validate anything added to it.  This key can only
> +be added during boot and must be a preexisting system kernel key.  If the
> +clavis= boot param is not used, the keyring does not exist and the feature
> +can not be used until the next power on reset.

So just a reboot won't cause it to be used?  Must be power off/on?

> +
> +The only user space components are OpenSSL and the keyctl utility. A new
> +key type call clavis_key_acl is used for ACL updates. Any number of signed
> +clavis_key_acl entries may be added to the .clavis keyring. The clavis_key_acl
> +contains the subject key identifer along with the allowed usage type for

                            identifier

> +the key.
> +
> +The format is as follows:
> +::
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
> +The clavis_key_acl must be S/MIME signed by the sole asymmetric key contained
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
> +::
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
> +  emailAddress = john.doe@foo.com

There is a foo.com  ;)

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
> +::
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
> +::
> +
> +  mokutil --import ./clavis-lsm.x509
> +
> +and then reboot and enroll the key through the MokManager.
> +
> +How to enable the Clavis LSM
> +----------------------------
> +
> +Add the key id to the clavis= boot param.  With the example above the
> +key id is the subject key identifer: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8

                             identifier:

> +
> +Add the following boot param:
> +::
> +
> +  clavis=4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +After booting there will be a single key contained in the .clavis keyring:
> +::
> +
> +  $ keyctl show %:.clavis
> +  Keyring
> +    254954913 ----swrv      0     0  keyring: .clavis
> +    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +The original clavis= boot param will persist across any kexec. Changing it or
> +removing it has no effect.
> +
> +
> +How to sign an entry to be added to the .clavis keyring:
> +-------------------------------------------------------
> +
> +In this example we have 3 keys in the machine keyring.  Our Clavis LSM key, a
> +key we want to use for kernel verification and a key we want to use for module
> +verification.
> +::
> +
> +  $ keyctl show %:.machine
> +   Keyring
> +    999488265 ---lswrv      0     0  keyring: .machine
> +    912608009 ---lswrv      0     0   \_ asymmetric: TEST: Module Key: 17eb8c5bf766364be094c577625213700add9471
> +    646229664 ---lswrv      0     0   \_ asymmetric: TEST: Kernel Key: b360d113c848ace3f1e6a80060b43d1206f0487d
> +   1073737099 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +To update the .clavis kerying acl list.  First create a file containing the

                                 ACL list:
?

> +key usage type followed by a colon and the key id that we want to allow to
> +validate that usage.  In the first example we are saying key
> +17eb8c5bf766364be094c577625213700add9471 is allowed to validate kernel modules.
> +In the second example we are saying key b360d113c848ace3f1e6a80060b43d1206f0487d
> +is allowed to validate signed kernels.
> +
> +::
> +
> +  echo "00:17eb8c5bf766364be094c577625213700add9471" > module-acl.txt
> +  echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt
> +
> +Now both these files must be signed by the key contained in the .clavis keyring:
> +
> +::
> +
> +  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in module-acl.txt \
> +        -out module-acl.pkcs7 -binary -outform DER -nodetach -noattr
> +
> +  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in kernel-acl.txt \
> +        -out kernel-acl.pkcs7 -binary -outform DER -nodetach -noattr
> +
> +Afterwards the ACL list in the clavis keyring can be updated:
> +::
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



> diff --git a/security/security.c b/security/security.c
> index 4cb832b00c40..d1da60a1b7a4 100644
> --- a/security/security.c
> +++ b/security/security.c

> @@ -5313,6 +5314,19 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
>  	call_void_hook(key_post_create_or_update, keyring, key, payload,
>  		       payload_len, flags, create);
>  }
> +
> +/**
> + * security_key_verify_signature - verify signature
> + * @key: key
> + * @public_key_signature: signature

Above should be "@sig:".

> + *
> + * See wheather signature verification is allowed based on the ACL for

          whether

> + * key usage.
> + */
> +int security_key_verify_signature(const struct key *key, const struct public_key_signature *sig)
> +{
> +	return call_int_hook(key_verify_signature, key, sig);
> +}
>  #endif	/* CONFIG_KEYS */
>  
>  #ifdef CONFIG_AUDIT

-- 
#Randy

