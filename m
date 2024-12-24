Return-Path: <linux-efi+bounces-2482-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EBE9FC110
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D3718840E4
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0D212F88;
	Tue, 24 Dec 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aKasivIp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B141D799D;
	Tue, 24 Dec 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735062312; cv=none; b=XY+w+BEWHESKZO+OpG7/KUysIBZ+GMY6W+wGh2yu6NiZZvWBvsmin/kxxkWWbjdVZ2mxhAwxJ1L28mO/m39HTdgJOEeyPYAgXI65yOkIMSxyPZqEmyIR3rFxNlcrZ7GoFha5b8mkbf5E2LYftsj2mkVRv7F8AYyTadOZiSy75Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735062312; c=relaxed/simple;
	bh=wHnb+WImNcE/bGTP5OYYvXsFJXXpjWcMLlUClt+mTc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7tp1KAcLl4SHDGxjKXh2IcFVBW7dVJgRrIjYG7QCwLD/8XIWU1bynoall6mX2ddVxS/nPPo44Gmsewe2bXc8Ait+eWK9BYJVVqmPs7GwTvspoHrEcA7svi4uXZSg4sK8BnUjgr7CswXKC3uCBNsOF8JqEtgvpvVYCWYj21PTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aKasivIp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOGavWp025841;
	Tue, 24 Dec 2024 17:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dKestP
	QpUv2K3Y/1wqeTXcp/HysTpHiRWQPfgUpOOQg=; b=aKasivIpDXEZXY4yiF+INH
	6vKNlveP+5zXnFdSO0bTLM3wcVR0M8EJuTOcY+PbkNrpuYD2xcRtBtlqpsYq3ehf
	mBjJa2/22pFrTSiChiAqjsZ/cw12bUBE92dx5R3H24n8MmGOdI427UA8yeuDb6bB
	Ca+1DDGuaRet/RNBEwTwjLcttK9aiAjZKr4oFHlVUusBcMxvGn2UxXyewC2BNm36
	FfJuR8lJ1GVl6gbiw5PFURguB8liskit6hrpmbFsKlJde2Fm91ykS1N3WA1JUdH9
	u9v8r/q09c6SqC4J3p3mtfiLm/kPtRtLopSgG8X45AwEI9t4NMe3L3up01kHrEYA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43qj0hbh67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 17:43:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BOHhZjE004346;
	Tue, 24 Dec 2024 17:43:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43qj0hbh63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 17:43:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOG5N5M010606;
	Tue, 24 Dec 2024 17:43:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p90n2vjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 17:43:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BOHhWJO32375494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 17:43:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D08F58053;
	Tue, 24 Dec 2024 17:43:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6575C58043;
	Tue, 24 Dec 2024 17:43:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.59.17])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Dec 2024 17:43:29 +0000 (GMT)
Message-ID: <0d71ffced35abf40bbfadb6e03b053c24757183d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>,
        linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, mic@digikod.net,
        casey@schaufler-ca.com, stefanb@linux.ibm.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Tue, 24 Dec 2024 12:43:28 -0500
