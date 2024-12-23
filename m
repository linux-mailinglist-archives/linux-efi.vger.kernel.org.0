Return-Path: <linux-efi+bounces-2433-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7CE9FAE28
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BC47A1D68
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4D1A8F81;
	Mon, 23 Dec 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mPQhbYTR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06433166307;
	Mon, 23 Dec 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955899; cv=none; b=Bw3sbPJhgDW8ALKYPWbuW4vL7FxwoetsqENeemWmWNAg0z1ewP94l2hGWKmdqgEhHc/c6fNMzJK0kFx917ZSbJEKEQ/t0oVTR6bhj+wkGybwpsQBDc7ixRc1mcT/bH7kBXDLShcT75yp7RMocIWw9wVxu0Mg4LPKkkEiHo5vzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955899; c=relaxed/simple;
	bh=T4q8TAqtW9ewJad2LRn3NEdOLjHX9vlVdu4sLUiB6A0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uG659ME1ylXLHjGJybe2YFZrw5oc7pTdNanlCbWipbqHFQRTeTIzm+2SOHXZD1bupfQxWan9/SrV0x5MhALcDSQ3W7aSgAkuozBw/GdaXFQOQDQGi+NXbDL03DplXwnHto7CmKMh8eDVnwhyJhhRkWZGGGKhpUZBSVBdIpRMUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mPQhbYTR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN9dTft008340;
	Mon, 23 Dec 2024 12:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X/HYWJ
	4KKBSZHIvaAsJTgofYfg4xLMIh7+ZZdByQCK4=; b=mPQhbYTRlVTgR3yAf4FRQC
	yHrW7xtdEfL4v0ldQpY6MwD03z0tp+sF+TJXDHeBpqgxWnBQPJLFi6TXJfhupHYC
	DGrrSURKRpjTXHdHm0fH9sdhyf6AUwpKCD3uvk3AARb/BnGNX5DEGFWhNr2yWmg3
	Lj98WOjFE37cQfin5xiTUO+b89VEV8egLR8+cmBzXEHM6LWmxTTFX08PWQBxM0wt
	4tzrpiTY1BWZ4UhaaREuzGCu4Hwf6r0mleZxzRA5ZmYG34wf4h/z+O6O3DoV7hiP
	JJF8c1oJI2TYugSs2T6vP+ydhTXw21H3dZVWwFSu156T3VT4zIGLOMH7fT1WTw5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pm84kmd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 12:10:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BNBvQ6c021056;
	Mon, 23 Dec 2024 12:10:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pm84kmcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 12:10:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNA4hH7020548;
	Mon, 23 Dec 2024 12:10:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p8cy5nd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 12:10:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BNC9xYp29229688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 12:09:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 902035805C;
	Mon, 23 Dec 2024 12:09:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65FA65805A;
	Mon, 23 Dec 2024 12:09:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.115.247])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Dec 2024 12:09:57 +0000 (GMT)
Message-ID: <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
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
Date: Mon, 23 Dec 2024 07:09:56 -0500
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
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
X-Proofpoint-GUID: pNfshmhnmaLmmrW9oMqIUfmRpie1-RxX
X-Proofpoint-ORIG-GUID: MW2ztICRoZTIHPLuL0dlKJnx9MYqPDCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412230108

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Motivation:
>=20
> Each end-user has their own security threat model. What is important to o=
ne
> end-user may not be important to another. There is not a right or wrong t=
hreat
> model.
>=20
> A common request made when adding new kernel changes that could impact th=
e
> threat model around system kernel keys is to add additional Kconfig optio=
ns.
> As kernel developers, it is challenging to both add and keep track of all=
 the
> Kconfig options around security features that may limit or restrict
> system key usage.  It is also difficult for a general purpose distro to t=
ake
> advantage of some of these features, since it may prevent some users from
> executing their workload.
>=20
> It is the author's belief that it is better left up to the end-user on ho=
w
> kernel keys should be used within their system.
>=20
> Throughout the Linux kernel, key usage is tracked when doing signature
> verification with keys contained within one of the system keyrings;  howe=
ver,
> there isn't a way for the end-user to enforce this usage.  This series gi=
ves the
> end-user the ability to configure key usage based on their threat model.
> Having the ability to enforce key usage also improves security by reducin=
g the
> attack surface should a system key be compromised. It allows new features=
 to be
> added without the need for additional Kconfig options for fear of changin=
g the
> end-user's threat model. It also allows a distro to build a kernel that s=
uits
> various end-user's needs without resorting to selecting Kconfig options w=
ith
> the least restrictive security options.

