Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5D485C93
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbiAEXv7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46368 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245578AbiAEXvH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:07 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N4rFq025697;
        Wed, 5 Jan 2022 23:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=a4vdaDAv+2vMnjkwDelFVRlQymxIHo9nLUjO+OgJTI0=;
 b=DK6MB+brm1NChW7tqiIiU00V3nwAjyqXR0Pyx7Bin+zqLgvhY4XvyjG1E7iriC2TS9vR
 wb3aN3dnaTCB0ZKIszHP4cziAjN3o4yi3XeM8Nx742GQOKCD0APmWN9J8aG791wYprKa
 uksYJIEJw2n1iVzHn+ablnzsj63xOtyxToM14o2DKMFQ3QcTLUEWc9j2NgwBj3euRTW1
 6yyAFLjqZv3UqlsGB7BUPTc9Jg/CiABnpj+pFgbByLoEYigM57XgdXBNACEo0Hzv+QJn
 eibwJJdKzzePgsVd8IkOK4XbvkyXd4XzTKT5CAaEfb5nDk+uZEem+fhxlvJKArsfds5U BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpmg1yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjfZ2150022;
        Wed, 5 Jan 2022 23:50:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3ddmqa1j7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afuvcAH+pBWA6gWtgmLQEXSlvQIXO166FTNcrKQQFm7Ezn7sA5WskndjymcqJXm/uGfB8HkXtJwQ/WUj9evzxbdl8aJGvv9pmrGOf8k6lHIQBxwTQamsYCyyYvTeTV1Y6mvGthTCTRGLnhQeAVhPdBC3zgOLBnvJXcLWS212hZ0PaNR3tNii13ARy6fsgFSSG7uooJUF63EJVlef35lPwFRasTZoBIxLDwJIit5QLpIkhtjaHZwDNVJP+Kh7fIawHLt3CMdk1CNKGcgtoPwYy/PUSwIcL16i0euObKFSKrKa9yDcwZswaYf7/nr/hpRvehm2S2bcEoQGvfT4uEr3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4vdaDAv+2vMnjkwDelFVRlQymxIHo9nLUjO+OgJTI0=;
 b=dCBaF9IzUz9h9XsiWE4I6vZ/ezl7S+KWKciNt0MlZX+twGeSMIEWRfEo2bHWXIruxZdXLNu81scWQC1l+kthwaZHu68L9ixIz/YaOalg/08m8WkaYy4RKOyeocbbPPg4PpyBMvMHZ0d4+MRIQfKulzaaQtWVzCQ+cYTUf0BjKg6LkinaLdVPNYRaNTdYEzhdUpW5bUBsEN//6iq++fLyeqLw0HN34s8D0Wao9p5xzqTYNzbYNOKiTVXcYbwXlj105pnmqjk3mtqutQ4Y/2sdlDudAa7Qf3TnblIX7rRtvOUgNvo6kiL8LmGnyJePmgnZgCx3ZLRZsyjhv02otiNPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4vdaDAv+2vMnjkwDelFVRlQymxIHo9nLUjO+OgJTI0=;
 b=kHYJR8SxEUgPQglg4Yu/RMdPynigD/B+FF54tEiRcML2dDayNaMpnS2HTJ9WNVUci5I6wwCEOBglrbJC8YvwiFBgb23CZWJ2TYnf6ckNuC51SVRguzgN+SrGoUEOS1ej1mysZPqBKrTYjq7zNVCwMKs5vcBF1WuMntRzMae6joY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:30 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:30 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        nayna@linux.ibm.com, zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v9 0/8] Enroll kernel keys thru MOK