In-Reply-To: <20241017155516.2582369-9-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-9-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X3ts4smAvCrt3bySj_tjCFakYo_zuN3n
X-Proofpoint-GUID: 68eFynIMHPivo4ZDpPOipK-XozvnKAUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240152

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Introduce a new LSM called clavis.  The motivation behind this LSM is to
> provide access control for system keys.  The access control list is
> contained within a keyring call .clavis.  During boot if the clavis=3D bo=
ot
> arg is supplied with a key id contained within any of the current system
> keyrings (builtin, secondary, machine, or platform) it shall be used as
> the root of trust for validating anything that is added to the ACL list.
>=20
> The first restriction introduced with this LSM is the ability to enforce
> key usage.  The kernel already has a notion of tracking key usage.  This
> LSM adds the ability to enforce this usage based on the system owners
> configuration.
>=20
> Each system key may have one or more uses defined within the ACL list.
> Until an entry is added to the .clavis keyring, no other system key may
> be used for any other purpose.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  Documentation/admin-guide/LSM/clavis.rst      | 191 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  crypto/asymmetric_keys/signature.c            |   4 +
>  include/linux/lsm_count.h                     |   8 +-
>  include/linux/lsm_hook_defs.h                 |   2 +
>  include/linux/security.h                      |   7 +
>  include/uapi/linux/lsm.h                      |   1 +
>  security/Kconfig                              |  10 +-
>  security/clavis/Makefile                      |   1 +
>  security/clavis/clavis.c                      |  26 +++
>  security/clavis/clavis.h                      |   4 +
>  security/clavis/clavis_keyring.c              |  78 ++++++-
>  security/security.c                           |  13 ++
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  14 files changed, 346 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/clavis.rst
>  create mode 100644 security/clavis/clavis.c
>=20
> diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation/adm=
in-guide/LSM/clavis.rst
> new file mode 100644
> index 000000000000..0e924f638a86
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/clavis.rst
> @@ -0,0 +1,191 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D
> +Clavis
> +=3D=3D=3D=3D=3D=3D
> +
> +Clavis is a Linux Security Module that provides mandatory access control=
 to
> +system kernel keys (i.e. builtin, secondary, machine and platform). Thes=
e
> +restrictions will prohibit keys from being used for validation. Upon boo=
t, the
> +Clavis LSM is provided a key id as a boot parameter.  This single key is=
 then
> +used as the root of trust for any access control modifications made goin=
g
> +forward. Access control updates must be signed and validated by this key=
.
> +
> +Clavis has its own keyring.  All ACL updates are applied through this ke=
yring.
> +The update must be signed by the single root of trust key.
> +
> +When enabled, all system keys are prohibited from being used until an AC=
L is
> +added for them.

Until the single key has been loaded, Clavis is not enabled.  Any key on th=
e
system trusted keyrings remains usable for any purpose.

-> When enabled, meaning the single key has been loaded onto the Clavis key=
ring,
all system keys are prohibited ...

Until clavis is enabled, in my opinion the defaults should be restrictive (=
e.g.
CONFIG_INTEGRITY_CA_MACHINE_KEYRING,
CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN). Once Clavis is enabled=
,
based=C2=A0on a new helper function is_clavis_enforced() we could consider =
relaxing
some of the existing keyring requirements (e.g. kernel modules).

Mimi