The motivation for this patch set is convincing and addresses limiting the =
usage
of keys loaded directly or indirectly onto the system trusted keyrings -=
=20
.builtin, .machine, and .secondary_trusted_keys keyrings.  Pre-loading the =
build
time ephemeral kernel module signing key is a nice improvement from the pre=
vious
versions.  My main concern is not with Clavis per-se, but that the LSM
infrastructure allows configuring all the LSMs, but enabling at build time =
and
modifying at runtime a subset of them.  Without Clavis enabled, nothing cha=
nges
- any key on the system trusted keyrings remains usable for any purpose.  W=
ith
the current LSM design, the end user security threat model cannot be guaran=
teed.

Mimi
>=20
> Solution:
>=20
> This series introduces a new LSM called Clavis (Latin word meaning key).
> This LSM leaves it up to the end-user to determine what system keys they =
want
> to use and for what purpose.
>=20
> The Clavis LSM adds the ability to do access control for all system keys.=
  When
> enabled, until an ACL entry is added for a specific key, none of the syst=
em keys
> may be used for any type of verification purpose.  When the kernel is bui=
lt,
> typically kernel modules are signed with an ephemeral key, an ACL entry f=
or the
> ephemeral key is pre-loaded, allowing the kernel modules to load during b=
oot. At
> build time other ACL entries may also be included.
>=20
> The Clavis LSM requires the end-user to have their own public key infrast=
ructure
> (PKI).  In order for a Clavis ACL entry to be added, the ACL must be sign=
ed by
> what is being called the Clavis key.  The Clavis key is owned by the end-=
user.
> The Clavis public key can be contained within the machine keyring, or it =
can be
> added after the machine boots.
>=20
> Not only is there a new Clavis key being introduced, but there is also a =
new
> .clavis keyring.  The .clavis keyring contains a single Clavis key. It al=
so
> contains any number of ACL entries that are signed by the Clavis key.
>=20
> It is believed that the most common setup would be to have the Clavis key
> contained within the machine keyring. Enabling the Clavis LSM during boot=
 is
> accomplished by passing in the asymmetric key id for the Clavis key withi=
n a
> new "clavis=3D" boot param.  The asymmetric key id must match one already
> contained within any of the system keyrings.  If a match is found, a link=
 is
> created into the new .clavis keyring.  This Clavis key shall be used as t=
he
> root of trust for any keyring ACL updates afterwards.
>=20
> On UEFI systems the "clavis" boot param is mirrored into a new UEFI varia=
ble
> within the EFI stub code. This variable will persist until the next reboo=
t.
> This same type of functionality is done within shim. Since this variable =
is
> created before ExitBootServices (EBS) it will not have the NVRAM bit set,
> signifying it was created during the Boot Services phase. This is being u=
sed
> so the "clavis" boot param can not be changed via kexec, thereby preventi=
ng a
> pivot of the root of trust.
>=20
> As mentioned earlier, this LSM introduces a new .clavis keyring.  Followi=
ng
> boot, no new keys can be added to this keyring and only the key designate=
d via
> the initial boot param may be used. If the clavis boot param was not used=
, the
> LSM can be enabled afterwards using the keyctl command.  The end-user may=
 add
> their Clavis key into the .clavis keyring and the Clavis LSM shall be ena=
bled.
>=20
> The .clavis keyring also holds the access control list for system keys. A=
 new
> key type called clavis_key_acl is being introduced. This contains the usa=
ge
> followed by the asymmetric key id. To be added to the clavis keyring, the
> clavis_key_acl must be S/MIME signed by the Clavis key. New ACL additions=
 to
> the .clavis keyring may be added at any time.
>=20
> Currently this LSM does not require new changes or modifications to any u=
ser
> space tools.  It also does not have a securityfs interface.  Everything i=
s
> done using the existing keyctl tool through the new .clavis keyring. The
> S/MIME signing can be done with a simple OpenSSL command. If additions or
> updates need to be added in the future, new ACL key types could be create=
d.
> With this approach, maintainability should not be an issue in the future
> if missing items are identified.
>=20
> Clavis must be configured at build time with CONFIG_SECURITY_CLAVIS=3Dy. =
The list
> of security modules enabled by default is set with CONFIG_LSM.  The kerne=
l
> configuration must contain CONFIG_LSM=3D[...],clavis with [...] as the li=
st of
> other security modules for the running system.
>=20
> For setup and usage instructions, a clavis admin-guide has been included
> in Documentation/admin-guide/LSM/clavis.rst.
>=20
> Future enhancements to this LSM could include:
>=20
> 1. Subsystems that currently use system keys with
>    VERIFYING_UNSPECIFIED_SIGNATURE could be updated with their specific u=
sage
>    type.  For example, a usage type for IMA, BPF, etc could be added.
>=20
> 2. Having the ability to allow platform keys to be on par with all other
>    system keys when using this LSM. This would be useful for a user that
>    controls their entire UEFI SB DB key chain and doesn't want to use MOK=
 keys.