Date:   Wed,  5 Jan 2022 18:50:04 -0500
Message-Id: <20220105235012.2497118-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ebfae9-b9ed-48f7-7689-08d9d0a627b2
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5034558D0D83762950D31870874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJd4hxxtnbGu1ZIXw+N364ZfwYWX7RY2nIeWRrCeyazJ94CSobJ+OH6xMmA6jNGqGiyRfz3PirXsm6ccNOsBYUCA4l2mkk8XbtyHp6Wal3RBzhefMSprhev5tHOYhloKzafBQOXgA75JTSpK7Au7Mic2eN/XS9otagNgNzM4x6U9RuA+zARZvv6U+ciLTMciu4cwagNNrSZtrow6L+URpt7GBmGwmw5gqDLRdmU6+JHVWxLxEvH+E3xueQr0YvUoO2noEb6OGtU+KWLAiUlVnRy0oGnEa4bN+kI6k2uuK5lC0S6kCdB1wQtrGKtyLt/oeF/rWGy3RBpPGOTU0mT/ShYzqd2DNpYbGajtGdT6GctKVwTzySAYLIXkKknmnvXCmo+zd71tJsqEG/IoZk1fR5J74/vN062wWmu4nElGJWB3LeNSdPABKX2iWeM9wI8Jn5jb1cROJVLNtCvrcWu9qth7QgnF7P/VFsFMsR+vDBx/c9ewl567I8y5O2J03Y0rp5x7+KXD0ayc3+BlFGpUs2mjF+c6bmAknyJxS9hpDtvkcMOoWYRUJ9ot36ZhuoVINjdJ8g3yPVRYjF8G9gner9KSKlCCxbcLFrt2AqjUNpvti05X4MptNAcYvEVql1gVdr1c1V0yFMMXOpYLFOmfTEgSNlS/4+/D3+bH8aq5mmPDEQFgYH/ZvLUSuJwD3HczFT1FF3ODUjKFyEuynxAdVvIlLW5/BAjfw/+fv0k8dWUaRbkWVbGUeNTJA5ROBsPzwFnPFH4LqHuxGYYD/0Af0tr0GXGT0iepU4CtTlZqtJ4r2iMnAKQN2ECImdnX9OhDW7GnSqVfqqX03vOvPgTOJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(966005)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?It+YOl7HmaQQC/hlKfvj3oC/QtvIcI/Y2V4nYHEgkWVWmErAiujfI7R3dQVt?=
 =?us-ascii?Q?oCH48R3w6Tgrk3cnpvxLGal+Qkh4IoJ7HsoIKhI52kMFiHVRdl//kYDkWZJn?=
 =?us-ascii?Q?pZLDjCFjRS5uDTLYHoRKeWsdvX0GlxnxmGPP/ie0Qne+EyQhs5qrkLoNFjva?=
 =?us-ascii?Q?BvSICKemNM1A/JMs1bGUkFh3mSiCtEt0Qkgpbg6D+uRacbt8TC2upIGiCfZW?=
 =?us-ascii?Q?jVC9tJKmt0JzmYuh8n12n3ZZXWHTG4Zu3teWKBpcub6utJyPBbqrepRrC7+U?=
 =?us-ascii?Q?c2mp8hUmkH85rFgoZTv8xJtzy8RER1ZwUYwwz6DK1u8kijEOBp62r2w9Q11V?=
 =?us-ascii?Q?NGzVzjgKUqVrRVz/w5dLml7T5n9iltmuSTKutips9smDtBBn+x8RWQL1p51s?=
 =?us-ascii?Q?mlP8Tae5C13lz5qXgPCe8Dtv9DskH5AiA5NL7t1gyFq7DF11xw0VBvSBTK7h?=
 =?us-ascii?Q?0EpBYcbH7D5sflh3sLr6oX9QANI0cTEuENOvZ4QYnAQzfcqxE98xBK1uRhSn?=
 =?us-ascii?Q?TaUntI2cQUjJBBd1LborX3K7rOa1vEi+W/8XgFVUVGoChCqEIyZXur9VCxRd?=
 =?us-ascii?Q?yFNuVBNkNyd8Gz5tigJ24KIujTo5vzqQq18xgvXu625r8Ta5cGVGgqBmt0XS?=
 =?us-ascii?Q?OWd/q3VNrgUVFQvyb6UJ0rXBWDjyaZnHE75lyTTzPhKZ30WkGRiehtxXtRFn?=
 =?us-ascii?Q?ZHV74kBQcMFbjqH7SIyoxQAZs7M4QIwb+ZB3rL+B0m6ufy8525QyFPFVYSkr?=
 =?us-ascii?Q?lq/TdGaBJcGSc4/u3QyX1W6MeaS6Sxb0wTsxjFVnyO4uXrKQDMU0Wiwr1OmB?=
 =?us-ascii?Q?cX34heToGGgMexNlK3q3072sw1xqpieSB62juP0NDglLvsK9OF+bgXDu7I6+?=
 =?us-ascii?Q?R5rRMS7xjAczom4YQ9S48jY4l5ekJZ3uHt7RFe+b4gsIyvm7/DyA6pFHiQwG?=
 =?us-ascii?Q?7gGqMUVprKtUWaWxZkLl+E9poBRDG/rAhBA/3gzqn0MVrmtIP6XnpTztwBba?=
 =?us-ascii?Q?W85wROhKkjP0zjcMTI+uIWZjjdldgaUJzhvxj4pUBFD8A5yxKr5za7SfTiAq?=
 =?us-ascii?Q?OpCIGRLIAc8jiYRP6EK/zefgf6nKf9CMooOcEBsLSGKtFrecstDfLRF+yH6b?=
 =?us-ascii?Q?l5HQeXKZo3Ne1ywXMY5A2QFGh6RRHyYrlz2e4gxExVOHOnJ/LYxjy+MQz1IW?=
 =?us-ascii?Q?RMK48B5l9CGpMWnfhTVAAUpprk9R6TWenGMrc4OdggGSNaOXZ776ZaIqJNwi?=
 =?us-ascii?Q?otx1U7xk0EgBde2Z3L8Y4+idNb8TjYFGvm5/1+4cCZ4ULAViV26aM9QESVt7?=
 =?us-ascii?Q?DxZI1ZsPYkVY4HRtKMiNZeERH7ykiHoxRxlDquV2sTuDB1rHTp6P25qUZFqy?=
 =?us-ascii?Q?scv/ss+h8iTHj1CaG/OYl7EXxNGAUjKJ0oIbF1twUXMw6HlamksKYzuk9zo8?=
 =?us-ascii?Q?bWk6KAz7TL2gzR/OHfB218/L1bkjutXS7Z1v9vRoJoz8eAs9VAR1YO+eNzNI?=
 =?us-ascii?Q?rdB8H3KtZ4Kuta9pL+PFd5n5kngZ40+nyBr33D7e1gaBi7lwqDSUHW3LuCyU?=
 =?us-ascii?Q?QiMxkhuxvvjj1Lm5PUTzi26ZWIxh3sXHNq3vionm+243Q89/CDKsPLGV5JKm?=
 =?us-ascii?Q?BmGnhosXWEc9wL4OYFh9VK1m81BAvRk8JpwErnS1JFkAu5dTQ7BLuwgp89P8?=
 =?us-ascii?Q?ktx4Kw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ebfae9-b9ed-48f7-7689-08d9d0a627b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:30.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDUEEnuEtbTjQJ2br9dDodwMkFLrlsq7IS34LVtbgihGzYwrU5I6nz8x9wdSii6SwLLaW5d9W6Pb9gAtXHYrmxXxt/7KHLQZxwkom3vGfyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-GUID: zkZfIGmZ-pryQ2FRhfjsGzv5GLcOt28M