> +
> +On UEFI platforms, the root of trust key shall survive a kexec. Trying t=
o
> +defeat or change it from the command line is not allowed.  The original =
boot
> +parameter is stored in UEFI and will always be referenced following a ke=
xec.
> +
> +The Clavis LSM contains a system keyring call .clavis.  It contains a si=
ngle
> +asymmetric key that is used to validate anything added to it.  This key =
can
> +be added during boot and must be a preexisting system kernel key.  If th=
e
> +``clavis=3D`` boot parameter is not used, any asymmetric key the user ow=
ns
> +can be added to enable the LSM.
> +
> +The only user space components are OpenSSL and the keyctl utility. A new
> +key type call ``clavis_key_acl`` is used for ACL updates. Any number of =
signed
> +``clavis_key_acl`` entries may be added to the .clavis keyring. The
> +``clavis_key_acl`` contains the subject key identifier along with the al=
lowed
> +usage type for the key.
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
> +The ``clavis_key_acl`` must be S/MIME signed by the sole asymmetric key =
contained
> +within the .clavis keyring.
> +
> +In the future if new features are added, new key types could be created.
> +
> +Usage Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +How to create a signing key:
> +----------------------------
> +
> +.. code-block:: bash
> +
> +  cat <<EOF > clavis-lsm.genkey
> +  [ req ]
> +  default_bits =3D 4096
> +  distinguished_name =3D req_distinguished_name
> +  prompt =3D no
> +  string_mask =3D utf8only
> +  x509_extensions =3D v3_ca
> +  [ req_distinguished_name ]
> +  O =3D TEST
> +  CN =3D Clavis LSM key
> +  emailAddress =3D user@example.com
> +  [ v3_ca ]
> +  basicConstraints=3DCA:TRUE
> +  subjectKeyIdentifier=3Dhash
> +  authorityKeyIdentifier=3Dkeyid:always,issuer
> +  keyUsage=3DdigitalSignature
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
> +        | tail -n +2 | cut -f2 -d '=3D'| tr -d ':'
> +  4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +How to enroll the signing key into the MOK
> +------------------------------------------
> +
> +The key must now be added to the machine or platform keyrings.  This
> +indicates the key was added by the system owner. For kernels booted thro=
ugh
> +shim, a first-stage UEFI boot loader, a key may be added to the machine =
keyring
> +by doing:
> +
> +.. code-block:: bash
> +
> +  mokutil --import ./clavis-lsm.x509
> +
> +and then rebooting and enrolling the key through MokManager.
> +
> +How to enable the Clavis LSM
> +----------------------------
> +
> +Add the key id to the ``clavis=3D`` boot parameter.  With the example ab=
ove the
> +key id is the subject key identifier: 4a00ab9f35c9dc3aed7c225d22bafcbd92=
85e1e8
> +
> +Add the following boot parameter:
> +
> +.. code-block:: console
> +
> +  clavis=3D4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +After booting there will be a single key contained in the .clavis keyrin=
g:
> +
> +.. code-block:: bash
> +
> +  keyctl show %:.clavis
> +  Keyring
> +    254954913 ----swrv      0     0  keyring: .clavis
> +    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM ke=
y: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +The original ``clavis=3D`` boot parameter will persist across any kexec.=
 Changing it or
> +removing it has no effect.
> +
> +
> +How to sign an entry to be added to the .clavis keyring:
> +--------------------------------------------------------
> +
> +In this example we have 3 keys in the machine keyring.  Our Clavis LSM k=
ey, a
> +key we want to use for kernel verification and a key we want to use for =
module
> +verification.
> +
> +.. code-block:: bash
> +
> +  keyctl show %:.machine
> +  Keyring
> +    999488265 ---lswrv      0     0  keyring: .machine
> +    912608009 ---lswrv      0     0   \_ asymmetric: TEST: Module Key: 1=
7eb8c5bf766364be094c577625213700add9471
> +    646229664 ---lswrv      0     0   \_ asymmetric: TEST: Kernel Key: b=
360d113c848ace3f1e6a80060b43d1206f0487d
> +   1073737099 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM ke=
y: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +
> +To update the .clavis kerying ACL list, first create a file containing t=
he
> +key usage type followed by a colon and the key id that we want to allow =
to
> +validate that usage.  In the first example we are saying key
> +17eb8c5bf766364be094c577625213700add9471 is allowed to validate kernel m=
odules.
> +In the second example we are saying key b360d113c848ace3f1e6a80060b43d12=
06f0487d
> +is allowed to validate signed kernels.
> +
> +.. code-block:: bash
> +
> +  echo "00:17eb8c5bf766364be094c577625213700add9471" > module-acl.txt
> +  echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt
> +
> +Now both these files must be signed by the key contained in the .clavis =
keyring:
> +
> +.. code-block:: bash
> +
> +  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in=
 module-acl.txt \