>    This could also potentially remove the need for the machine keyring al=
l
>    together.
>=20
> 3. Some of the Kconfig options around key usage and types could be deprec=
ated.
>=20
> I would appreciate any feedback on this approach. Thanks.
>=20
> Changes in v3:
>   Rebased to 6.12-rc3
>   Added Kunit test code
>   Preload an ACL in the clavis keyring with the ephemeral module signing =
key
>   Preload user defined ACL data into the clavis keyring with build time d=
ata
>   Changes to the second patch recommended by Jarkko
>   Reordered patches recommended by Mimi
>   Documentation improvements recommended by Randy
>=20
> Changes in v2:
>   Rebased to 6.10-rc1
>   Various cleanup in the first patch recommended by Jarkko
>   Documentation improvements recommended by Randy
>   Fixed lint warnings
>   Other cleanup
>=20
> Eric Snowberg (13):
>   certs: Remove CONFIG_INTEGRITY_PLATFORM_KEYRING check
>   certs: Introduce ability to link to a system key
>   clavis: Introduce a new system keyring called clavis
>   keys: Add new verification type (VERIFYING_CLAVIS_SIGNATURE)
>   clavis: Introduce a new key type called clavis_key_acl
>   clavis: Populate clavis keyring acl with kernel module signature
>   keys: Add ability to track intended usage of the public key
>   clavis: Introduce new LSM called clavis
>   clavis: Allow user to define acl at build time
>   efi: Make clavis boot param persist across kexec
>   clavis: Prevent boot param change during kexec
>   clavis: Add function redirection for Kunit support
>   clavis: Kunit support
>=20
>  Documentation/admin-guide/LSM/clavis.rst      | 191 ++++++
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  MAINTAINERS                                   |   7 +
>  certs/.gitignore                              |   1 +
>  certs/Makefile                                |  20 +
>  certs/blacklist.c                             |   3 +
>  certs/clavis_module_acl.c                     |   7 +
>  certs/system_keyring.c                        |  36 +-
>  crypto/asymmetric_keys/asymmetric_type.c      |   1 +
>  crypto/asymmetric_keys/pkcs7_trust.c          |  20 +
>  crypto/asymmetric_keys/pkcs7_verify.c         |   5 +
>  crypto/asymmetric_keys/signature.c            |   4 +
>  drivers/firmware/efi/Kconfig                  |  12 +
>  drivers/firmware/efi/libstub/Makefile         |   1 +
>  drivers/firmware/efi/libstub/clavis.c         |  33 +
>  .../firmware/efi/libstub/efi-stub-helper.c    |   2 +
>  drivers/firmware/efi/libstub/efi-stub.c       |   2 +
>  drivers/firmware/efi/libstub/efistub.h        |   8 +
>  drivers/firmware/efi/libstub/x86-stub.c       |   2 +
>  include/crypto/pkcs7.h                        |   3 +
>  include/crypto/public_key.h                   |   4 +
>  include/keys/system_keyring.h                 |   7 +-
>  include/linux/efi.h                           |   1 +
>  include/linux/integrity.h                     |   8 +
>  include/linux/lsm_count.h                     |   8 +-
>  include/linux/lsm_hook_defs.h                 |   2 +
>  include/linux/security.h                      |   7 +
>  include/linux/verification.h                  |   2 +
>  include/uapi/linux/lsm.h                      |   1 +
>  security/Kconfig                              |  11 +-
>  security/Makefile                             |   1 +
>  security/clavis/.gitignore                    |   2 +
>  security/clavis/.kunitconfig                  |   4 +
>  security/clavis/Kconfig                       |  37 ++
>  security/clavis/Makefile                      | 156 +++++
>  security/clavis/clavis.c                      |  26 +
>  security/clavis/clavis.h                      |  62 ++
>  security/clavis/clavis_builtin_acl.c          |   7 +
>  security/clavis/clavis_efi.c                  |  50 ++
>  security/clavis/clavis_keyring.c              | 426 +++++++++++++
>  security/clavis/clavis_test.c                 | 566 ++++++++++++++++++
>  security/integrity/iint.c                     |   2 +
>  security/security.c                           |  13 +
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  44 files changed, 1757 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/clavis.rst
>  create mode 100644 certs/clavis_module_acl.c
>  create mode 100644 drivers/firmware/efi/libstub/clavis.c
>  create mode 100644 security/clavis/.gitignore
>  create mode 100644 security/clavis/.kunitconfig
>  create mode 100644 security/clavis/Kconfig
>  create mode 100644 security/clavis/Makefile
>  create mode 100644 security/clavis/clavis.c
>  create mode 100644 security/clavis/clavis.h
>  create mode 100644 security/clavis/clavis_builtin_acl.c
>  create mode 100644 security/clavis/clavis_efi.c
>  create mode 100644 security/clavis/clavis_keyring.c
>  create mode 100644 security/clavis/clavis_test.c
>=20
>=20
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354