X-Proofpoint-ORIG-GUID: zkZfIGmZ-pryQ2FRhfjsGzv5GLcOt28M
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Back in 2013 Linus requested a feature to allow end-users to have the 
ability "to add their own keys and sign modules they trust". This was
his *second* order outlined here [1]. There have been many attempts 
over the years to solve this problem, all have been rejected.  Many 
of the failed attempts loaded all preboot firmware keys into the kernel,
including the Secure Boot keys. Many distributions carry one of these 
rejected attempts [2], [3], [4]. This series tries to solve this problem 
with a solution that takes into account all the problems brought up in 
the previous attempts.

On UEFI based systems, this series introduces a new Linux kernel keyring 
containing the Machine Owner Keys (MOK) called machine. It also defines
a new MOK variable in shim. This variable allows the end-user to decide 
if they want to load MOK keys into the machine keyring. 

By default, nothing changes; MOK keys are not loaded into the machine
keyring.  They are only loaded after the end-user makes the decision 
themselves.  The end-user would set this through mokutil using a new 
--trust-mok option [5]. This would work similar to how the kernel uses 
MOK variables to enable/disable signature validation as well as use/ignore 
the db. Any kernel operation that uses either the builtin or secondary 
trusted keys as a trust source shall also reference the new machine 
keyring as a trust source.