> +        -out module-acl.pkcs7 -binary -outform DER -nodetach -noattr
> +
> +  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in=
 kernel-acl.txt \
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
> +    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM ke=
y: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
> +   1013065475 --alswrv      0     0   \_ clavis_key_acl: 02:b360d113c848=
ace3f1e6a80060b43d1206f0487d
> +    445581284 --alswrv      0     0   \_ clavis_key_acl: 00:17eb8c5bf766=
364be094c577625213700add9471
> +
> +Now the 17eb8c5bf766364be094c577625213700add9471 key can be used for
> +validating kernel modules and the b360d113c848ace3f1e6a80060b43d1206f048=
7d
> +key can be used to validate signed kernels.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ad507f49324..748ba3f1143e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5567,6 +5567,13 @@ F:	scripts/Makefile.clang
>  F:	scripts/clang-tools/
>  K:	\b(?i:clang|llvm)\b
> =20
> +CLAVIS LINUX SECURITY MODULE
> +M:	Eric Snowberg <eric.snowberg@oracle.com>
> +L:	linux-security-module@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/admin-guide/LSM/clavis.rst
> +F:	security/clavis
> +
>  CLK API
>  M:	Russell King <linux@armlinux.org.uk>
>  L:	linux-clk@vger.kernel.org
> diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/=
signature.c
> index 2deff81f8af5..7e3a78650a93 100644
> --- a/crypto/asymmetric_keys/signature.c
> +++ b/crypto/asymmetric_keys/signature.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/keyctl.h>
> +#include <linux/security.h>
>  #include <crypto/public_key.h>
>  #include <keys/user-type.h>
>  #include "asymmetric_keys.h"
> @@ -153,6 +154,9 @@ int verify_signature(const struct key *key,
> =20
>  	ret =3D subtype->verify_signature(key, sig);
> =20
> +	if (!ret)
> +		ret =3D security_key_verify_signature(key, sig);
> +
>  	pr_devel("<=3D=3D%s() =3D %d\n", __func__, ret);
>  	return ret;
>  }
> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> index 16eb49761b25..146aba3993d9 100644
> --- a/include/linux/lsm_count.h
> +++ b/include/linux/lsm_count.h
> @@ -102,6 +102,11 @@
>  #define IPE_ENABLED
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_SECURITY_CLAVIS)
> +#define CLAVIS_ENABLED 1,
> +#else
> +#define CLAVIS_ENABLED
> +#endif
>  /*
>   *  There is a trailing comma that we need to be accounted for. This is =
done by
>   *  using a skipped argument in __COUNT_LSMS
> @@ -124,7 +129,8 @@
>  		LANDLOCK_ENABLED	\
>  		IMA_ENABLED		\
>  		EVM_ENABLED		\
> -		IPE_ENABLED)
> +		IPE_ENABLED		\
> +		CLAVIS_ENABLED)
> =20
>  #else
> =20
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 9eca013aa5e1..a405122a4657 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -410,6 +410,8 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, ch=
ar **buffer)
>  LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyr=
ing,
>  	 struct key *key, const void *payload, size_t payload_len,
>  	 unsigned long flags, bool create)
> +LSM_HOOK(int, 0, key_verify_signature, const struct key *key,
> +	 const struct public_key_signature *sig)
>  #endif /* CONFIG_KEYS */
> =20
>  #ifdef CONFIG_AUDIT
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 2ec8f3014757..4439be172a51 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -63,6 +63,7 @@ enum fs_value_type;
>  struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
> +struct public_key_signature;
> =20
>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
> @@ -2053,6 +2054,7 @@ void security_key_post_create_or_update(struct key =
*keyring, struct key *key,
>  					const void *payload, size_t payload_len,
>  					unsigned long flags, bool create);
> =20
> +int security_key_verify_signature(const struct key *key, const struct pu=
blic_key_signature *sig);
>  #else
> =20
>  static inline int security_key_alloc(struct key *key,
> @@ -2087,6 +2089,11 @@ static inline void security_key_post_create_or_upd=
ate(struct key *keyring,
>  						      bool create)
>  { }
> =20
> +static inline int security_key_verify_signature(const struct key *key,
> +						const struct public_key_signature *sig)
> +{
> +	return 0;
> +}
>  #endif
>  #endif /* CONFIG_KEYS */
> =20
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..a2ef13c71143 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -65,6 +65,7 @@ struct lsm_ctx {
>  #define LSM_ID_IMA		111
>  #define LSM_ID_EVM		112
>  #define LSM_ID_IPE		113
> +#define LSM_ID_CLAVIS		114
> =20
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes
> diff --git a/security/Kconfig b/security/Kconfig
> index 714ec08dda96..90355ddec5c0 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -265,11 +265,11 @@ endchoice
> =20
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,=
apparmor,ipe,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smac=
k,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DE=
FAULT_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf" if DEFAULT_S=
ECURITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,=
apparmor,ipe,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,=
apparmor,ipe,bpf,clavis" if DEFAULT_SECURITY_SMACK
> +	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smac=
k,tomoyo,ipe,bpf,clavis" if DEFAULT_SECURITY_APPARMOR
> +	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf,clavis=
" if DEFAULT_SECURITY_TOMOYO
> +	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf,clavis" if DE=
FAULT_SECURITY_DAC
> +	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,=
apparmor,ipe,bpf,clavis"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list, except for those with order
> diff --git a/security/clavis/Makefile b/security/clavis/Makefile
> index 16c451f45f37..a3430dd6bdf9 100644
> --- a/security/clavis/Makefile
> +++ b/security/clavis/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  obj-$(CONFIG_SECURITY_CLAVIS) +=3D clavis_keyring.o
> +obj-$(CONFIG_SECURITY_CLAVIS) +=3D clavis.o
> diff --git a/security/clavis/clavis.c b/security/clavis/clavis.c
> new file mode 100644
> index 000000000000..21ade9e625dc
> --- /dev/null
> +++ b/security/clavis/clavis.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +#include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> +#include "clavis.h"
> +
> +static struct security_hook_list clavis_hooks[] __ro_after_init =3D {
> +	LSM_HOOK_INIT(key_verify_signature, clavis_sig_verify),
> +};
> +
> +const struct lsm_id clavis_lsmid =3D {
> +	.name =3D "clavis",
> +	.id =3D LSM_ID_CLAVIS,
> +};
> +
> +static int __init clavis_lsm_init(void)
> +{
> +	clavis_keyring_init();
> +	security_add_hooks(clavis_hooks, ARRAY_SIZE(clavis_hooks), &clavis_lsmi=
d);
> +	return 0;
> +};
> +
> +DEFINE_LSM(clavis) =3D {
> +	.name =3D "clavis",
> +	.init =3D clavis_lsm_init,
> +};
> diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
> index 92f77a1939ad..b77e4ec8edbe 100644
> --- a/security/clavis/clavis.h
> +++ b/security/clavis/clavis.h
> @@ -3,6 +3,8 @@
>  #define _SECURITY_CLAVIS_H_
>  #include <keys/asymmetric-type.h>
> =20
> +struct public_key_signature;
> +
>  /* Max length for the asymmetric key id contained on the boot param */
>  #define CLAVIS_BIN_KID_MAX   32
>  #define CLAVIS_ASCII_KID_MAX 64
> @@ -20,4 +22,6 @@ const char __initconst *const clavis_module_acl[] =3D {
>  extern const char __initconst *const clavis_module_acl[];
>  #endif
> =20
> +int __init clavis_keyring_init(void);
> +int clavis_sig_verify(const struct key *key, const struct public_key_sig=
nature *sig);
>  #endif /* _SECURITY_CLAVIS_H_ */
> diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_ke=
yring.c
> index 2a18d0e77189..1e1fbb54f6be 100644
> --- a/security/clavis/clavis_keyring.c
> +++ b/security/clavis/clavis_keyring.c
> @@ -284,7 +284,7 @@ static void clavis_add_acl(const char *const *skid_li=
st, struct key *keyring)
>  	}
>  }
> =20
> -static int __init clavis_keyring_init(void)
> +int __init clavis_keyring_init(void)
>  {
>  	struct key_restriction *restriction;
> =20
> @@ -306,10 +306,82 @@ static int __init clavis_keyring_init(void)
> =20
>  void __init late_init_clavis_setup(void)
>  {
> -	clavis_keyring_init();
> -
>  	if (!clavis_boot_akid)
>  		return;
> =20
>  	system_key_link(clavis_keyring, clavis_boot_akid);
>  }
> +
> +int clavis_sig_verify(const struct key *key, const struct public_key_sig=
nature *sig)
> +{
> +	const struct asymmetric_key_ids *kids =3D asymmetric_key_ids(key);
> +	const struct asymmetric_key_subtype *subtype;
> +	const struct asymmetric_key_id *newkid;
> +	char *buf_ptr, *ptr;
> +	key_ref_t ref;
> +	int i, buf_len;
> +
> +	if (!clavis_acl_enforced())
> +		return 0;
> +	if (key->type !=3D &key_type_asymmetric)
> +		return -EKEYREJECTED;
> +	subtype =3D asymmetric_key_subtype(key);
> +	if (!subtype || !key->payload.data[0])
> +		return -EKEYREJECTED;
> +	if (!subtype->verify_signature)
> +		return -EKEYREJECTED;
> +
> +	/* Allow sig validation when not using a system keyring */
> +	if (!test_bit(PKS_USAGE_SET, &sig->usage_flags))
> +		return 0;
> +
> +	/* The previous sig validation is enough to get on the clavis keyring *=
/
> +	if (sig->usage =3D=3D VERIFYING_CLAVIS_SIGNATURE)
> +		return 0;
> +
> +	if (test_bit(PKS_REVOCATION_PASS, &sig->usage_flags))
> +		return 0;
> +
> +	for (i =3D 0, buf_len =3D 0; i < 3; i++) {
> +		if (kids->id[i]) {
> +			newkid =3D (struct asymmetric_key_id *)kids->id[i];
> +			if (newkid->len > buf_len)
> +				buf_len =3D newkid->len;
> +		}
> +	}
> +
> +	if (!buf_len)
> +		return -EKEYREJECTED;
> +
> +	/* Allocate enough space for the conversion to ascii plus the header. *=
/
> +	buf_ptr =3D kmalloc(buf_len * 2 + 4, GFP_KERNEL | __GFP_ZERO);
> +
> +	if (!buf_ptr)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < 3; i++) {
> +		if (kids->id[i]) {
> +			newkid =3D (struct asymmetric_key_id *)kids->id[i];
> +			if (!newkid->len)
> +				continue;
> +
> +			ptr =3D buf_ptr;
> +			ptr =3D bin2hex(ptr, &sig->usage, 1);
> +			*ptr++ =3D ':';
> +			ptr =3D bin2hex(ptr, newkid->data, newkid->len);
> +			*ptr =3D 0;
> +			ref =3D keyring_search(make_key_ref(clavis_keyring_get(), true),
> +					     &clavis_key_acl, buf_ptr, false);
> +
> +			if (!IS_ERR(ref))
> +				break;
> +		}
> +	}
> +
> +	kfree(buf_ptr);
> +
> +	if (IS_ERR(ref))
> +		return -EKEYREJECTED;
> +
> +	return 0;
> +}
> diff --git a/security/security.c b/security/security.c
> index c5981e558bc2..097f8cedcd36 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5522,6 +5522,19 @@ void security_key_post_create_or_update(struct key=
 *keyring, struct key *key,
>  	call_void_hook(key_post_create_or_update, keyring, key, payload,
>  		       payload_len, flags, create);
>  }
> +
> +/**
> + * security_key_verify_signature - verify signature
> + * @key: key
> + * @sig: signature
> + *
> + * See whether signature verification is allowed based on the ACL for
> + * key usage.
> + */
> +int security_key_verify_signature(const struct key *key, const struct pu=
blic_key_signature *sig)
> +{
> +	return call_int_hook(key_verify_signature, key, sig);
> +}
>  #endif	/* CONFIG_KEYS */
> =20
>  #ifdef CONFIG_AUDIT
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/=
testing/selftests/lsm/lsm_list_modules_test.c
> index 1cc8a977c711..cf292f976ac4 100644
> --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -131,6 +131,9 @@ TEST(correct_lsm_list_modules)
>  		case LSM_ID_IPE:
>  			name =3D "ipe";
>  			break;
> +		case LSM_ID_CLAVIS:
> +			name =3D "clavis";
> +			break;
>  		default:
>  			name =3D "INVALID";
>  			break;