Secure Boot keys will never be loaded into the machine keyring.  They
will always be loaded into the platform keyring.  If an end-user wanted 
to load one, they would need to enroll it into the MOK.

Unlike previous versions of this patch set, IMA support has been removed
to simplify the series. After acceptance, a follow-on series will add IMA 
support.

Steps required by the end user:

Sign kernel module with user created key:
$ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
   machine_signing_key.priv machine_signing_key.x509 my_module.ko

Import the key into the MOK
$ mokutil --import machine_signing_key.x509

Setup the kernel to load MOK keys into the .machine keyring
$ mokutil --trust-mok

Then reboot, the MokManager will load and ask if you want to trust the
MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
module will load.

I have included  a link to the mokutil [5] changes I have made to support 
this new functionality.  The shim changes have now been accepted
upstream [6].

Upstream shim is located here [7], the build instructions are here [8].
TLDR:

$ git clone --recurse-submodules https://github.com/rhboot/shim
$ cd shim
$ make

After building shim, move shimx64.efi and mmx64.efi to the vendor or 
distribution specific directory on your EFI System Partition (assuming
you are building on x86). The instructions above are the minimal
steps needed to build shim to test this feature. It is assumed
Secure Boot shall not be enabled for this testing. To do testing
with Secure Boot enabled, all steps in the build instructions [8]
must be followed.

Instructions for building mokutil (including the new changes):

$ git clone -b mokvars-v3 https://github.com/esnowberg/mokutil.git
$ cd mokutil/
$ ./autogen.sh
$ make

[1] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
[2] https://lore.kernel.org/lkml/1479737095.2487.34.camel@linux.vnet.ibm.com/
[3] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[4] https://lore.kernel.org/linux-integrity/1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com/
[5] https://github.com/esnowberg/mokutil/tree/mokvars-v3
[6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f
[7] https://github.com/rhboot/shim
[8] https://github.com/rhboot/shim/blob/main/BUILDING

Eric Snowberg (8):
  integrity: Fix warning about missing prototypes
  integrity: Introduce a Linux keyring called machine
  integrity: add new keyring handler for mok keys
  KEYS: store reference to machine keyring
  KEYS: Introduce link restriction for machine keys
  efi/mokvar: move up init order
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: Only use machine keyring when uefi_check_trust_mok_keys is
    true

 certs/system_keyring.c                        | 44 ++++++++++-
 drivers/firmware/efi/mokvar-table.c           |  2 +-
 include/keys/system_keyring.h                 | 14 ++++
 security/integrity/Kconfig                    | 13 ++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 15 +++-
 security/integrity/integrity.h                | 17 +++-
 .../platform_certs/keyring_handler.c          | 18 ++++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../platform_certs/machine_keyring.c          | 77 +++++++++++++++++++
 11 files changed, 202 insertions(+), 8 deletions(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c


base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
-- 
2.18.4

